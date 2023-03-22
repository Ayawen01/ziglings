//
//    "大象们走着
//     沿着小径
//
//     它们手拉手
//     通过拉尾巴。"
//
//     来自《手拉手》
//       作者：Lenore M. Link
//
const std = @import("std");

const Elephant = struct {
    letter: u8,
    tail: *Elephant = undefined,
    visited: bool = false,
};

pub fn main() void {
    var elephantA = Elephant{ .letter = 'A' };
    // (请在这里添加大象B！)
    var elephantB = Elephant{ .letter = 'B' };
    var elephantC = Elephant{ .letter = 'C' };

    // 将大象链接起来，使每个尾巴“指向”下一个大象。
    // 它们形成了一个圈：A->B->C->A...
    elephantA.tail = &elephantB;
    // (请在这里将大象B的尾巴链接到大象C！)
    elephantB.tail = &elephantC;
    elephantC.tail = &elephantA;

    visitElephants(&elephantA);

    std.debug.print("\n", .{});
}

// 这个函数访问所有的大象一次，从第一个大象开始，
// 沿着尾巴到下一个大象。
// 如果我们不“标记”已访问过的大象（通过设置visited=true），
// 那么这将无限循环！
fn visitElephants(first_elephant: *Elephant) void {
    var e = first_elephant;

    while (!e.visited) {
        std.debug.print("Elephant {u}. ", .{e.letter});
        e.visited = true;
        e = e.tail;
    }
}
