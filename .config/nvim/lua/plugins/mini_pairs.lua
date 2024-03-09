return {
  {
    "echasnovski/mini.pairs",
    opts = {
      mappings = {
        ["("] = { action = "open", pair = "()", neigh_pattern = "[^\\][\n ]" },
        ["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\][\n ]" },
        ["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\][\n ]" },
      },
    },
  },
}
