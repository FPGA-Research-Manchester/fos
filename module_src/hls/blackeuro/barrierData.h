/*----------------------------------------------------------------------------
*
* Author:   Liang Ma (liang-ma@polito.it)
*
*----------------------------------------------------------------------------
*/
#ifndef __BARRIERDATA_H__
#define __BARRIERDATA_H__

template<typename DATA_T>
class barrierData
{
public:
	DATA_T upBarrier;
	DATA_T downBarrier;

	barrierData(DATA_T,DATA_T);
	barrierData(const barrierData&);
	void print()const;
	bool checkRange(DATA_T)const;
};
template<typename DATA_T>
barrierData<DATA_T>::barrierData(DATA_T upBarrier, DATA_T downBarrier)
{
	if(upBarrier<downBarrier)
	{
		this->upBarrier=0;
		this->downBarrier=0;
	}
	else
	{
		this->upBarrier=upBarrier;
		this->downBarrier=downBarrier;
	}
}

template<typename DATA_T>
barrierData<DATA_T>::barrierData(const barrierData& data)
{
	this->upBarrier=data.upBarrier;
	this->downBarrier=data.downBarrier;
}

template<typename DATA_T>
bool barrierData<DATA_T>::checkRange(DATA_T stockPrice)const
{
	return (stockPrice>=downBarrier)&&(stockPrice<=upBarrier);
}

#endif
