//
// 一个哨兵值表示数据的结尾。假设我们有一个小写字母序列，其中大写字母'S'是哨兵，表示序列的结尾：
//
//     abcdefS
//
// 如果我们的序列还允许大写字母，则'S'将成为可怕的哨兵，因为它不能再是序列中的常规值：
//
//     abcdQRST
//          ^-- 哎呀！序列中的最后一个字母是R！
//
// 表示字符串结尾的流行选择是值0。ASCII和Unicode将其称为“空字符”。
//
// Zig支持哨兵终止的数组、切片和指针：
//
//     const a: [4:0]u32       =  [4:0]u32{1, 2, 3, 4};
//     const b: [:0]const u32  = &[4:0]u32{1, 2, 3, 4};
//     const c: [*:0]const u32 = &[4:0]u32{1, 2, 3, 4};
//
// 数组'a'存储5个u32值，其中最后一个值为0。
// 但是编译器会为您处理这个繁琐的细节。
// 您可以将'a'视为只有4个项目的普通数组。
//
// 切片'b'只允许指向零终止数组，但在其他方面与普通切片一样。
//
// 指针'c'与我们在练习054中学到的多项指针完全相同，但保证以0结尾。
// 由于这个保证，我们可以安全地找到这个多项指针的结尾，
// 而不知道它的长度。（我们不能用常规多项指针做到这一点！）。
//
// 重要提示：哨兵值必须与被终止的数据类型相同！
//
const print = @import("std").debug.print;
const sentinel = @import("std").meta.sentinel;

pub fn main() void {
    // 这是一个以0结尾的u32值数组：
    var nums = [_:0]u32{ 1, 2, 3, 4, 5, 6 };

    // 这是一个以0结尾的多项指针：
    var ptr: [*:0]u32 = &nums;

    // 为了好玩，让我们用哨兵值0替换位置3上的值。这似乎有点淘气。
    nums[3] = 0;

    // 现在我们有了一个以0结尾的数组和一个多项指针，它们引用相同的数据：一个以哨兵值结尾且包含哨兵值的数字序列。
    //
    // 尝试循环打印这两个序列应该可以演示它们的相似之处和不同之处。
    //
    // （事实证明，数组完全打印，包括中间的哨兵0。多项指针在第一个哨兵值处停止。）
    printSequence(nums);
    printSequence(ptr);

    print("\n", .{});
}

// 这是我们的通用序列打印函数。它几乎完成了，但还有一些缺失的部分。请修复它们！
fn printSequence(my_seq: anytype) void {
    const my_typeinfo = @typeInfo(@TypeOf(my_seq));

    // my_type中包含的TypeInfo是一个union。
    // 我们使用switch来处理打印Array或Pointer字段，具体取决于传入的my_seq类型：
    switch (my_typeinfo) {
        .Array => {
            print("Array:", .{});

            // 循环遍历my_seq中的项目。
            for (my_seq) |s| {
                print("{}", .{s});
            }
        },
        .Pointer => {
            // 看看这个 - 它很酷：
            const my_sentinel = sentinel(@TypeOf(my_seq));
            print("Many-item pointer:", .{});

            // 循环遍历my_seq中的项目，直到我们遇到哨兵值。
            var i: usize = 0;
            while (my_seq[i] != my_sentinel) {
                print("{}", .{my_seq[i]});
                i += 1;
            }
        },
        else => unreachable,
    }
    print(". ", .{});
}
