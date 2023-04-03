//
// 通过使用切片来断言特定长度，我们能够从多项指针中获取可打印字符串。
//
// 但是，一旦我们在强制转换中“丢失”了哨兵，我们还能回到哨兵终止的指针吗？
//
// 是的，我们可以。 Zig的@ptrCast（）内置函数可以做到这一点。看看签名：
//
//     @ptrCast（comptime DestType：type，value：anytype）DestType
//
// 看看您是否可以使用它来解决相同的多项指针问题，但无需长度！
//
const print = @import("std").debug.print;

pub fn main() void {
    // 再次，我们已将哨兵终止的字符串强制转换为多项指针，该指针没有长度或哨兵。
    const data: [*]const u8 = "Weird Data!";

    // 请将'data'转换为'printable'：
    const printable: [*:0]const u8 = @ptrCast([*:0]const u8, data);

    print("{s}\n", .{printable});
}
