//
// 你也许想尝试在字符串上使用切片？毕竟它们是u8字符的数组，对吧？在字符串上使用切片效果很好。
// 只有一个问题：不要忘记Zig字符串字面量是不可变（const）的值。所以我们需要改变切片的类型，
// 从：
//
//     var foo: []u8 = "foobar"[0..3];
//
// 到：
//
//     var foo: []const u8 = "foobar"[0..3];
//
// 看看你能否修复这个受Zero Wing启发的短语解码器：
const std = @import("std");

pub fn main() void {
    const scrambled = "great base for all your justice are belong to us";

    const base1: []const u8 = scrambled[15..23];
    const base2: []const u8 = scrambled[6..10];
    const base3: []const u8 = scrambled[32..];
    printPhrase(base1, base2, base3);

    const justice1: []const u8 = scrambled[11..14];
    const justice2: []const u8 = scrambled[0..5];
    const justice3: []const u8 = scrambled[24..31];
    printPhrase(justice1, justice2, justice3);

    std.debug.print("\n", .{});
}

fn printPhrase(part1: []const u8, part2: []const u8, part3: []const u8) void {
    std.debug.print("'{s} {s} {s}.' ", .{ part1, part2, part3 });
}
