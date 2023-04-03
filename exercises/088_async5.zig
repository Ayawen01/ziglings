//
// 当然，我们可以使用全局变量来解决异步值问题。但这似乎不是一个理想的解决方案。
//
// 那么我们如何才能真正从异步函数中获取返回值呢？
//
// 'await'关键字等待异步函数完成，然后捕获其返回值。
//
//     fn foo() u32 {
//         return 5;
//     }
//
//    var foo_frame = async foo(); // invoke and get frame
//    var value = await foo_frame; // await result using frame
//
// 上面的例子只是一种愚蠢的调用foo()并获得5的方法。
// 但如果foo()做了更有趣的事情，比如等待网络响应来获取那个5，我们的代码将暂停，直到该值准备好。
//
// 正如你所看到的，异步/等待基本上将函数调用分成两个部分：
//
//    1. 调用函数（'async'）
//    2. 获取返回值（'await'）
//
// 还要注意，在函数中不需要存在'suspend'关键字就可以在异步上下文中调用它。
//
// 请使用'await'获取getPageTitle()返回的字符串。
//
const print = @import("std").debug.print;

pub fn main() void {
    var myframe = async getPageTitle("http://example.com");

    var value = ???

    print("{s}\n", .{value});
}

fn getPageTitle(url: []const u8) []const u8 {
    // 请假装这实际上正在进行网络请求。
    _ = url;
    return "Example Title.";
}
