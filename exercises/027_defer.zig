//
// 你可以用 "defer" 语句来指定一些代码在一个代码块退出后执行：
//
//     {
//         defer runLater();
//         runNow();
//     }
//
// 在上面的例子中，runLater() 会在代码块 ({...}) 结束时运行。
// 所以上面的代码会按照下面的顺序执行：
//
//     runNow();
//     runLater();
//
// 这个特性一开始看起来很奇怪，但是我们会在下一个练习中看到它有什么用处。
const std = @import("std");

pub fn main() void {
    // 不改变其他任何东西，请给这段代码添加一个 'defer' 语句
    // 使得我们的程序打印出 "One Two\n"：
    defer std.debug.print("Two\n", .{});
    std.debug.print("One ", .{});
}
