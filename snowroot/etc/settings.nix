let
  uuid = "d43adf5e-b229-4884-a291-e62a6c697d81";
  hostname = "nixos";
  user = "yin";

# jp, nl, us
  protonRegion = "jp";
  DOCKER_ID_USER = "tianxian";
in {
  uuid = uuid;
  hostname = hostname;
  user = user;
  protonRegion = protonRegion;

  protonFile = /etc/nixos/credentials/protonvpn;
  passwordFile = "/etc/nixos/credentials/${user}";

  HOME = "/home/${user}";
  DOCKER_ID_USER = DOCKER_ID_USER;
}
