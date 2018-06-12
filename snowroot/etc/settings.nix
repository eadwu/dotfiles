let
  uuid = "d43adf5e-b229-4884-a291-e62a6c697d81";
  hostname = "nixos";
  user = "yin";

  DOCKER_ID_USER = "tianxian";
in {
  uuid = uuid;
  hostname = hostname;
  user = user;
  passwordFile = "/etc/nixos/passwords/${user}";

  HOME = "/home/${user}";
  DOCKER_ID_USER = DOCKER_ID_USER;
}
