//
// Zig 有一些有趣的数组操作符。
//
// 你可以用'++'来连接两个数组：
//
//   const a = [_]u8{ 1,2 };
//   const b = [_]u8{ 3,4 };
//   const c = a ++ b ++ [_]u8{ 5 }; // 等于 1 2 3 4 5
//
// 你可以用'**'来重复一个数组：
//
//   const d = [_]u8{ 1,2,3 } ** 2; // 等于 1 2 3 1 2 3
//
// 注意，'++'和'**'只在你的程序被编译时起作用。
// 这个特殊的时间在 Zig 中被称为"comptime", 我们稍后会学习更多关于它的内容。
//
const std = @import("std");

pub fn main() void {
    const le = [_]u8{ 1, 3 };
    const et = [_]u8{ 3, 7 };

    // (问题1)
    // 请设置这个数组，连接上面两个数组。
    // 它应该得到：1 3 3 7
    const leet = le ++ et;

    // (问题2)
    // 请设置这个数组，使用重复。
    // 它应该得到：1 0 0 1 1 0 0 1 1 0 0 1
    const bit_pattern = [_]u8{ 1, 0, 0, 1 } ** 3;

    // 好了，这就是所有的问题。让我们看看结果。
    //
    // 我们可以用leet[0], leet1,...来打印这些数组，但是让我们先预览一下 Zig 的 for 循环吧：
    //
    //    for (<item array>) |item| { <do something with item> }
    //
    // 别担心，我们会在接下来的课程中适当地介绍循环。
    //
    std.debug.print("LEET: ", .{});

    for (leet) |n| {
        std.debug.print("{}", .{n});
    }

    std.debug.print(", Bits: ", .{});

    for (bit_pattern) |n| {
        std.debug.print("{}", .{n});
    }

    std.debug.print("\n", .{});
}
