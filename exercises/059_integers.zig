//
// Zig允许你用几种方便的格式来表示整数字面量。这些都是相同的值：
//
//     const a1: u8 = 65;        // 十进制
//     const a2: u8 = 0x41;      // 十六进制
//     const a3: u8 = 0o101;     // 八进制
//     const a4: u8 = 0b1000001; // 二进制
//     const a5: u8 = 'A';       // UTF-8代码点字面量
//
// 你也可以在数字中放置下划线来增加可读性：
//
//     const t1: u32 = 14_689_520 // 福特T型车1909-1927年的销量
//     const t2: u32 = 0xE0_24_F0 // 同样，用十六进制对表示
//
// 请修复消息：

const print = @import("std").debug.print;

pub fn main() void {
    var zig = [_]u8{
        0o132, // 八进制
        0b1101001, // 二进制
        0x67, // 十六进制
        // 'Z', 'i', 'g',
    };

    print("{s} is cool.\n", .{zig});
}
