/**************联发科21校招题 C语言实现简单加密 *************************
 * 有一套四位数加密系统，输入四位数以后会自动加密。
 * 加密规则如下：每位数字都加上 5，然后用和除以 10 的余数代替该数字，分别再将第一位和第四位交换、第二位和第三位交换
 * */
#include <stdio.h>

int main() {
    int data_in;
    char A, B, C, D;
    char A1, B1, C1, D1;
    int data_out;

    while (1)
    {
        printf("please input a number: ");
        scanf("%d", &data_in);
        if(data_in == 1111){
            printf("exit\n");
            break;
        }

        A = data_in / 1000;
        B = data_in % 1000 / 100;
        C = data_in % 100 / 10;
        D = data_in % 10;

        A1 = (A + 5) % 10;
        B1 = (B + 5) % 10;
        C1 = (C + 5) % 10;
        D1 = (D + 5) % 10;

        data_out = D1 * 1000 + C1 * 100 + B1 * 10 + A1;
        printf("data_out = %04d\n", data_out); 
    }
    
    return 0;
}