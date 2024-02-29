{ pkgs, lib, ... }: {
  environment.systemPackages = with pkgs;
    [ lemurs ];

  systemd.services."display-manager" = {
    enable = lib.mkForce false;
  };

  systemd.services."lemurs" = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
    after = [
      "systemd-user-sessions.service"
      "plymouth-quit-wait.service"
      "getty@tty2.service"
    ];
    serviceConfig = {
      User = "root";
      Group = "root";
      # Restart = "on-failure";
      ExecStart = "${pkgs.lemurs}/bin/lemurs";
      StandardInput = "tty";
      TTYPath = "/dev/tty2";
      TTYReset = "yes";
      TTYVHangup = "yes";
      Type = "idle";
    };
    # aliases = [ "display-manager.service" ];
  };

  security.pam.services.lemurs = {
    # name = "lemurs";
    text = ''
      #%PAM-1.0
      auth        include    login
      account     include    login
      session     include    login
      password    include    login
    '';
  };
}
