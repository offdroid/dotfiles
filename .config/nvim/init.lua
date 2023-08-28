require("core.options")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = require("plugins")
require("lazy").setup(plugins, opts)

vim.cmd([[colorscheme carbonfox]])
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- Utils
P = function(value)
    print(vim.inspect(value))
    return value
end

RELOAD = function(...)
    return require("plenary.reload").reload_module(...)
end

R = function(name)
    RELOAD(name)
    return require(name)
end
