return {
  {
    "saecki/crates.nvim",
    tag = "stable",
    event = { "bufRead Cargo.toml" },
    config = function()
      local crates = require("crates")
      
      -- Initialize the plugin with standard configuration
      crates.setup({
        lsp = {
          enable = true,
          on_attach = function(client, bufnr)
            -- Keymaps specifically for managing your Cargo.toml dependencies
            local map = function(keys, func, desc)
              vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "Crates: " .. desc })
            end

            map("<leader>ct", crates.toggle, "Toggle Crates UI")
            map("<leader>cr", crates.reload, "Reload Crates Data")
            map("<leader>cv", crates.show_versions_popup, "Show Versions")
            map("<leader>cf", crates.show_features_popup, "Show Features")
            map("<leader>cd", crates.show_dependencies_popup, "Show Dependencies")
            
            map("<leader>cu", crates.update_crate, "Update Crate")
            map("<leader>cx", crates.expand_plain_crate_to_inline_table, "Expand Crate to Inline Table")
          end,
        },
      })
    end,
  },
}

