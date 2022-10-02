-- Runs helper functions
local helper = require("scripts/helper")
local home = os.getenv("HOME")

local nvim_path = home .. "/.config/nvim"
local backupdir_path = nvim_path .. "/tmp/backup"
local swapdir_path = nvim_path .. "/tmp/swap"
local undodir_path = nvim_path .. "/tmp/undo"

helper.if_no_dir_create_dir(nvim_path)
helper.if_no_dir_create_dir(backupdir_path)
helper.if_no_dir_create_dir(swapdir_path)
helper.if_no_dir_create_dir(undodir_path)
