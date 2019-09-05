/*  pgtest.c - SMMU user page table module.

*
*
*   This program is free software; you can redistribute it and/or modify
*   it under the terms of the GNU General Public License as published by
*   the Free Software Foundation; either version 2 of the License, or
*   (at your option) any later version.

*   This program is distributed in the hope that it will be useful,
*   but WITHOUT ANY WARRANTY; without even the implied warranty of
*   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*   GNU General Public License for more details.
*
*   You should have received a copy of the GNU General Public License along
*   with this program. If not, see <http://www.gnu.org/licenses/>.

*/
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/module.h>
#include <linux/slab.h>
#include <linux/io.h>
#include <linux/interrupt.h>
#include <linux/sched.h>
#include <linux/of_address.h>
#include <linux/of_device.h>
#include <linux/of_platform.h>
#include <linux/printk.h>
#include <linux/kobject.h>
#include <linux/sysfs.h>
#include <linux/fs.h>
#include <linux/string.h>
#include <linux/io.h>
#include <linux/io-64-nonatomic-hi-lo.h>
#include <linux/delay.h>
#include <linux/uaccess.h>
#include <linux/cdev.h>
#include <linux/device.h>
#include <asm/tlbflush.h>
#include <asm/tlb.h>
#include <asm/pgtable.h>

#define ARM_SMMU_GR1_CBA2R(n)		(0x800 + ((n) << 2))
//#define ARM_LPAE_TCR_SH_IS              2 << 12

#define ARM_LPAE_TCR_SH_IS              3 << 12
#define TTBCR2_SEP_UPSTREAM	            (0x7 << 15)
#define ARM_SMMU_CB_TTBCR2		0x10
#define ARM_LPAE_TCR_EPD1               (1 << 23)
#define ARM_LPAE_TCR_PS_48_BIT 0x5ULL
#define ARM_LPAE_TCR_IPS_SHIFT          32
#define ARM_LPAE_TCR_TG0_4K		(0 << 14)
#define ARM_LPAE_TCR_ORGN0_SHIFT	10
#define ARM_LPAE_TCR_IRGN0_SHIFT	8
#define ARM_LPAE_TCR_RGN_MASK		0x3
#define ARM_LPAE_TCR_RGN_NC		0
#define ARM_LPAE_TCR_RGN_WBWA		1
#define ARM_LPAE_TCR_RGN_WT		2
#define ARM_LPAE_TCR_RGN_WB		3
#define ARM_LPAE_TCR_SH0_SHIFT		12
#define ARM_LPAE_MAIR_ATTR_NC		0x44
#define ARM_LPAE_MAIR_ATTR_IDX_NC	0
#define ARM_LPAE_MAIR_ATTR_WBRWA	0xff
#define ARM_LPAE_MAIR_ATTR_IDX_CACHE	 1
#define ARM_LPAE_MAIR_ATTR_DEVICE	0x04
#define ARM_LPAE_MAIR_ATTR_IDX_DEV	2
#define ARM_LPAE_MAIR_ATTR_SHIFT(n)	((n) << 3)

#define SCTLR_S1_ASIDPNE		(1 << 12)
#define SCTLR_CFCFG			(1 << 7)
#define SCTLR_CFIE			(1 << 6)
#define SCTLR_CFRE			(1 << 5)
#define SCTLR_E				(1 << 4)
#define SCTLR_AFE			(1 << 2)
#define SCTLR_TRE			(1 << 1)
#define SCTLR_M				(1 << 0)
#define ARM_SMMU_CB_S1_MAIR0		0x38
#define ARM_SMMU_CB_S1_MAIR1		0x3c
#define ARM_SMMU_CB_TTBCR		0x30

#include <linux/ioctl.h>



// proc entry
dev_t dev_sys = 0;
static struct class *dev_class;
static struct cdev etx_cdev;
static struct arm_smmu_device *g_smmu;

uint8_t *kernel_buffer;
#define mem_size        1024
//

#define ARM_SMMU_GR0(smmu)		((smmu)->base)
#define ARM_SMMU_GR1(smmu)		((smmu)->base + (1 << (smmu)->pgshift))
#define S2CR_PRIVCFG_MASK		0x3

#define ARM_SMMU_GR1_CBAR(n)		(0x0 + ((n) << 2))

/* Translation context bank */
#define ARM_SMMU_CB_BASE(smmu)		((smmu)->base + ((smmu)->size >> 1))
#define ARM_SMMU_CB(smmu, n)		((n) * (1 << (smmu)->pgshift))

#define CBAR_S1_BPSHCFG_SHIFT		8
#define CBAR_S1_BPSHCFG_NSH		3
#define CBAR_S1_MEMATTR_SHIFT		12
#define CBAR_S1_MEMATTR_MASK		0xf
#define CBAR_S1_MEMATTR_WB		0xf

#define S2CR_PRIVCFG_SHIFT		24

/*
 * SMMU global address space with conditional offset to access secure
 * aliases of non-secure registers (e.g. nsCR0: 0x400, nsGFSR: 0x448,
 * nsGFSYNR0: 0x450)
 */
 #define ARM_SMMU_OPT_SECURE_CFG_ACCESS (1 << 0)


 					 #define FSR_MULTI			(1 << 31)
 #define FSR_SS				(1 << 30)
 #define FSR_UUT				(1 << 8)
 #define FSR_ASF				(1 << 7)
 #define FSR_TLBLKF			(1 << 6)
 #define FSR_TLBMCF			(1 << 5)
 #define FSR_EF				(1 << 4)
 #define FSR_PF				(1 << 3)
 #define FSR_AFF				(1 << 2)
 #define FSR_TF				(1 << 1)

 #define FSR_IGN				(FSR_AFF | FSR_ASF | \
					 FSR_TLBMCF | FSR_TLBLKF)

 #define FSR_FAULT			(FSR_MULTI | FSR_SS | FSR_UUT | \
 					 FSR_EF | FSR_PF | FSR_TF | FSR_IGN)

 #define FSYNR0_WNR			(1 << 4)


#define ARM_SMMU_GR0_NS(smmu)						\
	((smmu)->base +							\
		((smmu->options & ARM_SMMU_OPT_SECURE_CFG_ACCESS)	\
			? 0x400 : 0))

#define ARM_SMMU_CB_FAR			0x60

#define CBAR_TYPE_SHIFT			16

#define CBAR_TYPE_S1_TRANS_S2_BYPASS	(1 << CBAR_TYPE_SHIFT)

