//: Playground - noun: a place where people can play

import UIKit

// 1.内部参数(名称)和外部参数(名称)
/*
 内部参数:在函数内部可以看到的参数名称就是内部参数. 默认情况下,所有的参数都是内部参数
 外部参数:在函数外部可以看到的参数名称就是外部参数. 默认情况下从第二个参数开始就是外部参数.
 如果希望第一个参数也是外部参数: 可以在第一个参数的标识符前加上外部参数的名称
 如果希望第二参数开始都不是外部参数,那么可以在第二个参数(或者之后)标识符前加上 _
*/
func sum(num1 : Int, _ num2 : Int, _ num3 : Int) -> Int {
    return num1 + num2 + num3
}

sum(20, 30, 40)
