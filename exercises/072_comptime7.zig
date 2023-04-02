//
// 还有一种“inline while”。就像“inline for”一样，
// 它可以在编译时循环，允许您进行各种在运行时不可能实现的有趣的事情。
// 看看您是否可以弄清楚这个相当疯狂的示例打印了什么：
//
//     const foo = [3]*const [5]u8{ "~{s}~", "<{s}>", "d{s}b" };
//     comptime var i = 0;
//
//     inline while ( i < foo.len ) : (i += 1) {
//         print(foo[i] ++ "\n", .{foo[i]});
//     }
//
// 你还没有摘下那顶巫帽，是吗？
//
const print = @import("std").debug.print;

pub fn main() void {
    // 这里有一个包含一系列算术运算和一位数字的字符串。我们称每个操作和数字对为“指令”。
    const instructions = "+3 *5 -2 *2";

    // 这里有一个u32变量，它将在运行时跟踪程序中的当前值。它从0开始，我们将通过执行上面的指令序列来获得最终值。
    var value: u32 = 0;

    // 这个“索引”变量只会在我们的循环中编译时使用。
    comptime var i = 0;

    // 在这里，我们希望在编译时循环遍历字符串中的每个“指令”。
    //
    // 请修复此代码，使其每次循环一次“指令”：
    inline while (i < instructions.len) : (i += 3) {

        // 这从“instruction”中获取数字。你能想出为什么我们要从中减去'0'吗？
        comptime var digit = instructions[i + 1] - '0';

        // 这个“switch”语句包含了实际运行时执行的工作。起初，这似乎并不令人兴奋...
        switch (instructions[i]) {
            '+' => value += digit,
            '-' => value -= digit,
            '*' => value *= digit,
            else => unreachable,
        }
        // ...但它比起一开始看起来要有趣得多。
        // “inline while”在运行时不再存在，也没有任何其他
        // 没有被运行时代码直接触及的东西。例如，“instructions”字符串
        // 在编译后的程序中不会出现，因为它没有被使用！
        //
        // 因此，在非常真实的意义上，这个循环实际上将
        // 字符串中包含的指令转换为运行时代码。猜猜我们是编译器作者
        // 现在。看到了吗？巫师帽是有道理的。
    }

    print("{}\n", .{value});
}
