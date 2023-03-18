//
// 上两个练习在功能上是相同的。当与"continue"语句一起使用时，
// "continue"表达式真正显示了它们的用途！
//
// Example:
//
//     while (condition) : (continue expression) {
//
//         if (other condition) continue;
//
//     }
//
// "continue expression"每次循环重新开始时都会执行，
// 无论"continue"语句是否发生。
//
const std = @import("std");

pub fn main() void {
    var n: u32 = 1;

    // 我想打印出1到20之间所有不被3或5整除的数字。
    while (n <= 20) : (n += 1) {
        // "%"符号是"模"运算符，它返回除法后的余数。
        if (n % 3 == 0) continue;
        if (n % 5 == 0) continue;
        std.debug.print("{} ", .{n});
    }

    std.debug.print("\n", .{});
}
