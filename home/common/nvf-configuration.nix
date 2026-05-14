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
        enable = true; 
        plugins = { # plugins to lazily load when they are needed
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
          "flutter-tools.nvim" = {
            package = pkgs.vimPlugins.flutter-tools-nvim;
            ft = [ "dart" ];
            after = ''
              require("flutter-tools").setup({
                flutter_path = "${pkgs.flutter}/bin/flutter",
                lsp = {
                  on_attach = function(_, bufnr)
                    local opts = { buffer = bufnr, silent = true }
                    vim.keymap.set("n", "<leader>fr", "<cmd>FlutterRun<CR>",       opts)
                    vim.keymap.set("n", "<leader>fq", "<cmd>FlutterQuit<CR>",      opts)
                    vim.keymap.set("n", "<leader>fR", "<cmd>FlutterRestart<CR>",   opts)
                    vim.keymap.set("n", "<leader>fd", "<cmd>FlutterDevices<CR>",   opts)
                    vim.keymap.set("n", "<leader>fe", "<cmd>FlutterEmulators<CR>", opts)
                  end,
                },
              })
            '';
          };

          "obsidian.nvim" = {
            package = pkgs.vimPlugins.obsidian-nvim;
            ft = [ "markdown" ];

            after = ''
              require("obsidian").setup({
                legacy_commands = false,
                workspaces = {
                  {
                    name = "Mountain",
                    path = "~/Desktop/ObsidianVaults/ObisidianSnyc_TheMountain",
                  },
                },
                completion = {
                  nvim_cmp = true,
                },
                ui = {
                  enable = true, 
                },
              })
            '';
          };
          "vim-be-good" = {
            package = pkgs.vimPlugins.vim-be-good;
          };
        };
      };

      extraPlugins = { # plugins to load on startup
        harpoon2 = { # classic the vimagen W 
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
        render-markdown = { # render Markdown in file 
          package = pkgs.vimPlugins.render-markdown-nvim;
          setup = ''
            require("render-markdown").setup({
              enabled = true,
              file_types = { "markdown" },
            })
          '';
        };
        plenary = {
          package = pkgs.vimPlugins.plenary-nvim;
        };
        project = {
          package = pkgs.vimPlugins.project-nvim;
          setup = ''
            vim.schedule(function()
              require("project").setup({})
              require("telescope").load_extension("projects")
            end)
          '';
        };
        alpha = {
          package = pkgs.vimPlugins.alpha-nvim;
          setup = ''
            local alpha  = require("alpha")
            local theta  = require("alpha.themes.theta")
            local dash   = require("alpha.themes.dashboard")
        
            -- steal theta's header
            local header = theta.header
        
            -- ── Recent files ─────────────────────────────────────────────────
            local recent_files = {
              type = "group",
              val = function()
                local items = {{ type = "text", val = "  Recent Files", opts = { hl = "AlphaHeader", position = "center" }}}
                local count = 0
                for _, f in ipairs(vim.v.oldfiles) do
                  if count >= 3 then break end
                  if vim.fn.filereadable(f) == 1 then
                    count = count + 1
                    table.insert(items, dash.button(
                      tostring(count),
                      "   " .. vim.fn.fnamemodify(f, ":t"), -- only show filename not whole path
                      "<cmd>e " .. vim.fn.fnameescape(f) .. "<CR>"
                    ))
                  end
                end
                return items
              end,
            }
        
            -- ── Shortcuts ─────────────────────────────────────────────────────
            local shortcuts = {
              type = "group",
              val = {
                { type = "text", val = "   Shortcuts", opts = { hl = "AlphaHeader", position = "center" }},
                dash.button("g", "   LazyGit",      "<cmd>LazyGit<CR>"),
                dash.button("p", "   Find project", "<cmd>ProjectTelescope<CR>"),
                dash.button("f", "   Find file",    "<cmd>Telescope find_files<CR>"),
                dash.button("z", "   Fuzzy grep",    "<cmd>Telescope live_grep<CR>"),
                dash.button("n", "   New file",     "<cmd>ene | startinsert<CR>"),
                dash.button("c", "   Config",       "<cmd>e ~/NixFlakes/avalanche/home/common/nvf-configuration.nix<CR>"),
                dash.button("q", "   Quit",         "<cmd>qa<CR>"),
              },
            }
        
            local function pad(n) return { type = "padding", val = n } end
            alpha.setup({
              layout = {
                pad(2),
                header,
                pad(2),
                recent_files,
                pad(1),
                shortcuts,
                pad(1),
              },
              opts = { margin = 5 },
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
        python = {
          enable = true;
          lsp.servers = ["pyright"];
        };
        markdown.enable = true;
        java.enable = true;
      };

      statusline.lualine.enable = true;
      telescope.enable = true;
      autocomplete.nvim-cmp.enable = true;
      dashboard.alpha.enable = false;
    };
  };
}
