//
// 现在让我们创建一个带有参数的函数。
// 这里有一个例子，它接受两个参数。
// 如你所见，参数的声明就像任何其他类型一样（"name": "type"）：
//
//     fn myFunction(number: u8, is_lucky: bool) {
//         ...
//     }
//
const std = @import("std");

pub fn main() void {
    std.debug.print("Powers of two: {} {} {} {}\n", .{
        twoToThe(1),
        twoToThe(2),
        twoToThe(3),
        twoToThe(4),
    });
}

// 请给这个函数正确的输入参数。
// 你需要找出我们期望的参数名和类型。
// 输出类型已经为你指定好了。
//
fn twoToThe(my_number: u32) u32 {
    return std.math.pow(u32, 2, my_number);
    // std.math.pow(type, a, b) 接受一个数值类型和两个该类型的数字（或者可以转换为该类型的数字），
    // 并返回 "a 的 b 次方" 作为相同的数值类型。
}
