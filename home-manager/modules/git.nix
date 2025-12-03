{ pkgs, lib, config, ... }: 
let personal_git = {
    user.email = "tph5595@verizon.net";

    # Sign all commits using ssh key
    commit.gpgsign = true;
    gpg.format = "ssh";
    user.signingkey = "~/.ssh/github.pub";

    credential.helper = "${
        pkgs.git.override { withLibsecret = true; }
    }/bin/git-credential-libsecret";
}; in 
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
                contents = personal_git;
            }
            {
                condition = "gitdir:~/personal/";
                contents = personal_git;
            }
            {
                condition = "gitdir:~/Documents/";
                contents = {
                    user.email = "taylor.henderson@jhuapl.edu";

                    # Sign all commits using ssh key
                    commit.gpgsign = true;
                    gpg.format = "ssh";
                    user.signingkey = "~/.ssh/git.work.pub";

                    credential.helper = "${
                        pkgs.git.override { withLibsecret = true; }
                    }/bin/git-credential-libsecret";
                };
            }
        ];
        settings = {
            user.name  = "Taylor Henderson";
        };
        # signing = {
        #     signByDefault = true;
        #     key = "E9857FBDFC23A621";
        # };
    };
}
