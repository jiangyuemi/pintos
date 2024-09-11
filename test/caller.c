#include "stdio.h"

int a[2] = {1, 2};
int b[2] = {3, 4};

int*
get_a() {
  return a;
}

int*
get_b() {
  return b;
}

void
printf_a(int* a_){
  printf("addr of a = %p\n", a_);
}

int*
printf_b(int* b_){
  printf("addr of b = %p\n", b_);
  return b_;
}

void
f(){
  int* a_temp = get_a();
  int* b_temp = get_b();
  int* c = NULL;

  printf_a(a_temp);
  c = printf_b(b_temp);
}


void
main()
{
  f();
}