{ pkgs, ... }: {
  environment.systemPackages = [
    (pkgs.discord.override {
      withOpenASAR = true;
      withVencord = true;
    })
    pkgs.xwaylandvideobridge # for Discord screen sharing (without audio support)
  ];
}
