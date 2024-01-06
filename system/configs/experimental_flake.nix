{ ... }:
{
  # Enable Flakes and the new command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  programs = {
    # Flakes use Git to pull dependencies from data sources 
    git.enable = true;
  };
}