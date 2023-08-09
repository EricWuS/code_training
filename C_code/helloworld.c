#include "stdio.h"

int judgeSystem(void){
    int a = 1;
    return *(char *)&a;
}
// int main() {
//     int a = 1;
//     char b;
//     printf("int = %d", sizeof(a));
//     printf("char = %d", sizeof(b));
//     return 0;
// }
int main() {
    int a = 1;
    printf("&a = %d\n", &a);
    if(judgeSystem){
        printf("小端模式");
    }else
    {
        printf("大端模式");
    }
    return 0;
}