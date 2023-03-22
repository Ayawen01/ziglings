//
// 有时候你知道一个变量可能有一个值或者
// 它可能没有。Zig有一种很棒的表达这个想法的方式
// 叫做可选类型。一个可选类型只有一个'?'像这样：
//
//     var foo: ?u32 = 10;
//
// 现在foo可以存储一个u32整数或者空值（一个存储
// 值不存在的恐怖价值！）
//
//     foo = null;
//
//     if (foo == null) beginScreaming();
//
// 在我们可以把可选值当作非空类型使用之前
// （在这种情况下是u32整数），我们需要保证它不是空的。
// 一种做这个的方法是用"orelse"语句来威胁它。
//
//     var bar = foo orelse 2;
//
// 这里，bar要么等于存储在foo中的u32整数值，
// 要么等于2如果foo是空的。
//
const std = @import("std");

pub fn main() void {
    const result = deepThought();

    // 请用orelse语句来威胁结果，使得answer要么是
    // deepThought()函数返回的整数值，要么是数字42：
    var answer: u8 = result orelse 42;

    std.debug.print("The Ultimate Answer: {}.\n", .{answer});
}

fn deepThought() ?u8 {
    // 看起来Deep Thought的输出质量下降了。
    // 但是我们就这样吧。对不起Deep Thought。
    return null;
}
// 过去的回忆：
//
// 可选类型很像错误联合类型，它们可以
// 存储一个值或者一个错误。同样地，orelse语句就像
// catch语句一样，用来“解包”一个值或者提供一个默认值：
//
//    var maybe_bad: Error!u32 = Error.Evil;
//    var number: u32 = maybe_bad catch 0;
//
