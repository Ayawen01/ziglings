//
// 手动跟踪我们联合中的激活字段真的很不方便，不是吗？
//
// 幸运的是，Zig也有“标记联合（tagged unions）”，
// 它们可以让我们在联合中存储一个枚举值，表示哪个字段是激活状态。
//
//     const FooTag = enum{ small, medium, large };
//
//     const Foo = union(FooTag) {
//         small: u8,
//         medium: u32,
//         large: u64,
//     };
//
// 现在我们可以直接对联合使用switch语句来对激活状态的字段进行操作：
//
//     var f = Foo{ .small = 10 };
//
//     switch (f) {
//         .small => |my_small| do_something(my_small),
//         .medium => |my_medium| do_something(my_medium),
//         .large => |my_large| do_something(my_large),
//     }
//
// 让我们让我们的昆虫使用一个标记联合（博士Zoraptera赞成）。
//
const std = @import("std");

const InsectStat = enum { flowers_visited, still_alive };

const Insect = union(InsectStat) {
    flowers_visited: u16,
    still_alive: bool,
};

pub fn main() void {
    var ant = Insect{ .still_alive = true };
    var bee = Insect{ .flowers_visited = 16 };

    std.debug.print("Insect report! ", .{});

    // 它真的就是简单地传递一个联合吗？
    printInsect(ant);
    printInsect(bee);

    std.debug.print("\n", .{});
}

fn printInsect(insect: Insect) void {
    switch (insect) {
        .still_alive => |a| std.debug.print("Ant alive is: {}. ", .{a}),
        .flowers_visited => |f| std.debug.print("Bee visited {} flowers. ", .{f}),
    }
}

// 顺便说一下，联合是否让你想起了可选值和错误？
// 可选值基本上就是“空联合”，而错误使用“错误联合类型”。
// 现在我们可以把自己的联合加入到混合中来处理我们可能遇到的任何情况：
//          union(Tag) { value: u32, toxic_ooze: void }
