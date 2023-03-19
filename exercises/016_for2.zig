//
// for循环还可以让你使用迭代的“索引”，一个随着每次迭代而增加的数字。
// 要访问迭代的索引，除了指定第二个捕获值外，还要指定第二个条件。
//
//     for (items, 0..) |item, index| {
//
//         // 使用item和index做一些事情
//
//     }
//
// 你可以把“item”和“index”命名为任何你想要的名字。
// “i”是“index”的常用缩写。
// 项目名通常是你循环遍历的项目的单数形式。
//
const std = @import("std");

pub fn main() void {
    // 让我们以“小端”顺序（最低有效字节在前）存储二进制数1101的位：
    const bits = [_]u8{ 1, 0, 1, 1 };
    var value: u32 = 0;

    // 现在我们将通过为每个位添加其位置作为2的幂来将二进制位转换为数字值。
    //
    // 看看你能否找出缺失的部分：
    for (bits, 0..) |bit, i| {
        // 注意，我们用@intCast()将usize i转换为u32，
        // 这是一个内置函数，就像@import()一样。
        // 我们将在后面的练习中正确地学习这些内容。
        var place_value = std.math.pow(u32, 2, @intCast(u32, i));
        value += place_value * bit;
    }

    std.debug.print("The value of bits '1101': {}.\n", .{value});
}
