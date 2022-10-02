return function()
  require'nvim-web-devicons'.setup {default = true;}
  require'nvim-web-devicons'.get_icon(filename, extension, { default = true })
end
