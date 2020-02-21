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
 * Here declares the class RNG which is short for Random Number Generator.
 * It implements 32bits Mersenne-Twist algorithm and Box-Muller transformation.
 *
 * RNG_N is the total size of the states
 * mt_e/mt_o are two arrays that stores the states.
 * extract_number produces two uniformly i.i.d. numbers
 * init()/init_array() are two functions for state initialization.
 *
 *----------------------------------------------------------------------------
 */

#pragma once
#include <cmath>
#include "hls_stream.h"
#include "ap_fixed.h"
template<typename DATA_T>
class RNG
{

	typedef unsigned int uint;
	static const uint RNG_N = 624;
	static const uint RNG_H = 312;

	static const uint RNG_MH = 198;
	static const uint RNG_MHI = 199;

	static const uint RNG_F = 0x6C078965;
	static const uint RNG_W = 32;
	static const uint RNG_M = 397;

	static const uint RNG_R = 31;

	static const uint RNG_U = 11;
	static const uint RNG_A = 0x9908B0DF;
	static const uint RNG_D = 0xFFFFFFFF;
	static const uint RNG_S = 7;
	static const uint RNG_B = 0x9D2C5680;
	static const uint RNG_T = 15;
	static const uint RNG_C = 0xEFC60000;
	static const uint RNG_L = 18;

	static const uint lower_mask = 0x7FFFFFFF;
	static const uint upper_mask = 0x80000000;

	public:
	uint index;
	uint seed;
	uint mt_e[RNG_H],mt_o[RNG_H];

	RNG(){}
	RNG(uint seed){
		this->index = 0;
		this->seed=seed;
		uint tmp=seed;

		for (int i = 0; i < RNG_H; i++)
		{
#pragma HLS PIPELINE
			mt_e[i]=tmp;
			tmp= RNG_F*(tmp^ (tmp >> (RNG_W - 2))) + (i>>1) +1;
			mt_o[i]=tmp;
			tmp= RNG_F*(tmp^ (tmp >> (RNG_W - 2))) + (i>>1) +2;
		}
	}
	void init(uint seed){
		this->index = 0;
		this->seed=seed;
		uint tmp=seed;

		for (int i = 0; i < RNG_H; i++)
		{
			mt_e[i]=tmp;
			tmp= RNG_F*(tmp^ (tmp >> (RNG_W - 2))) + i*2+1;
			mt_o[i]=tmp;
			tmp= RNG_F*(tmp^ (tmp >> (RNG_W - 2))) + i*2+2;
		}
	}

	void extract_number(uint* num1,uint* num2){
#pragma HLS INLINE
		uint id1=increase(1), idm=increase(RNG_MH), idm1=increase(RNG_MHI);

		uint x = this->seed,x1=this->mt_o[this->index],x2=this->mt_e[id1],
				 xm=this->mt_o[idm],xm1=this->mt_e[idm1];

		x = (x & upper_mask)+(x1 & lower_mask);
		uint xp = x >> 1;
		if ((x & 0x01) != 0)
			xp ^= RNG_A;
		x = xm ^ xp;

		uint y = x;
		y ^= ((y >> RNG_U)&RNG_D);
		y ^= ((y << RNG_S)&RNG_B);
		y ^= ((y << RNG_T)&RNG_C);
		y ^= (y >> RNG_L);
		*num1 = y;
		mt_e[this->index]=x;

		x1 =( x1 & upper_mask) + (x2 & lower_mask);
		uint xt = x1 >> 1;
		if ((x1 &0x01) != 0)
			xt ^= RNG_A;
		x1 = xm1 ^ xt;

		uint y1 = x1;
		y1 ^= ((y1 >> RNG_U)&RNG_D);
		y1 ^= ((y1 << RNG_S)&RNG_B);
		y1 ^= ((y1 << RNG_T)&RNG_C);
		y1 ^= (y1 >> RNG_L);
		*num2 = y1;
		mt_o[this->index]=x1;

		this->index=id1;
		this->seed=x2;
	}

	static void BOX_MULLER(hls::stream<uint>&num0,hls::stream<uint>&num1,
			hls::stream<DATA_T>&data0,hls::stream<DATA_T>&data1, int rep){
		static const DATA_T _2PI= 2*3.14159265358979323846f;
		for(int i = 0; i<rep;i++){
#pragma HLS PIPELINE
			DATA_T tp,tmp1,tmp2;
			ap_ufixed<32,0> f_tmp1, f_tmp2;
			f_tmp1(31, 0)=num0.read();
			f_tmp2(31, 0)=num1.read();
			tmp1 = f_tmp1.to_float();
			tmp2 = f_tmp2.to_float();
			tp=sqrtf(fmaxf(-2.0f*logf(tmp1),0.0f));
			DATA_T g0=cosf(_2PI*tmp2)*tp;
			DATA_T g1=sinf(_2PI*tmp2)*tp;
			data0.write(g0);
			data1.write(g1);
		}
	}

	void BOX_MULLER(DATA_T*data1, DATA_T*data2,DATA_T ave, DATA_T deviation){
#pragma HLS INLINE
		static const DATA_T _2PI= 2*3.14159265358979323846f;
		//	static const DATA_T MINI_RNG = 2.328306e-10;

		uint num1,num2;
		DATA_T tp,tmp1,tmp2;
		extract_number(&num1,&num2);
		ap_ufixed<32,0> f_tmp1, f_tmp2;
		f_tmp1(31, 0)=num1;
		f_tmp2(31, 0)=num2;
		tmp1 = f_tmp1.to_float();
		tmp2 = f_tmp2.to_float();
#ifdef __DOUBLE_PRECISION__
		tp=sqrt(fmax(-2*log(tmp1),0)*deviation);
		*data1=cos(_2PI*tmp2)*tp+ave;
		*data2=sin(_2PI*tmp2)*tp+ave;
#else
		tp=sqrtf(fmaxf(-2.0f*logf(tmp1),0.0f)*deviation);
		*data1=cosf(_2PI*tmp2)*tp+ave;
		*data2=sinf(_2PI*tmp2)*tp+ave;
#endif
	}
	uint increase(uint k){
		uint tmp= this->index+k;
		return (tmp>=RNG_H)? tmp-RNG_H:tmp;
	}

	static void init_array(RNG* rng, uint* seed,const uint size){
		uint tmp[size];
#pragma HLS ARRAY_PARTITION variable=tmp complete dim=1

		for(int i=0;i<size;i++)
		{
#pragma HLS UNROLL
			rng[i].index = 0;
			rng[i].seed=seed[i];
			tmp[i]=seed[i];
		}


		for (int i = 0; i < RNG_H; i++)
		{
			for(int k=0;k<size;k++)
			{
#pragma HLS UNROLL
				rng[k].mt_e[i]=tmp[k];
				tmp[k]= RNG_F*(tmp[k]^ (tmp[k] >> (RNG_W - 2))) + i*2+1;
				rng[k].mt_o[i]=tmp[k];
				tmp[k]= RNG_F*(tmp[k]^ (tmp[k] >> (RNG_W - 2))) + i*2+2;
			}
		}
	}

};

