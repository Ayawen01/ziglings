//
// Zig 编译器提供了一些“内置”函数。你已经习惯了在每个 Ziglings 练习的顶部看到一个 @import()。
//
// 我们还在 "016_for2.zig", "058_quiz7.zig" 中看到了 @intCast()；
// 在 "036_enums2.zig" 中看到了 @enumToInt()。
//
// 内置函数很特别，因为它们是 Zig 语言本身的一部分（而不是由标准库提供的）。
// 它们也很特别，因为它们可以提供一些只有编译器才能帮助实现的功能，
// 比如类型内省（从程序中检查类型属性的能力）。
//
// Zig 目前包含了 101 个内置函数。我们当然不会涵盖它们所有的，
// 但我们可以看一些有趣的。
//
// 在我们开始之前，要知道很多内置函数有标记为“comptime”的参数。
// 当我们说这些参数需要在编译时就已知时，我们的意思可能很清楚。
// 但请放心，我们很快就会对“comptime”主题做一个真正的公正处理。
//
const print = @import("std").debug.print;

pub fn main() void {
    // 按字母顺序排列，第二个内置函数是：
    //   @addWithOverflow(a: anytype, b: anytype) struct { @TypeOf(a, b), u1 }
    //     * 'T' 是其他参数的类型。
    //     * 'a' 和 'b' 是类型 T 的数字。
    //     * 返回值是一个元组，包含结果和可能的溢出位。
    //
    // 让我们用一个很小的 4 位整数大小来试一试，以便清楚地看到：
    const a: u4 = 0b1101;
    const b: u4 = 0b0101;
    const my_result = @addWithOverflow(a, b);

    // 查看我们的精美格式！b:0>4表示，“以二进制数打印，右对齐四位数，用0填充”。
    // 下面的print()将产生：“1101 + 0101 = 0010 (true)”。
    print("{b:0>4} + {b:0>4} = {b:0>4} ({s})", .{ a, b, my_result[0], if (my_result[1] == 1) "true" else "false" });

    // 让我们理解一下这个答案。'b'的十进制值是5。
    // 让我们一步一步地把5加到'a'上，看看哪里会溢出：
    //
    //   a  |  b   | result | overflowed?
    // ----------------------------------
    // 1101 + 0001 =  1110  | false
    // 1110 + 0001 =  1111  | false
    // 1111 + 0001 =  0000  | true  (真正的答案是10000)
    // 0000 + 0001 =  0001  | false
    // 0001 + 0001 =  0010  | false
    //
    // 在最后两行中，'a'的值被破坏了，因为在第3行有一个溢出，但是第4行和第5行的操作本身没有溢出。
    // 这里有一个区别：
    // - 在某个时刻溢出并且现在已经损坏的值
    // - 单个操作溢出并可能导致后续错误
    // 在实践中，我们通常先注意到溢出的值，然后再回溯到导致溢出的操作。
    //
    // 如果在把5加到a时没有发生任何溢出，'my_result'会持有什么值？
    // 把答案写到'expected_result'中。
    const expected_result: u8 = 0b10010;
    print(". Without overflow: {b:0>8}. ", .{expected_result});

    print("Furthermore, ", .{});

    // 这是一个有趣的：
    //
    //   @bitReverse(integer: anytype) T
    //     * 'integer'是要反转的值。
    //     * 返回值将是相同类型的反转后的值！
    //
    // 现在轮到你了。看看你能否修复这个尝试使用这个内置函数来反转一个u8整数的位。
    const input: u8 = 0b11110000;
    const tupni: u8 = @bitReverse(input);
    print("{b:0>8} backwards is {b:0>8}.\n", .{ input, tupni });
}
