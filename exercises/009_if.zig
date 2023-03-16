//
// 现在我们开始有趣的东西，从 'if' 语句开始！
//
//     if (true) {
//         ...
//     } else {
//         ...
//     }
//
// Zig 有 "usual" 的比较运算符，比如：
//
//     a == b   意味着 "a 等于 b"
//     a < b    意味着 "a 小于 b"
//     a > b    意味着 "a 大于 b"
//     a != b   意味着 "a 不等于 b"
//
// Zig 的 "if" 的重要之处在于它 *只* 接受布尔值。
// 它不会强制数字或其他类型的数据转换为 true 和 false。
//
const std = @import("std");

pub fn main() void {
    const foo = 1;

    // 请修复这个条件：
    if (foo == 1) {
        // 我们希望我们的程序打印出这条消息！
        std.debug.print("Foo is 1!\n", .{});
    } else {
        std.debug.print("Foo is not 1!\n", .{});
    }
}
