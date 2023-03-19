//
// 让我们看看能否利用一些我们已经学过的东西。
// 我们将创建两个函数：一个包含 "for" 循环，另一个包含 "while" 循环。
//
// 这两个都简单地标记为 "loop"。
//
const std = @import("std");

pub fn main() void {
    const my_numbers = [4]u16{ 5, 6, 7, 8 };

    printPowersOfTwo(my_numbers);
    std.debug.print("\n", .{});
}

// 你不会每天都看到这样的：一个接受一个恰好有四个 u16 数字的数组的函数。
// 这不是你通常给函数传递数组的方式。
// 我们稍后会学习切片和指针。
// 现在，我们使用我们所知道的。
//
// 这个函数打印，但不返回任何东西。
//
fn printPowersOfTwo(numbers: [4]u16) void {
    for (numbers) |n| {
        std.debug.print("{} ", .{twoToThe(n)});
    }
}

// 这个函数和上一练习中的 twoToThe() 非常相似。
// 但是不要被骗了！这个函数在没有标准库的帮助下做数学运算！
//
fn twoToThe(number: u16) u16 {
    var n: u16 = 0;
    var total: u16 = 1;

    while (n < number) : (n += 1) {
        total *= 2;
    }

    return total;
}
