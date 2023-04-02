//
// 已经有几个情况，我们希望在程序中使用循环，
// 但我们不能，因为我们试图做的事情只能在编译时完成。
// 我们最终不得不像普通人一样手动完成这些事情。
// 呸！我们是程序员！计算机应该完成这项工作。
//
// “inline for”是在编译时执行的，允许您
// 在上述情况中通过一系列项目进行编程循环，
// 在这些情况下，常规的运行时“for”循环将不被允许：
//
//     inline for (.{ u8, u16, u32, u64 }) |T| {
//         print("{} ", .{@typeInfo(T).Int.bits});
//     }
//
// 在上面的示例中，我们正在遍历一个类型列表，
// 这些类型仅在编译时可用。
//
const print = @import("std").debug.print;

// 还记得我们在练习065中使用内置函数进行反射的Narcissus吗？他回来了，而且很喜欢它。
const Narcissus = struct {
    me: *Narcissus = undefined,
    myself: *Narcissus = undefined,
    echo: void = undefined,
};

pub fn main() void {
    print("Narcissus has room in his heart for:", .{});

    // 上次我们检查Narcissus结构时，必须
    // 手动访问三个字段中的每一个。我们的“if”
    // 语句几乎一字不差地重复了三次。呸！
    //
    // 请使用“内联for”来实现下面的块
    // 对于切片“fields”中的每个字段！

    const fields = @typeInfo(Narcissus).Struct.fields;

    inline for(fields) |field| {
        if (field.type != void) {
            print(" {s}", .{field.name});
        }
    }

    // 完成后，返回并查看练习
    // 065并将您所写的内容与我们在那里的怪物进行比较！

    print(".\n", .{});
}
