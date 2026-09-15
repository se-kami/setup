local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local c = ls.choice_node
local d = ls.dynamic_node
local f = ls.function_node
local i = ls.insert_node
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node

-- hashbang
ls.add_snippets("python", {
  s("beg", {
    t({ '#!/usr/bin/env python', '# -*- coding: utf-8 -*-', '', '', '' })
  })
})

-- import
ls.add_snippets("python", {
  s("imp", {
    t('import '),
    i(1),
  })
})

-- if main
ls.add_snippets("python", {
  s("ifmain", {
    t({ 'if __name__ == "__main__":', '\t', }),
  })
})

-- magic
ls.add_snippets("python", {
  s("def_", {
    t({ 'def __' }),
    i(1),
    t({ '__:', '\t', }),
    i(2),
  })
})

-- torch net
ls.add_snippets("python", {
  s("net_", {
    t('class '),
    i(1),
    t({ '(nn.Module):', '' }),
    t({ '\tdef __init__(self):', '' }),
    t({ '\t\tsuper().__init__()', '' }),
    t('\t\t'),
    i(2),
  })
})

-- function with docstring
local func_template = [[
def {}({}) -> {}:
    """
    {}

    {}

    Args:
{}

    Returns:
    {}

    Examples:
      >>
    """
    {}

    return {}
]]

ls.add_snippets("python", {
  s("def",
    fmt(func_template, {
      i(1, "fn_name"),
      i(2, "args"),
      i(3, "returns"),
      i(4, "Short desc."),
      i(5, "A really long desc."),
      d(6,
        function(values)
          local args = values[1][1]:gsub(", ", ",")
          args = vim.split(args, ",")

          local nodes = {}

          vim.print(args)

          for index, param in ipairs(args) do
            table.insert(nodes, sn(index, {t({"    "}), i(1, param), t({"", ""}) }))
          end
          return sn(nil, nodes)
        end, { 2 }),
      i(7, "returns"),
      i(8, "body"),
      i(9, "None"),
    }
    )
  )
})
