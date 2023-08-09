def day_of_year(year, month, day):
    days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

    if((year % 4 == 0 and year % 100  != 0) or year % 400 == 0):
        days_in_month[1] = 29
    
    dayth = sum(days_in_month[:month - 1]) + day

    return dayth

if __name__ == '__main__':
    # year, month, day = map(int, input("请输入年 月 日（格式为2023 5 20）：").split())
    year, month, day = map(int, input("请输入年 月 日（格式为2015 5 12）: ").split())

    dayth = day_of_year(year, month, day)
    print("该日期是这一年中的第{}天".format(dayth))