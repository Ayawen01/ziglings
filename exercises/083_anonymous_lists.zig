//
// 匿名结构体字面量语法也可以用于将具有数组类型目标的“匿名列表”组合在一起：
//
//     const foo: [3]u32 = .{10, 20, 30};
//
// 否则它是一个“元组”：
//
//     const bar = .{10, 20, 30};
//
// 唯一的区别是目标类型。
//
const print = @import("std").debug.print;

pub fn main() void {
    // 请将'hello'更改为u8的字符串数组，而不更改值文字。
    //
    // 不要更改此部分：
    //
    //     = .{'h', 'e', 'l', 'l', 'o'};
    //
    const hello = .{'h', 'e', 'l', 'l', 'o'};
    print("I say {s}!\n", .{hello});
}
