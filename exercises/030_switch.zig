//
// switch语句可以让你匹配一个表达式的可能值，并根据每个值执行不同的动作。
//
// 这个 switch:
//
//     switch (players) {
//         1 => startOnePlayerGame(),
//         2 => startTwoPlayerGame(),
//         else => {
//             alert();
//             return GameError.TooManyPlayers;
//         }
//     }
//
// 等价于这个 this if/else:
//
//     if (players == 1) startOnePlayerGame();
//     else if (players == 2) startTwoPlayerGame();
//     else {
//         alert();
//         return GameError.TooManyPlayers;
//     }
//
const std = @import("std");

pub fn main() void {
    const lang_chars = [_]u8{ 26, 9, 7, 42 };

    for (lang_chars) |c| {
        switch (c) {
            1 => std.debug.print("A", .{}),
            2 => std.debug.print("B", .{}),
            3 => std.debug.print("C", .{}),
            4 => std.debug.print("D", .{}),
            5 => std.debug.print("E", .{}),
            6 => std.debug.print("F", .{}),
            7 => std.debug.print("G", .{}),
            8 => std.debug.print("H", .{}),
            9 => std.debug.print("I", .{}),
            10 => std.debug.print("J", .{}),
            // ... 我们不需要中间的所有内容 ...
            25 => std.debug.print("Y", .{}),
            26 => std.debug.print("Z", .{}),
            // switch语句必须是“穷举”的（必须有一个匹配每个可能值）。
            // 请在这个switch中添加一个“else”，
            // 当c不是现有匹配之一时，打印一个问号“?”。
            else => std.debug.print("?", .{}),
        }
    }

    std.debug.print("\n", .{});
}
