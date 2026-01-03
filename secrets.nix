let
  b550m = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHR0CW9OFYn1rcVP/9mv2qeILX4zQ8Js8l0XqZuDAm/j root@b550m";
  latitude = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILlBmk8Al29Xq7OiDe52KippL5LokYBRR/ttPqtO7iYW root@latitude";
in
{
  "secrets/k3s/node-token.age".publicKeys = [ b550m ];
  "secrets/wireguard/b550m/preshared-key.age".publicKeys = [ b550m ];
  "secrets/wireguard/b550m/private-key.age".publicKeys = [ b550m ];

  "secrets/wireguard/latitude/preshared-key.age".publicKeys = [ latitude ];
  "secrets/wireguard/latitude/private-key.age".publicKeys = [ latitude ];
}
