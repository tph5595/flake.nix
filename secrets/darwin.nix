{
    age = {
        secrets = {
            "care_ssh" = {
                file = ./care_ssh.age;
                path = "/Users/taylor/test_secret";
                owner = "taylor";
            };
        };

        secretsDir = "/Users/taylor/.agenix/agenix";
        secretsMountPoint = "/Users/taylor/.agenix/agenix.d";
        identityPaths = [ "/Users/taylor/.ssh/id_ed25519" ];
    };
}
