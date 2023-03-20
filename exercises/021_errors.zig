//
// 相信与否，有时程序会出错。
//
// 在 Zig 中，错误是一种值。错误有名字，所以我们可以识别
// 可能出错的地方。错误是在“错误集”中创建的，它们只是一组命名的错误。
//
// 我们有一个错误集的开始，但我们缺少了“TooSmall”这个条件。
const MyNumberError = error{
    TooBig,
    TooSmall,
    TooFour,
};

const std = @import("std");

pub fn main() void {
    const nums = [_]u8{ 2, 3, 4, 5, 6 };

    for (nums) |n| {
        std.debug.print("{}", .{n});

        const number_error = numberFail(n);

        if (number_error == MyNumberError.TooBig) {
            std.debug.print(">4. ", .{});
        }
        if (number_error == MyNumberError.TooSmall) {
            std.debug.print("<4. ", .{});
        }
        if (number_error == MyNumberError.TooFour) {
            std.debug.print("=4. ", .{});
        }
    }

    std.debug.print("\n", .{});
}

// 请在需要的地方添加它！
// 注意这个函数可以返回 MyNumberError 错误集中的任何一个成员。
fn numberFail(n: u8) MyNumberError {
    if (n > 4) return MyNumberError.TooBig;
    if (n < 4) return MyNumberError.TooSmall; // <---- 这个是免费的
    return MyNumberError.TooFour;
}
