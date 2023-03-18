//
// 瞧瞧"for"循环！for循环让你对数组中的每个元素执行代码：
//
//     for (items) |item| {
//
//         // 对item做一些事情
//
//     }
//
const std = @import("std");

pub fn main() void {
    const story = [_]u8{ 'h', 'h', 's', 'n', 'h' };

    std.debug.print("A Dramatic Story: ", .{});

    for (story) |scene| {
        if (scene == 'h') std.debug.print(":-)  ", .{});
        if (scene == 's') std.debug.print(":-(  ", .{});
        if (scene == 'n') std.debug.print(":-|  ", .{});
    }

    std.debug.print("The End.\n", .{});
}
// 注意，"for"循环也适用于我们稍后会看到的叫做"切片"的东西。
