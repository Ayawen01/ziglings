//
// 使用标记联合，它变得更好！如果你不需要一个单独的枚举，
// 你可以在一个地方定义一个推断枚举和你的联合。
// 只需要用'enum'关键字代替标签类型：
//
//     const Foo = union(enum) {
//         small: u8,
//         medium: u32,
//         large: u64,
//     };
//
// 让我们转换Insect。博士Zoraptera已经为你删除了显式的InsectStat枚举！
//
const std = @import("std");

const Insect = union(enum) {
    flowers_visited: u16,
    still_alive: bool,
};

pub fn main() void {
    var ant = Insect{ .still_alive = true };
    var bee = Insect{ .flowers_visited = 17 };

    std.debug.print("Insect report! ", .{});

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

// 推断枚举很整洁，它代表了枚举和联合之间关系的冰山一角。
// 你实际上可以把一个联合强制转换为一个枚举（这会给你联合中的激活字段作为一个枚举）。
// 更疯狂的是，你可以把一个枚举强制转换为一个联合！
// 但是不要太兴奋，这只有在联合类型是那些奇怪的零位类型（zero-bit types）如void时才有效！
//
// 标记联合，和计算机科学中的大多数思想一样，
// 有着悠久的历史，可以追溯到20世纪60年代。
// 然而，它们最近才开始成为主流，特别是在系统级编程语言中。
// 你可能也见过它们被称为“变体（variants）”，“和类型（sum types）”，或者甚至“枚举（enums）”！

