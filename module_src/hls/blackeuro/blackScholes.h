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
* This class is called "blackScholes" which implements the BS model.
*
* simulation() is launched by top function.
* It defines and initializes some objects of RNG and then launch the simulation.
*
* sampleSIM performs the entire simulation and passes the results to top function.
*
*----------------------------------------------------------------------------
*/
#ifndef __BLACKSCHOLES__
#define __BLACKSCHOLES__
#include "hls_stream.h"
#include "stockData.h"
#include "hls_math.h"
using namespace std;

template<int NUM_SIMS, typename OptionStatus,  typename DATA_T>
class blackScholes
{
	const stockData<DATA_T> data;
	const int NUM_STEPS;
	public:
	blackScholes(stockData<DATA_T>&data, int num_steps):data(data),
	NUM_STEPS(num_steps){}

	void simulation(hls::stream<DATA_T>& s_RNG0,hls::stream<DATA_T>& s_RNG1, int sims,  DATA_T &pCall, DATA_T &pPut)
	{
		DATA_T call = 0, put = 0;
		hls::stream<DATA_T> prices;
#pragma HLS STREAM variable=prices depth=NUM_SIMS dim=1
#pragma HLS DATAFLOW
		path_sim(s_RNG0, s_RNG1, prices, sims);
		sum(prices, call, put, sims);
		pCall= call;
		pPut = put;
	}
	void path_sim(hls::stream<DATA_T>& s_RNG0,hls::stream<DATA_T>& s_RNG1, hls::stream<DATA_T>& prices, int sims){
		OptionStatus stockPrice[NUM_SIMS];
#pragma HLS ARRAY_PARTITION variable=stockPrice cyclic factor=2 dim=1
		for(int j=0;j<NUM_SIMS;j++)
#pragma HLS PIPELINE
			stockPrice[j].init(data.price);

		for(int k=0;k<sims/NUM_SIMS;k++) {
			for(int s=0; s <NUM_STEPS;s++){
				for(int j=0;j<NUM_SIMS/2;j++) {
#pragma HLS PIPELINE
					DATA_T r0 = s_RNG0.read();
					DATA_T r1 = s_RNG1.read();
					update(stockPrice[j*2], r0);
					update(stockPrice[j*2+1], r1);
				}
			}
			for(int j=0;j<NUM_SIMS;j++){
#pragma HLS DEPENDENCE variable=stockPrice array inter RAW false
#pragma HLS PIPELINE
				DATA_T price = stockPrice[j].valid? stockPrice[j].price():data.strikePrice;
				prices.write(price);
				stockPrice[j].init(data.price);
			}
		}
	}
	void update(OptionStatus &option, DATA_T r){
#pragma HLS INLINE
		const DATA_T Dt = data.timeT / (DATA_T)NUM_STEPS,
					Rdt = 1+data.freeRate*Dt,
					SqrtV = data.volatility * sqrtf(Dt);
		option.stockPrice *= Rdt +r *SqrtV;
		option.update();
	}
	void sum(hls::stream<DATA_T> &prices, DATA_T &call, DATA_T&put, int sims){
		for(int j=0;j<sims;j++) {
#pragma HLS PIPELINE
			DATA_T price = prices.read();
			call+=executeCall(price);
			put+=executePut(price);
		}
	}
	DATA_T executeCall(DATA_T& price){
#pragma HLS INLINE
		if(price > data.strikePrice){
			return (price - data.strikePrice);
		}
		else
			return 0;
	}
	DATA_T executePut(DATA_T& price){
#pragma HLS INLINE
		if(price < data.strikePrice){
			return (data.strikePrice - price);
		}
		else
			return 0;
	}
};

#endif
