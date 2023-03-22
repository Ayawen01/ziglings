//
// 现在让我们使用指针来做一些我们以前不能做的事情：将一个值按引用传递给一个函数。
//
// 为什么我们希望将一个整数变量的引用而不是整数值本身传递给一个函数呢？因为这样我们就可以
// *改变*这个变量的值！
//
//     +------------------------------------------------+
//     | 当你想要改变指向的值时，按引用传递。否则，传递值。 |
//     +------------------------------------------------+
//
const std = @import("std");

pub fn main() void {
    var num: u8 = 1;
    var more_nums = [_]u8{ 1, 1, 1, 1 };

    // 让我们将num引用传递给我们的函数并打印它：
    makeFive(&num);
    std.debug.print("num: {}, ", .{num});

    // 现在有趣的事情来了。让我们将一个特定数组值的引用传递：
    makeFive(&more_nums[2]);

    // 并打印数组：
    std.debug.print("more_nums: ", .{});
    for (more_nums) |n| {
        std.debug.print("{} ", .{n});
    }

    std.debug.print("\n", .{});
}

// 这个函数应该接受一个u8值的引用，并将其设置为5。
fn makeFive(x: *u8) void {
    x.* = 5; // 修复我！
}
