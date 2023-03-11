return {
    "nvim-orgmode/orgmode",
    opts = function()
        require "orgmode".setup_ts_grammar()
        require "orgmode".setup {
            org_agenda_files = "~/share/notes/orgzly/*",
            org_default_notes_file = "~/share/notes/orgzly/main.org",
        }
    end,
}
