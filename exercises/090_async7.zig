//
// 记得一个带有'suspend'的函数是异步的，而不带'async'关键字调用异步函数会使调用函数变成异步函数吗？
//
//     fn fooThatMightSuspend(maybe: bool) void {
//         if (maybe) suspend {}
//     }
//
//     fn bar() void {
//         fooThatMightSuspend(true); // 现在bar()是异步的！
//     }
//
// 但是，如果你知道该函数不会挂起，你可以使用'nosuspend'关键字向编译器做出承诺：
//
//     fn bar() void {
//         nosuspend fooThatMightSuspend(false);
//     }
//
// 如果该函数确实挂起并且你对编译器的承诺被打破，则程序将在运行时崩溃，这可能比你应得的更好！ >:-(
//
const print = @import("std").debug.print;

pub fn main() void {

    // main() 函数不能是异步的。但是我们知道
    // getBeef() 在这种特定情况下不会挂起。
    // 请让这个程序正常工作：
    var my_beef = getBeef(0);

    print("beef? {X}!\n", .{my_beef});
}

fn getBeef(input: u32) u32 {
    if (input == 0xDEAD) {
        suspend {}
    }

    return 0xBEEF;
}
//
// 深入探讨...
//             ...未定义行为！
//
// 我们还没有讨论过，但运行时“安全”特性需要一些额外的指令来编译程序。
// 大多数情况下，你会想保留这些指令。
//
// 但是，在某些程序中，当数据完整性不如原始速度重要时（例如某些游戏），
// 你可以在不使用这些安全特性的情况下进行编译。
//
// 如果程序出现问题，而不是安全的panic，
// 你的程序将表现出Undefined Behavior (UB)，
// 这意味着Zig语言不能定义会发生什么。
// 最好的情况是它会崩溃，
// 但在最坏的情况下，
// 它将继续运行并产生错误结果，
// 破坏您的数据或使您面临安全风险。
//
// 这个程序是探索UB的好方法。
// 当你调用getBeef()函数时，
// 使用值0xDEAD来调用'suspend'关键字：
//
//     getBeef(0xDEAD)
//
// 现在运行程序，
// 它将会panic并给你一个漂亮的堆栈跟
