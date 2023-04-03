//
// 六个事实：
//
// 1. 为函数调用及其数据分配的内存空间称为“堆栈帧”。
//
// 2. “返回”关键字将当前函数调用的帧从堆栈中“弹出”（不再需要），并将控制权返回到调用函数的位置。
//
//     fn foo() void {
//         return; // 弹出帧并返回控制权
//     }
//
// 3. 像“返回”一样，“suspend”关键字将控制权返回到调用函数的位置，
// 但函数调用的帧仍然存在，以便稍后可以再次获得控制权。
// 执行此操作的函数是“async”函数。
//
//     fn fooThatSuspends() void {
//         suspend {} // 返回控制权，但保留帧
//     }
//
// 4. 要在异步上下文中调用任何函数并获取对其帧的引用以供以后使用，请使用“async”关键字：
//
//     var foo_frame = async fooThatSuspends();
//
// 5. 如果您在不使用“async”关键字的情况下调用异步函数，则调用异步函数的函数本身变为异步！ 
// 在此示例中，bar（）函数现在是异步的，因为它调用了异步的fooThatSuspends（）。
//
//     fn bar() void {
//         fooThatSuspends();
//     }
//
// 6. main（）函数不能是异步的！
//
// 鉴于事实3和4，我们如何修复此程序（由事实5和6破坏）？
//
const print = @import("std").debug.print;

pub fn main() void {
    // 额外提示：当您不打算使用时，可以将事物分配给'_'
    foo();
}

fn foo() void {
    print("foo() A\n", .{});
    suspend {}
    print("foo() B\n", .{});
}
