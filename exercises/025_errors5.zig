//
// Zig有一个方便的"try"快捷方式，用于处理这种常见的错误处理模式：
//
//     canFail() catch |err| return err;
//
// 可以更简洁地写成：
//
//     try canFail();
//
const std = @import("std");

const MyNumberError = error{
    TooSmall,
    TooBig,
};

pub fn main() void {
    var a: u32 = addFive(44) catch 0;
    var b: u32 = addFive(14) catch 0;
    var c: u32 = addFive(4) catch 0;

    std.debug.print("a={}, b={}, c={}\n", .{ a, b, c });
}

fn addFive(n: u32) MyNumberError!u32 {
    // 这个函数需要返回任何可能来自detect()的错误。
    // 请使用"try"语句而不是"catch"。
    //
    var x = try detect(n);

    return x + 5;
}

fn detect(n: u32) MyNumberError!u32 {
    if (n < 10) return MyNumberError.TooSmall;
    if (n > 20) return MyNumberError.TooBig;
    return n;
}
