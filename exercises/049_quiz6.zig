//
//    “鼻子和尾巴
//     都是方便的东西”

//     选自《牵手》
//       作者：莱诺尔·M·林克
//
// 现在我们已经弄清楚了尾巴的问题，你能实现鼻子吗？
//
const std = @import("std");

const Elephant = struct {
    letter: u8,
    tail: ?*Elephant = null,
    trunk: ?*Elephant = null,
    visited: bool = false,

    // 大象尾巴方法！
    pub fn getTail(self: *Elephant) *Elephant {
        return self.tail.?; // 记住，这意味着“否则无法到达”
    }

    pub fn hasTail(self: *Elephant) bool {
        return (self.tail != null);
    }

    // 你的大象鼻子方法放在这里！
    // ---------------------------------------------------

    pub fn getTrunk(self: *Elephant) *Elephant {
        return self.trunk.?;
    }

    pub fn hasTrunk(self: *Elephant) bool {
        return self.trunk != null;
    }

    // ---------------------------------------------------

    pub fn visit(self: *Elephant) void {
        self.visited = true;
    }

    pub fn print(self: *Elephant) void {
        // 打印大象字母和[v]isited
        var v: u8 = if (self.visited) 'v' else ' ';
        std.debug.print("{u}{u} ", .{ self.letter, v });
    }
};

pub fn main() void {
    var elephantA = Elephant{ .letter = 'A' };
    var elephantB = Elephant{ .letter = 'B' };
    var elephantC = Elephant{ .letter = 'C' };

    // 我们将大象连接起来，使每个尾巴“指向”下一个。
    elephantA.tail = &elephantB;
    elephantB.tail = &elephantC;

    // 并将大象连接起来，使每个鼻子“指向”前一个。
    elephantB.trunk = &elephantA;
    elephantC.trunk = &elephantB;

    visitElephants(&elephantA);

    std.debug.print("\n", .{});
}

// 这个函数访问所有的大象两次，从尾巴到鼻子。
fn visitElephants(first_elephant: *Elephant) void {
    var e = first_elephant;

    // 我们跟随尾巴！
    while (true) {
        e.print();
        e.visit();

        // 这获取下一个大象或停止。
        if (e.hasTail()) {
            e = e.getTail();
        } else {
            break;
        }
    }

    // 我们跟随鼻子！
    while (true) {
        e.print();

        // 这获取前一个大象或停止。
        if (e.hasTrunk()) {
            e = e.getTrunk();
        } else {
            break;
        }
    }
}
