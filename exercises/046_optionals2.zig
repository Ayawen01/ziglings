//
// 现在我们有了可选类型，我们可以把它们应用到结构体上。
// 上次我们检查大象的时候，我们不得不把所有三只大象连接在一起，
// 形成一个“圆圈”，这样最后一条尾巴就指向了第一只大象。
// 这是因为我们没有一个不指向另一只大象的尾巴的概念！
//
// 我们还介绍了一个方便的“.?”快捷方式：
//
//     const foo = bar.?;
//
// 等同于
//
//     const foo = bar orelse unreachable;
//
// 看看你能否在下面找到我们使用这个快捷方式的地方。
//
// 现在让我们把大象的尾巴变成可选的！
//
const std = @import("std");

const Elephant = struct {
    letter: u8,
    tail: ?*Elephant = null, // 嗯……尾巴需要点什么……
    visited: bool = false,
};

pub fn main() void {
    var elephantA = Elephant{ .letter = 'A' };
    var elephantB = Elephant{ .letter = 'B' };
    var elephantC = Elephant{ .letter = 'C' };

    // 把大象连接起来，让每条尾巴“指向”下一只。
    elephantA.tail = &elephantB;
    elephantB.tail = &elephantC;

    visitElephants(&elephantA);

    std.debug.print("\n", .{});
}

// 这个函数会访问所有的大象一次，从第一只开始，
// 沿着尾巴找到下一只。当我们遇到一个不指向另一个元素的尾巴时，我们应该停止。
fn visitElephants(first_elephant: *Elephant) void {
    var e = first_elephant;

    while (!e.visited) {
        std.debug.print("Elephant {u}. ", .{e.letter});
        e.visited = true;

        // 我们可以在这里放什么东西来实现这个功能呢？
        if (e.tail == null) break;

        e = e.tail.?;
    }
}
