{ pkgs, lib, config, ... }: 
{
    programs.ssh = {
        enable = true;
        matchBlocks = {
            "github.com" = {
                hostname = "github.com";
                identityFile = "${config.home.homeDirectory}/.ssh/github";
            };
        };
    };

    programs.gh = {
        enable = true;
        settings = {
            git_protocol = "ssh";
            prompt = "enabled";
            editor = "nvim";
        };
    };
    
    programs.delta = {
	enable = true;
	enableGitIntegration = true;
    };
    programs.git = {
        enable = true;
        lfs.enable = true;
        includes = [
            {
                condition = "gitdir:~/flake.nix";
                contents = {
                    user.email = "tph5595@verizon.net";
                    user.signingkey = "~/.ssh/github.pub";
                };
            }
            {
                condition = "gitdir:~/repos";
                contents = {
                    user.email = "taylor.henderson@jhuapl.edu";
                    user.signingkey = "~/.ssh/git.work.pub";
                };
            }
        ];
        settings = {
            user.name  = "Taylor Henderson";

            # Sign all commits using ssh key
            commit.gpgsign = true;
            gpg.format = "ssh";

            credential.helper = "${
                pkgs.git.override { withLibsecret = true; }
            }/bin/git-credential-libsecret";
        };
        signing = {
            signByDefault = true;
            # key = "E9857FBDFC23A621";
        };
    };
}
