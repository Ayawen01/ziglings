//
// 有时候你需要创建一个不符合命名规则的标识符，但由于某种原因，这个标识符不能被创建：
//
//     const 55_cows: i32 = 55; // 非法：以数字开头
//     const isn't true: bool = false; // 非法：什么鬼?!
//
// 如果你尝试在正常情况下创建这两个标识符中的任何一个，一个特殊的程序标识符语法安全团队（PISST）将会来到你家并把你带走。
//
// 幸运的是，Zig 有一种方法可以让这些古怪的标识符绕过当局：@"" 标识符引用语法。
//
//     @"foo"
//
// 请帮助我们安全地将这些逃犯标识符走私到我们的程序中：
//
const print = @import("std").debug.print;

pub fn main() void {
    const @"55_cows": i32 = 55;
    const @"isn't true": bool = false;

    print("Sweet freedom: {}, {}.\n", .{
        @"55_cows",
        @"isn't true",
    });
}
