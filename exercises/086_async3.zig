//
// 因为它们可以挂起和恢复，所以异步Zig函数是更一般的编程概念"协程"的一个例子。
// Zig异步函数的一个很棒的特点是，
// 它们在挂起和恢复时保留它们的状态。
//
// 看看你能否使这个程序打印出 "5 4 3 2 1"。
const print = @import("std").debug.print;

pub fn main() void {
    const n = 5;
    var foo_frame = async foo(n);
    _ = foo_frame;

    ???

    print("\n", .{});
}

fn foo(countdown: u32) void {
    var current = countdown;

    while (current > 0) {
        print("{} ", .{current});
        current -= 1;
        suspend {}
    }
}
