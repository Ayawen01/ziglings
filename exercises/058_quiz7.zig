//
// 我们已经了解了很多关于Zig中可以使用的类型的变化。大致上，按顺序我们有：
//
//                          u8  单个元素
//                         *u8  单元素指针
//                        []u8  切片（大小在运行时确定）
//                       [5]u8  5个u8的数组
//                       [*]u8  多元素指针（零个或多个）
//                 enum {a, b}  a和b的一组唯一值
//                error {e, f}  e和f的一组唯一错误值
//      struct {y: u8, z: i32}  y和z的一组值
// union(enum) {a: u8, b: i32}  单个值，可以是u8或i32
//
// 任何上述类型的值都可以被赋值为"var"或"const"
// 来允许或禁止通过赋值的名称修改（可变性）：
//
//     const a: u8 = 5; // 不可变
//       var b: u8 = 5; //   可变
//
// 我们也可以从任何上述类型中制作错误联合或可选类型：
//
//     var a: E!u8 = 5; // 可以是u8或E集合中的错误
//     var b: ?u8 = 5;  // 可以是u8或null
//
// 知道了这些，也许我们可以帮助一个当地的隐士。他写了一个小小的Zig程序来帮助他规划他穿越森林的旅行，
// 但是它有一些错误。
//
// *************************************************************
// *                关于这个练习的一点说明                       *
// *                                                           *
// *   你不需要阅读和理解这个程序的每一点。这是一个非常大的例子。  *
// *   随便浏览一下，然后只关注那些真正出错的部分就好了！          *
// *                                                           *
// *************************************************************
//
const print = @import("std").debug.print;

// grue是对Zork的致敬。
const TripError = error{ Unreachable, EatenByAGrue };

// 让我们从地图上的地点开始。每个地点都有一个名字和一个
// 旅行的距离或难度（由隐士判断）。
//
// 注意，我们声明地点为可变的（var），因为我们需要稍后
// 分配路径。为什么呢？因为路径包含指向地点的指针，如果现在分配它们，就会创建一个依赖循环！
const Place = struct {
    name: []const u8,
    paths: []const Path = undefined,
};

var a = Place{ .name = "Archer's Point" };
var b = Place{ .name = "Bridge" };
var c = Place{ .name = "Cottage" };
var d = Place{ .name = "Dogwood Grove" };
var e = Place{ .name = "East Pond" };
var f = Place{ .name = "Fox Pond" };

//           隐士手绘的ASCII地图
//  +---------------------------------------------------+
//  |         * Archer's Point                ~~~~      |
//  | ~~~                              ~~~~~~~~         |
//  |   ~~~| |~~~~~~~~~~~~      ~~~~~~~                 |
//  |         Bridge     ~~~~~~~~                       |
//  |  ^             ^                           ^      |
//  |     ^ ^                      / \                  |
//  |    ^     ^  ^       ^        |_| Cottage          |
//  |   Dogwood Grove                                   |
//  |                  ^     <boat>                     |
//  |  ^  ^  ^  ^          ~~~~~~~~~~~~~    ^   ^       |
//  |      ^             ~~ East Pond ~~~               |
//  |    ^    ^   ^       ~~~~~~~~~~~~~~                |
//  |                           ~~          ^           |
//  |           ^            ~~~ <-- short waterfall    |
//  |   ^                 ~~~~~                         |
//  |            ~~~~~~~~~~~~~~~~~                      |
//  |          ~~~~ Fox Pond ~~~~~~~    ^         ^     |
//  |      ^     ~~~~~~~~~~~~~~~           ^ ^          |
//  |                ~~~~~                              |
//  +---------------------------------------------------+
//
// 我们将根据地图上的地点数量在我们的程序中预留内存。注意，我们不需要指定这个值的类型，因为一旦
// 它被编译，我们就不会在我们的程序中使用它了！（如果这还不清楚，不用担心。）
const place_count = 6;

// 现在让我们创建所有的路径，连接各个地点。一条路径从一个地点到另一个地点，有一个距离。
const Path = struct {
    from: *const Place,
    to: *const Place,
    dist: u8,
};

// 顺便说一下，如果下面的代码看起来像是很多乏味的手工劳动，你是对的！Zig的一个杀手级特性是让
// 我们写一些在编译时运行的代码，来“自动化”重复的代码（类似于其他语言中的宏），但是我们还没有学
// 会如何做到这一点！
const a_paths = [_]Path{
    Path{
        .from = &a, // from: Archer's Point
        .to = &b, //   to: Bridge
        .dist = 2,
    },
};

