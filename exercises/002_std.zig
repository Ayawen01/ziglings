//
// 糟糕！这个程序本来应该打印一行像我们的 Hello World 例子那样的内容。
// 但是我们忘了如何导入Zig标准库。
//
// @import()函数是内置在Zig中的。它返回一个代表导入的代码的值。
// 把导入作为一个常量值存储，并且和导入的名字相同，是一个好主意：
//
//     const foo = @import("foo");
//
// 请完成下面的导入：
//

const std = @import("std");

pub fn main() void {
    std.debug.print("Standard Library.\n", .{});
}

// 对于好奇的人：导入必须声明为常量，因为它们只能在编译时而不是运行时使用。
// Zig在编译时计算常量值。
// 别担心，我们稍后会详细介绍导入。
// 另见这个回答：https://stackoverflow.com/a/62567550/695615
