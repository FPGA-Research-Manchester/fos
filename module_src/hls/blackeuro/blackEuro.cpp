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
* Top function is defined here with interface specified as axi4.
* It creates an object of blackScholes and launches the simulation.
*
*----------------------------------------------------------------------------
*/
#include "RNG.h"
#include "blackScholes.h"
#include "europeanOption.h"
#include "stockData.h"
#include "launchSim.h"

	extern "C"
void blackEuro(float *pCall, float *pPut,   // call price and put price
		float timeT,				// time period of options
		float freeRate,			// interest rate of the riskless asset
		float volatility,			// volatility of the risky asset
		float initPrice,			// stock price at time 0
		float strikePrice,// strike price
		int steps,
		int sims,
		int g_id)			
{
#pragma HLS INTERFACE m_axi port=pCall bundle=gmem
#pragma HLS INTERFACE s_axilite port=pCall bundle=control
#pragma HLS INTERFACE m_axi port=pPut bundle=gmem
#pragma HLS INTERFACE s_axilite port=pPut bundle=control
#pragma HLS INTERFACE s_axilite port=timeT bundle=control
#pragma HLS INTERFACE s_axilite port=freeRate bundle=control
#pragma HLS INTERFACE s_axilite port=volatility bundle=control
#pragma HLS INTERFACE s_axilite port=initPrice bundle=control
#pragma HLS INTERFACE s_axilite port=strikePrice bundle=control
#pragma HLS INTERFACE s_axilite port=steps bundle=control
#pragma HLS INTERFACE s_axilite port=sims bundle=control
#pragma HLS INTERFACE s_axilite port=g_id bundle=control
#pragma HLS INTERFACE s_axilite port=return bundle=control

#pragma HLS ALLOCATION instances=mul limit=1 operation
#pragma HLS ALLOCATION instances=fmul limit=1 operation
#pragma HLS ALLOCATION instances=fexp limit=1 operation
#pragma HLS ALLOCATION instances=fdiv limit=1 operation
	static const int SIMS_PER_GROUP =32;
	stockData<float> sd(timeT,freeRate,volatility,initPrice,strikePrice);
	
	float call0, put0;
	blackScholes<SIMS_PER_GROUP,EuropeanOptionStatus<float>, float> bs0(sd, steps);
//	float call1, put1;
//	blackScholes<SIMS_PER_GROUP,EuropeanOptionStatus<float>, float> bs1(sd, steps);
//	float call2, put2;
//	blackScholes<SIMS_PER_GROUP,EuropeanOptionStatus<float>, float> bs2(sd, steps);
//	float call3, put3;
//	blackScholes<SIMS_PER_GROUP,EuropeanOptionStatus<float>, float> bs3(sd, steps);
//	float call4, put4;
//	blackScholes<SIMS_PER_GROUP,EuropeanOptionStatus<float>, float> bs4(sd, steps);
//	float call5, put5;
//	blackScholes<SIMS_PER_GROUP,EuropeanOptionStatus<float>, float> bs5(sd, steps);
//	float call6, put6;
//	blackScholes<SIMS_PER_GROUP,EuropeanOptionStatus<float>, float> bs6(sd, steps);
//	float call7, put7;
//	blackScholes<SIMS_PER_GROUP,EuropeanOptionStatus<float>, float> bs7(sd, steps);
//	float call8, put8;
//	blackScholes<SIMS_PER_GROUP,EuropeanOptionStatus<float>, float> bs8(sd, steps);
//	float call9, put9;
//	blackScholes<SIMS_PER_GROUP,EuropeanOptionStatus<float>, float> bs9(sd, steps);
//	float call10, put10;
//	blackScholes<SIMS_PER_GROUP,EuropeanOptionStatus<float>, float> bs10(sd, steps);
//	float call11, put11;
//	blackScholes<SIMS_PER_GROUP,EuropeanOptionStatus<float>, float> bs11(sd, steps);
//	float call12, put12;
//	blackScholes<SIMS_PER_GROUP,EuropeanOptionStatus<float>, float> bs12(sd, steps);
//	float call13, put13;
//	blackScholes<SIMS_PER_GROUP,EuropeanOptionStatus<float>, float> bs13(sd, steps);
//	float call14, put14;
//	blackScholes<SIMS_PER_GROUP,EuropeanOptionStatus<float>, float> bs14(sd, steps);
//	float call15, put15;
//	blackScholes<SIMS_PER_GROUP,EuropeanOptionStatus<float>, float> bs15(sd, steps);
	{
#pragma HLS FUNCTION_EXTRACT
#pragma HLS DATAFLOW

		// Replicate launchSimulation and spread work with sims*steps, sims parameters for
		// varying amount of resources uages. Performance vs Area tradeoff.

		launchSimulation(call0, put0,  g_id, bs0, sims*steps, sims);
//		launchSimulation(call1, put1,  g_id+1, bs1, sims*steps>>1, sims>>1);

//		launchSimulation(call0, put0, g_id+0, bs0, sims*steps>>4, sims>>4);
//		launchSimulation(call1, put1, g_id+1, bs1, sims*steps>>4, sims>>4);
//		launchSimulation(call2, put2, g_id+2, bs2, sims*steps>>4, sims>>4);
//		launchSimulation(call3, put3, g_id+3, bs3, sims*steps>>4, sims>>4);
//		launchSimulation(call4, put4, g_id+4, bs4, sims*steps>>4, sims>>4);
//		launchSimulation(call5, put5, g_id+5, bs5, sims*steps>>4, sims>>4);
//		launchSimulation(call6, put6, g_id+6, bs6, sims*steps>>4, sims>>4);
//		launchSimulation(call7, put7, g_id+7, bs7, sims*steps>>4, sims>>4);
//		launchSimulation(call8, put8, g_id+8, bs8, sims*steps>>4, sims>>4);
//		launchSimulation(call9, put9, g_id+9, bs9, sims*steps>>4, sims>>4);
//		launchSimulation(call10, put10, g_id+10, bs10, sims*steps>>4, sims>>4);
//		launchSimulation(call11, put11, g_id+11, bs11, sims*steps>>4, sims>>4);
//		launchSimulation(call12, put12, g_id+12, bs12, sims*steps>>4, sims>>4);
//		launchSimulation(call13, put13, g_id+13, bs13, sims*steps>>4, sims>>4);
//		launchSimulation(call14, put14, g_id+14, bs14, sims*steps>>4, sims>>4);
//		launchSimulation(call15, put15, g_id+15, bs15, sims*steps>>4, sims>>4);
	}

	pCall[g_id] = (call0
//			+call1
//			+call2
//			+call3
//			+call4
//			+call5
//			+call6
//			+call7
//			+call8
//			+call9
//			+call10
//			+call11
//			+call12
//			+call13
//			+call14
//			+call15
			)/sims;
	pPut[g_id] =(put0
//			+put1
//			+put2
//			+put3
//			+put4
//			+put5
//			+put6
//			+put7
//			+put8
//			+put9
//			+put10
//			+put11
//			+put12
//			+put13
//			+put14
//			+put15
			)/sims;
}