const b_paths = [_]Path{
    Path{
        .from = &b, // from: Bridge
        .to = &a, //   to: Archer's Point
        .dist = 2,
    },
    Path{
        .from = &b, // from: Bridge
        .to = &d, //   to: Dogwood Grove
        .dist = 1,
    },
};

const c_paths = [_]Path{
    Path{
        .from = &c, // from: Cottage
        .to = &d, //   to: Dogwood Grove
        .dist = 3,
    },
    Path{
        .from = &c, // from: Cottage
        .to = &e, //   to: East Pond
        .dist = 2,
    },
};

const d_paths = [_]Path{
    Path{
        .from = &d, // from: Dogwood Grove
        .to = &b, //   to: Bridge
        .dist = 1,
    },
    Path{
        .from = &d, // from: Dogwood Grove
        .to = &c, //   to: Cottage
        .dist = 3,
    },
    Path{
        .from = &d, // from: Dogwood Grove
        .to = &f, //   to: Fox Pond
        .dist = 7,
    },
};

const e_paths = [_]Path{
    Path{
        .from = &e, // from: East Pond
        .to = &c, //   to: Cottage
        .dist = 2,
    },
    Path{
        .from = &e, // from: East Pond
        .to = &f, //   to: Fox Pond
        .dist = 1, // (one-way down a short waterfall!)
    },
};

const f_paths = [_]Path{
    Path{
        .from = &f, // from: Fox Pond
        .to = &d, //   to: Dogwood Grove
        .dist = 7,
    },
};

// 一旦我们规划出穿越森林的最佳路线，我们就把它做成一个“旅行”。一个旅行是由一系列地点和路径组成的。
// 我们使用一个TripItem联合类型来允许地点和路径在同一个数组中。
const TripItem = union(enum) {
    place: *const Place,
    path: *const Path,

    // 这是一个小助手函数，用来正确地打印两种不同类型的项目。
    fn printMe(self: TripItem) void {
        switch (self) {
            // 糟糕！隐士忘了如何在switch语句中捕获联合值。
            // 请把两个值都捕获为'p'，这样打印语句才能工作！
            .place => |p| print("{s}", .{p.name}),
            .path => |p| print("--{}->", .{p.dist}),
        }
    }
};

// 隐士的笔记本是所有魔法发生的地方。
// 一个笔记本条目是一个在地图上发现的地点，以及到达那里所走的路径和从起点到达那里的距离。
// 如果我们找到了到达一个地点的更好的路径（更短的距离），我们就更新条目。
// 条目也充当了一个“待办事项”列表，这是我们如何跟踪下一个要探索的路径。
const NotebookEntry = struct {
    place: *const Place,
    coming_from: ?*const Place,
    via_path: ?*const Path,
    dist_to_reach: u16,
};

