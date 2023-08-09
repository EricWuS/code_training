'''bubble sort'''
def bubble_sort(lst):
    n = len(lst)
    for i in range(n - 1):
        for j in range(n - 1 - i):
            if lst[j] > lst[j + 1]:
                lst[j], lst[j + 1] = lst[j + 1], lst[j]
    return lst

if __name__ == '__main__':
    a = [1,3,2,6,5,4,9,8,7,0]
    print(bubble_sort(a))