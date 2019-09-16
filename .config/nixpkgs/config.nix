with import <nixpkgs> {};

{
    allowUnfree = true;

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
                        vimproc-vim
                    ];
                    opt = [ ];
                };
            };
        };

        myVscode = vscode-with-extensions.override {
            vscodeExtensions = vscode-utils.extensionsFromVscodeMarketplace [
                {
                    name = "shellcheck";
                    publisher = "timonwong";
                    version = "0.8.1";
                    sha256 = "0zg7ihwkxg0da0wvqcy9vqp6pyjignilsg9cldp5pp9s0in561cw";
                }

                {
                    name = "Nix";
                    publisher = "bbenoist";
                    version = "1.0.1";
                    sha256 = "0zd0n9f5z1f0ckzfjr38xw2zzmcxg1gjrava7yahg5cvdcw6l35b";
                }
            ];
        };

        all = with pkgs; buildEnv {
            name = "all";
            paths = [
                myNeovim
                myVscode
                nodePackages.typescript
            ];
        };
    };
}
