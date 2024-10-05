return {
  "echasnovski/mini.indentscope",
  opts = {
    -- Module mappings. Use `''` (empty string) to disable one.
    mappings = {
      -- Textobjects
      object_scope = "io",
      object_scope_with_border = "ao",

      -- Motions (jump to respective border line; if not present - body line)
      goto_top = "[o",
      goto_bottom = "]o",
    },
  },
}
