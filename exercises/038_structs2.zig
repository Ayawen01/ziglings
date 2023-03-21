//
// 在结构体中分组值不仅方便，而且还允许我们在存储它们、传递给函数等时，将它们作为一个单独的项来处理。
//
// 这个练习演示了我们如何在数组中存储结构体，以及这样做如何让我们使用循环来打印它们。
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
    health: u8,
    experience: u32,
};

pub fn main() void {
    var chars: [2]Character = undefined;

    // Glorp the Wise
    chars[0] = Character{
        .class = Class.wizard,
        .gold = 20,
        .health = 100,
        .experience = 10,
    };

    // 请添加“Zump the Loud”，并具有以下属性：
    //
    //     class      bard
    //     gold       10
    //     health     100
    //     experience 20
    //
    // 您可以在不添加Zump的情况下运行这个程序。它会做什么，为什么呢？
    chars[1] = Character{
        .class = Class.bard,
        .gold = 10,
        .health = 100,
        .experience = 20,
    };

    // 在循环中打印所有RPG角色：
    for (chars, 0..) |c, num| {
        std.debug.print("Character {} - G:{} H:{} XP:{}\n", .{
            num + 1, c.gold, c.health, c.experience,
        });
    }
}

// 如果你按照上面提到的，在不添加Zump的情况下尝试运行程序，你会得到看起来像“垃圾”值。
// 在调试模式下（默认情况下），Zig会将重复模式“10101010”
// （二进制）或0xAA（十六进制）写入所有未定义的位置，以便在调试时更容易发现它们。
