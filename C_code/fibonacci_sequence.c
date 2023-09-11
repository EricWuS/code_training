/************C 语言实现fibonacci sequence**************/
#include <stdio.h>

int main() {
    int n, t1, t2, nextTerm;
    t1 = 0;
    t2 = 1;
    printf("请输入需要输出的斐波那契数列的项数：");
    scanf("%d", &n);
    printf("%d项斐波那契数列:", n);
    for (int i = 0; i < n; ++i) 
    {
        printf("%d ", t2);
        nextTerm = t1 + t2;
        t1 = t2;
        t2 = nextTerm;
    }
    return 0;
    
}