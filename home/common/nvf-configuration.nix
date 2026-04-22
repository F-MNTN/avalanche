{ ... }:
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
        scrolloff = 5;
      };

      binds = {
        whichKey.enable = true;
      };

      theme = {
        enable = true;
        name = "tokyonight";
        style = "night";
      };

      navigation.harpoon = {
        enable = true;
        mappings = {
          markFile = "<leader>H";
          listMarks = "<leader>h";
          file1 = "<leader>1";
          file2 = "<leader>2";
          file3 = "<leader>3";
          file4 = "<leader>4";
        };
      };

      lazy = {
        enable = true; # enable lazy loading of plugins
      };

      lsp = {
        enable = true;
        formatOnSave = false; # re-format according to lsp on save
        inlayHints.enable = true;
        harper-ls = {
          enable = false; # enable spellchecking
          settings = {
            codeActions = {
              ForceStable = false;
            };
            diagnosticSeverity = "hint";
            dialect = "American";
            fileDictPath = "";
            ignoredLintsPath = { };
            isolateEnglish = true;
            linters = {
              BoringWords = true;
              PossessiveNoun = true;
              SentenceCapitalization = false;
              SpellCheck = true;
            };
            markdown = {
              IgnoreLinkTitle = false;
            };
          };
        };
      };

      treesitter = {
        enable = true;
        highlight.enable = true;
        indent.enable = true;
      };

      languages = {
        clang.enable = true;
        nix.enable = true;
        rust.enable = true;
        python.enable = true;
      };
      
      git.vim-fugitive.enable = true;
      statusline.lualine.enable = true;
      telescope.enable = true;
      autocomplete.nvim-cmp.enable = true;
      dashboard.alpha = {
        enable = true; # enable nvim dashboard just to have a landing page
        theme = "theta";
        # layout = {};
      };
    };
  };
}
