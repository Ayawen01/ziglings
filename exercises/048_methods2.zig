//
// 现在我们已经看到了方法是如何工作的，
// 让我们看看我们能否用一些Elephant方法来帮助
// 我们的大象多一点。
//
const std = @import("std");

const Elephant = struct {
    letter: u8,
    tail: ?*Elephant = null,
    visited: bool = false,

    // 新的Elephant方法！
    pub fn getTail(self: *Elephant) *Elephant {
        return self.tail.?; // 记住，这意味着“否则无法到达”
    }

    pub fn hasTail(self: *Elephant) bool {
        return (self.tail != null);
    }

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

    // 这将大象连接起来，使每个尾巴“指向”下一个。
    elephantA.tail = &elephantB;
    elephantB.tail = &elephantC;

    visitElephants(&elephantA);

    std.debug.print("\n", .{});
}

// 这个函数访问所有的大象一次，从第一个大象开始，并沿着尾巴到下一个大象。
fn visitElephants(first_elephant: *Elephant) void {
    var e = first_elephant;

    while (true) {
        e.print();
        e.visit();

        // 这获取下一个大象或停止。
        if (e.hasTail()) {
            e = e.getTail(); // 我们想要哪种方法呢？
        } else {
            break;
        }
    }
}

// Zig的枚举也可以有方法！
// 这条评论最初询问是否有人能在野外找到枚举方法的实例。
// 前五个拉取请求被接受了，它们是：
//
// 1) drforester - 我在Zig源码中找到了一个：
// https://github.com/ziglang/zig/blob/041212a41cfaf029dc3eb9740467b721c76f406c/src/Compilation.zig#L2495
//
// 2) bbuccianti - 我找到了一个！
// https://github.com/ziglang/zig/blob/6787f163eb6db2b8b89c2ea6cb51d63606487e12/lib/std/debug.zig#L477
//
// 3) GoldsteinE - 找到了很多，这里有一个
// https://github.com/ziglang/zig/blob/ce14bc7176f9e441064ffdde2d85e35fd78977f2/lib/std/target.zig#L65
//
// 4) SpencerCDixon - 到目前为止非常喜欢这种语言 :-)
// https://github.com/ziglang/zig/blob/a502c160cd51ce3de80b3be945245b7a91967a85/src/zir.zig#L530
//
// 5) tomkun - 这里还有另一个枚举方法
// https://github.com/ziglang/zig/blob/4ca1f4ec2e3ae1a08295bc6ed03c235cb7700ab9/src/codegen/aarch64.zig#L24