/* Configuration registers */
#define ARM_SMMU_GR0_sCR0		0x0
#define sCR0_CLIENTPD			(1 << 0)
#define sCR0_GFRE			(1 << 1)
#define sCR0_GFIE			(1 << 2)
#define sCR0_GCFGFRE			(1 << 4)
#define sCR0_GCFGFIE			(1 << 5)
#define sCR0_USFCFG			(1 << 10)
#define sCR0_VMIDPNE			(1 << 11)
#define sCR0_PTM			(1 << 12)
#define sCR0_FB				(1 << 13)
#define sCR0_VMID16EN			(1 << 31)
#define sCR0_BSU_SHIFT			14
#define sCR0_BSU_MASK			0x3

/* Auxiliary Configuration register */
#define ARM_SMMU_GR0_sACR		0x10

#define ARM_MMU500_ACTLR_CPRE		(1 << 1)
#define ARM_SMMU_CB_FSR			0x58
#define ARM_SMMU_CB_ACTLR		0x4

#define ARM_SMMU_CB_FSYNR0		0x68
#define FSR_FAULT			(FSR_MULTI | FSR_SS | FSR_UUT | \
					 FSR_EF | FSR_PF | FSR_TF | FSR_IGN)

#define ARM_SMMU_CB_SCTLR		0x0

/* Identification registers */
#define ARM_SMMU_GR0_ID0		0x20
#define ARM_SMMU_GR0_ID1		0x24
#define ARM_SMMU_GR0_ID2		0x28
#define ARM_SMMU_GR0_ID3		0x2c
#define ARM_SMMU_GR0_ID4		0x30
#define ARM_SMMU_GR0_ID5		0x34
#define ARM_SMMU_GR0_ID6		0x38
#define ARM_SMMU_GR0_ID7		0x3c
#define ARM_SMMU_GR0_sGFSR		0x48
#define ARM_SMMU_GR0_sGFSYNR0		0x50
#define ARM_SMMU_GR0_sGFSYNR1		0x54
#define ARM_SMMU_GR0_sGFSYNR2		0x58

#define ID0_S1TS			(1 << 30)
#define ID0_S2TS			(1 << 29)
#define ID0_NTS				(1 << 28)
#define ID0_SMS				(1 << 27)
#define ID0_ATOSNS			(1 << 26)
#define ID0_PTFS_NO_AARCH32		(1 << 25)
#define ID0_PTFS_NO_AARCH32S		(1 << 24)
#define ID0_CTTW			(1 << 14)
#define ID0_NUMIRPT_SHIFT		16
#define ID0_NUMIRPT_MASK		0xff
#define ID0_NUMSIDB_SHIFT		9
#define ID0_NUMSIDB_MASK		0xf
#define ID0_NUMSMRG_SHIFT		0
#define ID0_NUMSMRG_MASK		0xff

#define ID1_PAGESIZE			(1 << 31)
#define ID1_NUMPAGENDXB_SHIFT		28
#define ID1_NUMPAGENDXB_MASK		7
#define ID1_NUMS2CB_SHIFT		16
#define ID1_NUMS2CB_MASK		0xff
#define ID1_NUMCB_SHIFT			0
#define ID1_NUMCB_MASK			0xff

#define ID2_OAS_SHIFT			4
#define ID2_OAS_MASK			0xf
#define ID2_IAS_SHIFT			0
#define ID2_IAS_MASK			0xf
#define ID2_UBS_SHIFT			8
#define ID2_UBS_MASK			0xf
#define ID2_PTFS_4K			(1 << 12)
#define ID2_PTFS_16K			(1 << 13)
#define ID2_PTFS_64K			(1 << 14)
#define ID2_VMID16			(1 << 15)

#define ID7_MAJOR_SHIFT			4
#define ID7_MAJOR_MASK			0xf

/* Global TLB invalidation */
#define ARM_SMMU_GR0_TLBIVMID		0x64
#define ARM_SMMU_GR0_TLBIALLNSNH	0x68
#define ARM_SMMU_GR0_TLBIALLH		0x6c
#define ARM_SMMU_GR0_sTLBGSYNC		0x70
#define ARM_SMMU_GR0_sTLBGSTATUS	0x74
#define sTLBGSTATUS_GSACTIVE		(1 << 0)
#define TLB_LOOP_TIMEOUT		1000000	/* 1s! */
#define ARM_SMMU_FEAT_STREAM_MATCH	(1 << 1)

#define disable_bypass 0

#define ARM_MMU500_ACR_CACHE_LOCK	(1 << 26)

#define TTBRn_ASID_SHIFT		48
#define ARM_SMMU_CB_TTBR0		0x20
#define ARM_SMMU_CB_TTBR1		0x28

enum arm_smmu_s2cr_type {
	S2CR_TYPE_TRANS,
	S2CR_TYPE_BYPASS,
	S2CR_TYPE_FAULT,
};

#define s2cr_init_val (struct arm_smmu_s2cr){				\
	.type = disable_bypass ? S2CR_TYPE_FAULT : S2CR_TYPE_BYPASS,	\
}

/* Stream mapping registers */
#define ARM_SMMU_GR0_SMR(n)		(0x800 + ((n) << 2))
#define SMR_VALID			(1 << 31)
#define SMR_MASK_SHIFT			16
#define SMR_ID_SHIFT			0

#define ARM_SMMU_GR0_S2CR(n)		(0xc00 + ((n) << 2))
#define S2CR_CBNDX_SHIFT		0
#define S2CR_CBNDX_MASK			0xff
#define S2CR_TYPE_SHIFT			16
#define S2CR_TYPE_MASK			0x3

#define ARM_SMMU_FEAT_TRANS_S1		(1 << 2)
#define ARM_SMMU_FEAT_TRANS_S2		(1 << 3)

#define ARM_SMMU_FEAT_TRANS_OPS		(1 << 5)
#define ARM_SMMU_FEAT_TRANS_NESTED	(1 << 4)


enum arm_smmu_s2cr_privcfg {
	S2CR_PRIVCFG_DEFAULT,
	S2CR_PRIVCFG_DIPAN,
	S2CR_PRIVCFG_UNPRIV,
	S2CR_PRIVCFG_PRIV,
};


struct arm_smmu_smr {
	u16				mask;
	u16				id;
	bool				valid;
};

struct arm_smmu_s2cr {
	struct iommu_group		*group;
	int				count;
	enum arm_smmu_s2cr_type		type;
	enum arm_smmu_s2cr_privcfg	privcfg;
	u8				cbndx;
};

struct arm_smmu_device {
	struct device			*dev;
	void __iomem			*base;
	unsigned long			size;
	unsigned long			pgshift;
	u32				features;
	u32				options;

	u32				num_context_banks;
	u32				num_s2_context_banks;

	atomic_t			irptndx;

	u32				num_mapping_groups;
	u16				streamid_mask;
	u16				smr_mask_mask;
	struct arm_smmu_smr		*smrs;
	struct arm_smmu_s2cr		*s2crs;
	struct mutex			stream_map_mutex;

