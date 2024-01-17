{ ... }:
{
  services.xserver.libinput = {
    enable = true;
    
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