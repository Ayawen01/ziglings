//
// 处理错误联合的一种方法是“catch”任何错误，并用一个默认值替换它。
//
//     foo = canFail() catch 6;
//
// 如果canFail()失败了，foo将等于6。
//
const std = @import("std");

const MyNumberError = error{TooSmall};

pub fn main() void {
    var a: u32 = addTwenty(44) catch 22;
    var b: u32 = addTwenty(4) catch 22;

    std.debug.print("a={}, b={}\n", .{ a, b });
}

// 请提供这个函数的返回类型。
// 提示：它将是一个错误联合。
fn addTwenty(n: u32) MyNumberError!u32 {
    if (n < 5) {
        return MyNumberError.TooSmall;
    } else {
        return n + 20;
    }
}
