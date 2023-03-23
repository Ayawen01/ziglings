//
// 我们已经看到，传递数组可能会很麻烦。也许你还记得quiz3中一个特别可怕的函数定义？
// 这个函数只能接受长度恰好为4的数组！
//
//     fn printPowersOfTwo(numbers: [4]u16) void { ... }
//
// 这就是数组的麻烦之处 - 它们的大小是数据类型的一部分，必须硬编码到该类型的每个用法中。这个
// digits数组永远是一个[10]u8：
//
//     var digits = [10]u8{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
//
// 幸运的是，Zig有切片，它们可以动态地指向一个起始项并提供一个长度。这里是我们digit
// 数组的切片：
//
//     const foo = digits[0..1];  // 0
//     const bar = digits[3..9];  // 3 4 5 6 7 8
//     const baz = digits[5..9];  // 5 6 7 8
//     const all = digits[0..];   // 0 1 2 3 4 5 6 7 8 9
//
// 正如你所看到的，一个切片[x..y]从索引为x的第一个项开始，到索引为y-1的最后一个项结束。你可以
// 省略y，以获取“剩余的项”。
//
// 一个u8数组上的切片的类型是[]u8。
//
const std = @import("std");

pub fn main() void {
    var cards = [8]u8{ 'A', '4', 'K', '8', '5', '2', 'Q', 'J' };

    // 请将前4张牌放在hand1中，将剩余的牌放在hand2中。
    const hand1: []u8 = cards[0..4];
    const hand2: []u8 = cards[4..];

    std.debug.print("Hand1: ", .{});
    printHand(hand1);

    std.debug.print("Hand2: ", .{});
    printHand(hand2);
}

// 请帮助这个函数。一个u8切片手，就是了。
fn printHand(hand: []u8) void {
    for (hand) |h| {
        std.debug.print("{u} ", .{h});
    }
    std.debug.print("\n", .{});
}
//
// 有趣的事实：在底层，切片是以指向第一项的指针和长度来存储的。