	unsigned long			va_size;
	unsigned long			ipa_size;
	unsigned long			pa_size;
	unsigned long			pgsize_bitmap;

	u32				num_global_irqs;
	u32				num_context_irqs;
	unsigned int			*irqs;

	u32				cavium_id_base; /* Specific to Cavium */
};

static struct arm_smmu_device *smmu;
void __iomem *gr0_base;
static struct kobject *example_kobject;
static int test_count;

static ssize_t test_show(struct kobject *kobj, struct kobj_attribute *attr,
                      char *buf)
{

        return sprintf(buf, "comm = %d, process = %d", current->comm,current->pid);

}

static ssize_t test_store(struct kobject *kobj, struct kobj_attribute *attr,
                      char *buf, size_t count)
{
        sscanf(buf, "%du", &test_count);
        return count;
}


static struct kobj_attribute test_attribute =__ATTR(test_count, 0660, test_show,
                                                   test_store);


/* Standard module information, edit as appropriate */
MODULE_LICENSE("GPL");
MODULE_AUTHOR
    ("University of Manchester");
MODULE_DESCRIPTION
    ("pgtest - Platform module for user pagetable SMMU configuration");

#define DRIVER_NAME "pgtest"

/* Simple example of how to receive command line parameters to your module.
   Delete if you don't need them */

struct pgtest_local {
	int irq;
	unsigned long mem_start;
	unsigned long mem_end;
	void __iomem *base_addr;
};


//function fixed to cb 0 for testing
static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
{
	u32 fsr, fsynr;
	unsigned long iova;
	struct arm_smmu_device *smmu = dev;
	void __iomem *cb_base;

	cb_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu,0);
	fsr = readl_relaxed(cb_base + ARM_SMMU_CB_FSR);

	if (!(fsr & FSR_FAULT))
		return IRQ_NONE;

	fsynr = readl_relaxed(cb_base + ARM_SMMU_CB_FSYNR0);
	iova = readq_relaxed(cb_base + ARM_SMMU_CB_FAR);

	dev_err_ratelimited(smmu->dev,
	"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cb=%d\n",
			    fsr, iova, fsynr, 0);

	writel(fsr, cb_base + ARM_SMMU_CB_FSR);
	return IRQ_HANDLED;
}



static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
{
	u32 gfsr, gfsynr0, gfsynr1, gfsynr2;
	struct arm_smmu_device *smmu = dev;
	void __iomem *gr0_base = ARM_SMMU_GR0_NS(smmu);

	gfsr = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSR);
	gfsynr0 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSYNR0);
	gfsynr1 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSYNR1);
	gfsynr2 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSYNR2);

	if (!gfsr)
		return IRQ_NONE;

	dev_info(smmu->dev,
		" global fault\n");
	dev_info(smmu->dev,
		"\tGFSR 0x%08x, GFSYNR0 0x%08x, GFSYNR1 0x%08x, GFSYNR2 0x%08x\n",
		gfsr, gfsynr0, gfsynr1, gfsynr2);

	writel(gfsr, gr0_base + ARM_SMMU_GR0_sGFSR);
	return IRQ_HANDLED;
}


static void arm_smmu_write_s2cr(struct arm_smmu_device *smmu, int idx)
{
	struct arm_smmu_s2cr *s2cr = smmu->s2crs + idx;
	u32 reg = (s2cr->type & S2CR_TYPE_MASK) << S2CR_TYPE_SHIFT |
		  (s2cr->cbndx & S2CR_CBNDX_MASK) << S2CR_CBNDX_SHIFT |
		  (s2cr->privcfg & S2CR_PRIVCFG_MASK) << S2CR_PRIVCFG_SHIFT;

	writel_relaxed(reg, ARM_SMMU_GR0(smmu) + ARM_SMMU_GR0_S2CR(idx));
}

static void arm_smmu_write_smr(struct arm_smmu_device *smmu, int idx)
{
	struct arm_smmu_smr *smr = smmu->smrs + idx;
	u32 reg = smr->id << SMR_ID_SHIFT | smr->mask << SMR_MASK_SHIFT;

	if (smr->valid)
		reg |= SMR_VALID;
	writel_relaxed(reg, ARM_SMMU_GR0(smmu) + ARM_SMMU_GR0_SMR(idx));
}


static void arm_smmu_write_sme(struct arm_smmu_device *smmu, int idx)
{
	arm_smmu_write_s2cr(smmu, idx);
	if (smmu->smrs)
		arm_smmu_write_smr(smmu, idx);
}

/* Wait for any pending TLB invalidations to complete */
static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu)
{
	int count = 0;
	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);

	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_sTLBGSYNC);
	while (readl_relaxed(gr0_base + ARM_SMMU_GR0_sTLBGSTATUS)
	       & sTLBGSTATUS_GSACTIVE) {
		cpu_relax();
		if (++count == TLB_LOOP_TIMEOUT) {
			dev_err_ratelimited(smmu->dev,
			"TLB sync timed out -- SMMU may be deadlocked\n");
			return;
		}
		udelay(1);
	}
}


static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
{
	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
	void __iomem *cb_base;
	int i;
	u32 reg, major,ret;

	/* clear global FSR */
	reg = readl_relaxed(ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sGFSR);
	writel(reg, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sGFSR);

	/*
	 * Reset stream mapping groups: Initial values mark all SMRn as
	 * invalid and all S2CRn as bypass unless overridden.
	 */
	for (i = 1 ; i < smmu->num_mapping_groups; ++i)
		arm_smmu_write_sme(smmu, i);

	/*
	 * Before clearing ARM_MMU500_ACTLR_CPRE, need to
	 * clear CACHE_LOCK bit of ACR first. And, CACHE_LOCK
	 * bit is only present in MMU-500r2 onwards.
	 */
	reg = readl_relaxed(gr0_base + ARM_SMMU_GR0_ID7);
	major = (reg >> ID7_MAJOR_SHIFT) & ID7_MAJOR_MASK;
	//if ((smmu->model == ARM_MMU500) && (major >= 2)) {
		reg = readl_relaxed(gr0_base + ARM_SMMU_GR0_sACR);
		reg &= ~ARM_MMU500_ACR_CACHE_LOCK;
		writel_relaxed(reg, gr0_base + ARM_SMMU_GR0_sACR);
//	}

	/* Make sure all context banks are disabled and clear CB_FSR  */
	for (i = 0; i < smmu->num_context_banks; ++i) {
    dev_info(smmu->dev, "Clear context bank %d\n",i);
		cb_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, i);
		writel_relaxed(0, cb_base + ARM_SMMU_CB_SCTLR);
		writel_relaxed(FSR_FAULT, cb_base + ARM_SMMU_CB_FSR);
		/*
		 * Disable MMU-500's not-particularly-beneficial next-page
		 * prefetcher for the sake of errata #841119 and #826419.
		 */

			reg = readl_relaxed(cb_base + ARM_SMMU_CB_ACTLR);
			reg &= ~ARM_MMU500_ACTLR_CPRE;
			writel_relaxed(reg, cb_base + ARM_SMMU_CB_ACTLR);

	}

	/* Invalidate the TLB, just in case */
	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLH);
	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLNSNH);

	reg = readl_relaxed(ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);

	/* Enable fault reporting */
	reg |= (sCR0_GFRE | sCR0_GFIE | sCR0_GCFGFRE | sCR0_GCFGFIE);

	/* Disable TLB broadcasting. */
	reg |= (sCR0_VMIDPNE | sCR0_PTM);

	/* Enable client access, handling unmatched streams as appropriate */
	reg &= ~sCR0_CLIENTPD;

