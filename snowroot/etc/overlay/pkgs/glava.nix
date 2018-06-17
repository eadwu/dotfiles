self: super:

{
  glava = super.glava.override {
    enableGlfw = true;
  };
}
