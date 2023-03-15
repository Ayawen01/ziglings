//
// 现在我们已经学习了数组，我们可以讨论字符串。
//
// 我们已经看到了Zig字符串字面量："Hello world.\n"
//
// Zig将字符串存储为字节数组。
//
//     const foo = "Hello";
//
// 几乎和下面这样相同：
//
//     const foo = [_]u8{ 'H', 'e', 'l', 'l', 'o' };
//
// (* 我们将在练习77中看到 Zig 字符串真正是什么。)
//
// 注意单个字符使用单引号 ('H')，而字符串使用双引号 ("H")。
// 这些是不可互换的！
//
const std = @import("std");

pub fn main() void {
    const ziggy = "stardust";

    // (问题1)
    // 使用数组方括号语法从上面的字符串 "stardust" 中获取字母 'd'。
    const d: u8 = ziggy[4];

    // (问题2)
    // 使用数组重复 '**'' 运算符来制作 "ha ha ha "。
    const laugh = "ha " ** 3;

    // (问题3)
    // 使用数组连接 '++'' 运算符来制作 "Major Tom"。
    // (你还需要添加一个空格！)
    const major = "Major";
    const tom = "Tom";
    const major_tom = major ++ " " ++ tom;

    // 这就是所有的问题。让我们看看结果：
    std.debug.print("d={u} {s}{s}\n", .{ d, laugh, major_tom });
    // 有眼力的人会注意到，我们在上面的格式化字符串中将 'u' 和 's' 放在了 '{}' 占位符内。
    // 这告诉print()函数将值格式化为UTF-8字符和UTF-8字符串。
    // 如果我们不这样做，我们会看到 '100'，这是UTF-8中与字符 'd' 对应的十进制数字。（以及字符串情况下的错误。）
    // 顺便说一下，'c'（ASCII编码字符）可以代替 'u'，因为UTF-8的前128个字符和ASCII是一样的！
}
