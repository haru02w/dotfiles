local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local extras = require("luasnip.extras")
local rep = extras.rep
local fmt = require("luasnip.extras.fmt").fmt

return {
	s(
		"classfd",
		fmt(
			[[
		#pragma once
		#include <optional>
		class {} {{
		public:
			static std::optional<{}> create();
			~{}() = default;
		private:
			struct M {{
				{}
			}} m;
			explicit {}(M m)
				: m(std::move(m))
			{{}}
		}};
		{}
		]],
			{ i(1), rep(1), rep(1), i(2), rep(1), i(0) }
		)
	),
	s(
		"classfi",
		fmt(
			[[
		std::optional<{}> {}::create()
		{{
			{}
			return std::make_optional({}(M{{{}}}));
		}}
		]],
			{ i(1), rep(1), i(0), rep(1), i(2) }
		)
	),
}
