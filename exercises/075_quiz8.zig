//
// 测验时间！
//
// 让我们重新审视一下第7题中的隐士地图。
//
// 哦，别担心，没有所有的解释性注释，它不会那么大。
// 我们只会改变其中的一部分。
//
const print = @import("std").debug.print;

const TripError = error{ Unreachable, EatenByAGrue };

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

// 还记得我们为什么不必声明place_count的数字类型吗？
// 因为它只在编译时使用。现在这可能更有意义了。:-)
const place_count = 6;

const Path = struct {
    from: *const Place,
    to: *const Place,
    dist: u8,
};

// 好吧，你可能还记得，我们必须手动创建每个路径结构，
// 每个路径结构需要5行代码来定义：
//
//    Path{
//        .from = &a, // from: Archer's Point
//        .to = &b,   //   to: Bridge
//        .dist = 2,
//    },
//
// 现在，凭借我们可以在编译时运行代码的知识，
// 我们可以通过一个简单的函数来缩短这个过程。
//
// 请填写此函数的主体！
fn makePath(from: *Place, to: *Place, dist: u8) Path {
    return Path{ .from = from, .to = to, .dist = dist };
}

// 使用我们的新函数，这些路径定义现在在我们的程序中占用的空间要少得多！
const a_paths = [_]Path{makePath(&a, &b, 2)};
const b_paths = [_]Path{ makePath(&b, &a, 2), makePath(&b, &d, 1) };
const c_paths = [_]Path{ makePath(&c, &d, 3), makePath(&c, &e, 2) };
const d_paths = [_]Path{ makePath(&d, &b, 1), makePath(&d, &c, 3), makePath(&d, &f, 7) };
const e_paths = [_]Path{ makePath(&e, &c, 2), makePath(&e, &f, 1) };
const f_paths = [_]Path{makePath(&f, &d, 7)};
//
// 但是它更易读吗？这可能是双方都可以争论的。
//
// 我们已经看到，在编译时解析字符串是可能的，
// 因此我们可以使用这种方法来实现更高级的功能。
//
// 例如，我们可以创建自己的“路径语言”并从中创建路径。
// 也许是这样：
//
//    a -> (b[2])
//    b -> (a[2] d[1])
//    c -> (d[3] e[2])
//    ...
//
// 随意将其实现为超级奖励练习！

const TripItem = union(enum) {
    place: *const Place,
    path: *const Path,

    fn printMe(self: TripItem) void {
        switch (self) {
            .place => |p| print("{s}", .{p.name}),
            .path => |p| print("--{}->", .{p.dist}),
        }
    }
};

const NotebookEntry = struct {
    place: *const Place,
    coming_from: ?*const Place,
    via_path: ?*const Path,
    dist_to_reach: u16,
};

const HermitsNotebook = struct {
    entries: [place_count]?NotebookEntry = .{null} ** place_count,
    next_entry: u8 = 0,
    end_of_entries: u8 = 0,

    fn getEntry(self: *HermitsNotebook, place: *const Place) ?*NotebookEntry {
        for (&self.entries, 0..) |*entry, i| {
            if (i >= self.end_of_entries) break;
            if (place == entry.*.?.place) return &entry.*.?;
        }
        return null;
    }

    fn checkNote(self: *HermitsNotebook, note: NotebookEntry) void {
        var existing_entry = self.getEntry(note.place);

        if (existing_entry == null) {
            self.entries[self.end_of_entries] = note;
            self.end_of_entries += 1;
        } else if (note.dist_to_reach < existing_entry.?.dist_to_reach) {
            existing_entry.?.* = note;
        }
    }

    fn hasNextEntry(self: *HermitsNotebook) bool {
        return self.next_entry < self.end_of_entries;
    }

    fn getNextEntry(self: *HermitsNotebook) *const NotebookEntry {
        defer self.next_entry += 1;
        return &self.entries[self.next_entry].?;
    }

    fn getTripTo(self: *HermitsNotebook, trip: []?TripItem, dest: *Place) TripError!void {
        const destination_entry = self.getEntry(dest);

        if (destination_entry == null) {
            return TripError.Unreachable;
        }

        var current_entry = destination_entry.?;
        var i: u8 = 0;

        while (true) : (i += 2) {
            trip[i] = TripItem{ .place = current_entry.place };
            if (current_entry.coming_from == null) break;
            trip[i + 1] = TripItem{ .path = current_entry.via_path.? };
            const previous_entry = self.getEntry(current_entry.coming_from.?);
            if (previous_entry == null) return TripError.EatenByAGrue;
            current_entry = previous_entry.?;
        }
    }
};

pub fn main() void {
    const start = &a; // Archer's Point
    const destination = &f; // Fox Pond

    // 我们可以这样做：
    //
    //   a.paths = a_paths[0..];
    //   b.paths = b_paths[0..];
    //   c.paths = c_paths[0..];
    //   d.paths = d_paths[0..];
    //   e.paths = e_paths[0..];
    //   f.paths = f_paths[0..];
    //
    // 或者使用这个 comptime 魔法:
    //
    const letters = [_][]const u8{ "a", "b", "c", "d", "e", "f" };
    inline for (letters) |letter| {
        @field(@This(), letter).paths = @field(@This(), letter ++ "_paths")[0..];
    }

    var notebook = HermitsNotebook{};
    var working_note = NotebookEntry{
        .place = start,
        .coming_from = null,
        .via_path = null,
        .dist_to_reach = 0,
    };
    notebook.checkNote(working_note);

    while (notebook.hasNextEntry()) {
        var place_entry = notebook.getNextEntry();

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

    var trip = [_]?TripItem{null} ** (place_count * 2);

    notebook.getTripTo(trip[0..], destination) catch |err| {
        print("Oh no! {}\n", .{err});
        return;
    };

    printTrip(trip[0..]);
}

fn printTrip(trip: []?TripItem) void {
    var i: u8 = @intCast(u8, trip.len);

    while (i > 0) {
        i -= 1;
        if (trip[i] == null) continue;
        trip[i].?.printMe();
    }

    print("\n", .{});
}
