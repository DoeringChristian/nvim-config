return {
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
                -- "comment",
                "cpp",
                -- "css",
                "cuda",
                -- "d",
                -- "dart",
                -- "devicetree",
                "dockerfile",
                -- "dot",
                "eex",
                -- "elixir",
                -- "elvish",
                -- "erlang",
                -- "fennel",
                -- "fish",
                -- "foam",
                -- "fusion",
                "gdscript",
                -- "gleam",
                "glsl",
                -- "gomod",
                -- "gowork",
                -- "graphql",
                -- "hcl",
                -- "heex",
                -- "help",
                -- "hjson",
                -- "hocon",
                -- "html",
                -- "http",
                "java",
                -- "javascript",
                -- -- "jsdoc",
                -- "json",
                -- "json5",
                -- "julia",
                -- "kotlin",
                -- "lalrpop",
                "latex",
                -- "ledger",
                "llvm",
                "lua",
                -- "m68k",
                "make",
                "markdown",
                "ninja",
                -- "nix",
                "norg",
                "ocaml",
                "ocamllex",
                "org",
                -- "perl",
                -- "pioasm",
                -- "prisma",
                -- "proto",
                -- "pug",
                "python",
                -- "query",
                -- "r",
                -- "rasi",
                "regex",
                -- "rego",
                "rst",
                -- "ruby",
                "rust",
                -- "scala",
                -- "scheme",
                -- "scss",
                -- "slint",
                -- "solidity",
                -- "sparql",
                -- "supercollider",
                -- "surface",
                -- "svelte",
                -- "teal",
                -- "tlaplus",
                -- "todotxt",
                -- "tsx",
                -- "turtle",
                -- "typescript",
                -- "v",
                -- "vala",
                -- "verilog",
                "vim",
                -- "vue",
                "wgsl",
                "yaml",
                -- "yang",
                -- "zig",
            },

            sync_install = false,

            highlight = { enable = true },
            indent = { enable = true },
        })
    end,
}