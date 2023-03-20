//
// 现在你知道了“defer”是怎么工作的，让我们用它做些更有趣的事情。
//
const std = @import("std");

pub fn main() void {
    const animals = [_]u8{ 'g', 'c', 'd', 'd', 'g', 'z' };

    for (animals) |a| printAnimal(a);

    std.debug.print("done.\n", .{});
}

// 这个函数_应该_打印一个括号里的动物名字
// 比如“(Goat) ”，但我们不知道怎么样才能打印出右括号
// 即使这个函数有四个不同的返回位置！
fn printAnimal(animal: u8) void {
    std.debug.print("(", .{});

    defer std.debug.print(") ", .{}); // <---- 怎么办？！

    if (animal == 'g') {
        std.debug.print("Goat", .{});
        return;
    }
    if (animal == 'c') {
        std.debug.print("Cat", .{});
        return;
    }
    if (animal == 'd') {
        std.debug.print("Dog", .{});
        return;
    }

    std.debug.print("Unknown", .{});
}
