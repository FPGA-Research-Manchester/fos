#pragma once
#include "RNG.h"

template<typename DATA_T>
class EuropeanOptionStatus{
	public:
		EuropeanOptionStatus(DATA_T p = 0){
			stockPrice = p;
			valid = true;
		}
		void init(DATA_T p){
			stockPrice = p;
			valid = true;
		}

		void update(){
		}
		
		DATA_T price(){
			return stockPrice;
		}

		DATA_T stockPrice;
		bool valid;
};


