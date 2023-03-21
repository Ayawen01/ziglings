//
// 枚举其实就是一组数字。你可以让编译器自动编号，也可以显式地指定它们。
// 你甚至可以指定用于枚举的数字类型。
//
//     const Stuff = enum(u8){ foo = 16 };
//
// 你可以用一个内置函数@enumToInt()来获取枚举对应的整数值。
// 我们会在后面的练习中详细了解内置函数。
//
//     var my_stuff: u8 = @enumToInt(Stuff.foo);
//
// 注意这个内置函数和我们一直在用的@import()函数一样，都以“@”开头。
//
const std = @import("std");

// Zig允许我们用十六进制格式写整数：
//
//     0xf (是十六进制中的15)
//
// 网页浏览器让我们用一个十六进制数来指定颜色，
// 其中每个字节代表红、绿、蓝三原色（RGB）的亮度，
// 两个十六进制数字是一个字节，取值范围是0-255：
//
//     #RRGGBB
//
// 请定义并使用一个纯蓝色值Color：
const Color = enum(u32) {
    red = 0xff0000,
    green = 0x00ff00,
    blue = 0x0000ff,
};

pub fn main() void {
    // 还记得Zig的多行字符串吗？它们又出现了。
    // 另外，看看这个酷炫的格式字符串：
    //
    //     {x:0>6}
    //      ^
    //      x       类型（'x'是小写十六进制）
    //       :      分隔符（需要用于格式语法）
    //        0     填充字符（默认是空格）
    //         >    对齐方式（'>'表示右对齐）
    //          6   宽度（用填充字符强制宽度）
    //
    // 请给蓝色值加上这种格式化。
    // （更好的做法是，在没有它或只有部分它时试验一下，
    // 看看会打印什么！）
    std.debug.print(
        \\<p>
        \\  <span style="color: #{x:0>6}">Red</span>
        \\  <span style="color: #{x:0>6}">Green</span>
        \\  <span style="color: #{x:0>6}">Blue</span>
        \\</p>
        \\
    , .{
        @enumToInt(Color.red),
        @enumToInt(Color.green),
        @enumToInt(Color.blue), // 哎呀！我们漏了什么！
    });
}
