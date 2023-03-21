//
// 小测验时间。看看你能否让这个程序运行起来！
//
// 你可以用任何你喜欢的方式解决这个问题，只要确保输出是：
//
//     my_num=42
//
const std = @import("std");

const NumError = error{IllegalNumber};

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    const my_num: u32 = try getNumber();

    try stdout.print("my_num={}\n", .{my_num});
}

// 这个函数显然是很奇怪和不功能的。但是在这个测验中，你不会改变它。
fn getNumber() NumError!u32 {
    if (false) return NumError.IllegalNumber;
    return 42;
}
