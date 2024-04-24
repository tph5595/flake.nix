let
  BestBox = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDgl9C/J+Qtaab4mkGpuhIlAHS1d7XUTL64KLSbhCZ7w taylorhenderson@pm.me";
  sr3s13 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL0idNvgGiucWgup/mP78zyC23uFjYq0evcWdjGQUaBH";
  taylor = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGJhGM7OLxBYjZR0HdKZadqSemsPuyxdMc5UYRIb+fbj taylor@pop-os";
  personal = [ BestBox taylor ];
  gmucare = [ sr3s13 ];
  systems = personal ++ gmucare;
in
{
  "care_ssh.age".publicKeys = systems;
}