// +------------------------------------------------+
// |              ~ Hermit's Notebook ~             |
// +---+----------------+----------------+----------+
// |   |      地点      |      来自      |    距离   |
// +---+----------------+----------------+----------+
// | 0 | Archer's Point | null           |        0 |
// | 1 | Bridge         | Archer's Point |        2 | < next_entry
// | 2 | Dogwood Grove  | Bridge         |        1 |
// | 3 |                |                |          | < end_of_entries
// |                      ...                       |
// +---+----------------+----------------+----------+
//
const HermitsNotebook = struct {
    // 还记得数组重复操作符`**`吗？它不仅是一个新奇的东西，
    // 它也是一个很好的方式来给数组中的多个元素赋值，而不用一个一个地列出来。
    // 这里我们用它来初始化一个包含null值的数组。
    entries: [place_count]?NotebookEntry = .{null} ** place_count,

    // 下一个条目跟踪我们在“待办事项”列表中的位置。
    next_entry: u8 = 0,

    // 标记笔记本中空白空间的开始。
    end_of_entries: u8 = 0,

    // 我们经常想要通过地点来找到一个条目。如果没有找到，我们返回null。
    fn getEntry(self: *HermitsNotebook, place: *const Place) ?*NotebookEntry {
        for (&self.entries, 0..) |*entry, i| {
            if (i >= self.end_of_entries) break;

            // 这里是隐士卡住的地方。我们需要返回一个可选的指向NotebookEntry的指针。
            //
            // 我们现在有的“entry”是相反的：一个指向可选NotebookEntry的指针！
            //
            // 要从一个得到另一个，我们需要解引用“entry”（用.*）并从可选值中得到非空值（用.?）并返回它的地址。
            // if语句提供了一些线索，关于解引用和可选值“解包”是如何结合在一起的。
            // 记住，你用“&”操作符返回地址。
            if (place == entry.*.?.place) return &entry.*.?;
            // 尽量让你的答案这么长：__________;
        }
        return null;
    }

    // checkNote()方法是神奇笔记本的跳动的心脏。
    // 给定一个新的笔记，以NotebookEntry结构体的形式，
    // 我们检查一下我们是否已经有了一个关于笔记地点的条目。
    //
    // 如果我们没有，我们就把这个条目加到笔记本的末尾，连同走过的路径和距离。
    //
    // 如果我们有，我们就检查一下这条路径是否比我们之前记录的路径“更好”（更短的距离）。
    // 如果是，我们就用新的条目覆盖旧的条目。
    fn checkNote(self: *HermitsNotebook, note: NotebookEntry) void {
        var existing_entry = self.getEntry(note.place);

        if (existing_entry == null) {
            self.entries[self.end_of_entries] = note;
            self.end_of_entries += 1;
        } else if (note.dist_to_reach < existing_entry.?.dist_to_reach) {
            existing_entry.?.* = note;
        }
    }

    // 接下来的两个方法允许我们把笔记本当作一个“待办事项”列表。
    fn hasNextEntry(self: *HermitsNotebook) bool {
        return self.next_entry < self.end_of_entries;
    }

    fn getNextEntry(self: *HermitsNotebook) *const NotebookEntry {
        defer self.next_entry += 1; // 获取条目后递增
        return &self.entries[self.next_entry].?;
    }

    // 在我们完成了对地图的搜索后，我们就计算出了到每个地点的最短路径。
    // 要收集从起点到目的地的完整旅行，
    // 我们需要从目的地的笔记本条目开始，沿着coming_from指针回溯到起点。
    // 我们最终得到的是一个TripItem数组，里面是我们倒序排列的旅行。
    //
    // 我们需要把旅行数组作为一个参数，因为我们想让main()函数“拥有”数组内存。
    // 你觉得如果我们在这个函数的栈帧（为函数的“局部”数据分配的空间）中分配数组，
    // 并返回一个指针或切片会发生什么？
    //
    // 看起来隐士在这个函数的返回值中忘了一些东西。那会是什么呢？
    fn getTripTo(self: *HermitsNotebook, trip: []?TripItem, dest: *Place) TripError!void {
        // 我们从目的地条目开始。
        const destination_entry = self.getEntry(dest);

        // 这个函数需要在请求的目的地没有到达时返回一个错误。
        // （这实际上不会发生在我们的地图上，因为每个地点都可以被每个其他地点到达。）
        if (destination_entry == null) {
            return TripError.Unreachable;
        }

        // 变量保存了我们当前正在检查的条目和一个索引来跟踪我们在哪里追加旅行项目。
        var current_entry = destination_entry.?;
        var i: u8 = 0;

        // 在每次循环的结束，一个continue表达式递增我们的索引。你能看出为什么我们需要每次递增两个吗？
        while (true) : (i += 2) {
            trip[i] = TripItem{ .place = current_entry.place };

            // 一个“来自”无处的条目意味着我们已经到达了
            // 起点，所以我们完成了。
            if (current_entry.coming_from == null) break;

            // 否则，条目有一条路径。
            trip[i + 1] = TripItem{ .path = current_entry.via_path.? };

            // 现在我们跟随我们“来自”的条目。如果我们
            // 没有能够通过地点找到我们“来自”的条目，那么我们的
            // 程序就出了大问题！（这真的不应该发生。你检查过grues了吗？）
            // 注意：你不需要在这里修复任何东西。
            const previous_entry = self.getEntry(current_entry.coming_from.?);
            if (previous_entry == null) return TripError.EatenByAGrue;
            current_entry = previous_entry.?;
        }
    }
};

