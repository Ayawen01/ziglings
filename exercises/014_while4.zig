//
// 您可以使用"break"语句强制循环立即退出：
//
//     while (condition) : (continue expression) {
//
//         if (other condition) break;
//
//     }
//
// 当while循环因为break而停止时，continue expression不会执行！
//
const std = @import("std");

pub fn main() void {
    var n: u32 = 1;

    // 哦，天哪！这个while循环会一直进行下去吗？
    // 请修复这个问题，使下面的打印语句输出期望的结果。
    while (true) : (n += 1) {
        if (n == 4) break;
    }

    // 我们想要n=4
    std.debug.print("n={}\n", .{n});
}
