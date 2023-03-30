//
// 'comptime'函数参数的更常见用法之一是将类型传递给函数：
//
//     fn foo(comptime MyType: type) void { ... }
//
// 实际上，类型仅在编译时可用，因此此处需要“comptime”关键字。
//
// 请花点时间戴上为您提供的巫师帽。我们将使用此功能来实现通用函数。
//
const print = @import("std").debug.print;

pub fn main() void {
    // 在这里，我们从函数调用中在编译时声明了三种不同类型和大小的数组。很棒！
    const s1 = makeSequence(u8, 3); // 创建一个[3]u8
    const s2 = makeSequence(u32, 5); // 创建一个[5]u32
    const s3 = makeSequence(i64, 7); // 创建一个[7]i64

    print("s1={any}, s2={any}, s3={any}\n", .{ s1, s2, s3 });
}

// 此函数非常疯狂，因为它在运行时执行，并且是最终编译的程序的一部分。该函数编译时具有不变的数据大小和类型。
//
// 然而，它也允许不同的大小和类型。这似乎是自相矛盾的。两件事怎么可能都是真的？
//
// 为了实现这一点，Zig编译器实际上会为每个大小/类型组合生成单独的函数副本！
// 因此，在这种情况下，将为您生成三个不同的函数，每个函数都具有处理该特定数据大小和类型的机器代码。
//
// 请修复此函数，以便“size”参数：
//
//     1）保证在编译时已知。
//     2）设置T类型数组（我们正在创建和返回的序列）的大小。
//
fn makeSequence(comptime T: type, comptime size: usize) [size]T {
    var sequence: [size]T = undefined;
    var i: usize = 0;

    while (i < size) : (i += 1) {
        sequence[i] = @intCast(T, i) + 1;
    }

    return sequence;
}
