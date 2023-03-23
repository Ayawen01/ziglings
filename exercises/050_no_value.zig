//
//    “我们生活在无知的平静岛屿上，
//     在无限的黑暗海洋中，
//     我们不应该远航。”
//
//     选自《克苏鲁的呼唤》
//       作者：H. P. 洛夫克拉夫特
//
// Zig至少有四种表示“无值”的方式：
//
// * undefined
//
//       var foo: u8 = undefined;
//
//       “undefined”不应该被认为是一个值，而是一种告诉编译器你还没有分配一个值
//       的方式。任何类型都可以设置为undefined，但是试图读取或使用该值总是一个错误。
//
// * null
//
//       var foo: ?u8 = null;
//
//       “null”原始值_是_一个表示“无值”的值。
//       这通常用于可选类型，如上面显示的?u8。
//       当foo等于null时，那不是u8类型的一个值。
//       它意味着foo根本没有u8类型的_任何值_！
//
// * error
//
//       var foo: MyError!u8 = BadError;
//
//       错误和null非常_相似_。
//       它们_是_一个值，但它们通常表示你要找的“真正的值”不存在。
//       相反，你有一个错误。
//       上面示例中的错误联合类型MyError!u8意味着foo要么持有
//       一个u8值，要么持有一个错误。
//       当它设置为错误时，foo中没有u8类型的_任何值_！
//
// * void
//
//       var foo: void = {};
//
//       "void "是一个_类型_，而不是一个值。它是最流行的
//       零比特类型（那些完全不占空间的类型
//       并且只有一个语义值。当被编译为可执行
//       时，零位类型根本不产生任何代码。上面的例子
//       显示了一个void类型的变量foo，它被分配的值是
//       是一个空表达式。更常见的情况是将void作为
//       是一个不返回任何东西的函数的返回类型。
//
// Zig有所有这些表达不同类型的 "无值 "的方法。
// 因为它们都有各自的作用。简而言之：
//
//   * undefined - 现在还没有值，这不能被读取
//   * null      - 有一个明确的 "无价值 "的值
//   * errors    - 没有值，因为出了问题。
//   * void      - 这里永远不会有一个存储的值
//
// 请为每个 "空 "使用正确的 "无值"，以使这个程序
// 打印出Necronomicon中被诅咒的一句话。...如果你敢的话。
//
const std = @import("std");

const Err = error{Cthulhu};

pub fn main() void {
    var first_line1: *const [16]u8 = undefined;
    first_line1 = "That is not dead";

    var first_line2: Err!*const [21]u8 = Err.Cthulhu;
    first_line2 = "which can eternal lie";

    // 注意我们需要“{!s}”格式来表示错误联合字符串。
    std.debug.print("{s} {!s} / ", .{ first_line1, first_line2 });

    printSecondLine();
}

fn printSecondLine() void {
    var second_line2: ?*const [18]u8 = null;
    second_line2 = "even death may die";

    std.debug.print("And with strange aeons {s}.\n", .{second_line2.?});
}
