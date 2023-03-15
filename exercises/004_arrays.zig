//
// 让我们学习一些数组的基础知识。数组是用以下方式声明的：
//
//   var foo: [3]u32 = [3]u32{ 42, 108, 5423 };
//
// 当 Zig 可以推断出数组的大小时，您可以用'_'表示大小。
// 您也可以让 Zig 推断出值的类型，这样声明就不那么冗长了。
//
//   var foo = [_]u32{ 42, 108, 5423 };
//
// 使用 array[index] 表示法获取数组的值：
//
//     const bar = foo[2]; // 5423
//
// 使用 array[index] 表示法设置数组的值：
//
//     foo[2] = 16;
//
// 使用 len 属性获取数组的长度：
//
//     const length = foo.len;
//
const std = @import("std");

pub fn main() void {
    // (问题1)
    // 这个“const”后面会出现一个问题，你能看出来是什么吗？
    // 我们怎么解决它？
    var some_primes = [_]u8{ 1, 3, 5, 7, 11, 13, 17, 19 };

    // 可以用'[]'符号来设置单个值。
    // 例如：这一行把第一个质数改成了2（这是正确的）
    some_primes[0] = 2;

    // 单个值也可以用'[]'符号来访问。
    // 例如：这一行把第一个质数存储在“first”中：
    const first = some_primes[0];

    // (问题2)
    // 看起来我们需要完成这个表达式。用上面的例子
    // 来把“fourth”设置为 some_primes 数组的第四个元素：
    const fourth = some_primes[3];

    // (问题3)
    // 用 len 属性来获取数组的长度：
    const length = some_primes.len;

    std.debug.print("First: {}, Fourth: {}, Length: {}\n", .{
        first, fourth, length,
    });
}
