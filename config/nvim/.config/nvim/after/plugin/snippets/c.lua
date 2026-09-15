local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- beg
ls.add_snippets("c", {
  s("beg", {
    t({'#include <stdio.h>', ''}),
    t({'int main() {', ''}),
    t({'\treturn 0;', ''}),
    t({'}'}),
  })
})

-- comment
ls.add_snippets("c", {
  s("com", {
    t({'/* '}),
    i(1),
    t({' */'}),
  })
})
