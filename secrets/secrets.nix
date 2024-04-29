let
  BestBox = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDgl9C/J+Qtaab4mkGpuhIlAHS1d7XUTL64KLSbhCZ7w taylorhenderson@pm.me";
  sr3s13 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC9M83BK8IEW3r6e16n4iO8M8lwy3mg/79AaByytdeL7 thender8@sr3s13";
  taylor = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGJhGM7OLxBYjZR0HdKZadqSemsPuyxdMc5UYRIb+fbj taylor@pop-os";
  personal = [ BestBox taylor ];
  gmucare = [ sr3s13 ];
  systems = personal ++ gmucare;
in
{
  "./files/care_ssh.age".publicKeys = systems;
}
