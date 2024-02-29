{ pkgs, ... }: {
  environment.systemPackages = with pkgs;
    [ lemurs ];

  systemd.services."lemurs" = {
    enable = false;
    after = [
      "systemd-user-sessions.service"
      "plymouth-quit-wait.service"
      "getty@tty2.service"
    ];
    serviceConfig = {
      Restart = "on-failure";
      ExecStart = "${pkgs.lemurs}/bin/lemurs";
      StandartInput = "tty";
      TTYPath = "/dev/tty2";
      TTYReset = "yes";
      TTYVHangup = "yes";
      Type = "idle";
    };
    aliases = [ "display-manager.service" ];
  };
}
