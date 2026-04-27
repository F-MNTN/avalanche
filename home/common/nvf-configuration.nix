{ pkgs, ... }:
{
  programs.nvf.enable = true;
  programs.nvf.settings = {
    vim = {
      globals = {
        mapleader = " ";
        maplocalleader = " ";
      };

      options = {
        shiftwidth = 2; # Number of spaces for each step of (auto)indent
        tabstop = 2; # Number of spaces that a <Tab> in the file counts for
        softtabstop = 2; # Number of spaces that a <Tab> counts for, while editing
        expandtab = true; # Convert tabs to spaces
        #smartindent = true;
        scrolloff = 10; # scollpadding in lines
      };

      binds = {
        whichKey.enable = true;
      };

      keymaps = [
        /*
          { example keymap
            key = "<leader>m";
            mode = "[n,i]";
            silent = true;
            action = ":make<CR>";
          }
        */
      ];

      theme = {
        enable = true;
        name = "rose-pine";
        style = "moon";
      };

      lazy = {
        enable = true; # enable lazy loading of plugins
        plugins = {
          "lazygit.nvim" = {
            package = pkgs.vimPlugins.lazygit-nvim;
            cmd = [ "LazyGit" ];
            keys = [
              {
                key = "<leader>gg";
                action = "<cmd>LazyGit<CR>";
                mode = "n";
              }
            ];
          };
          "vimtex" = {
            package = pkgs.vimPlugins.vimtex;
            ft = [
              "tex"
              "latex"
              "bib"
            ];
            before = ''
              vim.g.vimtex_view_method = "sioyek"
            '';
          };
        };
      };
      extraPlugins = {
        harpoon2 = {
          package = pkgs.vimPlugins.harpoon2;
          setup = ''
            local harpoon = require("harpoon")
            harpoon:setup({ settings = { save_on_toggle = true } })
            vim.keymap.set("n", "<leader>H", function() harpoon:list():add() end,                        { desc = "Harpoon: add file" })
            vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon: menu" })
            vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end,                    { desc = "Harpoon: file 1" })
            vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end,                    { desc = "Harpoon: file 2" })
            vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end,                    { desc = "Harpoon: file 3" })
            vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end,                    { desc = "Harpoon: file 4" })
          '';
        };
        render-markdown = {
          package = pkgs.vimPlugins.render-markdown-nvim;
          setup = ''
            require("render-markdown").setup({
              enabled = true,
              file_types = { "markdown", "obsidian" },
            })
          '';
        };
      };

      lsp = {
        enable = true;
        formatOnSave = false; # re-format according to lsp on save
        inlayHints.enable = true;
      };

      treesitter = {
        enable = true;
        highlight.enable = true;
        indent.enable = true;
      };

      undoFile.enable = true;

      languages = {
        clang.enable = true;
        nix.enable = true;
        rust.enable = true;
        python.enable = true;
        markdown.enable = true;
      };

      statusline.lualine.enable = true;
      telescope.enable = true;
      autocomplete.nvim-cmp.enable = true;
      dashboard.alpha = {
        enable = true; # enable nvim dashboard just to have a landing page
        theme = "theta";
      };
    };
  };
}
