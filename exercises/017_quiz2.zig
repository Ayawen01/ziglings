//
// 又到了测验时间！让我们看看你能否解决著名的“Fizz Buzz”！
//
//     “玩家轮流递增地数数，将任何能被三整除的数替换为单词“fizz”，
//      将任何能被五整除的数替换为单词“buzz”。
//          - 来自 https://en.wikipedia.org/wiki/Fizz_buzz
//
// 让我们从1数到16。这已经为你开始了，但是有一些问题。:-(
//
const std = @import("std");

pub fn main() void {
    var i: u8 = 1;
    var stop_at: u8 = 16;

    // 这是什么样的循环？一个‘for’还是一个‘while’？
    while (i <= stop_at) : (i += 1) {
        if (i % 3 == 0) std.debug.print("Fizz", .{});
        if (i % 5 == 0) std.debug.print("Buzz", .{});
        if (!(i % 3 == 0) and !(i % 5 == 0)) {
            std.debug.print("{}", .{i});
        }
        std.debug.print(", ", .{});
    }
    std.debug.print("\n", .{});
}
