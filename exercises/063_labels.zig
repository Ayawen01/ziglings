//
// 循环体是块，也是表达式。我们已经看到了
// 它们可以用于评估和返回值。为了进一步
// 扩展这个概念，事实证明我们也可以给
// 块命名，通过应用一个“标签”：
//
//     my_label: { ... }
//
// 一旦给块命名，就可以使用“break”退出
// 从该块中退出。
//
//     outer_block: {           // 外部块
//         while (true) {       // 内部块
//             break :outer_block;
//         }
//         unreachable;
//     }
//
// 正如我们刚学到的，您可以使用break返回值
// 语句。这是否意味着您可以从任何标记块中返回值？是的！
//
//     const foo = make_five: {
//         const five = 1 + 1 + 1 + 1 + 1;
//         break :make_five five;
//     };
//
// 标签也可用于循环。能够在特定级别上退出嵌套循环是
// 您不会每天使用的东西之一，但当时机到来时，它就是
// 非常方便。能够从内部循环返回值有时非常方便，几乎感觉像作弊
// （并且可以帮助您避免创建大量临时变量）。
//
//     const bar: u8 = two_loop: while (true) {
//         while (true) {
//             break :two_loop 2;
//         }
//     } else 0;
//
// 在上面的示例中，break从标记为“two_loop”的外部循环中退出
// 并返回值2。else子句附加到外部two_loop，并在没有调用break的情况下评估。
//
// 最后，您还可以使用块标签与“continue”语句：
//
//     my_while: while (true) {
//         continue :my_while;
//     }
//
const print = @import("std").debug.print;

// 如前所述，我们很快就会明白为什么这两个数字不需要显式类型。请耐心等待！
const ingredients = 4;
const foods = 4;

const Food = struct {
    name: []const u8,
    requires: [ingredients]bool,
};

//                 辣椒  通心粉  番茄酱  奶酪
// ------------------------------------------------------
//  奶酪通心粉              x                     x
//  辣椒通心粉      x        x
//  意大利面                x          x
//  奶酪辣椒        x                              x
// ------------------------------------------------------

const menu: [foods]Food = [_]Food{
    Food{
        .name = "Mac & Cheese",
        .requires = [ingredients]bool{ false, true, false, true },
    },
    Food{
        .name = "Chili Mac",
        .requires = [ingredients]bool{ true, true, false, false },
    },
    Food{
        .name = "Pasta",
        .requires = [ingredients]bool{ false, true, true, false },
    },
    Food{
        .name = "Cheesy Chili",
        .requires = [ingredients]bool{ true, false, false, true },
    },
};

pub fn main() void {
    // 欢迎来到美国自助餐厅！选择你喜欢的食材
    // 我们会为你制作一顿美味的饭菜。
    //
    // 自助餐厅顾客注意：并非所有的食材组合
    // 都能做成一道菜。默认的菜是奶酪通心粉。
    //
    // 软件开发者注意：根据数组位置硬编码食材
    // 编号对于我们这个小例子来说还可以，但是在真正的
    // 应用程序中，这样做是绝对不可原谅的！
    const wanted_ingredients = [_]u8{ 0, 3 }; // 辣椒，奶酪

    // 查看菜单上的每一种食物...
    const meal = food_loop: for (menu) |food| {

        // 现在查看每种食物所需的食材...
        for (food.requires, 0..) |required, required_ingredient| {

            // 这种食材不是必需的，所以跳过它。
            if (!required) continue;

            // 看看顾客是否想要这种食材。
            // （记住，want_it将是食材的索引号，根据它在
            // 每种食物所需食材列表中的位置。）
            const found = for (wanted_ingredients) |want_it| {
                if (required_ingredient == want_it) break true;
            } else false;

            // 我们没有找到这种必需的食材，所以我们不能做这种食物。继续外层循环。
            if (!found) continue :food_loop;
        }

        // 如果我们走到这一步，说明这种食物所需的食材都是顾客想要的。
        //
        // 请从循环中返回这种食物。
        break food;
    } else menu[0];
    // ^ 哎呀！我们忘了在找不到请求的食材时返回奶酪通心粉作为默认的食物。

    print("Enjoy your {s}!\n", .{meal.name});
}

// 挑战：你也可以在内层循环中去掉'found'变量。
// 看看你能不能想出怎么做！
