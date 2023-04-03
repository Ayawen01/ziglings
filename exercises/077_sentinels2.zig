//
// ------------------------------------------------------------
//  TOP SECRET  TOP SECRET  TOP SECRET  TOP SECRET  TOP SECRET
// ------------------------------------------------------------
//
// 您准备好了解Zig字符串文字的真相吗？
//
// 在这里：
//
//     @TypeOf("foo") == *const [3:0]u8
//
// 这意味着字符串文字是“指向u8固定大小的零终止（空终止）数组的常量指针”。
//
// 现在你知道了。你赢得了它。欢迎来到秘密俱乐部！
//
// ------------------------------------------------------------
//
// 为什么我们要在Zig中使用零/空哨兵来终止字符串，而我们已经知道长度了呢？
//
// 多功能性！ Zig字符串与C字符串（它们是以null结尾的）兼容，并且可以强制转换为各种其他Zig类型：
//
//     const a: [5]u8 = "array".*;
//     const b: *const [16]u8 = "pointer to array";
//     const c: []const u8 = "slice";
//     const d: [:0]const u8 = "slice with sentinel";
//     const e: [*:0]const u8 = "many-item pointer with sentinel";
//     const f: [*]const u8 = "many-item pointer";
//
// 除了'f'之外，所有内容都可以打印。 （没有哨兵的多项指针不安全，因为我们不知道它在哪里结束！）
const print = @import("std").debug.print;

const WeirdContainer = struct {
    data: [*]const u8,
    length: usize,
};

pub fn main() void {
    // WeirdContainer是存储字符串的一种奇怪方式。
    //
    // 作为多项指针（没有哨兵终止符），'data'字段“丢失”了字符串文字“Weird Data！”的长度信息和哨兵终止符。
    //
    // 幸运的是，'length'字段使得仍然可以使用此值。
    const foo = WeirdContainer{
        .data = "Weird Data!",
        .length = 11,
    };

    // 我们如何从'foo'获取可打印值？一种方法是将其转换为具有已知长度的内容。
    // 我们确实有一个长度...您实际上已经解决了这个问题！
    //
    // 这里有一个重要提示：您还记得如何获取切片吗？
    const printable = foo.data[0..foo.length];

    print("{s}\n", .{printable});
}
