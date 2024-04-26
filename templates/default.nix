{
    python = {
        path = ./dev/python;
        description = "Python dev environment template";
    };

    rust = {
        path = ./dev/rust;
        description = "Rust dev environment template";
    };
    bash = {
        path = ./default;
        description = "nix flake new -t github:Mic92/nix-direnv .";
    };
    latex = {
        path = ./dev/latex;
        description = "Latex dev environment template";
    };
    kotlin = {
        path = ./dev/kotlin;
        description = "kotlin dev environment template";
    };
}
