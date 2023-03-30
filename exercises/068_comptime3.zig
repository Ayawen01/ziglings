//
// 您还可以在函数参数前面放置'comptime'来强制要求传递给函数的参数必须在编译时已知。
// 我们实际上一直在使用这样的函数，std.debug.print()：
//
//     fn print(comptime fmt: []const u8, args: anytype) void
//
// 请注意，格式字符串参数'fmt'标记为'comptime'。
// 这样做的一个很好的好处是，可以在编译时检查格式字符串是否有误，而不是在运行时崩溃。
//
// （实际的格式化是由std.fmt.format()完成的，它包含一个完整的格式字符串解析器，完全在编译时运行！）
//
const print = @import("std").debug.print;

// 这个结构体是模型船的模型。我们可以将它转换为任何比例尺：1:2是半尺寸，1:32比真实物品小三十二倍，等等。
const Schooner = struct {
    name: []const u8,
    scale: u32 = 1,
    hull_length: u32 = 143,
    bowsprit_length: u32 = 34,
    mainmast_height: u32 = 95,

    fn scaleMe(self: *Schooner, comptime scale: u32) void {
        var my_scale = scale;

        // 我们做了一些很棒的事情：我们预见到了意外尝试创建1:0比例尺的可能性。我们没有让它在运行时导致除以零错误，而是将其转换为编译错误。
        //
        // 这可能大多数情况下都是正确的解决方案。但是我们的模型船模型程序非常随意，我们只想让它“做我想要的”并继续工作。
        //
        // 请更改此设置，以便将0比例设置为1。
        if (my_scale == 0) my_scale = 1;

        self.scale = my_scale;
        self.hull_length /= my_scale;
        self.bowsprit_length /= my_scale;
        self.mainmast_height /= my_scale;
    }

    fn printMe(self: Schooner) void {
        print("{s} (1:{}, {} x {})\n", .{
            self.name,
            self.scale,
            self.hull_length,
            self.mainmast_height,
        });
    }
};

pub fn main() void {
    var whale = Schooner{ .name = "Whale" };
    var shark = Schooner{ .name = "Shark" };
    var minnow = Schooner{ .name = "Minnow" };

    // 嘿，我们不能只将此运行时变量作为参数传递给scaleMe()方法。什么可以让我们这样做？
    comptime var scale: u32 = undefined;

    scale = 32; // 1:32 比例尺

    minnow.scaleMe(scale);
    minnow.printMe();

    scale -= 16; // 1:16 比例尺

    shark.scaleMe(scale);
    shark.printMe();

    scale -= 16; // 1:0 比例尺（糟糕了，但不要修复它！）

    whale.scaleMe(scale);
    whale.printMe();
}
//
// 更深入地探讨：
//
// 如果您尝试按比例1：0建立模型，会发生什么？
//
// A）您已经完成了！
// B）您将遭受精神除以零的错误。
// C）您将构建奇点并摧毁行星。
//
// 那么比例为0：1的模型呢？
//
// A）您已经完成了！
// B）您会仔细安排无形物体，使其形成原始无形物体，但是无限大。
// C）您将构建奇点并摧毁行星。
//
// 答案可以在Ziglings包装的背面找到。