//this should turn default bypass off.
	//if (disable_bypass)
		reg |= sCR0_USFCFG;
	//else

//	reg &= ~sCR0_USFCFG;

	/* Disable forced broadcasting */
	reg &= ~sCR0_FB;

	/* Don't upgrade barriers */
	reg &= ~(sCR0_BSU_MASK << sCR0_BSU_SHIFT);

	//if (smmu->features & ARM_SMMU_FEAT_VMID16)
	//	reg |= sCR0_VMID16EN;

	/* Push the button */
	__arm_smmu_tlb_sync(smmu);
	writel(reg, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);

//the smmu is now ENABLED


//seeting to Translation to cb 0  and default privacy
  reg = (S2CR_TYPE_TRANS & S2CR_TYPE_MASK) << S2CR_TYPE_SHIFT |
    (0 & S2CR_CBNDX_MASK) << S2CR_CBNDX_SHIFT |
    (S2CR_PRIVCFG_DEFAULT & S2CR_PRIVCFG_MASK) << S2CR_PRIVCFG_SHIFT;


//static to 0 for testing
    writel_relaxed(reg, ARM_SMMU_GR0(smmu) + ARM_SMMU_GR0_S2CR(0));
    int irq = smmu->irqs[smmu->num_global_irqs + 0];


//enable the context bank

void __iomem  *gr1_base;
gr1_base = ARM_SMMU_GR1(smmu);
cb_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, 0);

    reg = CBAR_TYPE_S1_TRANS_S2_BYPASS;
    reg |= (CBAR_S1_BPSHCFG_NSH << CBAR_S1_BPSHCFG_SHIFT) |
    			(CBAR_S1_MEMATTR_WB << CBAR_S1_MEMATTR_SHIFT);
writel_relaxed(reg, gr1_base + ARM_SMMU_GR1_CBAR(0));


//TTBR
//need ASID
//u16 asid = ARM_SMMU_CB_ASID(smmu, cfg);
//reg64 = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
//reg64 |= (u64)asid << TTBRn_ASID_SHIFT;
//writeq_relaxed(reg64, cb_base + ARM_SMMU_CB_TTBR0);

//reg64 = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[1];
//reg64 |= (u64)asid << TTBRn_ASID_SHIFT;
//writeq_relaxed(reg64, cb_base + ARM_SMMU_CB_TTBR1);

//end TTBR


//enable irq for testing





}

