//
// 通常情况下，当没有等效的Zig函数时，会使用C函数。
// 由于C函数的集成非常简单，如上一次练习所示，
// 因此自然而然地可以使用各种各样的C函数来编写自己的程序。
// 此外，立即举个例子：
//
// 假设我们有一个给定的角度为765.2度。
// 如果我们想要将其归一化，那么就意味着我们必须减去X * 360度才能得到正确的角度。
// 我们该怎么做？一个好的方法是使用模数函数。
// 但是，如果我们写“765.2％360”，它不起作用，因为标准模数函数仅适用于整数值。
// 在C库“math”中有一个名为“fmod”的函数。 “f”代表浮点数，并表示我们可以解决实数的模数。
// 使用此函数应该可以归一化我们的角度。让我们开始吧。

const std = @import("std");

const c = @cImport({
    // 这里需要什么？
    @cInclude("math.h");
});

pub fn main() !void {
    const angel = 765.2;
    const circle = 360;

    // 在这里，我们调用C函数'fmod'以获取我们的归一化天使。
    const result = c.fmod(angel, circle);

    // 我们使用格式化程序来获取所需的精度并截断小数位
    std.debug.print("The normalized angle of {d: >3.1} degrees is {d: >3.1} degrees.\n", .{ angel, result });
}
