/********实现输入整数的逆序输出***********/
#include <stdio.h>

int reverse(int a){
    int num = 0;
    do{
        num = num * 10 + a % 10 ;
        a = a / 10;
    }while(a != 0);
    return num;
}

int main(){
    int a;
    printf("please input a number:\n");
    scanf("%d", &a);
    printf("reverse: %d", reverse(a));

    return 0;
}