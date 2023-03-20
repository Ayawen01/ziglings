//
// 好消息！现在我们已经知道了足够多的东西，
// 可以理解一个Zig中的"真正"的Hello World程序 - 一个使用系统标准输出资源的程序...这个资源可能会失败！
//
const std = @import("std");

// 注意，这个main()定义现在返回"!void"而不是
// 只是"void"。因为没有具体的错误类型，这意味着
// Zig会推断错误类型。这在main()的情况下是合适的，
// 但在某些情况下可能会使函数更难（函数指针）或者
// 甚至不可能（递归）工作。
//
// 你可以在这里找到更多信息：
// https://ziglang.org/documentation/master/#Inferred-Error-Sets
//
pub fn main() !void {
    // 我们获取一个标准输出的Writer，这样我们就可以print()到它。
    const stdout = std.io.getStdOut().writer();

    // 不像std.debug.print()，标准输出writer可能会失败
    // 抛出一个错误。我们不关心_什么_错误是什么，我们想要
    // 能够将它作为main()的返回值传递上去。
    //
    // 我们刚刚学习了一个可以实现这一点的单一语句。
    try stdout.print("Hello world!\n", .{});
}
