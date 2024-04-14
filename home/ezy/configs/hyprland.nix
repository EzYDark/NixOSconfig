{ pkgs, ... }: {
  home.file."hypr_reset" = {
    enable = true;
    executable = true;
    text = ''
      #!/bin/sh
      sleep 4
      killall .xdg-desktop-portal
      ${pkgs.xdg-desktop-portal-hyprland}/libexec/xdg-desktop-portal-hyprland &
      sleep 4
      ${pkgs.xdg-desktop-portal-gtk}/libexec/xdg-desktop-portal-gtk &
      sleep 4
      ${pkgs.xdg-desktop-portal}/libexec/xdg-desktop-portal &
    '';
  };

  wayland.windowManager.hyprland = {
    enable = true;
    # enableNvidiaPatches = true;
    systemd.enable = true;
    # plugins = [
    #   inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
    #   "/absolute/path/to/plugin.so"
    # ];
    settings = {
      monitor = [
        "HDMI-A-1, 1920x1080@120, 0x0, 1"
        "eDP-1, highres, auto, 1.5"
        # "eDP-1, disable"
      ];

      workspace = [ "HDMI-A-1, 1" "eDP-1, 2" ];

      # Execute your favorite apps at launch
      exec-once = [
        "waybar & hyprpaper"
        "mako"
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
        "dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user import-environment DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "/home/ezy/hypr_reset"
        "wl-paste --watch cliphist store"
      ];

      exec = [
        "systemctl --user import-environment PATH && systemctl --user restart xdg-desktop-portal.service"
      ];

      env = [
        "XDG_CURRENT_DESKTOP, Hyprland"
        "XDG_SESSION_TYPE, wayland"
        "XDG_SESSION_DESKTOP, Hyprland"
        "GDK_BACKEND, wayland,x11"
        "QT_QPA_PLATFORM, wayland;xcb"
        "SDL_VIDEODRIVER, wayland"
        "CLUTTER_BACKEND, wayland"
        "QT_AUTO_SCREEN_SCALE_FACTOR, 1"
        "NIXOS_OZONE_WL, 1"
        "GTK_USE_PORTAL, 1"
        "SSH_ASKPASS, /home/ezy/askpass-rofi"
        "GIT_ASKPASS, /home/ezy/askpass-rofi"
        "SSH_AUTH_SOCK, /run/user/1000/ssh-agent"
        "POLKIT_AUTH_AGENT, ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
        "RUSTC_WRAPPER, ${pkgs.sccache}/bin/sccache"

        "PATH, $HOME/.cargo/bin:$PATH"

        "SHELL, ${pkgs.fish}/bin/fish"
        "EDITOR, ${pkgs.vscode-fhs}/bin/code"
        "VISUAL, ${pkgs.vscode-fhs}/bin/code"
        "BROWSER, ${pkgs.vivaldi}/bin/vivaldi"
        "TERM, xterm-256color"
        "TERMINAL, alacritty"
      ];

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        focus_on_activate = true;
        new_window_takes_over_fullscreen =
          1; # 0 = disabled; 1 = focuses new window and fullscreens it; 2 = focuses new window without fullscreening it
        vfr = false;
        vrr = false;
      };

      input = {
        kb_layout = "cz";
        # kb_options = "ctrl:swap_lalt_lctl";

        follow_mouse = 1;

        touchpad = {
          disable_while_typing = true;
          natural_scroll = true;
          scroll_factor = 0.25;
        };

        sensitivity = 0;
        accel_profile = "flat";
      };

      "device:gxtp7863:00-27c6:01e0-touchpad" = {
        accel_profile = "adaptive";
        sensitivity = -0.25;
      };

      general = {
        gaps_in = 3;
        gaps_out = 7;
        border_size = 2;
        "col.active_border" =
          "rgb(282828) rgb(427b58) 90deg";
        "col.inactive_border" = "rgb(1d2021)";

        layout = "dwindle";
      };

      group = {
        "col.border_inactive" = "rgba(282a36dd)";
        "col.border_active" =
          "rgb(bd93f9) rgb(44475a) 90deg";
      };

      decoration = {
        rounding = 2;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };

        "col.shadow" = "rgba(1E202966)";
        drop_shadow = true;
        shadow_range = 60;
        shadow_offset = "1 2";
        shadow_render_power = 3;
        shadow_scale = 0.97;
      };

      bezier = "overshot,0.7,0.6,0.1,1.1";

      animations = {
        enabled = true;
        animation = [
          "windows,1,4,overshot,slide"
          "border,1,14,default"
          "fade,1,4,default"
          "workspaces,1,4,overshot,slide"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = { new_is_master = true; };

      gestures = { workspace_swipe = false; };

      # https://github.com/xkbcommon/libxkbcommon/blob/master/include/xkbcommon/xkbcommon-keysyms.h
      # https://gist.github.com/rickyzhang82/8581a762c9f9fc6ddb8390872552c250
      "$mainMod" = "SUPER";

      bind = [
        "Ctrl Shift Alt, F12, exec, hyprctl dispatch cyclenext prev"
        "Ctrl Shift Alt, F11, exec, hyprctl dispatch layoutmsg cycleprev"

        "$mainMod, Tab, layoutmsg, cycleprev"

        "$mainMod Shift, F, fullscreen, 1"
        "$mainMod Ctrl, F, fakefullscreen"

        "$mainMod, return, exec, alacritty"
        "$mainMod, C, killactive,"
        "$mainMod, E, exec, thunar"
        "$mainMod, F, exec, vivaldi"
        "$mainMod, R, exec, rofi -show drun -show-icons"
        "$mainMod, J, togglesplit,"
        "$mainMod, L, togglefloating"

        # Clipboard manager
        "$mainMod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"

        # Screenshot tool
        ", Print, exec, /home/ezy/satty-screenshot"

        # Brightness Controls
        ", XF86MonBrightnessUp, exec, brightnessctl s 5%+"
        ", XF86MonBrightnessDown, exec, brightnessctl s 5%-"

        # Volume Controls 
        ", XF86AudioMute, exec, pamixer --toggle-mute toggle"
        ", XF86AudioRaiseVolume, exec, pamixer -i 5"
        ", XF86AudioLowerVolume, exec, pamixer -d 5"
        ", XF86AudioMicMute, exec, pamixer --default-source -t"

        # Move focus with mainMod + arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, F1, workspace, 1"
        "$mainMod, F2, workspace, 2"
        "$mainMod, F3, workspace, 3"
        "$mainMod, F4, workspace, 4"
        "$mainMod, F5, workspace, 5"
        "$mainMod, F6, workspace, 6"
        "$mainMod, F7, workspace, 7"
        "$mainMod, F8, workspace, 8"
        "$mainMod, F9, workspace, 9"
        "$mainMod, F10, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, F1, movetoworkspace, 1"
        "$mainMod SHIFT, F2, movetoworkspace, 2"
        "$mainMod SHIFT, F3, movetoworkspace, 3"
        "$mainMod SHIFT, F4, movetoworkspace, 4"
        "$mainMod SHIFT, F5, movetoworkspace, 5"
        "$mainMod SHIFT, F6, movetoworkspace, 6"
        "$mainMod SHIFT, F7, movetoworkspace, 7"
        "$mainMod SHIFT, F8, movetoworkspace, 8"
        "$mainMod SHIFT, F9, movetoworkspace, 9"
        "$mainMod SHIFT, F0, movetoworkspace, 10"

        "$mainMod, mouse:275, cyclenext"
        "$mainMod, mouse:276, cyclenext, prev"
      ];

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}
