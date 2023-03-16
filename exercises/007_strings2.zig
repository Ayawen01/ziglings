//
// 这是一个有趣的例子：Zig 有多行字符串！
//
// 要创建一个多行字符串，只需在每一行的开头加上 '\\' ，就像代码注释一样，但是用反斜杠代替：
//
//     const two_lines =
//         \\Line One
//         \\Line Two
//     ;
//
// 看看你能否让这个程序打印出一些歌词。
//
const std = @import("std");

pub fn main() void {
    const lyrics =
        \\Ziggy played guitar
        \\Jamming good with Andrew Kelley
        \\And the Spiders from Mars
    ;

    std.debug.print("{s}\n", .{lyrics});
}
