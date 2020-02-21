/*----------------------------------------------------------------------------
 *
 * Author:   Liang Ma (liang-ma@polito.it)
 *
 *----------------------------------------------------------------------------
 */
#ifndef __VOLDATA_H__
#define __VOLDATA_H__

template<typename DATA_T>
class volData
{
	public:
		DATA_T expect;
		DATA_T kappa;
		DATA_T variance;
		DATA_T initValue;
		DATA_T correlation;

		volData(DATA_T, DATA_T,DATA_T,DATA_T,DATA_T);
		volData(const volData&);
		void print()const;
		static DATA_T truncFun1(DATA_T);
		static DATA_T truncFun2(DATA_T);
		static DATA_T truncFun3(DATA_T);
};

	template<typename DATA_T>
volData<DATA_T>::volData(DATA_T expect,
		DATA_T kappa,
		DATA_T variance,
		DATA_T initValue,
		DATA_T correlation)
{
	this->expect=expect;
	this->kappa=kappa;
	this->variance=variance;
	this->initValue=initValue;
	this->correlation=correlation;
}

	template<typename DATA_T>
volData<DATA_T>::volData(const volData& data)
{
	this->expect=data.expect;
	this->kappa=data.kappa;
	this->variance=data.variance;
	this->initValue=data.initValue;
	this->correlation=data.correlation;
}


	template<typename DATA_T>
DATA_T volData<DATA_T>::truncFun1(DATA_T x)
{
	return x;
}
	template<typename DATA_T>
DATA_T volData<DATA_T>::truncFun2(DATA_T x)
{
	return fmax(x,0);
}
	template<typename DATA_T>
DATA_T volData<DATA_T>::truncFun3(DATA_T x)
{
	return fmax(x,0);
}

#ifdef __CLIANG__
using namespace std;
template<typename DATA_T>
void volData<DATA_T>::print()const
{
	cout<<"expect:"<<expect<<' '
		<<"variance:"<<variance<<' '
		<<"initValue:"<<initValue<<' '
		<<"correlation:"<<correlation<<endl;
}
#endif
#endif
