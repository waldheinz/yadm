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
                    name = "gitblame";
                    publisher = "waderyan";
                    version = "3.0.1";
                    sha256 = "1h68fzm9glv7gqwbi15sk6iw45kp9r08wrv2vd6lwi45srriwgjp";
                }

                {
                    name = "shellcheck";
                    publisher = "timonwong";
                    version = "0.8.1";
                    sha256 = "0zg7ihwkxg0da0wvqcy9vqp6pyjignilsg9cldp5pp9s0in561cw";
                }

                {
                    name = "vscode-typescript-tslint-plugin";
                    publisher = "ms-vscode";
                    version = "1.2.2";
                    sha256 = "1n2yv37ljaadp84iipv7czzs32dbs4q2vmb98l3z0aan5w2g8x3z";
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
