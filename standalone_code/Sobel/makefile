OPENCVFLAGS=$(shell pkg-config --libs --cflags opencv)
CPPFLAGS=-W -pedantic -g --std=c++11

sobel_linux: sobel_linux.cpp
	g++ sobel_linux.cpp -o sobel_linux $(CPPFLAGS) $(LDFLAGS) $(OPENCVFLAGS)

sobel_soft: sobel_soft.cpp
	g++ sobel_soft.cpp -o sobel_soft $(CPPFLAGS) $(LDFLAGS) $(OPENCVFLAGS)

sobel_linux_soft: sobel_linux_soft.cpp
	g++ sobel_linux_soft.cpp -o sobel_linux_soft $(CPPFLAGS) $(LDFLAGS) $(OPENCVFLAGS)

clean:
	rm *.o *~