pub fn main() void {
    // 这里是隐士决定他想去哪里的地方。一旦你让程序运行起来，试试地图上的不同地点！
    const start = &a; // Archer's Point
    const destination = &f; // Fox Pond

    // 把每个路径数组作为一个切片存储在每个地点中。
    // 如上所述，我们需要延迟建立这些引用，以避免在编译器试图
    a.paths = a_paths[0..];
    b.paths = b_paths[0..];
    c.paths = c_paths[0..];
    d.paths = d_paths[0..];
    e.paths = e_paths[0..];
    f.paths = f_paths[0..];

    // 确定如何为每个项目分配空间时创建一个依赖循环。
    // 现在我们创建一个笔记本的实例，并添加第一个“开始”条目。注意null值。
    // 阅读上面checkNote()方法的注释，看看这个条目是如何被添加到笔记本中的。
    var notebook = HermitsNotebook{};
    var working_note = NotebookEntry{
        .place = start,
        .coming_from = null,
        .via_path = null,
        .dist_to_reach = 0,
    };
    notebook.checkNote(working_note);

    // 从笔记本中获取下一个条目（第一个是我们刚刚添加的“开始”条目），
    // 直到我们用完为止，这时我们就检查了每个可到达的地点。
    while (notebook.hasNextEntry()) {
        var place_entry = notebook.getNextEntry();

        // 对于每一条从当前地点出发的路径，创建一个新的笔记（以NotebookEntry结构体的形式），
        // 包含目的地和从起点到达那里的总距离。
        // 再次阅读checkNote()方法的注释，看看这是如何工作的。
        for (place_entry.place.paths) |*path| {
            working_note = NotebookEntry{
                .place = path.to,
                .coming_from = place_entry.place,
                .via_path = path,
                .dist_to_reach = place_entry.dist_to_reach + path.dist,
            };
            notebook.checkNote(working_note);
        }
    }

    // 一旦上面的循环完成，我们就计算出了到每个可到达的地方的最短
    // 路径！我们现在需要做的是为旅行分配内存，并让隐士的笔记本从
    // 目的地回到路径上填写旅行。注意，这是我们第一次真正使用目的地！
    var trip = [_]?TripItem{null} ** (place_count * 2);

    notebook.getTripTo(trip[0..], destination) catch |err| {
        print("Oh no! {}\n", .{err});
        return;
    };

    // 用下面的一个小助手函数打印旅行。
    printTrip(trip[0..]);
}

// 记住，旅行将是一系列交替的TripItems
// 包含从目的地回到起点的一个地方或路径。
// 旅行数组中剩余的空间将包含空值，所以
// 我们需要反向遍历数组中的项目，跳过空值，直到我们到达数组前面的目的地。
fn printTrip(trip: []?TripItem) void {
    // 我们用@intCast()把usize长度转换成u8，这是一个内置函数，就像@import()一样。
    // 我们会在后面的练习中正确地学习这些。
    var i: u8 = @intCast(u8, trip.len);

    while (i > 0) {
        i -= 1;
        if (trip[i] == null) continue;
        trip[i].?.printMe();
    }

    print("\n", .{});
}

// 深入探讨：
//
// 用计算机科学的术语来说，我们的地图地点是“节点”或“顶点”，而路径是“边”。
// 它们一起形成了一个“带权重的有向图”。
// 它是“带权重的”，因为每条路径都有一个距离（也称为“代价”）。
// 它是“有向的”，因为每条路径都是从一个地方到另一个地方（无向图允许你在一条边上任意方向行走）。
//
// 由于我们在列表的末尾添加新的笔记本条目，然后从开头依次探索每个条目（就像一个“待办事项”列表），
// 我们把笔记本当作一个“先进先出”（FIFO）队列。
//
// 由于我们先检查所有最近的路径，再尝试更远的路径（多亏了“待办事项”队列），
// 我们正在执行一个“广度优先搜索”（BFS）。
//
// 通过跟踪“最低代价”路径，我们也可以说我们正在执行一个“最小代价搜索”。
//
// 更具体地说，隐士的笔记本最接近于最短路径快速算法（SPFA），归功于Edward F. Moore。
// 通过用一个“优先队列”替换我们简单的FIFO队列，我们基本上就有了Dijkstra算法。
// 一个优先队列按照“权重”排序检索项目（在我们的情况下，它会把距离最短的路径放在队列的前面）。
// Dijkstra算法更有效率，因为更长的路径可以更快地被淘汰。（用纸笔演算一下就知道为什么了！）
