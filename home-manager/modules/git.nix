{ pkgs, lib, config, ... }: 
{
    programs.git = {
        enable = true;
        lfs.enable = true;
        userName  = "Taylor Henderson";
        userEmail = "tph5595@verizon.net";
        extraConfig = {
            credential.helper = "${
                pkgs.git.override { withLibsecret = true; }
            }/bin/git-credential-libsecret";
        };
    };
}
