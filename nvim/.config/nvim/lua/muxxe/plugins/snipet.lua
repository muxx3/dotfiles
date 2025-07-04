local ls = require("luasnip")

-- HTML Boilerplate Snippet
ls.add_snippets("html", {
    ls.parser.parse_snippet("html", [[
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>$1</title>
</head>
<body>
    $0
<script src="$1"></script>
</body>
</html>
]])
})

ls.add_snippets("html", {
    ls.parser.parse_snippet("htss", [[
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>$1</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    $0
<script src="script.js"></script>
</body>
</html>
]])
})

-- Key mappings for expanding and jumping through snippets
vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump(1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-E>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end, {silent = true})

