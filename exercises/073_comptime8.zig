//
// 实际上，您可以在任何表达式前面放置'comptime'，以强制其在编译时运行。
//
// 执行函数：
//
//     comptime llama();
//
// 获取值：
//
//     bar = comptime baz();
//
// 执行整个块：
//
//     comptime {
//         bar = baz + biff();
//         llama(bar);
//     }
//
// 从块中获取值：
//
//     var llama = comptime bar: {
//         const baz = biff() + bonk();
//         break :bar baz;
//     }
//
const print = @import("std").debug.print;

const llama_count = 5;
const llamas = [llama_count]u32{ 5, 10, 15, 20, 25 };

pub fn main() void {
    // 我们本来想获取最后一只羊驼。请修复这个简单的错误，以便断言不再失败。
    const my_llama = getLlama(llamas.len - 1);

    print("My llama value is {}.\n", .{my_llama});
}

fn getLlama(comptime i: usize) u32 {
    // 我们在这个函数的顶部放置了一个守卫assert()，以防止错误。这里的'comptime'关键字意味着
    // 当我们编译时会捕捉到错误！
    //
    // 没有'comptime'，这仍然可以工作，但是
    // 断言将在运行时失败并出现PANIC，这不太好。
    //
    // 不幸的是，我们现在会遇到一个错误
    // 因为'i'参数需要在编译时保证已知。您可以使用上面的'i'参数做什么来实现这一点？
    comptime assert(i < llama_count);

    return llamas[i];
}

// 有趣的事实：这个assert()函数与
// Zig标准库中的std.debug.assert()完全相同。
fn assert(ok: bool) void {
    if (!ok) unreachable;
}
//
// 额外有趣的事实：我意外地将所有'foo'的实例替换为'llama'
// 在这个练习中，我没有后悔！