static int pgtest_probe(struct platform_device *pdev)
{
//	struct resource *r_irq; /* Interrupt resources */
//	struct resource *r_mem; /* IO mem resources */
	struct device *dev = &pdev->dev;
  /*
	struct pgtest_local *lp = NULL;

	int rc = 0;
        int error = 0;
	dev_info(dev, "Device Tree Probing\n");
//	/* Get iospace for the device
////	r_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
////	if (!r_mem) {
////		dev_err(dev, "invalid address\n");
////		return -ENODEV;
////	}
	lp = (struct pgtest_local *) kmalloc(sizeof(struct pgtest_local), GFP_KERNEL);
	if (!lp) {
		dev_err(dev, "Cound not allocate pgtest device\n");
		return -ENOMEM;
	}
	dev_set_drvdata(dev, lp);


        example_kobject = kobject_create_and_add("exa-test",
                                                 kernel_kobj);
        if(!example_kobject)
                return -ENOMEM;

        error = sysfs_create_file(example_kobject, &test_attribute.attr);
        if (error) {
                pr_debug("failed to create the foo file in /sys/kernel/exa-test \n");
        }
	dev_info(dev, "created sysfs file\n");

*/


//	lp->mem_start = r_mem->start;
//	lp->mem_end = r_mem->end;

//	if (!request_mem_region(lp->mem_start,
//				lp->mem_end - lp->mem_start + 1,
//				DRIVER_NAME)) {
//		dev_err(dev, "Couldn't lock memory region at %p\n",
//			(void *)lp->mem_start);
//		rc = -EBUSY;
//		goto error1;
//	}

//	lp->base_addr = ioremap(lp->mem_start, lp->mem_end - lp->mem_start + 1);
//	if (!lp->base_addr) {
//		dev_err(dev, "pgtest: Could not allocate iomem\n");
//		rc = -EIO;
//		goto error2;
//	}

	/* Get IRQ for the device */
//	r_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
//	if (!r_irq) {
//		dev_info(dev, "no IRQ found\n");
//		dev_info(dev, "pgtest at 0x%08x mapped to 0x%08x\n",
//			(unsigned int __force)lp->mem_start,
//			(unsigned int __force)lp->base_addr);
//		return 0;
//	}
//	lp->irq = r_irq->start;
//	rc = request_irq(lp->irq, &pgtest_irq, 0, DRIVER_NAME, lp);
//	if (rc) {
//		dev_err(dev, "testmodule: Could not allocate interrupt %d.\n",
//			lp->irq);
//		goto error3;
//	}

//	dev_info(dev,"pgtest at 0x%08x mapped to 0x%08x, irq=%d\n",
//		(unsigned int __force)lp->mem_start,
//		(unsigned int __force)lp->base_addr,
//		lp->irq);

//smmu test

struct resource *res;
//struct arm_smmu_device *smmu;
smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
if (!smmu) {
  dev_err(dev, "failed to allocate arm_smmu_device\n");
  return -ENOMEM;
}
g_smmu = smmu;
smmu->dev = dev;

	int num_irqs, i, err;
  res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
	dev_info(dev, "platform_get_resource\n");

    smmu->base = devm_ioremap_resource(dev, res);

    if (IS_ERR(smmu->base))
    {
      dev_err(dev, "missing base address\n");
     return PTR_ERR(smmu->base);
    }
dev_info(dev, "platform_set_base\n");

    smmu->size = resource_size(res);

    if (of_property_read_u32(dev->of_node, "#global-interrupts",
    			 &smmu->num_global_irqs)) {
    	dev_err(dev, "missing #global-interrupts property\n");
    	return -ENODEV;
    }
dev_info(dev, "platform_get_global-interrupts\n");


    num_irqs = 0;
    	while ((res = platform_get_resource(pdev, IORESOURCE_IRQ, num_irqs))) {
    		num_irqs++;
    		if (num_irqs > smmu->num_global_irqs)
    			smmu->num_context_irqs++;
    	}
      if (!smmu->num_context_irqs) {
    		dev_err(dev, "found %d interrupts but expected at least %d\n",
    			num_irqs, smmu->num_global_irqs + 1);
    		return -ENODEV;
    	}
dev_info(dev, "platform_get_count irq\n");

    smmu->irqs = devm_kzalloc(dev, sizeof(*smmu->irqs) * num_irqs,
    GFP_KERNEL);

    if (!smmu->irqs) {
      dev_err(dev, "failed to allocate %d irqs\n", num_irqs);
      return -ENOMEM;
    }

    for (i = 0; i < num_irqs; ++i) {
  		int irq = platform_get_irq(pdev, i);

  		if (irq < 0) {
  			dev_err(dev, "failed to get irq index %d\n", i);
  			return -ENODEV;
  		}
  		smmu->irqs[i] = irq;
  	}
dev_info(dev, "platform_get_global-setting up interrupts\n");

u32 id;
unsigned long size;
gr0_base = ARM_SMMU_GR0(smmu);
dev_notice(smmu->dev, "probing hardware configuration...\n");

id = readl_relaxed(gr0_base + ARM_SMMU_GR0_ID0);

if (id & ID0_S1TS) {
		smmu->features |= ARM_SMMU_FEAT_TRANS_S1;
		dev_notice(smmu->dev, "\tstage 1 translation\n");
	}

	if (id & ID0_S2TS) {
		smmu->features |= ARM_SMMU_FEAT_TRANS_S2;
		dev_notice(smmu->dev, "\tstage 2 translation\n");
	}

	if (id & ID0_NTS) {
		smmu->features |= ARM_SMMU_FEAT_TRANS_NESTED;
		dev_notice(smmu->dev, "\tnested translation\n");
	}

	if (!(smmu->features &
		(ARM_SMMU_FEAT_TRANS_S1 | ARM_SMMU_FEAT_TRANS_S2))) {
		dev_err(smmu->dev, "\tno translation support!\n");
		return -ENODEV;
	}

	if ((id & ID0_S1TS) ) {
		smmu->features |= ARM_SMMU_FEAT_TRANS_OPS;
		dev_notice(smmu->dev, "\taddress translation ops\n");
	}

  size = 1 << ((id >> ID0_NUMSIDB_SHIFT) & ID0_NUMSIDB_MASK);
smmu->streamid_mask = size - 1;

if (id & ID0_SMS) {
		u32 smr;

		smmu->features |= ARM_SMMU_FEAT_STREAM_MATCH;
		size = (id >> ID0_NUMSMRG_SHIFT) & ID0_NUMSMRG_MASK;
		if (size == 0) {
			dev_err(smmu->dev,
				"stream-matching supported, but no SMRs present!\n");
			return -ENODEV;
		}

		/*
		 * SMR.ID bits may not be preserved if the corresponding MASK
		 * bits are set, so check each one separately. We can reject
		 * masters later if they try to claim IDs outside these masks.
		 */
     /*
		smr = smmu->streamid_mask << SMR_ID_SHIFT;
    dev_info(dev, "Stream ID Mask %d\n",smmu->streamid_mask );
		writel_relaxed(smr, gr0_base + ARM_SMMU_GR0_SMR(0));
		smr = readl_relaxed(gr0_base + ARM_SMMU_GR0_SMR(0));

		smmu->streamid_mask = smr >> SMR_ID_SHIFT;

		smr = smmu->streamid_mask << SMR_MASK_SHIFT;
		writel_relaxed(smr, gr0_base + ARM_SMMU_GR0_SMR(0));
		smr = readl_relaxed(gr0_base + ARM_SMMU_GR0_SMR(0));
		smmu->smr_mask_mask = smr >> SMR_MASK_SHIFT;
    */

    //pagN_INFO "Device Driver Insert...Done!!!\n");
	dev_notice(smmu->dev,"\tSMR address is: %lx\n",(long unsigned int *)gr0_base + ARM_SMMU_GR0_SMR(0));



    void * gr0_base = ARM_SMMU_GR0(smmu);
		/* Zero-initialised to mark as invalid */
		smmu->smrs = devm_kcalloc(smmu->dev, size, sizeof(*smmu->smrs),
					  GFP_KERNEL);
		if (!smmu->smrs)
			return -ENOMEM;

		dev_notice(smmu->dev,
			   "\tstream matching with %lu register groups, mask 0x%x",
			   size, smmu->smr_mask_mask);
	}

  smmu->s2crs = devm_kmalloc_array(smmu->dev, size, sizeof(*smmu->s2crs),
					 GFP_KERNEL);
  if (!smmu->s2crs)
   return -ENOMEM;

  for(i = 0; i < size; i++)
  {
   smmu->s2crs[i] = s2cr_init_val;
 }


   smmu->num_mapping_groups = size;
   	mutex_init(&smmu->stream_map_mutex);


    id = readl_relaxed(gr0_base + ARM_SMMU_GR0_ID1);
  	smmu->pgshift = (id & ID1_PAGESIZE) ? 16 : 12;

  	/* Check for size mismatch of SMMU address space from mapped region */
  	size = 1 << (((id >> ID1_NUMPAGENDXB_SHIFT) & ID1_NUMPAGENDXB_MASK) + 1);
  	size *= 2 << smmu->pgshift;
  	if (smmu->size != size)
  		dev_warn(smmu->dev,
  			"SMMU address space size (0x%lx) differs from mapped region size (0x%lx)!\n",
  			size, smmu->size);

  	smmu->num_s2_context_banks = (id >> ID1_NUMS2CB_SHIFT) & ID1_NUMS2CB_MASK;
  	smmu->num_context_banks = (id >> ID1_NUMCB_SHIFT) & ID1_NUMCB_MASK;
  	if (smmu->num_s2_context_banks > smmu->num_context_banks) {
  		dev_err(smmu->dev, "impossible number of S2 context banks!\n");
  		return -ENODEV;
  	}
  	dev_notice(smmu->dev, "\t%u context banks (%u stage-2 only)\n",
  		   smmu->num_context_banks, smmu->num_s2_context_banks);

id = readl_relaxed(gr0_base + ARM_SMMU_GR0_ID2);
dev_notice(smmu->dev, "ID 2 Register = %08x\n",
    id);

dev_info(dev, "Setting up global irq\n");
    for (i = 0; i < smmu->num_global_irqs; ++i) {
    		err = devm_request_irq(smmu->dev, smmu->irqs[i],
    				       arm_smmu_global_fault,
    				       IRQF_SHARED,
    				       "arm-smmu global fault",
    				       smmu);
    		if (err) {
    			dev_err(dev, "failed to request global IRQ %d (%u)\n",
    				i, smmu->irqs[i]);
    			return err;
    		}
    	}
dev_info(dev, "RESET SMMU !!!!\n");
      arm_smmu_device_reset(smmu);






platform_set_drvdata(pdev, smmu);


	return 0;
//error3:
//	free_irq(lp->irq, lp);
//error2:
//	release_mem_region(lp->mem_start, lp->mem_end - lp->mem_start + 1);
//error1:
//	kfree(lp);
//	dev_set_drvdata(dev, NULL);
	//return rc;
}

