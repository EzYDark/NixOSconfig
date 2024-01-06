 { ... }:
 {
  # do garbage collection weekly to keep disk usage low
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options =  "--delete-older-than 7d";
  };
 }