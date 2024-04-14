{ pkgs, ... }: {
  environment.systemPackages = [
    (pkgs.discord.override {
      withOpenASAR = false;
      withVencord = false;
    })
    pkgs.xwaylandvideobridge # for Discord screen sharing (without audio support)
  ];
}
