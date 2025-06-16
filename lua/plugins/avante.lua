return {
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        version = false, -- Never set this value to "*"! Never!
        build = "make",
        opts = {
            auto_suggestions_provider = "ollama-mini",
            providers = {
                claude = {
                    endpoint = "https://api.anthropic.com",
                    model = "claude-sonnet-4-20250514",
                    api_key_name = "ANTHROPIC_API_KEY",
                    timeout = 600000, -- 10 minutes
                    extra_request_body = {
                        max_tokens = 32000,
                    },
                },
                ollama = {
                    endpoint = "http://localhost:11434",
                    model = "qwq:32b",
                },
                ["ollama-mini"] = {
                    __inherited_from = "ollama",
                    model = "qwen2.5-coder:1.5b",
                },
            },
            behaviour = {
                auto_set_keymaps = false,
            }
        }
    }
}
