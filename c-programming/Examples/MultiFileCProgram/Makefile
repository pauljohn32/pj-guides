main: main.o bigmonster.o                
	gcc -o myMonsterProgram main.o bigmonster.o 

main.o: main.c bigmonster.h 
	gcc -c -g main.c
bigmonster.o: bigmonster.c bigmonster.h  
	gcc -c -g bigmonster.c
