return {
  {
    "mrcjkb/rustaceanvim",
    version = "^5", -- Recommended for stable releases
    lazy = false,   -- Plugin manages its own lazy loading
    config = function()
      vim.g.rustaceanvim = {
        -- Plugin configuration
        tools = {
          -- Customize inlay hints or hovering here if needed
        },
        -- LSP configuration
        server = {
          on_attach = function(client, bufnr)
            -- Utility function to easily set keymaps for the current buffer
            local map = function(keys, func, desc)
              vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "Rust: " .. desc })
            end

            -- =============================================================
            -- KEYMAPS
            -- =============================================================
            -- Override standard Neovim hover actions with rustaceanvim features
            map("K", function() vim.cmd.RustLsp({ "hover", "actions" }) end, "Hover Actions")
            
            -- Code action grouping (gives cleaner Rust-specific macro expansions)
            map("<leader>ca", function() vim.cmd.RustLsp("codeAction") end, "Code Action")
            
            -- View the macro expansion window for code under the cursor
            map("<leader>cm", function() vim.cmd.RustLsp("expandMacro") end, "Expand Macro")
            
            -- Open the Cargo.toml file or view item documentation on crates.io
            map("<leader>cd", function() vim.cmd.RustLsp("openCargo") end, "Open Cargo.toml")

            -- Standard Neovim navigation (fallbacks that work across LSPs)
            map("gd", vim.lsp.buf.definition, "Go to Definition")
            map("gr", vim.lsp.buf.references, "Go to References")
            map("gi", vim.lsp.buf.implementation, "Go to Implementation")
            map("<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
          end, -- <-- This was the missing 'end'
          default_settings = {
            -- rust-analyzer language server configuration
            ["rust-analyzer"] = {
              -- Run Clippy lints on save instead of basic 'cargo check'
          checkOnSave = true, -- Now strictly expects a boolean flag
            check = {
          command = "clippy", -- Sub-settings are now placed under 'check'
                },
              -- Ensure workspace analysis checks all conditional features and build scripts
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                buildScripts = {
                  enable = true,
                },
              },
              -- Proc-macro expansion support for crates like serde, tokio, etc.
              procMacro = {
                enable = true,
                ignored = {
                  ["async-trait"] = { "async_trait" },
                  ["napi-derive"] = { "napi" },
                },
              },
              -- Enhanced visual cues (inlay hints) directly in your editor pane
              inlayHints = {
                bindingModeHints = { enable = true },
                chainingHints = { enable = true },
                closingBraceHints = { enable = true, minLines = 25 },
                closureReturnTypeHints = { enable = "always" },
                lifetimeElisionHints = { enable = "always", useParameterNames = true },
                parameterHints = { enable = true },
                reborrowHints = { enable = "always" },
                typeHints = { enable = true },
              },
            },
          },
        },
        -- DAP (Debugging) configuration
        dap = {
        },
      }
    end,
  },
}

