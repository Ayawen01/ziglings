//
// 一个常见的错误情况是我们期望有一个值或者发生了错误。看看这个例子：
//
//     var text: Text = getText("foo.txt");
//
// 如果getText()找不到"foo.txt"会发生什么？我们如何在Zig中表达这个情况？
//
// Zig让我们可以创建一个叫做“错误联合”的值，它可以是一个普通值或者一个错误集合中的一个错误：
//
//     var text: MyErrorSet!Text = getText("foo.txt");
//
// 现在，让我们看看是否能够尝试创建一个错误联合！
//
const std = @import("std");

const MyNumberError = error{TooSmall};

pub fn main() void {
    var my_number: MyNumberError!i32 = 5;

    // 看起来my_number需要存储一个数字或者一个错误。
    // 你能正确地设置上面的类型吗？
    my_number = MyNumberError.TooSmall;

    std.debug.print("I compiled!\n", .{});
}
