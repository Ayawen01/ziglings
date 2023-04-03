//
// 记得我们之前在练习55和56中使用联合体构建的蚂蚁和蜜蜂模拟器吗？
// 我们展示了联合体如何以统一的方式处理不同的数据类型。
//
// 其中一个很棒的特性是使用标记联合体来创建一个单一函数，通过switch语句来打印蚂蚁或蜜蜂的状态：
//
//   switch (insect) {
//      .still_alive => ...      // (print ant stuff)
//      .flowers_visited => ...  // (print bee stuff)
//   }
//
// 这个模拟器一直运行得很好，直到一个新的昆虫——蚂蚱出现在虚拟花园中！
//
// Zoraptera博士开始添加蚂蚱代码，但是她突然停下了，发出了一声愤怒的嘶嘶声。
// 她意识到，在一个地方编写每个昆虫的代码，在另一个地方编写每个昆虫的打印代码，
// 当模拟器扩展到数百种不同的昆虫时，这种方式将变得难以维护。
//
// 幸运的是，Zig有另一个编译时特性可以帮助我们摆脱这个困境——'inline else'。
//
// 我们可以用以下代码替换这些冗余代码：
//
//   switch (thing) {
//       .a => |a| special(a),
//       .b => |b| normal(b),
//       .c => |c| normal(c),
//       .d => |d| normal(d),
//       .e => |e| normal(e),
//       ...
//   }
//
// 使用以下代码：
//
//   switch (thing) {
//       .a => |a| special(a),
//       inline else |t| => normal(t),
//   }
//
// 我们可以对一些情况进行特殊处理，然后Zig会为我们处理其他匹配项。
//
// 借助这个特性，你决定创建一个Insect联合体，
// 并为其定义一个统一的'print()'函数。
// 所有昆虫都可以负责打印自己。Zoraptera博士可以放心了。
//
const std = @import("std");

const Ant = struct {
    still_alive: bool,

    pub fn print(self: Ant) void {
        std.debug.print("Ant is {s}.\n", .{if (self.still_alive) "alive" else "dead"});
    }
};

const Bee = struct {
    flowers_visited: u16,

    pub fn print(self: Bee) void {
        std.debug.print("Bee visited {} flowers.\n", .{self.flowers_visited});
    }
};

// 这里是新的蚂蚱。注意我们还为每个昆虫添加了打印方法。
const Grasshopper = struct {
    distance_hopped: u16,

    pub fn print(self: Grasshopper) void {
        std.debug.print("Grasshopper hopped {} meters.\n", .{self.distance_hopped});
    }
};

const Insect = union(enum) {
    ant: Ant,
    bee: Bee,
    grasshopper: Grasshopper,

    // 由于“inline else”的存在，我们可以将此print()视为接口方法。
    // 具有print()方法的此联合的任何成员都可以被外部代码统一处理，而无需了解任何其他细节。很酷！
    pub fn print(self: Insect) void {
        switch (self) {
            inline else => |case| return case.print(),
        }
    }
};

pub fn main() !void {
    var my_insects = [_]Insect{
        Insect{ .ant = Ant{ .still_alive = true } },
        Insect{ .bee = Bee{ .flowers_visited = 17 } },
        Insect{ .grasshopper = Grasshopper{ .distance_hopped = 32 }, },
    };

    std.debug.print("Daily Insect Report:\n", .{});
    for (my_insects) |insect| {
        // 快完成了！我们想要使用单个方法调用print()每个昆虫。
        ???
    }
}

// 上面的Insect联合中的print()方法演示了与面向对象概念非常相似的东西：抽象数据类型。
// 也就是说，Insect类型不包含底层数据，而print()函数实际上并不执行打印操作。
//
// 接口的目的是支持通用编程：将不同的事物视为相同以减少杂乱和概念上的复杂性。
//
// 每日昆虫报告不需要担心报告中有哪些昆虫-它们都通过接口以相同方式打印！
//
// Zoraptera医生很喜欢它。
