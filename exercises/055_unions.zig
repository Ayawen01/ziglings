//
// 一个联合（union）可以让你在同一个内存地址存储不同类型和大小的数据。
// 这是怎么做到的呢？
// 编译器会为你可能想要存储的最大的东西预留足够的内存空间。
//
// 在这个例子中，一个Foo的实例总是占用u64的内存空间，
// 即使你当前只存储了一个u8。
//
//     const Foo = union {
//         small: u8,
//         medium: u32,
//         large: u64,
//     };
//
// 语法看起来就像一个结构体（struct），
// 但是一个Foo只能存储一个small或者一个medium或者一个large值。
// 一旦一个字段变成激活状态，其他非激活状态的字段就不能被访问。
// 要改变激活状态的字段，需要赋值一个全新的实例：
//
//     var f = Foo{ .small = 5 };
//     f.small += 5;                  // 可以
//     f.medium = 5432;               // 错误！
//     f = Foo{ .medium = 5432 };     // 可以
//
// 联合可以节省内存空间，因为它们让你“重复使用”一个内存空间。
// 它们也提供了一种原始的多态性。
// 这里fooBar()可以接受任何大小的无符号整数类型的Foo：
//
//     fn fooBar(f: Foo) void { ... }
//
// 哦，但是fooBar()怎么知道哪个字段是激活状态呢？
// Zig有一种巧妙的方式来跟踪，但是现在我们只能手动做。
//
// 让我们看看我们能不能让这个程序运行起来！
//
const std = @import("std");

// 我们刚刚开始写一个简单的生态系统模拟程序。
// 昆虫将由蜜蜂或者蚂蚁来表示。
// 蜜蜂存储它们一天访问过多少朵花，
// 而蚂蚁只存储它们是否还活着。
const Insect = union {
    flowers_visited: u16,
    still_alive: bool,
};

// 因为我们需要指定昆虫的类型，我们将使用枚举（enum）（还记得吗？）。
const AntOrBee = enum { a, b };

pub fn main() void {
    // 我们只创建了一只蜜蜂和一只蚂蚁来测试它们：
    var ant = Insect{ .still_alive = true };
    var bee = Insect{ .flowers_visited = 15 };

    std.debug.print("Insect report! ", .{});

    // 哎呀！我们在这里犯了一个错误。
    printInsect(ant, AntOrBee.a);
    printInsect(bee, AntOrBee.b);

    std.debug.print("\n", .{});
}

// 古怪的博士Zoraptera说我们只能用一个函数来打印我们的昆虫。
// 博士Z很小而且有时难以理解，但是我们不会质疑她。
fn printInsect(insect: Insect, what_it_is: AntOrBee) void {
    switch (what_it_is) {
        .a => std.debug.print("Ant alive is: {}. ", .{insect.still_alive}),
        .b => std.debug.print("Bee visited {} flowers. ", .{insect.flowers_visited}),
    }
}
