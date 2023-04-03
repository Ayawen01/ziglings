//
// 除了知道何时使用'comptime'关键字之外，
// 还要知道何时不需要它。
//
// 以下上下文已经在编译时隐式评估，
// 添加'comptime'关键字是多余的、冗余的和臭的：
//
//    * 全局范围（在源文件中任何函数之外）
//    * 变量的类型声明
//    * 函数（参数和返回值的类型）
//    * 结构体
//    * 联合体
//    * 枚举
//    * inline for和while循环中的测试表达式
//    * 传递给@cImport()内置函数的表达式
//
// 与Zig一起工作一段时间，你就会开始发展一个
// 对这些上下文的直觉。让我们现在开始工作。
//
// 您只有一个'comptime'语句可用于下面的程序。这里它是：
//
//     comptime
//
// 只需要一个就可以了。明智地使用它！
const print = @import("std").debug.print;

// 作为全局范围，这个值的所有内容都是隐式的
const llama_count = 5;

// 要求在编译时知道。再次强调，这个值的类型和大小必须在编译时知道，
// 但我们让编译器从函数的返回类型中推断出两者。
const llamas = makeLlamas(llama_count);

// 这就是函数。请注意，返回值类型
// 取决于其中一个输入参数！
fn makeLlamas(comptime count: usize) [count]u8 {
    var temp: [count]u8 = undefined;
    var i = 0;

    // 请注意，这不需要是内联'while'。
    while (i < count) : (i += 1) {
        temp[i] = i;
    }

    return temp;
}

pub fn main() void {
    print("My llama value is {}.\n", .{llamas[2]});
}
//
// 这里的教训是，除非你需要它们，否则不要在程序中使用'comptime'关键字。
// 在隐式编译时间上下文和Zig对任何可以在编译时确定的表达式的积极评估之间，
// 有时会令人惊讶地发现实际上只有很少的地方需要该关键字。
