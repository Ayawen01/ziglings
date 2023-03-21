//
// 让我们回顾一下第一个错误练习。这次，我们要看看if语句的一个错误处理变体。
//
//     if (foo) |value| {
//
//         // foo不是一个错误；value是foo的非错误值
//
//     } else |err| {
//
//         // foo是一个错误；err是foo的错误值
//
//     }
//
// 我们还可以更进一步，用switch语句来处理错误类型。
//
//     if (foo) |value| {
//         ...
//     } else |err| switch(err) {
//         ...
//     }
//
const MyNumberError = error{
    TooBig,
    TooSmall,
};

const std = @import("std");

pub fn main() void {
    const nums = [_]u8{ 2, 3, 4, 5, 6 };

    for (nums) |num| {
        std.debug.print("{}", .{num});

        const n = numberMaybeFail(num);
        if (n) |value| {
            std.debug.print("={}. ", .{value});
        } else |err| switch (err) {
            MyNumberError.TooBig => std.debug.print(">4. ", .{}),
            // 请在这里添加一个匹配TooSmall的情况，并让它打印："<4. "
            MyNumberError.TooSmall => std.debug.print("<4. ", .{}),
        }
    }

    std.debug.print("\n", .{});
}

// 这次我们让numberMaybeFail()返回一个错误联合，而不是一个直接的错误。
fn numberMaybeFail(n: u8) MyNumberError!u8 {
    if (n > 4) return MyNumberError.TooBig;
    if (n < 4) return MyNumberError.TooSmall;
    return n;
}
