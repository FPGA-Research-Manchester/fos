/* 
	 ======================================================
	 Copyright 2016 Liang Ma

	 Licensed under the Apache License, Version 2.0 (the "License");
	 you may not use this file except in compliance with the License.
	 You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
======================================================
 *
 * Author:   Liang Ma (liang-ma@polito.it)
 *
 * This class is called stockData which stores the basic data for a given stock and option.
 *
 *----------------------------------------------------------------------------
 */
#ifndef __STOCKDATA_H__
#define __STOCKDATA_H__

template<typename DATA_T>
class stockData
{
	public:
		DATA_T timeT;
		DATA_T freeRate;
		DATA_T volatility;
		DATA_T price;
		DATA_T strikePrice;

		stockData(){}
		stockData(DATA_T timeT, DATA_T freeRate, DATA_T volatility,	DATA_T price,DATA_T strikePrice)
		{
			this->freeRate=freeRate;
			this->price=price;
			this->timeT=timeT;
			this->volatility=volatility;
			this->strikePrice=strikePrice;
		}
		stockData(const stockData&data)
		{
			this->freeRate=data.freeRate;
			this->price=data.price;
			this->timeT=data.timeT;
			this->volatility=data.volatility;
			this->strikePrice=data.strikePrice;
		}
		const stockData& operator = (stockData&data){
			this->freeRate=data.freeRate;
			this->price=data.price;
			this->timeT=data.timeT;
			this->volatility=data.volatility;
			this->strikePrice=data.strikePrice;
			return *this;
		}
		void print()const;
};

#endif
