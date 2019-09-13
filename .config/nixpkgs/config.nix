with import <nixpkgs> {};

{
    packageOverrides = pkgs_: with pkgs_; {
        myNeovim = neovim.override {
            configure = {
                customRC = lib.fileContents ./nvim-init.vim;
                packages.myVimPackage = with pkgs.vimPlugins; {
                    start = [
                        ctrlp-vim
                        nerdtree
                        tsuquyomi
                        typescript-vim
                        vim-airline
                        vim-airline-themes
                        vim-colors-solarized
                        vim-gitgutter
                    ];
                    opt = [ ];
                };
            };
        };

        all = with pkgs; buildEnv {
            name = "all";
            paths = [
		        myNeovim
            ];
        };
    };
}
