//
// 使用`catch`来用一个默认值替换错误有点粗暴，因为它不关心错误是什么。
//
// Catch让我们捕获错误值，并用这种形式执行额外的操作：
//
//     canFail() catch |err| {
//         if (err == FishError.TunaMalfunction) {
//             ...
//         }
//     };
//
const std = @import("std");

const MyNumberError = error{
    TooSmall,
    TooBig,
};

pub fn main() void {
    // 下面的"catch 0"是一个临时的hack，用来处理
    // makeJustRight()返回的错误联合（暂时）。
    var a: u32 = makeJustRight(44) catch 0;
    var b: u32 = makeJustRight(14) catch 0;
    var c: u32 = makeJustRight(4) catch 0;

    std.debug.print("a={}, b={}, c={}\n", .{ a, b, c });
}

// 在这个愚蠢的例子中，我们将制作一个合适数字的责任分成了四个（！）函数：
//
//     makeJustRight()   调用fixTooBig()，不能修复任何错误。
//     fixTooBig()       调用fixTooSmall()，修复TooBig错误。
//     fixTooSmall()     调用detectProblems()，修复TooSmall错误。
//     detectProblems()  返回数字或者错误。
//
fn makeJustRight(n: u32) MyNumberError!u32 {
    return fixTooBig(n) catch |err| {
        return err;
    };
}

fn fixTooBig(n: u32) MyNumberError!u32 {
    return fixTooSmall(n) catch |err| {
        if (err == MyNumberError.TooBig) {
            return 20;
        }

        return err;
    };
}

fn fixTooSmall(n: u32) MyNumberError!u32 {
    // 哦，天哪，这里缺少了很多东西！但是别担心，它几乎和上面的fixTooBig()一样。
    //
    // 如果我们得到一个TooSmall错误，我们应该返回10。
    // 如果我们得到其他任何错误，我们应该返回那个错误。
    // 否则，我们返回u32类型的数字。
    return detectProblems(n) catch |err| {
        if (err == MyNumberError.TooSmall) {
            return 10;
        }

        return err;
    };
}

fn detectProblems(n: u32) MyNumberError!u32 {
    if (n < 10) return MyNumberError.TooSmall;
    if (n > 20) return MyNumberError.TooBig;
    return n;
}
