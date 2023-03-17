//
// Zig 的 'while' 语句可以有一个可选的 'continue expression'
// 它在每次 while 循环继续时运行（无论是在循环的末尾还是当显式调用 'continue' 时
// 我们将在下一步尝试这些）
//
//     while (condition) : (continue expression) {
//         ...
//     }
//
// Example:
//
//     var foo = 2;
//     while (foo < 10) : (foo += 2) {
//         // 对小于 10 的偶数做些什么…
//     }
//
// 看看你能否用 continue 表达式重写上一练习：
// expression:
//
const std = @import("std");

pub fn main() void {
    var n: u32 = 2;

    // 请设置 continue 表达式，以便我们在下面的打印语句中得到期望的结果。
    while (n < 1000) : (n *= 2) {
        // 打印当前数字
        std.debug.print("{} ", .{n});
    }

    // 和上一练习一样，我们希望这个结果是 "n=1024"
    std.debug.print("n={}\n", .{n});
}
