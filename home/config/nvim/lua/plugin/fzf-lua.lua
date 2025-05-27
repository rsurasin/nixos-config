local actions = require("fzf-lua").actions

require("fzf-lua").setup {
  "fzf-native",
  keymap = {
    fzf = {
      ["ctrl-w"] = "unix-line-discard",
      ["ctrl-u"] = "preview-page-up",
      ["ctrl-d"] = "preview-page-down",
    }
  },
  actions = {
    files = {
      ["enter"] = actions.file_edit_or_qf,
      ["ctrl-x"] = actions.file_split,
      ["ctrl-v"] = actions.file_vsplit,
    },
  }
}
