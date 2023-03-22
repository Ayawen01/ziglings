//
// 和整数一样，当你想要修改一个结构体时，你可以传递一个指向结构体的指针。指针也很有用，
// 当你需要存储一个结构体的引用（一个指向它的“链接”）时。
//
//     const Vertex = struct{ x: u32, y: u32, z: u32 };
//
//     var v1 = Vertex{ .x=3, .y=2, .z=5 };
//
//     var pv: *Vertex = &v1;   // <-- 我们结构体的一个指针
//
// 注意，你不需要解引用“pv”指针来访问结构体的字段：
//
//     YES: pv.x
//     NO:  pv.*.x
//
// 我们可以写一些接受结构体指针作为参数的函数。这个foo()函数修改了结构体v：
//
//     fn foo(v: *Vertex) void {
//         v.x += 2;
//         v.y += 3;
//         v.z += 7;
//     }
//
// 并像这样调用它们：
//
//     foo(&v1);
//
// 让我们重新回顾一下我们的RPG示例，并制作一个printCharacter()函数，
// 它接受一个Character引用并打印它...*并且*
// 如果有一个链接的“mentor” Character，也打印它。
//
const std = @import("std");

const Class = enum {
    wizard,
    thief,
    bard,
    warrior,
};

const Character = struct {
    class: Class,
    gold: u32,
    health: u8 = 100, // 你可以提供默认值
    experience: u32,

    // 我需要在这里使用'?'来允许空值。但是
    // 我直到后面才解释它。请不要告诉任何人。
    mentor: ?*Character = null,
};

pub fn main() void {
    var mighty_krodor = Character{
        .class = Class.wizard,
        .gold = 10000,
        .experience = 2340,
    };

    var glorp = Character{ // Glorp!
        .class = Class.wizard,
        .gold = 10,
        .experience = 20,
        .mentor = &mighty_krodor, // Glorp 的导师是强大的 Krodor
    };

    // 修复我！
    // 请将 Glorp 传递给 printCharacter():
    printCharacter(&glorp);
}

// 注意这个函数的“c”参数是一个指向Character结构体的指针。
fn printCharacter(c: *Character) void {
    // 这里有一些你以前没见过的东西：当切换枚举时，你
    // 不必写出完整的枚举名字。Zig理解“.wizard”
    // 意味着“Class.wizard”，当我们切换一个Class枚举值时：
    const class_name = switch (c.class) {
        .wizard => "Wizard",
        .thief => "Thief",
        .bard => "Bard",
        .warrior => "Warrior",
    };

    std.debug.print("{s} (G:{} H:{} XP:{})\n", .{
        class_name,
        c.gold,
        c.health,
        c.experience,
    });

    // 检查一个“可选”的值并捕获它将会在
    // 后面解释（这与上面提到过'?'相配合）
    if (c.mentor) |mentor| {
        std.debug.print("  Mentor: ", .{});
        printCharacter(mentor);
    }
}
