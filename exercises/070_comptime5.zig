//
// 能够在编译时将类型传递给函数，使我们能够生成适用于多种类型的代码。
// 但是，它并不能帮助我们将不同类型的值传递给函数。
//
// 为此，我们有“anytype”占位符，它告诉Zig在编译时推断参数的实际类型。
//
//     fn foo(thing: anytype) void { ... }
//
// 然后，我们可以使用内置函数，
// 例如@TypeOf()、@typeInfo()、@typeName()、@hasDecl()和@hasField()
// 来确定更多关于已传递的类型的信息。
// 所有这些逻辑都将完全在编译时执行。
//
const print = @import("std").debug.print;

// 让我们定义三个结构体：Duck、RubberDuck和Duct。
// 请注意，Duck和RubberDuck都包含在其命名空间（也称为“decls”）中声明的waddle()和quack()方法。

const Duck = struct {
    eggs: u8,
    loudness: u8,
    location_x: i32 = 0,
    location_y: i32 = 0,

    fn waddle(self: Duck, x: i16, y: i16) void {
        self.location_x += x;
        self.location_y += y;
    }

    fn quack(self: Duck) void {
        if (self.loudness < 4) {
            print("\"Quack.\" ", .{});
        } else {
            print("\"QUACK!\" ", .{});
        }
    }
};

const RubberDuck = struct {
    in_bath: bool = false,
    location_x: i32 = 0,
    location_y: i32 = 0,

    fn waddle(self: RubberDuck, x: i16, y: i16) void {
        self.location_x += x;
        self.location_y += y;
    }

    fn quack(self: RubberDuck) void {
        // 把一个表达式赋值给'_'可以让我们安全地“使用”这个值，同时也忽略它。
        _ = self;
        print("\"Squeek!\" ", .{});
    }

    fn listen(self: RubberDuck, dev_talk: []const u8) void {
        // 听开发人员谈论编程问题。
        // 沉默地思考问题。发出有帮助的声音。
        _ = dev_talk;
        self.quack();
    }
};

const Duct = struct {
    diameter: u32,
    length: u32,
    galvanized: bool,
    connection: ?*Duct = null,

    fn connect(self: Duct, other: *Duct) !void {
        if (self.diameter == other.diameter) {
            self.connection = other;
        } else {
            return DuctError.UnmatchedDiameters;
        }
    }
};

const DuctError = error{UnmatchedDiameters};

pub fn main() void {
    // 这是一只真鸭子！
    const ducky1 = Duck{
        .eggs = 0,
        .loudness = 3,
    };

    // 这不是一只真鸭子，但它有quack()和waddle()能力，
    // 所以它仍然是一只“鸭子”。
    const ducky2 = RubberDuck{
        .in_bath = false,
    };

    // 这甚至不像鸭子。
    const ducky3 = Duct{
        .diameter = 17,
        .length = 165,
        .galvanized = true,
    };

    print("ducky1: {}, ", .{isADuck(ducky1)});
    print("ducky2: {}, ", .{isADuck(ducky2)});
    print("ducky3: {}\n", .{isADuck(ducky3)});
}

// 这个函数有一个在编译时推断的单一参数。
// 它使用内置的@TypeOf()和@hasDecl()来执行鸭子类型
// （“如果它像鸭子一样走路，像鸭子一样嘎嘎叫，
// 那么它一定是一只鸭子”）来确定类型是否为“鸭子”。
fn isADuck(possible_duck: anytype) bool {
    // 我们将使用@hasDecl()来确定类型是否具有
    // 成为“鸭子”的一切所需。
    //
    // 在此示例中，如果类型Foo具有increment()方法，
    // 则'has_increment'将为true：
    //
    //     const has_increment = @hasDecl(Foo, "increment");
    //
    // 请确保MyType具有waddle()和quack()方法：
    const MyType = @TypeOf(possible_duck);
    const walks_like_duck = @hasDecl(MyType, "waddle");
    const quacks_like_duck = @hasDecl(MyType, "quack");

    const is_duck = walks_like_duck and quacks_like_duck;

    if (is_duck) {
        // 我们还在这里调用quack()方法来证明Zig
        // 允许我们对任何足够像鸭子的东西执行鸭子动作。
        //
        // 因为所有检查和推断都是在编译时执行的，
        // 所以我们仍然具有完整的类型安全性：
        // 尝试在没有它的结构上调用quack()方法
        // （如Duct）将导致编译错误，而不是运行时恐慌或崩溃！
        possible_duck.quack();
    }

    return is_duck;
}
