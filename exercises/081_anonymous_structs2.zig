//
// 匿名结构体值字面量（不要与结构体类型混淆）使用'.{}'语法：
//
//     .{
//          .center_x = 15,
//          .center_y = 12,
//          .radius = 6,
//     }
//
// 这些字面量总是在编译时完全计算。上面的示例可以强制转换为上一个练习中的“圆形结构体”的i32变体。
//
// 或者您可以让它们完全匿名，就像这个例子一样：
//
//     fn bar(foo: anytype) void {
//         print("a:{} b:{}\n", .{foo.a, foo.b});
//     }
//
//     bar(.{
//         .a = true,
//         .b = false,
//     });
//
// 上面的示例打印“a:true b:false”。
//
const print = @import("std").debug.print;

pub fn main() void {
    printCircle(.{
        .center_x = @as(u32, 205),
        .center_y = @as(u32, 187),
        .radius = @as(u32, 12),
    });
}

// 请完成此函数，该函数打印表示圆的匿名结构体。
fn printCircle(???) void {
    print("x:{} y:{} radius:{}\n", .{
        circle.center_x,
        circle.center_y,
        circle.radius,
    });
}
