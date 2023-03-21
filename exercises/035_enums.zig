//
// 记得我们用“不可达”语句做的那个小型数学虚拟机吗？我们用操作码的方式有两个问题：
//
//   1. 用数字记住操作码不好。
//   2. 我们必须用“不可达”，因为Zig不知道有多少有效的操作码。
//
// “枚举”是一个Zig构造，它让你给数字值起名字，并把它们存储在一个集合中。它们看起来很像错误集：
//
//     const Fruit = enum{ apple, pear, orange };
//
//     const my_fruit = Fruit.apple;
//
// 让我们用枚举代替我们在前一个版本中使用的数字吧！
//
const std = @import("std");

// 请完成枚举！
const Ops = enum { inc, pow, dec };

pub fn main() void {
    const operations = [_]Ops{
        Ops.inc,
        Ops.inc,
        Ops.inc,
        Ops.pow,
        Ops.dec,
        Ops.dec,
    };

    var current_value: u32 = 0;

    for (operations) |op| {
        switch (op) {
            Ops.inc => {
                current_value += 1;
            },
            Ops.dec => {
                current_value -= 1;
            },
            Ops.pow => {
                current_value *= current_value;
            },
            // 不需要“else”！为什么呢？
        }

        std.debug.print("{} ", .{current_value});
    }

    std.debug.print("\n", .{});
}
