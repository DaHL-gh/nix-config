let
  b550m = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHR0CW9OFYn1rcVP/9mv2qeILX4zQ8Js8l0XqZuDAm/j root@b550m";
in
{
  "secrets/k3s/node-token.age".publicKeys = [ b550m ];

  "secrets/wireguard/b550m/preshared-key.age".publicKeys = [ b550m ];
  "secrets/wireguard/b550m/private-key.age".publicKeys = [ b550m ];
}
