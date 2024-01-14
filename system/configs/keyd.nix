{ ... }:
{
  services.keyd = {
    enable = true;
    # Swap Ctrl with alt
    keyboards = {
      default = {
        ids = "*";
        settings = {
          control = "alt";
        };
      };
    };
  };
}