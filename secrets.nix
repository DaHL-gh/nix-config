let
  b550m = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHR0CW9OFYn1rcVP/9mv2qeILX4zQ8Js8l0XqZuDAm/j root@b550m";
  latitude = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHxknhg4MQvmRr8A4Tv3n27SsVx2Z/xHS2MhHzGqjhhd root@nix-book";
  lenovo = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEfefED6p0F5KXfufgE1ux/+wIlS2aTBjBNZrA79EtfO root@kitayoza";
in
{
  "secrets/k3s/node-token.age".publicKeys = [ b550m ];
}
