{
  pkgs,
  config,
  lib,
  ...
}: {
  fonts = lib.mkIf config.foehammer.graphical.enable {
    packages = with pkgs; [
      nerdfonts
      dejavu_fonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-extra
      unifont
    ];
  };
}