static int pgtest_remove(struct platform_device *pdev)
{
	struct device *dev = &pdev->dev;
	struct pgtest_local *lp = dev_get_drvdata(dev);
//	free_irq(lp->irq, lp);
//	release_mem_region(lp->mem_start, lp->mem_end - lp->mem_start + 1);
	kfree(lp);
	dev_set_drvdata(dev, NULL);
	return 0;
}

#ifdef CONFIG_OF
static struct of_device_id pgtest_of_match[] = {
	{ .compatible = "pgtest", },
	{ /* end of list */ },
};
MODULE_DEVICE_TABLE(of, pgtest_of_match);
#else
# define pgtest_of_match
#endif


static struct platform_driver pgtest_driver = {
	.driver = {
		.name = DRIVER_NAME,
		.owner = THIS_MODULE,
		.of_match_table	= pgtest_of_match,
	},
	.probe		= pgtest_probe,
	.remove		= pgtest_remove,
};



static int etx_open(struct inode *inode, struct file *file)
{
        /*Creating Physical memory*/
        if((kernel_buffer = kmalloc(mem_size , GFP_KERNEL)) == 0){
            printk(KERN_INFO "Cannot allocate memory in kernel\n");
            return -1;
        }
//DEBUG        printk(KERN_INFO "Device File Opened...!!!\n");


        return 0;
}

static int etx_release(struct inode *inode, struct file *file)
{
//DEBUG        printk(KERN_INFO "Device File Closed...!!!\n");
        return 0;
}
void find_physical_pte(void *addr)
{
    pgd_t *pgd;
    pud_t *pud;
    pmd_t *pmd;
    pte_t *ptep;
    unsigned long long address;
    address = (unsigned long long)addr;

//DEBUG    printk(KERN_INFO "\n\n## Flush PTE for virtual %llx ##\n",address);
//    flush_dcache_poc(address,1024 *4);


    pgd = pgd_offset(current->mm, address);
//DEBUG    printk(KERN_INFO "\npgd is: %llx\n", (void *)pgd);
//DEBUG    printk(KERN_INFO "\npgd v2p is: %llx\n", virt_to_phys((void *)pgd));
//DEBUG    printk(KERN_INFO "pgd value: %llx %llx, \n", *(pgd + 4), *pgd);
    if (pgd_none(*pgd) || pgd_bad(*pgd))
      printk(KERN_INFO "pgd error\n");

  //  flush_kernel_vmap_range(pgd, 1024 *4);

//    flush_dcache_poc(pgd,1024 *4);
    pud = pud_offset(pgd, address);
//DEBUG    printk(KERN_INFO "\npud is: %llx\n", (void *)pud);
//DEBUG   printk(KERN_INFO "pud value: %llx\n", *pud);
    if (pud_none(*pud) || pud_bad(*pud))
      printk(KERN_INFO "pud error\n");

//    flush_kernel_vmap_range(pud, 1024 *4);
//    flush_dcache_poc(pud,1024 *4);
    pmd = pmd_offset(pud, address);
//DEBUG    printk(KERN_INFO "\npmd is: %llx\n", (void *)pmd);
//DEBUG    printk(KERN_INFO "pmd value: %llx\n",*pmd);
    if (pmd_none(*pmd) || pmd_bad(*pmd))
       printk(KERN_INFO "pmd error\n");


      //      flush_kernel_vmap_range(pmd, 1024 *4);

//    flush_dcache_poc(pmd,1024 *4);

    ptep = pte_offset_kernel(pmd, address);
//DEBUG    printk(KERN_INFO "\npte is: %llx\n", (void *)ptep);
//DEBUG    printk(KERN_INFO "pte value: %llx\n",*ptep);
    if (!ptep)
        printk(KERN_INFO "ptep error\n")  ;

    //        flush_kernel_vmap_range(ptep, 1024 *4);


//    flush_dcache_poc(ptep,1024 *4);

//    printk(KERN_INFO "flush_dcache_poc\n")  ;


}

//get the pgd
// while size > 0


#define PUD_LIMIT ((1 << 9 ) - 1) << 30
#define PMD_LIMIT ((1 << 9 ) - 1) << 21
#define PTEP_LIMIT ((1 << 9 ) - 1) << 12

//create target address


void flush_pte_range(void *addr,unsigned long long size)
{ //#FIXME add some functionality for greater granularity sizes
//DEBUG    unsigned int flushed_pte = 0;
    //these are entries in the table. So PGD is a reference in the pgd to a pud
    pgd_t *pgd;
    pud_t *pud;
    pmd_t *pmd; //this will hold a refernce to the PTE
    pte_t *ptep;

    unsigned long long address, target_address;
    address = (unsigned long long)addr;
    target_address = address + size;
//DEBUG    printk(KERN_INFO "\n\n## Flush PTE for virtual %llx TARGET ADDRESS %llx##\n",address,target_address);


    while(address != target_address){
      pgd = pgd_offset(current->mm, address);
      if (pgd_none(*pgd) || pgd_bad(*pgd))
      {
        //todo return error code
        printk(KERN_INFO "pgd error\n");
        return 0;
      }
      while((address < target_address))
      {
        pud = pud_offset(pgd, address);
        if (pud_none(*pud) || pud_bad(*pud))
        {
          printk(KERN_INFO "pud error\n");
          return 0;
        }
        while((address < target_address) )
        {
          pmd = pmd_offset(pud, address);
          if (pmd_none(*pmd) || pmd_bad(*pmd))
          {
              printk(KERN_INFO "pmd error  ADDRESS %llx, TARGET ADDRESS %llx \n",address,target_address);
              return 0;
          }
          //todo - we might need to check for valid ptep - but not if we are aligning might not be a ptep
          //todo ptep is an address in the frame need to align the flush

	//flush the ptes
	// pmd &= ~(1<<12 - 1);
     //// pmd = (void *) ((uintptr_t) pmd & ((uintptr_t) ~(1<<12-1)));

	//  printk(KERN_INFO "FLUSH PTE FRAME %lx\n", address);
  unsigned long long flushaddress = address & ((unsigned long long) ~((1<<12)-1));
  //printk(KERN_INFO "FLUSH PTE FRAME %lx\n", flushaddress);
    	ptep = pte_offset_kernel(pmd,flushaddress  );
 //   printk(KERN_INFO "\npte is: %llx\n", (void *)ptep);
 //   printk(KERN_INFO "pte value: %llx\n",*ptep);
 	  if (!ptep)
        printk(KERN_INFO "ptep error\n")  ;

          flush_dcache_poc(ptep, 1024 *4);



//DEBUG	  flushed_pte++;
          flush_dcache_poc(pmd,1024 *4);
          address += (1 << 12);

	 if(((PMD_LIMIT & address) == PMD_LIMIT))
		break;
	}
//	pud &= ~(1<<21 - 1);



    ////  pud = (void *) ((uintptr_t) pud & ((uintptr_t) ~(1<<21-1)));

	//flush the pmd
        flush_dcache_poc(pud,1024 *4);
        //address += (1 << 30);
	if((PUD_LIMIT & address) == PUD_LIMIT)
		break;
      }
     // pgd &= ~(1<<30 - 1);
////      pgd = (void *) ((uintptr_t) pgd & ((uintptr_t) ~(1<<30-1)));
      //flush the pud
      flush_dcache_poc(pgd,1024 *4);

      	//needed for huge table
	//address += (1 << 39)
    }//In the future, maybe a PGD table flush is required, for larger mallocs(TB)
    flush_dcache_poc(current->mm,1024 *4);
  //  printk(KERN_INFO "flushed PTE number: %u \n",flushed_pte);
    return 0;

}

