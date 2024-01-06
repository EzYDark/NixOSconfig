{ ... }:

{
  sound.enable = true;
  security.rtkit.enable = true; # Realtime privileges for PipeWire
  services.pipewire = {
    enable = true;
    alsa.enable = true; # Enable the ALSA support
    alsa.support32Bit = true; # Optional: 32-bit application support
    pulse.enable = true; # PulseAudio emulation using PipeWire
    jack.enable = true; # JACK support using PipeWire
  };

  hardware.pulseaudio.enable = false;
}
