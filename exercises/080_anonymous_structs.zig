//
// 结构体类型总是“匿名”的，直到我们给它们命名：
//
//     struct {};
//
// 到目前为止，我们一直在给结构体类型命名，例如：
//
//     const Foo = struct {};
//
// * @typeName(Foo) 的值为“<filename>.Foo”。
//
// 当您从函数中返回它时，结构体也会被命名：
//
//     fn Bar() type {
//         return struct {};
//     }
//
//     const MyBar = Bar();  // 存储结构体类型
//     const bar = Bar() {}; // 创建结构体实例
//
// * @typeName(Bar()) 的值为“Bar()”。
// * @typeName(MyBar) 的值为“Bar()”。
// * @typeName(@TypeOf(bar)) 的值为“Bar()”。
//
// 您还可以拥有完全匿名的结构体。@typeName(struct {}) 的值为“struct：<position in source>”。
//
const print = @import("std").debug.print;

// 此函数通过返回一个匿名的结构体类型（在从函数返回后将不再是匿名的）来创建通用数据结构。
fn Circle(comptime T: type) type {
    return struct {
        center_x: T,
        center_y: T,
        radius: T,
    };
}

pub fn main() void {
    //
    // 看看您是否可以完成这两个变量初始化表达式，以创建可以容纳以下值的圆形结构体类型：
    //
    // * circle1 应该容纳 i32 整数
    // * circle2 应该容纳 f32 浮点数
    //
    var circle1 = ??? {
        .center_x = 25,
        .center_y = 70,
        .radius = 15,
    };

    var circle2 = ??? {
        .center_x = 25.234,
        .center_y = 70.999,
        .radius = 15.714,
    };

    print("[{s}: {},{},{}] ", .{
        stripFname(@typeName(@TypeOf(circle1))),
        circle1.center_x,
        circle1.center_y,
        circle1.radius,
    });

    print("[{s}: {d:.1},{d:.1},{d:.1}]\n", .{
        stripFname(@typeName(@TypeOf(circle2))),
        circle2.center_x,
        circle2.center_y,
        circle2.radius,
    });
}

// 或许您还记得 Ex. 065 中类型名称的“自恋修复”？
// 我们在这里做同样的事情：使用硬编码的切片来返回类型名称。
// 这只是为了让我们的输出看起来更漂亮。满足您的虚荣心。程序员很美丽。
fn stripFname(mytype: []const u8) []const u8 {
    return mytype[22..];
}
// 上面的代码在“real”的程序中会立即引起注意。
