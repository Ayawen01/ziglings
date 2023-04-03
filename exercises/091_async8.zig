//
// 你肯定注意到'suspend'需要一个代码块表达式，如下所示：
//
//     suspend {}
//
// 当函数暂停时，执行suspend代码块。为了了解何时发生这种情况，请使以下程序打印字符串
//
//     "ABCDEF"
//
const print = @import("std").debug.print;

pub fn main() void {
    print("A", .{});

    var frame = async suspendable();

    print("X", .{});

    resume frame;

    print("F", .{});
}

fn suspendable() void {
    print("X", .{});

    suspend {
        print("X", .{});
    }

    print("X", .{});
}
