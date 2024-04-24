{
    age = {
        secrets = {
            "care_ssh" = {
                file = ./care_ssh.age;
                path = "/home/taylor/test_secret";
            };
        };

        secretsDir = "/home/taylor/.agenix/agenix";
        secretsMountPoint = "/home/taylor/.agenix/agenix.d";
        identityPaths = [ "/home/taylor/.ssh/id_ed25519" ];
    };
}
