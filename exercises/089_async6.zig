//
// 这是一个关于异步/等待的示例，
// 它展示了在同时执行多个任务时异步/等待的强大和目的。
// Foo和Bar互不依赖，可以同时发生，但End需要它们都完成。
//
//               +---------+
//               |  Start  |
//               +---------+
//                  /    \
//                 /      \
//        +---------+    +---------+
//        |   Foo   |    |   Bar   |
//        +---------+    +---------+
//                 \      /
//                  \    /
//               +---------+
//               |   End   |
//               +---------+
//
// 我们可以这样用Zig来表达：
//
//     fn foo() u32 { ... }
//     fn bar() u32 { ... }
//
//     // Start
//
//     var foo_frame = async foo();
//     var bar_frame = async bar();
//
//     var foo_value = await foo_frame;
//     var bar_value = await bar_frame;
//
//     // End
//
// 请等待两个页面标题！
const print = @import("std").debug.print;

pub fn main() void {
    var com_frame = async getPageTitle("http://example.com");
    var org_frame = async getPageTitle("http://example.org");

    var com_title = com_frame;
    var org_title = org_frame;

    print(".com: {s}, .org: {s}.\n", .{ com_title, org_title });
}

fn getPageTitle(url: []const u8) []const u8 {
    // 请假装这实际上正在进行网络请求。
    _ = url;
    return "Example Title";
}
