return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local treesitter = require("nvim-treesitter.configs")
            treesitter.setup({
                ensure_installed = {
                    "bash",
                    "bibtex",
                    "c",
                    "cmake",
                    "cpp",
                    "cuda",
                    "dockerfile",
                    "eex",
                    "gdscript",
                    "glsl",
                    "java",
                    "latex",
                    "llvm",
                    "lua",
                    "make",
                    "markdown",
                    "markdown_inline",
                    "ninja",
                    "norg",
                    "ocaml",
                    "ocamllex",
                    "org",
                    "python",
                    "regex",
                    "rst",
                    "rust",
                    "vim",
                    "wgsl",
                    "yaml",
                },

                sync_install = false,

                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },
    -- TODO: treesitter textobjects

}
