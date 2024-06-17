{pkgs, ...}: let
  polkitRule = pkgs.writeTextDir "share/polkit-1/rules.d/10-sc.rules" ''
    polkit.addRule(function (action, subject) {
    	if ((action.id == "org.debian.pcsc-lite.access_pcsc" || action.id == "org.debian.pcsc-lite.access_card") && subject.isInGroup("wheel")) {
     			return polkit.Result.YES;
     	}
    })
  '';
in {
  services.udev.packages = with pkgs; [
    yubikey-personalization

    libu2f-host
  ];

  services.pcscd.enable = true;
  security.polkit.enable = true;

  environment.systemPackages = with pkgs; [
    yubikey-manager
    yubikey-personalization
    pcsclite
    polkitRule
  ];
}
