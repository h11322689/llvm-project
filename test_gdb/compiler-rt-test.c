/*************************************************************************
	> File Name: compiler-rt-test.c
	> Author: Lihao
	> Mail: h11322689@gmail.com 
	> Created Time: Thu 04 Jul 2024 01:48:32 PM CST
 ************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

int main() 
{
    uint64_t a = 0ULL, b = 0ULL;
    scanf("%lld %lld", &a, &b);
    printf("64-bit division is %lld\n", a / b);
    return EXIT_SUCCESS;
}

