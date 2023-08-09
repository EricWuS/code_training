# 判断1-n的质数
# def isPrime(result, n):
#     for i in range(2, n):
#         flag = True
#         for j in range (2, i):
#             if i % j == 0:
#                 flag = False
#                 break
#         if flag:
#             result.append(i)
#     print(result)

def isPrime(n):
    if n <= 1:
        return False
    for i in range(2, n):
        if n % i == 0:
            return False
    return True


if __name__ == '__main__':
    result = []
    # isPrime(result, 100)
    for i in range(1, 101):
        if isPrime(i):
            result.append(i)
    print("Prime number from 1 to 100 are:\n", result)
