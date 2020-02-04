#include <stdio.h>

#define GRID 128 
#define BLOCK 32

//#define GRID 8
//#define BLOCK 2

__global__ void DumpMem(int* m)
{
	int i = blockIdx.x*gridDim.x+threadIdx.x;
	printf("%x ", m[i]);
}

__global__ void WriteToMem(int* m)
{
	int i = blockIdx.x*gridDim.x+threadIdx.x;
	m[i] = 0xC0FFEE43;
}

int main(int argc, char* argv[])
{
	cudaSetDevice(0);

	int* dm;
	int* dn;

	int memSize = sizeof(int) * GRID * GRID * BLOCK * BLOCK;

	dim3 grid(GRID,GRID);
	dim3 block(BLOCK,BLOCK);

	cudaMalloc(&dm, memSize);

	WriteToMem<<<grid,block>>>(dm);

	cudaDeviceSynchronize();

	cudaFree(dm);

	cudaMalloc(&dn, memSize);

	DumpMem<<<grid,block>>>(dn);

	cudaDeviceSynchronize();

	cudaFree(dn);

	return 0;
}
