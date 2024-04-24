{
    age = {
        secrets = {
            "care_ssh" = {
                file = ./care_ssh.age;
                path = "/home/thender8/test_secret";
            };
        };

        secretsDir = "/home/thender8/.agenix/agenix";
        secretsMountPoint = "/home/thender8/.agenix/agenix.d";
        identityPaths = [ "/home/thender8/.ssh/id_ed25519" ];
    };
}
