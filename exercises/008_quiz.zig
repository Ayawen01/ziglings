//
// 测验时间！让我们看看你能否修复这个整个程序。
//
// 你必须对这个问题有点思考。
//
// 让编译器告诉你哪里出错了。
//
// 从最上面开始。
//
const std = @import("std");

pub fn main() void {
    // 这是什么胡说八道？:-)
    const letters = "YZhifg";

    // 注意：usize 是一个无符号整数类型，用于表示...大小。
    // usize 的确切大小取决于目标 CPU 架构。
    // 我们本可以在这里使用 u8，但 usize 是用于数组索引的惯用类型。
    //
    // 这一行有一个问题，但 'usize' 不是它。
    var x: usize = 1;

    // 注意：当你想要声明内存（在这种情况下是一个数组）而不放入任何东西时，
    // 你可以将其设置为 'undefined'。这一行没有问题。
    var lang: [3]u8 = undefined;

    // 下面的几行试图通过用变量 'x' 索引数组 'letters' 将 'Z'、'i' 和 'g' 放入我们刚刚创建的 'lang' 数组中。
    // 正如你在上面看到的，x=1 开始时。
    lang[0] = letters[x];

    x = 3;
    lang[1] = letters[x];

    x = letters.len - 1;
    lang[2] = letters[x];

    // 我们当然想要 "Program in Zig!"：
    std.debug.print("Program in {s}!\n", .{lang});
}
