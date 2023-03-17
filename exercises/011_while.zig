//
// Zig 的 'while' 语句创建一个循环，当条件为真时运行。
// 这最多运行一次：
//
//     while (condition) {
//         condition = false;
//     }
//
// 记住，条件必须是一个布尔值，我们可以从条件运算符中得到一个布尔值，例如：
//
//     a == b   means "a equals b"
//     a < b    means "a is less than b"
//     a > b    means "a is greater than b"
//     a != b   means "a does not equal b"
//
const std = @import("std");

pub fn main() void {
    var n: u32 = 2;

    // 请使用一个条件，直到 "n" 达到 1024 为止：
    while (n < 1024) {
        // 打印当前数字
        std.debug.print("{} ", .{n});

        // 将 n 设置为 n 乘以 2
        n *= 2;
    }

    // 一旦上面的正确，这将打印 "n=1024"
    std.debug.print("n={}\n", .{n});
}
