//
// 另一个常见的问题是一块代码可能因为错误而在多个地方退出 - 但是在退出之前需要做一些事情 (通常是清理自己的资源)。
//
// 一个 "errdefer" 是一个只有在块出现错误时才运行的 defer：
//
//     {
//         errdefer cleanup();
//         try canFail();
//     }
//
// cleanup() 函数只有在 "try" 语句返回由 canFail() 产生的错误时才被调用。
//
const std = @import("std");

var counter: u32 = 0;

const MyErr = error{ GetFail, IncFail };

pub fn main() void {
    // 如果我们无法得到一个数字，我们就简单地退出整个程序：
    var a: u32 = makeNumber() catch return;
    var b: u32 = makeNumber() catch return;

    std.debug.print("Numbers: {}, {}\n", .{ a, b });
}

fn makeNumber() MyErr!u32 {
    std.debug.print("Getting number...", .{});

    // 请让 "failed" 消息只在 makeNumber() 函数出现错误时打印：
    errdefer std.debug.print("failed!\n", .{});

    var num = try getNumber(); // <-- 这可能会失败！

    num = try increaseNumber(num); // <-- 这也可能会失败！

    std.debug.print("got {}. ", .{num});

    return num;
}

fn getNumber() MyErr!u32 {
    // 我 _可能_ 会失败...但我没有！
    return 4;
}

fn increaseNumber(n: u32) MyErr!u32 {
    // 我在你第一次运行我之后就失败了！
    if (counter > 0) return MyErr.IncFail;

    // 狡猾的，奇怪的全局变量。
    counter += 1;

    return n + 1;
}
