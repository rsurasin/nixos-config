local actions = require("fzf-lua").actions

require("fzf-lua").setup {
  "fzf-native",
  keymap = {
    fzf = {
      ["ctrl-u"] = "preview-page-up",
      ["ctrl-d"] = "preview-page-down",
    }
  },
  actions = {
    files = {
      ["ctrl-x"] = actions.file_split
    },
  }
}
