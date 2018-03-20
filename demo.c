# define _EXFUN(N,P) N P

int     _EXFUN(printf, (const char *, ...));
int     _EXFUN(scanf, (const char *, ...));


char name[24];

int main(){
  printf("What is your name?\n");
  scanf("%s", &name);
  printf("Hello %s!\n", name);
}
