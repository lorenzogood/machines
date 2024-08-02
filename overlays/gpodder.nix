final: prev: {
  gpodder2go = final.buildGoModule rec {
    pname = "gpodder2go";
    version = "0.2.0";

    src = final.fetchFromGitHub {
      owner = "oxtyped";
      repo = "gpodder2go";
      rev = "v${version}";
      hash = "sha256-DLUVANrePlnzEGmyjmrtQbus8zjPytBJUIg2MSqD8go=";
    };

    checkPhase = false;

    vendorHash = "sha256-7VkpRyoqWFfZODrNq5YjgHFKM3/7u/4G5b/930aoqyA=";

    CGO_ENABLED = 0;
  };
}
