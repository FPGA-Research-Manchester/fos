
#pragma once
#include "hls_stream.h"
#include "RNG.h"
	template<typename DATA_T>
void prng(RNG<DATA_T> &rng0,RNG<DATA_T> &rng1, hls::stream<unsigned int> &sRNG0,hls::stream<unsigned int> &sRNG1, int nums){
	for(int i = 0 ; i < nums>>2;i++){
#pragma HLS PIPELINE
		unsigned int r0, r1, r2, r3;
		rng0.extract_number(&r0, &r1);
		rng1.extract_number(&r2, &r3);
		sRNG0.write(r0);
		sRNG0.write(r2);
		sRNG1.write(r1);
		sRNG1.write(r3);
	}
}
	template<typename DATA_T, typename Model>
void launchSim(DATA_T &pCall, DATA_T &pPut, RNG<DATA_T> &rng0,RNG<DATA_T> &rng1, Model &m, int numR, int sims){
#pragma HLS DATAFLOW
	hls::stream<unsigned int> s_num0;
	hls::stream<unsigned int> s_num1;
#pragma HLS STREAM variable=s_num0 depth=4 dim=1
#pragma HLS STREAM variable=s_num1 depth=4 dim=1
	hls::stream<DATA_T> sRNG0;
	hls::stream<DATA_T> sRNG1;
#pragma HLS STREAM variable=sRNG0 depth=4 dim=1
#pragma HLS STREAM variable=sRNG1 depth=4 dim=1
	
	prng(rng0, rng1, s_num0, s_num1, numR);
	
	RNG<DATA_T>::BOX_MULLER(s_num0, s_num1, sRNG0, sRNG1, numR>>1);

	m.simulation(sRNG0,sRNG1, sims, pCall, pPut);
}
	template<typename DATA_T, int SEED_STRIDE=1024, typename Model>
void launchSimulation(DATA_T &pCall, DATA_T &pPut, int seed, Model &m, int numR, int sims){
#pragma HLS INLINE off
#pragma HLS ALLOCATION instances=mul limit=1 operation
	RNG<float> rng0(seed*SEED_STRIDE);
	RNG<float> rng1(seed*SEED_STRIDE + 1);
	launchSim(pCall, pPut, rng0, rng1, m, numR, sims);
}
