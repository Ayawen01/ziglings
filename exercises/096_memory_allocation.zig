// 在大多数示例中，输入在编译时已知，因此程序使用的内存量是固定的。
// 但是，如果响应大小在编译时未知的输入，例如：
//  - 通过命令行参数输入的用户输入
//  - 来自另一个程序的输入
//
// 您需要请求您的操作系统在运行时分配程序的内存。
//
// Zig提供了几种不同的分配器。在Zig文档中，它建议使用Arena分配器来为只分配一次然后退出的简单程序分配内存：
//
//     const std = @import("std");
//
//     // 内存分配可能会失败，因此返回类型为!void
//     pub fn main() !void {
//
//         var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
//         defer arena.deinit();
//
//         const allocator = arena.allocator();
//
//         const ptr = try allocator.create(i32);
//         std.debug.print("ptr={*}\n", .{ptr});
//
//         const slice_ptr = try allocator.alloc(f64, 5);
//         std.debug.print("ptr={*}\n", .{ptr});
//     }

// 此程序需要分配与输入数组相同大小的切片，而不是简单的整数或常量大小的切片。

// 给定一系列数字，计算其平均值。换句话说，每个项目N应包含最后N个元素的平均值。

const std = @import("std");

fn runningAverage(arr: []const f64, avg: []f64) void {
    var sum: f64 = 0;

    for (0.., arr) |index, val| {
        sum += val;
        avg[index] = sum / @intToFloat(f64, index + 1);
    }
}

pub fn main() !void {
    // 假装这是通过读取用户输入定义的
    var arr: []const f64 = &[_]f64{ 0.3, 0.2, 0.1, 0.1, 0.4 };

    // 初始化分配器
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);

    // 在退出时释放内存
    defer arena.deinit();

    // 初始化分配器
    const allocator = arena.allocator();

    // 为此数组分配内存
    var avg: []f64 = try allocator.alloc(f64, arr.len);

    runningAverage(arr, avg);
    std.debug.print("Running Average: ", .{});
    for (avg) |val| {
        std.debug.print("{d:.2} ", .{val});
    }
    std.debug.print("\n", .{});
}

// 有关内存分配和不同类型的内存分配器的更多详细信息，请参见 https://www.youtube.com/watch?v=vHWiDx_l4V0
