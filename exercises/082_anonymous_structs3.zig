//
// 您甚至可以创建没有字段名称的匿名结构体字面量：
//
//     .{
//         false,
//         @as(u32, 15),
//         @as(f64, 67.12)
//     }
//
// 我们称这些为“元组”，这是许多编程语言用于表示按索引顺序而不是名称引用的数据类型的术语。
// 为了实现这一点，Zig编译器会自动将数字字段名称0、1、2等分配给结构体。
//
// 由于裸数字不是合法标识符（foo.0是语法错误），我们必须使用@""语法引用它们。例如：
//
//     const foo = .{ true, false };
//
//     print("{} {}\n", .{foo.@"0", foo.@"1"});
//
// 上面的示例打印“true false”。
//
// 等等...
//
// 如果.print()函数想要的是一个 .{} 东西，我们需要将我们的“元组”分开并放入另一个元组中吗？
// 不需要！这将打印相同的内容：
//
//     print("{} {}\n", foo);
//
// 哈！所以现在我们知道print()需要一个“元组”。事情真的开始变得清晰起来了。
//
const print = @import("std").debug.print;

pub fn main() void {
    // 元组：
    const foo = .{
        true,
        false,
        @as(i32, 42),
        @as(f32, 3.141592),
    };

    // 我们将要实现这个：
    printTuple(foo);

    // 这只是为了好玩，因为我们可以：
    const nothing = .{};
    print("\n", nothing);
}

// 让我们制作自己的通用“元组”打印机。这应该接受一个“元组”，并以以下格式打印出每个字段：
//
//     “name”（type）：value
//
// 示例：
//
//     “0”（bool）：true
//
// 您将把这些放在一起。但是不要担心，您需要的所有内容都在注释中记录下来了。
fn printTuple(tuple: anytype) void {
    // 1. 获取输入“元组”参数中的字段列表。您需要：
    //
    //     @TypeOf() - 获取值并返回其类型。
    //
    //     @typeInfo() - 获取类型并返回一个TypeInfo联合，
    //                   其中包含特定于该类型的字段。
    //
    //     结构体类型的列表可以在TypeInfo的Struct.fields中找到。
    //
    //     示例：
    //
    //         @typeInfo(Circle).Struct.fields
    //
    // 这将是一个StructFields数组。
    const fields = @typeInfo(@TypeOf(tuple)).Struct.fields;

    // 2. 循环遍历每个字段。这必须在编译时完成。
    //
    //     提示：记住“inline”循环？
    //
    inline for (fields) |field| {
        // 3. 打印字段的名称、类型和值。
        //
        //     此循环中的每个“field”都是以下之一：
        //
        //         pub const StructField = struct {
        //             name: []const u8,
        //             type: type,
        //             default_value: anytype,
        //             is_comptime: bool,
        //             alignment: comptime_int,
        //         };
        //
        //     您将需要此内置函数：
        //
        //         @field(lhs:anytype, comptime field_name:[]const u8)
        //
        //     第一个参数是要访问的值，第二个参数是带有要访问的字段名称的字符串。返回字段的值。
        //
        //     示例：
        //
        //         @field(foo, "x"); // 返回foo.x处的值
        //
        // 第一个字段应打印为：“0”（bool）：true
        print("\"{s}\"({any}):{any} ", .{
            field.name,
            field.type,
            @field(tuple, field.name),
        });
    }
}
