//
// 函数！我们已经创建了许多名为'main()'的函数。现在让我们做一些不同的事情：
//
//     fn foo(n: u8) u8 {
//         return n + 1;
//     }
//
// 上面的foo()函数接受一个数字'n'并返回一个大一的数字。
//
// 注意输入参数'n'和返回类型都是u8。
//
const std = @import("std");

pub fn main() void {
    // 新函数deepThought()应该返回数字42。见下面。
    const answer: u8 = deepThought();

    std.debug.print("Answer to the Ultimate Question: {}\n", .{answer});
}

// 请在下面定义deepThought()函数。
//
// 我们只缺少几件事。我们不缺少的一件事是关键字"pub"，这里不需要它。
// 你能猜出为什么吗？
//
fn deepThought() u8 {
    return 42; // 数字由道格拉斯·亚当斯提供
}
