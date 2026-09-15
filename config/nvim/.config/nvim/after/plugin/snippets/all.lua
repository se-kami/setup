local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node
local d = ls.dynamic_node
local sn = ls.snippet_node

-- hashbang
ls.add_snippets("all", {
  s("begsh", {
    t({ '#!/usr/bin/env sh', '', '' })
  })
})


ls.add_snippets("all", {
  s("begpy", {
    t({ '#!/usr/bin/env python', '# -*- coding: utf-8 -*-', '', '', '' })
  })
})

-- testing
ls.add_snippets("all", {
  s('h', {
    t({ "line one", "line two" }),
  })
})
-- testing insert node
ls.add_snippets("all", {
  s('var', {
    i(0), -- last one
    t("something "),
    i(1),
    t(" is "),
    i(2, "placeholder"),
  })
})
-- testing choice node
ls.add_snippets("all", {
  s("choice", {
    c(1, {
      t("1st"),
      t("2nd"),
      t("3rd")
    })
  })
})
-- testing function node
-- ls.add_snippets("all", {
--   s("function",
--     {
--       f(function()
--         return "hello"
--       end
--       )
--     }
--   )
-- })

-- ls.add_snippets("all", {
--   s("date",
--     {
--       f(function()
--         return os.date("%Y-%m-%d")
--       end
--       )
--     }
--   )
-- })
--
-- ls.add_snippets("all", {
--   s("ii", fmt("1st arg {} = 2nd arg {}", {
--     f(function(values)
--       vim.print(values)
--       return values[1]
--     end, { 1, }),
--     i(1),
--   }))
-- })

ls.add_snippets("all", {
  s("tag", fmt("<{}{}>{}<\\{}>", {
    i(1),
    i(2),
    i(3),
    f(function(values)
      vim.print(values)
      return values[1][1]
    end, { 1, }),
  }))
})
--
-- testing dynamic node
-- local func_template = [[
-- -- {}{}
-- function {}({})
--   {}
-- end
-- ]]
-- ls.add_snippets("all", {
--   s("iii", {
--     fmt(func_template, {
--       i(1, "function description"),
--       d(5, function(args)
--         vim.print(args)
--         local param_str = args[1][1]
--         param_str = param_str:gsub(", ", ",")
--
--         if param_str == "" then
--           return sn(1, { t("") })
--         end
--
--
--         local params = vim.split(param_str, ",")
--
--         local nodes = {}
--
--         for index, param in ipairs(params) do
--           table.insert(nodes, sn(index, fmt("-- @param {} {} {}", {
--             t(param),
--             i(1, "any"),
--             i(2, "desc"),
--           })))
--         end
--
--         return sn(nil, nodes)
--         --
--         -- local doc_comments = { "" }
--         --
--         -- for index, param in ipairs(params) do
--         --   table.insert(doc_comments, string.format("-- @param %s any <some description>", param))
--         -- end
--         --
--         -- return doc_comments
--       end, {}),
--     }),
--     i(2, "function_name"),
--     i(3, "params"),
--     i(4, "body")
--   })
-- })
