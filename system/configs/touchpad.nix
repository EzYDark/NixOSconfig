{ ... }:
{
  services.xserver.libinput = {
    enable = true;

    # disabling mouse acceleration
    mouse = {
      accelProfile = "flat";
    };

    # disabling touchpad acceleration
    touchpad = {
      accelProfile = "flat";
    };
    
    # TODO: Not working - fix touchpad's scroll speed
    # touchpad = {
    #   accelProfile = "flat";
    #   accelSpeed = "0";
    #   additionalOptions = 
    #   ''
    #     Option "ScrollPixelDistance" "50"
    #   '';
    # };
  };
}