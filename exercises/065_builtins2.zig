//
// Zig有一些内置的数学运算，比如...
//
//      @sqrt        @sin          @cos
//      @exp         @log          @floor
//
// ...还有很多类型转换的操作，比如...
//
//      @as          @intToError   @intToFloat
//      @intToPtr    @ptrToInt     @enumToInt
//
// 在雨天花一点时间浏览一下官方Zig文档中的内置函数列表也不是
// 一件坏事。里面有一些非常酷的特性。
// 看看@call, @compileLog,@embedFile, 和@src!
//
//                            ...
//
// 现在，我们要完成对内置函数的探索，只看Zig的许多自省能力中的三个：
//
// 1. @This() type
//
// 返回一个函数调用所在的最内层的结构体，枚举或联合体。
//
// 2. @typeInfo(comptime T: type) @import("std").builtin.TypeInfo
//
// 返回一个TypeInfo联合体，包含了任何类型的信息，这个联合体会根据你检查的类型包含不同的信息。
//
// 3. @TypeOf(...) type
//
// 返回所有输入参数（每个都可以是任何表达式）的公共类型。这个类型是
// 用和编译器自身使用的“同级类型解析”过程来确定的。
//
// (注意到返回类型的两个函数都以大写字母开头了吗？这是Zig中的一个标准命名惯例。)
//
const print = @import("std").debug.print;

const Narcissus = struct {
    me: *Narcissus = undefined,
    myself: *Narcissus = undefined,
    echo: void = undefined, // 可怜的Echo!

    fn fetchTheMostBeautifulType() type {
        return @This();
    }
};

pub fn main() void {
    var narcissus: Narcissus = Narcissus{};

    // 哎呀！我们不能把'me'和'myself'字段留空。请在这里设置它们：
    narcissus.me = &narcissus;
    narcissus.myself = &narcissus;

    // 这里根据三个不同的引用（它们恰好都是同一个对象）确定了一个“同级类型”。
    const Type1 = @TypeOf(narcissus, narcissus.me.*, narcissus.myself.*);

    // 哦，亲爱的，我们在调用这个函数时似乎做错了什么。我们把它当作一个方法调用，
    // 这样做可以，如果它有一个self参数的话。但它没有。（看上面。）
    //
    // 这里修复的方法很微妙，但是会有很大的区别！
    const Type2 = Narcissus.fetchTheMostBeautifulType();

    // 现在我们打印一个关于Narcissus的简短陈述。
    print("A {s} loves all {s}es. ", .{
        maximumNarcissism(Type1),
        maximumNarcissism(Type2),
    });

    //   他在看着那些他习惯看的水时说了这些话：
    //       “哎呀，我心爱的男孩，白费了！”
    //   这个地方把每个单词都回复了。
    //   他喊道：
    //            “再见。”
    //   回声叫道：
    //                   “再见！”
    //
    //     --Ovid，《变形记》
    //       由Ian Johnston翻译

    print("He has room in his heart for:", .{});

    // 一个StructFields数组
    const fields = @typeInfo(Narcissus).Struct.fields;

    // 'fields'是StructFields的一个切片。这是声明：
    //
    //     pub const StructField = struct {
    //         name: []const u8,
    //         type: type,
    //         default_value: anytype,
    //         is_comptime: bool,
    //         alignment: comptime_int,
    //     };
    //
    // 请完成这些'if'语句，以便如果字段是'void'类型（这是一种零位类型，根本不占用空间！），则不会打印字段名：
    if (fields[0].type != void) {
        print(" {s}", .{@typeInfo(Narcissus).Struct.fields[0].name});
    }

    if (fields[1].type != void) {
        print(" {s}", .{@typeInfo(Narcissus).Struct.fields[1].name});
    }

    if (fields[2].type != void) {
        print(" {s}", .{@typeInfo(Narcissus).Struct.fields[2].name});
    }

    // 呸，看看上面那些重复的代码！我不知道你怎么想，但它让我感到痒痒的。
    //
    // 不幸的是，我们不能在这里使用常规的“for”循环，
    // 因为'fields'只能在编译时计算。
    // 看来我们已经过期了，需要了解一下“comptime”这个东西，不是吗？别担心，我们会到那里去的。

    print(".\n", .{});
}

// 注意：此练习最初未包括下面的函数。
// 但是，在Zig 0.10.0之后进行更改时将源文件名添加到类型中。 “Narcissus"变成了"065_builtins2.Narcissus”。
//
// 为了解决这个问题，我添加了此函数以从类型名称中最愚蠢的方式删除文件名。（它返回从第14个字符（假设单字节字符）开始的类型名称切片。
//
// 我们将在练习070中再次看到@typeName。
// 现在您可以看到它需要一个Type并返回一个u8“字符串”。
fn maximumNarcissism(myType: anytype) []const u8 {
    // 将’065_builtins2.Narcissus’转换为’Narcissus’。
    return @typeName(myType)[14..];
}