typedef struct
{
    unsigned int size;
    unsigned long long address;
    unsigned int smr;
    unsigned long long new_address;
} mem_ops_t;

#define MEM_OPS_SET_TTBR _IOW('q', 'a', mem_ops_t *)
#define MEM_OPS_CLEAR_CACHE _IOW('q', 'b', mem_ops_t *)
#define MEM_OPS_CLEAR_PG _IOW('q', 'c', mem_ops_t *)
#define MEM_OPS_SET_OS _IOW('q', 'd', mem_ops_t *)
#define MEM_OPS_SET_SMR _IOW('q', 'e', mem_ops_t *)
#define MEM_OPS_SET_PTE_ADDR _IOW('q', 'f', mem_ops_t *)

static  change_pte(pte_t *ptep, pgtable_t token, unsigned long addr, void *data)
{
  pgprot_t os_clear,os_set;

	unsigned long int * cdata = data;
	pte_t pte = READ_ONCE(*ptep);
	//SET VALUE TO 3 = OUTER SHAREABLE
//DEBUG  printk(KERN_INFO "set OS pte value: %llx\n",*ptep);
  pte_val(pte) &= ~(u64)(3 << 8);
  pte_val(pte) |= (2 << 8);

//extract the bits from pte
  unsigned long long pte_bits = pte_val(pte) & 0xff;
  unsigned long long pte_val_new = pte_val(pte) & 0x00;
  pte_val_new = pte_val_new >> 59; //hardwiring the 2 LS bits to 3 to change the cacheability according to the MAIR register and the memory.h.
  pte_val(pte) &= 0xFFFFFFFFFFFFFFE0;
        pte_val(pte) |= (1 << 0);
        pte_val(pte) |= (1 << 1);
        pte_val(pte) |= (1 << 2);
        pte_val(pte) |= (1 << 3);

//  pte_val(pte) |= pgprot_val(prot);
	set_pte(ptep, pte);
//DEBUG  printk(KERN_INFO "set OS pte value: %llx\n",*ptep);
//    printk(KERN_INFO "change_pte: addr is %lx\n",addr);
//    printk(KERN_INFO "change_pte: pte is %lx\n",(unsigned long) ptep)	;

	return;
}


static  change_pte_addr(pte_t *ptep, pgtable_t token, unsigned long addr, void *data)
{
//  pgprot_t os_clear,os_set;

        unsigned long long * cdata = (unsigned long long *)data;
        pte_t pte = READ_ONCE(*ptep);
//DEBUG  printk(KERN_INFO "set total pte value:``` %llx\n",*ptep);
  //pte_val(pte) =  0xe80000A0010e4f;
//DEBUG  printk(KERN_INFO "total pte value has ben seet to:``` %llx\n",*ptep);

        set_pte(ptep, pte);
  // printk(KERN_INFO "change_pte: addr is %lx\n",addr);
//DEBUG    printk(KERN_INFO "change_pte_addr: pte is %lx\n",(unsigned long) ptep) ;

        return;
}






mem_ops_t mem_in;


static int set_ttbr(long long temp)
{

  //copy_from_user(&temp, buf, sizeof(long long));
//DEBUG  printk(KERN_INFO "Temp received in driver %llx",temp);

  //find pte start and end flush all concering PGD PUD PMD PTE
  //at the moment in only findes the pte for the pointer address and flushes 4k of memory
  //starting from that address
  find_physical_pte(temp);

  u64 reg64;
  u32 reg,reg2;
  void __iomem  *gr1_base;

  gr1_base = ARM_SMMU_GR1(g_smmu);
  //sets 64bit VA
  writel_relaxed(0x1, gr1_base + ARM_SMMU_GR1_CBA2R(0));

  void __iomem *cb_base;

  reg64 = virt_to_phys(pgd_offset(current->mm,0));
  flush_cache_mm(current->mm);

  cb_base = ARM_SMMU_CB_BASE(g_smmu) + ARM_SMMU_CB(g_smmu,0);

  reg64 |= (u64)current->pid << TTBRn_ASID_SHIFT;
  writeq_relaxed(reg64, cb_base + ARM_SMMU_CB_TTBR0);

//DEBUG  printk(KERN_INFO "written page table to ttbr0 %llx \n",reg64);


  reg64 = (ARM_LPAE_TCR_SH_IS << ARM_LPAE_TCR_SH0_SHIFT) |
  (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_IRGN0_SHIFT) |
  (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_ORGN0_SHIFT);

  reg64 |= ARM_LPAE_TCR_TG0_4K;
  reg64 |= (ARM_LPAE_TCR_PS_48_BIT << ARM_LPAE_TCR_IPS_SHIFT);
  reg64 |= (64ULL - 48) << 0;
  reg64 |= ARM_LPAE_TCR_EPD1;

  reg2 = reg64 >> 32;
  reg2 |= TTBCR2_SEP_UPSTREAM;

  writel_relaxed(reg2, cb_base + ARM_SMMU_CB_TTBCR2);


  //end TTBR
  writel_relaxed(reg64, cb_base + ARM_SMMU_CB_TTBCR);

  reg = (ARM_LPAE_MAIR_ATTR_NC
   << ARM_LPAE_MAIR_ATTR_SHIFT(ARM_LPAE_MAIR_ATTR_IDX_NC)) |
  (ARM_LPAE_MAIR_ATTR_WBRWA
   << ARM_LPAE_MAIR_ATTR_SHIFT(ARM_LPAE_MAIR_ATTR_IDX_CACHE)) |
  (ARM_LPAE_MAIR_ATTR_DEVICE
   << ARM_LPAE_MAIR_ATTR_SHIFT(ARM_LPAE_MAIR_ATTR_IDX_DEV));

   writel_relaxed(reg, cb_base + ARM_SMMU_CB_S1_MAIR0);
   reg2 = 0;
   writel_relaxed(reg2, cb_base + ARM_SMMU_CB_S1_MAIR1);

   reg = SCTLR_CFIE | SCTLR_CFRE | SCTLR_AFE | SCTLR_TRE | SCTLR_M | SCTLR_S1_ASIDPNE;

    writel_relaxed(reg, cb_base + ARM_SMMU_CB_SCTLR);
    int irq, ret = 0;
    irq = g_smmu->irqs[1];
    ret = devm_request_irq(g_smmu->dev, irq, arm_smmu_context_fault,
                 IRQF_SHARED, "arm-smmu-context-fault", g_smmu);
     if (ret < 0) {
        dev_err(g_smmu->dev, "failed to request context IRQ %d (%u)\n",
          0, irq);
      }

  return 0;
}


