//
// 我们已经看到Zig在编译时隐式执行了一些评估。但有时您需要显式请求编译时评估。为此，我们有一个新关键字：

//  .     .   .      o       .          .       *  . .     .
//    .  *  |     .    .            .   .     .   .     * .    .
//        --o--            comptime        *    |      ..    .
//     *    |       *  .        .    .   .    --*--  .     *  .
//  .     .    .    .   . . .      .        .   |   .    .

// 当放置在变量声明之前时，“comptime”保证该变量的每个使用都将在编译时执行。

// 作为一个简单的例子，请比较这两个语句：

// var bar1 = 5; // 错误！
// comptime var bar2 = 5; // 没问题！

// 第一个会给我们一个错误，因为Zig假定可变标识符（使用“var”声明）将在运行时使用，而我们没有分配运行时类型（如u8或f32）。尝试在运行时使用未确定大小的comptime_int是一种内存犯罪，你被逮捕了。

// 第二个没问题，因为我们告诉Zig“bar2”是一个编译时变量。Zig将帮助我们确保这是正确的，并让我们知道如果我们犯了错误。
//
const print = @import("std").debug.print;

pub fn main() void {
    //
    // 在这个人为的例子中，我们决定使用变量计数来分配一些数组！但是还缺少一些东西...
    //
    comptime var count = 0;

    count += 1;
    var a1: [count]u8 = .{'A'} ** count;

    count += 1;
    var a2: [count]u8 = .{'B'} ** count;

    count += 1;
    var a3: [count]u8 = .{'C'} ** count;

    count += 1;
    var a4: [count]u8 = .{'D'} ** count;

    print("{s} {s} {s} {s}\n", .{ a1, a2, a3, a4 });

    // 内置奖励！
    //
    // @compileLog()内置函数类似于仅在编译时操作的打印语句。
    // Zig编译器将@compileLog()调用视为错误，因此您需要暂时使用它们来调试编译时逻辑。
    //
    // 尝试取消注释此行并玩弄它（复制它，移动它）以查看它的作用：
    // @compileLog("Count at compile time: ", count);
}
