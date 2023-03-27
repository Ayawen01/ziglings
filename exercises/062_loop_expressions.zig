//
// 还记得像这样使用if/else语句作为表达方式吗？
//
//     var foo: u8 = if (true) 5 else 0;
//
// Zig还允许你将for和while循环作为表达式使用。
//
// 像函数的 "return "一样，你可以从一个
// 循环块中返回一个值，并使用break：
//
//     break true; // 从块返回布尔值
//
// 但是，如果break语句没有到达，从循环中返回的是什么值呢？
// 从未到达？我们需要一个默认的表达式。幸好，Zig
// 循环也有 "else "子句! 正如你可能已经猜到的，'else'子句在以下情况下被评估
// 'else'子句会在以下情况下被评估： 1) 一个'while'条件变成
// 为假，或者2）'for'循环中的项目用完。
//
//     const two: u8 = while (true) break 2 else 0;         // 2
//     const three: u8 = for ([1]u8{1}) |f| break 3 else 0; // 3
//
// 如果你没有提供一个else子句，一个空的else子句将被提供给你。
// 它将评估为void类型，这可能不是你想要的。
// 可能不是你想要的。所以请考虑else子句
// 在使用循环作为表达式时，是必不可少的。
//
//     const four: u8 = while (true) {
//         break 4;
//     };               // <-- 错误! 这里隐含了'else void'!
//
// 考虑到这一点，看看你能不能用这个程序解决这个问题程序。
// 程序。
//
const print = @import("std").debug.print;

pub fn main() void {
    const langs: [6][]const u8 = .{
        "Erlang",
        "Algol",
        "C",
        "OCaml",
        "Zig",
        "Prolog",
    };

    // 让我们找到第一个有三个字母名字的语言，并从for循环中返回。
    // 从for循环中返回。
    const current_lang: ?[]const u8 = for (langs) |lang| {
        if (lang.len == 3) break lang;
    } else null;

    if (current_lang) |cl| {
        print("Current language: {s}\n", .{cl});
    } else {
        print("Did not find a three-letter language name. :-(\n", .{});
    }
}
