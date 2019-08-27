OPENCVFLAGS=$(shell pkg-config --libs --cflags opencv)
CPPFLAGS=-W -pedantic -g --std=c++11

sobel_linux: sobel_linux.cpp
	g++ sobel_linux.cpp -o sobel_linux $(CPPFLAGS) $(LDFLAGS) $(OPENCVFLAGS)

clean:
	rm *.o *~
