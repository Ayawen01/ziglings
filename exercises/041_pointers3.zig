//
// 棘手的部分是，指针的可变性（var vs const）指的是
// 改变指针指向的能力，而不是改变该位置的值的能力！
//
//     const locked: u8 = 5;
//     var unlocked: u8 = 10;
//
//     const p1: *const u8 = &locked;
//     var   p2: *const u8 = &locked;
//
// p1 和 p2 都指向不能改变的常量值。然而，
// p2 可以被改变为指向别的东西，而 p1 不行！
//
//     const p3: *u8 = &unlocked;
//     var   p4: *u8 = &unlocked;
//     const p5: *const u8 = &unlocked;
//     var   p6: *const u8 = &unlocked;
//
// 这里 p3 和 p4 都可以用来改变它们指向的值，但是
// 有趣的是，p5 和 p6 的行为像 p1 和 p2，但是指向
// "unlocked" 处的值。这就是我们说我们可以对任何值
// 做一个常量引用的意思！
//
const std = @import("std");

pub fn main() void {
    var foo: u8 = 5;
    var bar: u8 = 10;

    // 请定义一个指针 "p"，使它可以指向 foo 或 bar，并且可以改变它所指向的值！
    var p: *u8 = undefined;

    p = &foo;
    p.* += 1;
    p = &bar;
    p.* += 1;
    std.debug.print("foo={}, bar={}\n", .{ foo, bar });
}
