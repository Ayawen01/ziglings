//
// 真正好的是，你可以用switch语句作为一个表达式来返回一个值。
//
//     var a = switch (x) {
//         1 => 9,
//         2 => 16,
//         3 => 7,
//         ...
//     }
//
const std = @import("std");

pub fn main() void {
    const lang_chars = [_]u8{ 26, 9, 7, 42 };

    for (lang_chars) |c| {
        const real_char: u8 = switch (c) {
            1 => 'A',
            2 => 'B',
            3 => 'C',
            4 => 'D',
            5 => 'E',
            6 => 'F',
            7 => 'G',
            8 => 'H',
            9 => 'I',
            10 => 'J',
            // ...
            25 => 'Y',
            26 => 'Z',
            // 和上一个练习一样，请添加'else'子句
            // 这次，让它返回一个感叹号'!'。
            else => '!',
        };

        std.debug.print("{c}", .{real_char});
        // 注意："{c}"强制print()以字符的形式显示值。
        // 你能猜出如果你去掉"c"会发生什么吗？试试看！
    }

    std.debug.print("\n", .{});
}
