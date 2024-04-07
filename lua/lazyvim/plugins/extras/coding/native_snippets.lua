if not vim.snippet then
  LazyVim.warn("Native snippets are only supported on Neovim >= 0.10.0")
  return {}
end

return {
  desc = "Use native snippets instead of LuaSnip. Only works on Neovim >= 0.10!",
  {
    "L3MON4D3/LuaSnip",
    enabled = false,
  },
  {
    "nvim-cmp",
    dependencies = {
      { "rafamadriz/friendly-snippets" },
      { "garymjr/nvim-snippets", opts = { friendly_snippets = true } },
    },
    opts = function(_, opts)
      opts.snippet = {
        expand = function(args)
          vim.snippet.expand(args.body)
        end,
      }
      table.insert(opts.sources, { name = "snippets" })
    end,
    keys = {
      {
        "<Tab>",
        function()
          if vim.snippet.active({ direction = 1 }) then
            vim.schedule(function()
              vim.snippet.jump(1)
            end)
            return
          end
          return "<Tab>"
        end,
        expr = true,
        silent = true,
        mode = "i",
      },
      {
        "<Tab>",
        function()
          vim.schedule(function()
            vim.snippet.jump(1)
          end)
        end,
        silent = true,
        mode = "s",
      },
      {
        "<S-Tab>",
        function()
          if vim.snippet.active({ direction = -1 }) then
            vim.schedule(function()
              vim.snippet.jump(-1)
            end)
            return
          end
          return "<S-Tab>"
        end,
        expr = true,
        silent = true,
        mode = { "i", "s" },
      },
    },
  },
}
