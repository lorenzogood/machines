{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.bash = {
    enable = true;
  };

  home = {
    sessionVariables = {
      EDITOR = "nvim";
    };

    shellAliases = {
      vi = "nvim";
      vim = "nvim";
    };
  };

  programs.starship = {
    enable = true;

    settings = {
      format = lib.concatStrings [
        "[\\[](green)"
        "$username"
        "[@](blue)"
        "$hostname"
        ":"
        "$directory"
        "$git_branch"
        "$nix_shell"
        "[\\]\\$](green) "
      ];

      username = {
        style_root = "red";
        style_user = "green";
        format = "[$user]($style)";
        show_always = true;
        aliases = {
          foehammer = "foe";
        };
      };

      hostname = {
        ssh_only = false;
        ssh_symbol = "!";
        trim_at = ".";
        style = "green";
        format = "[$hostname]($style)[$ssh_symbol](red)";
      };

      directory = {
        truncation_length = 3;
        truncate_to_repo = true;
        style = "green";
        read_only = "(ro)";
        read_only_style = "red";
        home_symbol = "~";
        use_os_path_sep = true;

        format = "[$path]($style)[$read_only]($read_only_style)";
      };

      git_branch = {
        symbol = "";
        always_show_remote = false;
        truncation_symbol = "..";
        ignore_branches = [];
        truncation_length = 7;
        style = "orange";

        format = "[\\(g-$branch\\)]($style)";
      };

      nix_shell = {
        format = "[\\($symbol$pure_msg$impure_msg\\)]($style)";
        symbol = "n";
        style = "blue";
        impure_msg = " - \\(impure\\)";
        pure_msg = "p";
      };
    };

    enableBashIntegration = true;
  };
}
