{...}: {
  programs.wezterm = {
    enable = true;
    enableBashIntegration = true;

    extraConfig = builtins.readFile ./wezterm.lua;

    colorSchemes = {
      gbox = rec {
        background = "#282828";
        foreground = "#ebdbb2";

        cursor_bg = foreground;
        cursor_fg = background;

        cursor_border = foreground;

        selection_fg = background;
        selection_bg = foreground;

        ansi = [
          "#282828"
          "#cc241d"
          "#98971a"
          "#d79921"
          "#458588"
          "#B16286"
          "#689D6A"
          "#A89984"
        ];

        brights = [
          "#928374"
          "#FB4934"
          "#B8BB26"
          "#FABD2F"
          "#83A598"
          "#D3869B"
          "#8EC07C"
          "#EBDBB2"
        ];
      };
    };
  };
}
