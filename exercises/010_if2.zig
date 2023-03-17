//
// 如果语句也是有效的表达式：
//
//     var foo: u8 = if (a) 2 else 3;
//
const std = @import("std");

pub fn main() void {
    var discount = true;

    // 请使用 if…else 表达式来设置 "price"。
    // 如果 discount 为 true，价格应为 $17，否则为 $20：
    var price: u8 = if (discount) 17 else 20;

    std.debug.print("With the discount, the price is ${}.\n", .{price});
}
