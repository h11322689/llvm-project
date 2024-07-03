/*************************************************************************
	> File Name: hello.c
	> Author: Lihao
	> Mail: h11322689@gmail.com 
	> Created Time: Wed 03 Jul 2024 03:08:18 PM CST
 ************************************************************************/

#include <stdio.h>

// 定义一个结构体来表示学生信息
struct Student {
    char name[50];
    int age;
    float score;
};

// 函数：打印学生信息
void printStudent(struct Student student) {
    printf("姓名：%s\n", student.name);
    printf("年龄：%d\n", student.age);
    printf("分数：%.2f\n", student.score);
}

// 函数：计算两个整数的和
int add(int num1, int num2) {
    return num1 + num2;
}

// 主函数
int main() {
    // 定义并初始化一个学生结构体变量
    struct Student student1 = {"张三", 20, 85.5};
    // 调用打印函数输出学生信息
    printStudent(student1);

    // 定义两个整数变量
    int num1 = 10;
    int num2 = 20;
    // 调用求和函数并输出结果
    int sum = add(num1, num2);
    printf("两数之和为：%d\n", sum);

    // 使用条件判断
    if (sum > 25) {
        printf("和大于 25\n");
    } else {
        printf("和不大于 25\n");
    }

    // 使用循环计算 1 到 10 的和
    int total = 0;
    for (int i = 1; i <= 10; i++) {
        total += i;
    }
    printf("1 到 10 的和为：%d\n", total);

    // 使用指针
    int *ptr = &num1;
    printf("num1 的地址：%p, 值：%d\n", ptr, *ptr);

    return 0;
}


