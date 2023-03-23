//
// 救命啊! 邪恶的外星生物在地球上到处藏蛋
// 而且它们开始孵化了!
//
// 在你投入战斗之前，你需要知道四件事：
//
// 1.你可以在结构上附加函数：
//
//     const Foo = struct{
//         pub fn hello() void {
//             std.debug.print("Foo says hello!\n", .{});
//         }
//     };
//
// 2.作为结构成员的函数是一种 "方法"，可以用 "点语法 "来调用。
//   用 "点语法 "来调用，比如说：
//
//     Foo.hello();
//
// 3.方法的NEAT特性是一个名为 "self "的特殊参数。
//   "self "的特殊参数，它需要一个该类型结构的实例：
//
//     const Bar = struct{
//         number: u32,
//
//         pub fn printMe(self: Bar) void {
//             std.debug.print("{}\n", .{self.number});
//         }
//     };
//
//    （实际上，你可以给第一个参数起任何名字，但
//    请遵循惯例，使用 "self"）。
//
// 4.现在，当你用 "点语法 "在该结构的一个实例上调用该方法时，该实例
//   时，该实例将自动作为 "self "参数被传递。
//   作为 "self "参数传递：
//
//     var my_bar = Bar{ .number = 2000 };
//     my_bar.printMe(); // prints "2000"
//
// 好了，你已经武装起来了。
//
// 现在，请将这些外星结构斩断，直到它们全部消失，否则
// 否则地球就会被毁灭!
//
const std = @import("std");

// 看看这个丑陋的外星人结构。了解你的敌人!
const Alien = struct {
    health: u8,

    // 我们讨厌这种方法：
    pub fn hatch(strength: u8) Alien {
        return Alien{
            .health = strength * 5,
        };
    }
};

// 你可靠的武器。扑灭那些外星人!
const HeatRay = struct {
    damage: u8,

    // 我们喜欢这种方法：
    pub fn zap(self: HeatRay, alien: *Alien) void {
        alien.health -= if (self.damage >= alien.health) alien.health else self.damage;
    }
};

pub fn main() void {
    //  看看这些实力各异的外星人!
    var aliens = [_]Alien{
        Alien.hatch(2),
        Alien.hatch(1),
        Alien.hatch(3),
        Alien.hatch(3),
        Alien.hatch(5),
        Alien.hatch(3),
    };

    var aliens_alive = aliens.len;
    var heat_ray = HeatRay{ .damage = 7 }; // 我们得到了一个热射线武器。

    // 我们将不断检查，看我们是否已经杀死了所有的外星人。
    while (aliens_alive > 0) {
        aliens_alive = 0;

        // 通过引用循环查看每个外星人（*做一个指针捕捉值）。
        for (&aliens) |*alien| {

            // ***在这里用热射线斩杀外星人! ***
            heat_ray.zap(alien);

            // 如果这个外星人的健康状况仍然在0以上，那么它仍然活着。
            if (alien.health > 0) aliens_alive += 1;
        }

        std.debug.print("{} aliens. ", .{aliens_alive});
    }

    std.debug.print("Earth is saved!\n", .{});
}
