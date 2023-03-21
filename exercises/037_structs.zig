//
// 将值分组在一起可以让我们把这样的代码：
//
//     point1_x = 3;
//     point1_y = 16;
//     point1_z = 27;
//     point2_x = 7;
//     point2_y = 13;
//     point2_z = 34;
//
// 变成这样的代码：
//
//     point1 = Point{ .x=3, .y=16, .z=27 };
//     point2 = Point{ .x=7, .y=13, .z=34 };
//
// 上面的Point就是一个“结构体”（structure）的例子。
// 下面是如何定义这个结构体类型的代码：
//
//     const Point = struct{ x: u32, y: u32, z: u32 };
//
// 让我们用一个结构体来存储一些有趣的东西：一个角色扮演游戏中的角色！
//
const std = @import("std");

// 我们将用一个枚举类型（enum）来指定角色的职业。
const Class = enum {
    wizard,
    thief,
    bard,
    warrior,
};

// 请在这个结构体中添加一个新的属性叫做“health”，并且让它是一个u8整数类型。
const Character = struct {
    class: Class,
    gold: u32,
    experience: u32,
    health: u8,
};

pub fn main() void {
    // 请用100点生命值来初始化Glorp。
    var glorp_the_wise = Character{
        .class = Class.wizard,
        .gold = 20,
        .experience = 10,
        .health = 100,
    };

    // Glorp获得了一些金币。
    glorp_the_wise.gold += 5;

    // 糟糕！Glorp挨了一拳！
    glorp_the_wise.health -= 10;

    std.debug.print("Your wizard has {} health and {} gold.\n", .{
        glorp_the_wise.health,
        glorp_the_wise.gold,
    });
}
