//
// Zig有一个“unreachable”语句。
// 当你想告诉编译器一段代码永远不应该被执行，
// 而且到达它就是一个错误时，就用它。
//
//     if (true) {
//         ...
//     } else {
//         unreachable;
//     }
//
// 这里我们做了一个小型的虚拟机，
// 它对一个数值进行数学运算。
// 看起来很棒，
// 但有一个小问题：switch语句没有覆盖u8数字的每个可能值！
//
// 我们知道只有三种操作，
// 但Zig不知道。
// 用unreachable语句来让switch完整。否则的话。:-)
//
const std = @import("std");

pub fn main() void {
    const operations = [_]u8{ 1, 1, 1, 3, 2, 2 };

    var current_value: u32 = 0;

    for (operations) |op| {
        switch (op) {
            1 => {
                current_value += 1;
            },
            2 => {
                current_value -= 1;
            },
            3 => {
                current_value *= current_value;
            },
            else => unreachable,
        }

        std.debug.print("{} ", .{current_value});
    }

    std.debug.print("\n", .{});
}
