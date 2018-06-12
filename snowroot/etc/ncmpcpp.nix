self: super:

{
  ncmpcpp = super.ncmpcpp.override {
    clockSupport = true;
    outputsSupport = true;
    visualizerSupport = true;
  };
}
