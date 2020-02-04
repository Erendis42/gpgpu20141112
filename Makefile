PROG = PoC1 
all: $(PROG)
%: %.cu
	nvcc -o $@ $< -lncurses
#	nvcc -o $@ $< -keep -lncurses

clean:
	rm $(PROG)
