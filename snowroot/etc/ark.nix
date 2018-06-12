self: super:

{
  ark = super.ark.override {
    unfreeEnableUnrar = true;
  };
}
