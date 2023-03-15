//
// 哦，不！这个程序本来应该打印"Hello world!"，但它需要你的帮助！
//
//
// Zig 函数默认是私有的，但是main()函数应该是公开的。
//
//
// 一个函数用"pub"语句声明为公开，像这样：
//
//     pub fn foo() void {
//         ...
//     }
//
// 尝试修复程序并运行 ziglings 来看看它是否工作！
//
const std = @import("std");

pub fn main() void {
    std.debug.print("Hello world!\n", .{});
}
