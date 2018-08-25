let
  hostname = "nixos";
  user = "yin";

  # jp, nl, us
  protonRegion = "jp";
  DOCKER_ID_USER = "tianxian";
in {
  hostname = hostname;
  user = user;
  protonRegion = protonRegion;

  protonFile = /etc/nixos/credentials/protonvpn;
  passwordFile = "/etc/nixos/credentials/${user}";

  HOME = "/home/${user}";
  DOCKER_ID_USER = DOCKER_ID_USER;
}
