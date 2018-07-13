self: super:

{
  vscode-with-extensions = super.vscode-with-extensions.override {
    vscodeExtensions = with super.vscode-extensions; [
      WakaTime.vscode-wakatime
    ];
  };

  environment = {
    systemPackages = with pkgs; [
      dwmstatus
    ];
  };
}
