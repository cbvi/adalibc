all:
	egcc -Wall -c extra.c
	gnatmake -Wall ohno.adb -largs extra.o
