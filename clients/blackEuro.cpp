#include <stdio.h>
#include <stdlib.h>
#include <chrono>
#include <iostream>
#include <math.h>
#include <float.h>

#include "udmalib/udma.h"
#include "proto/fpga_rpc_c.h"

#define max32       (0xffffffff)
#define intify64(x) (*(uint64_t*)&x)
#define intify32(x) (*(uint32_t*)&x)
#define top32(x)    (intify64(x) >> 32 & max32)
#define bot32(x)    (intify64(x) & max32)


int main(int argc, char **argv)
{
	printf("In main\n");

	// get fpga rpc client instance
  	FPGARPCClient fpgaRpc;

  	// get free udma buffer from daemon
  	UdmaRepo repo;
  	int bufno = fpgaRpc.Alloc();
  	if (bufno < 0) throw std::runtime_error("Failed to get buffer from daemon");
  	UdmaDevice *device = repo.device(bufno);
	char *buffer = device->map();
	uint64_t bufferPhy = device->phys_addr;

	int num_accels = 1;
	int num_runs = 16;
	int sims = 1024, steps=1024;

	float initPrice = 100;	// -s
	float strikePrice = 110;// -k
	float rate = 0.05;   		// -r
	float volatility = 0.2;	// -v
	float time = 1.0;			  // -t

	float callR=6.04, putR=10.65; // taken from makefile

	if (argc > 1)
	  num_accels = std::stoi(argv[1]);


	//float hCall[num_accels];
	//float hPut[num_accels];

	int buflen = sizeof(float) * num_accels;
	
	float *hCall = (float*) (buffer);
	float *hPut  = (float*) (buffer + buflen);
	uint64_t hCallPhy = (bufferPhy);
	uint64_t hPutPhy  = (bufferPhy + buflen);

	int i = 0;

	for(i=0; i<num_runs; i++){
		hCall[i] = -1; // placeholder value
		hPut[i] = -1;
	}

	int num_time_samples = 10;
	long time_samples[num_time_samples];
	for(int s = 0; s < num_time_samples; s++){
		auto start = std::chrono::high_resolution_clock::now();
		
		int j = 0;
		while(j < num_runs){
			// build and fire off fpga job
		  	std::vector<Job> jobs;              // create list of jobs
			for(i=0; i<num_accels && j < num_runs; i++)
			{
		  		Job& job = jobs.emplace_back();     // add job
		  		job.accname = "Partial_blackEuro";  // set accelerator name
		  		job.params["pCall_1"]     = bot32(hCallPhy); // call price and put price
		  		job.params["pCall_2"]     = top32(hCallPhy);
		  		job.params["pPut_1"]      = bot32(hPutPhy);
		  		job.params["pPut_2"]      = top32(hPutPhy);
		  		job.params["timeT"]       = intify32(time); // time period of options
		  		job.params["freeRate"]    = intify32(rate); // interest rate of the riskless asset
		  		job.params["volatility"]  = intify32(volatility); // volatility of the risky asset
		  		job.params["initPrice"]   = intify32(initPrice); // stock price at time 0
		  		job.params["strikePrice"] = intify32(strikePrice); // strike price
		  		job.params["steps"]       = steps;
		  		job.params["sims"]        = sims;
		  		job.params["g_id"]        = i;
				
				j++;
			}
		 	fpgaRpc.Run(jobs);                  // send the jobs to the daemon
	
		}
	
		auto stop = std::chrono::high_resolution_clock::now();
		long duration = std::chrono::duration_cast<std::chrono::milliseconds>(stop - start).count();
  		time_samples[s] = duration;
		std::cout << "Processing took: " << duration << "ms" << std::endl;
	}

	float pCall=0, pPut=0;
	for(int i=0; i<num_runs; i++){
		pCall+= hCall[i];
		pPut += hPut[i];
	}

	pCall/=num_runs*expf(rate*time);
	pPut/=num_runs*expf(rate*time);

	printf("pCall: %f  pPut: %f\n", pCall, pPut);

	printf("The difference with the reference value is %f%%\n", 
			fabs(pCall/callR-1)*100);

	printf("The difference with the reference value is %f%%\n", 
			fabs(hPut[0]/putR-1)*100);
	
	long total_duration = 0;
	for(int s = 0; s < num_time_samples; s++){
		total_duration += time_samples[s];
	}
	std::cout << "Average processing latency: " << (total_duration/num_time_samples)  << "ms" << std::endl;

	device->unmap();
	fpgaRpc.Free(bufno);

	return 0;
}
