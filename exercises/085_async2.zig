//
// 所以，'suspend' 返回到调用它的地方（"调用站点"）。我们如何将控制权返回到被挂起的函数？
//
// 为此，我们有一个新关键字叫做 'resume'，它接受异步函数调用的帧并将控制权返回给它。
//
// 定义一个挂起函数fooThatSuspends()：
// fn fooThatSuspends() void {
//     suspend {} // 挂起函数
// }
//
// 创建一个协程对象foo_frame并执行fooThatSuspends()：
// var foo_frame = async fooThatSuspends();
//
// 使用'resume'关键字将控制权返回给foo_frame：
// resume foo_frame;
//
// 看看你能否使这个程序打印出 "Hello async!"。
//
const print = @import("std").debug.print;

pub fn main() void {
    var foo_frame = async foo();
    _ = foo_frame;
}

fn foo() void {
    print("Hello ", .{});
    suspend {}
    print("async!\n", .{});
}