static long memops_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
{
  void * empty;
	if(copy_from_user(&mem_in, (mem_ops_t *)arg, sizeof(mem_in)))
	{
    //printk(KERN_INFO "Value = %d\n", mem_in.size);
    printk(KERN_INFO "ioctl error on copy\n");
		return -EACCES;
	}
	else
	{
    int ret;

		switch(cmd)
		{
      case MEM_OPS_SET_TTBR:
        // this sets the ttbr0 of cb0 to be that of the calling application
        //it will also flush the pte of the address passed and the next 4k from the pte (to be fixed)
        //todo - we should probably not take an address e.g. just use virtual address 0.

        set_ttbr(mem_in.address);

      break;

			case MEM_OPS_CLEAR_CACHE:
      //clear the cache of a given virtual address
				 printk(KERN_INFO "Clear Cache\n");

			break;
			case MEM_OPS_CLEAR_PG:
      //clear the pte entries from the cache for a given range.

      //this needs to better that the version called by set_ttbr
				 printk(KERN_INFO "Clear PTE from cache\n");
				flush_pte_range((void *)mem_in.address,mem_in.size);

			break;
                        case MEM_OPS_SET_SMR:
      //sets the stream match register of the SMMU  according to the user input address.
      //this needs to better that the version called by set_ttbr
			         printk(KERN_INFO "Setting the Stream Match Register\n");
	                    writel_relaxed(mem_in.smr, gr0_base + ARM_SMMU_GR0_SMR(0));

//DEBUG			printk(KERN_INFO "SMR0 vaddr is %lx\r\n",virt_to_phys(0xfd800800));

                   	break;
			case MEM_OPS_SET_OS: //clear the pointer page table entries
        //set the pte for a range to outer sharable.


//DEBUG                printk(KERN_INFO "Setting Outer Sharable for %llx\n",mem_in.address);
//				find_physical_pte(mem_in.address);

				ret = apply_to_page_range(current->mm, mem_in.address, mem_in.size, change_pte, empty);
				//find_physical_pte(mem_in.address);


  				flush_tlb_all();


//DEBUG        printk(KERN_INFO "Set outersharable\n");

				//printk(KERN_INFO "SET OUTER SHARE on PTE err = %d \n",ret);
               		break;

 case MEM_OPS_SET_PTE_ADDR: //clear the pointer page table entries
        //set the pte for a range to outer sharable.


//DEBUG                printk(KERN_INFO "Setting Outer Sharable for %llx\n",mem_in.address);
//                              find_physical_pte(mem_in.address);

                                ret = apply_to_page_range(current->mm, mem_in.address, mem_in.size, change_pte_addr,(void *)&mem_in.new_address );
                                //find_physical_pte(mem_in.address);


                                flush_tlb_all();


//DEBUG        		printk(KERN_INFO "Pointing PTE to addr(could be bram)\n");

                        break;



			default:
			   return -EINVAL;
		}
	}
	return 0;
}


static ssize_t etx_write(struct file *filp, const char __user *buf, size_t len, loff_t *off)
{
  printk(KERN_INFO "Write Function not in use\n");
  return 0;
}

static ssize_t etx_read(struct file *filp, char __user *buf, size_t len, loff_t *off)
{
        printk(KERN_INFO "Read Function not in use\n");
        return 0;
}

static struct file_operations fops =
{
        .owner          = THIS_MODULE,
        .open           = etx_open,
        .release        = etx_release,
        .write          = etx_write,
        .unlocked_ioctl = memops_ioctl,
        .read           = etx_read
};





static int __init pgtest_init(void)
{
	printk("Loading PgTEST.\n");


//this section is related to proc entries

if((alloc_chrdev_region(&dev_sys, 0, 1, "etx_Dev")) <0){
        printk(KERN_INFO "Cannot allocate major number\n");
        return -1;
}
printk(KERN_INFO "Major = %d Minor = %d \n",MAJOR(dev_sys), MINOR(dev_sys));

cdev_init(&etx_cdev,&fops);
etx_cdev.owner = THIS_MODULE;
etx_cdev.ops = &fops;
if((cdev_add(&etx_cdev,dev_sys,1)) < 0){
  printk(KERN_INFO "Cannot add the device to the system\n");
  goto r_class;
}
if((dev_class = class_create(THIS_MODULE,"etx_class")) == NULL){
  printk(KERN_INFO "Cannot create the struct class\n");
  goto r_class;
}
if((device_create(dev_class,NULL,dev_sys,NULL,"etx_device")) == NULL){
    printk(KERN_INFO "Cannot create the Device 1\n");
    goto r_device;
}
printk(KERN_INFO "Device Driver Insert...Done!!!\n");






//end of proc entries

	return platform_driver_register(&pgtest_driver);

  r_device:
      class_destroy(dev_class);
  r_class:
      unregister_chrdev_region(dev_sys,1);
      return -1;
}


static void __exit pgtest_exit(void)
{
  device_destroy(dev_class,dev_sys);
  class_destroy(dev_class);
  cdev_del(&etx_cdev);
  unregister_chrdev_region(dev_sys, 1);
  printk(KERN_INFO "Device Driver Remove...Done!!!\n");


	platform_driver_unregister(&pgtest_driver);
	printk(KERN_ALERT "Goodbye module world.\n");

}

module_init(pgtest_init);
module_exit(pgtest_exit);
