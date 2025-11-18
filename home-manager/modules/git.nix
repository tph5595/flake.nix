{ pkgs, lib, config, ... }: 
{
#    programs.ssh = {
#        enable = true;
        #matchBlocks = {
        #    "github.com" = {
        #        hostname = "github.com";
        #        identityFile = "${config.home.homeDirectory}/.ssh/github";
        #    };
        #};
#    };

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
        #settings.userName  = "Taylor Henderson";
	#settings.user.email "tph5595@verizon.net";
        #signing = {
        #    signByDefault = true;
        #    key = "E9857FBDFC23A621";
        #};
        #extraConfig = {
        #    # Sign all commits using ssh key
        #    commit.gpgsign = true;
        #    gpg.format = "ssh";
        #    user.signingkey = "~/.ssh/github.pub";

        #    credential.helper = "${
        #        pkgs.git.override { withLibsecret = true; }
        #    }/bin/git-credential-libsecret";
        #};
    };
}
