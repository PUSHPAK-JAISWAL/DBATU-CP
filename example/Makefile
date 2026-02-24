.PHONY: py r cpp c java js ts v sh clean

py:
	python solution.py

r:
	Rscript solution.R

# C++: Added static linking to prevent the DLL error and fixed the run command
cpp:
	g++ -static solution.cpp -o solution.exe
	./solution.exe

# C: Fixed for Windows naming and execution
c:
	gcc -static solution.c -o solution.exe
	./solution.exe

java:
	javac solution.java
	java solution

js:
	node solution.js

ts:
	npx ts-node solution.ts

v:
	v run solution.v

sh:
	bash solution.sh

# Recommended: Add a clean rule to tidy up your folder
clean:
	if exist *.exe del *.exe
	if exist *.class del *.class