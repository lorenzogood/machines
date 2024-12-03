{...}: {
  services.kanata = {
    enable = true;
    keyboards."leni" = {
      config = ''
        (defsrc
        	caps)

        (deflayermap (default-layer)
        	caps esc)
      '';
    };
  };
}
