{ pkgs, lib, ... }:

let
  easyFX = "${pkgs.fetchzip {
    url = "https://nilssoderman.com/files/blender/EasyFX.zip";
    sha256 = "0zlm2kgnjwcp8p9znbp4iwn4wqlv30yg8335nk3k8mgr0c21xx16";
  }}/EasyFX.py";

  autoMirror = "${pkgs.fetchgit {
    url = "https://framagit.org/Lapineige/Blender_add-ons.git";
    rev = "8d00ac4a71259f476bd4adac7e8fd1cc4e580b69";
    sha256 = "1n0rb6nn952s65vhfjka3pcvaa80myq95ldpzjwrvb73znrpl7nq";
  }}/AutoMirror/AutoMirror_V2-4.py";

  matalogue = "${pkgs.fetchFromGitHub {
    owner = "gregzaal";
    repo = "Matalogue";
    rev = "e9aaa80e6702d2dcee0351e464b18110d50084d7";
    sha256 = "0akld9w84l59ss54ysgmdrr9vfvb2rhp1jl6i8zfdsxckqysz0w1";
  }}/matalogue.py";

  sculptBrushes = "${pkgs.fetchFromGitHub {
    owner = "IIK3D";
    repo = "Sculpt_Brushes";
    rev = "c8ec603c65e839ad33ccf96ced420376af3d8ace";
    sha256 = "1fmi2x6lv3899njk7pfz8shc9c49g388d02hx7d2gfnxmdkjw6xl";
  }}/sculpt_brushes";

  batchOperations = "${pkgs.fetchFromGitHub {
    owner = "dairin0d";
    repo = "batch-operations";
    rev = "b723e3d376da395cb1db5f2715c704dc64a1a68a";
    sha256 = "0lw4dzd5jf9kqyzpwx7mi58s4xsq2icfpy2wb4ayqh6vas9w43mc";
  }}/space_view3d_batch_operations";

  blender_2_7x = {
    "blender/2.79/pie-essentials".source = ./blender/pie-essentials;

    "blender/2.79/EasyFX.py".source = easyFX;
    "blender/2.79/AutoMirror_V2-4.py".source = autoMirror;
    "blender/2.79/matalogue.py".source = matalogue;
    "blender/2.79/space_view3d_batch_operations".source = batchOperations;
  };

  blender_2_8x = { };
in {
  home.packages = lib.singleton pkgs.blender;
  xdg.configFile = {
    "blender/2.80/sculpt_brushes".source = sculptBrushes;
  };
}
