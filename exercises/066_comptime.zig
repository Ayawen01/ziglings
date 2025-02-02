//
// "Compile time" 是程序在编译时的环境，
// 而 "run time" 是指编译后的程序在执行时的环境（传统上是作为机器代码在硬件CPU上执行）。
//
// 错误可以很好地说明这个问题：
//
// 1. 编译时错误：由编译器捕获，通常会导致向程序员发送消息。
//
// 2. 运行时错误：由运行中的程序本身或主机硬件或操作系统捕获。
// 可以优雅地捕获和处理，也可能导致计算机崩溃（或停止并着火）！
//
// 所有编译语言都必须在编译时执行一定量的逻辑，以分析代码，维护符号表（例如变量和函数名称）等。
//
// 优化编译器还可以计算出多少程序可以在编译时进行预计算或“内联”，以使结果程序更加高效。
// 智能编译器甚至可以“展开”循环，将它们的逻辑转换为快速的线性语句序列（通常会稍微增加重复代码的大小）。
//
// Zig通过使这些优化成为语言本身的一个组成部分来进一步发展了这些概念！
//
const print = @import("std").debug.print;

pub fn main() void {
    // 所有数字文字都是类型为comptime_int或comptime_float的Zig中的类型。它们具有任意大小（尽可能大或小）。
    //
    // 注意，当我们使用“const”不可变地分配标识符时，我们不必指定像“u8”、“i32”或“f64”这样的大小。
    //
    // 当我们在程序中使用这些标识符时，值会在编译时插入到可执行代码中。
    // 标识符“const_int”和“const_float”不存在于我们编译后的应用程序中！
    const const_int = 12345;
    const const_float = 987.654;

    print("Immutable: {}, {d:.3}; ", .{ const_int, const_float });

    // 但是当我们使用“var”可变地将完全相同的值分配给标识符时，情况会发生变化。
    //
    // 文字仍然是comptime_int和comptime_float，但我们希望将它们分配给在运行时可变的标识符。
    //
    // 要在运行时可变，这些标识符必须引用内存区域。
    // 为了引用内存区域，Zig必须确切地知道为这些值保留多少内存。
    // 因此，我们只需指定具有特定大小的数字类型。
    // 如果它们适合，comptime数字将被强制转换为您选择的运行时类型。为此需要指定大小，例如32位。
    var var_int: u32 = 12345;
    var var_float: f32 = 987.654;

    // 我们可以更改在运行编译后的程序中为“var_int”和“var_float”设置的区域中存储的内容。
    var_int = 54321;
    var_float = 456.789;

    print("Mutable: {}, {d:.3}; ", .{ var_int, var_float });

    // 奖励：现在我们熟悉了Zig的内置函数，我们还可以检查类型以查看它们是什么，无需猜测！
    print("Types: {}, {}, {}, {}\n", .{
        @TypeOf(const_int),
        @TypeOf(const_float),
        @TypeOf(var_int),
        @TypeOf(var_float),
    });
}
