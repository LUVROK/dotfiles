{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    withNodeJs = true;
    extraLuaConfig = builtins.readFile ./init.lua;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      nvchad
      nvchad-ui
      gruvbox-nvim
      colorizer
      obsidian-nvim
      nerdtree
      nerdtree-git-plugin
      vim-nerdtree-syntax-highlight
      vim-nerdtree-tabs
    ];

    extraConfig = ''
      let mapleader = "\Space"
      syntax on
      filetype plugin indent on
      set wrap
      set tabstop=2
      set shiftwidth=2
      set softtabstop=2
      set expandtab
      set scrolloff=5
      set number
      set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ [BUFFER=%n]\ %{strftime('%c')}
      set encoding=utf-8
      set hlsearch
      set incsearch
      set ignorecase
      set smartcase
      colorscheme gruvbox
      set bg=dark
      autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
      nnoremap <F4> :NERDTreeToggle<CR>
      autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

      nnoremap <leader>n :NERDTreeFocus<CR>
      nnoremap <C-n> :NERDTree<CR>
      nnoremap <C-t> :NERDTreeToggle<CR>
      nnoremap <C-f> :NERDTreeFind<CR>
    '';
  };

  programs.vim = {
    enable = true;
    defaultEditor = false;

    plugins = with pkgs.vimPlugins; [ 

    ];
  };
}