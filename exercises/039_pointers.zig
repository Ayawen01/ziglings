//
// 看看这个：
//
//     var foo: u8 = 5;      // foo 是 5
//     var bar: *u8 = &foo;  // bar 是一个指针
//
// 什么是指针？它是对一个值的引用。在这个例子中
// bar 是对当前包含值 5 的内存空间的引用。
//
// 给出上面的声明，一个小抄：
//
//     u8         u8 值的类型
//     foo        值 5
//     *u8        指向 u8 值的指针的类型
//     &foo       对 foo 的引用
//     bar        指向 foo 处的值的指针
//     bar.*      值 5 (bar 处的解引用值)
//
// 我们马上就会看到指针为什么有用。现在，看看你能否让这个例子运行！
//
const std = @import("std");

pub fn main() void {
    var num1: u8 = 5;
    var num1_pointer: *u8 = &num1;

    var num2: u8 = undefined;

    // 请使用 num1_pointer 让 num2 等于 5！
    // (参考上面的“小抄”来获取一些想法。)
    num2 = num1_pointer.*;

    std.debug.print("num1: {}, num2: {}\n", .{ num1, num2 });
}
