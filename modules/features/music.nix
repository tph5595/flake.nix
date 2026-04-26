{ self, inputs, ... }: {

    flake.homeModules.music = { pkgs, lib, ... }: {
    home.packages = with pkgs; [
        # HW Interface controls
        alsa-scarlett-gui

        # DJ
        # mixxx

        # DAW
        bitwig-studio4
        # Tuner
        lingot
    ];
};
}
