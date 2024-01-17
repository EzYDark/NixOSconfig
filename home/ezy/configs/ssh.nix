{ pkgs, ... }:
{
  programs.ssh = {
    enable = true;
    package = pkgs.openssh;
    compression = true;
    matchBlocks = {
      # Github 
      "github.com" = {
        user = "git";
        hostname = "github.com";
        indentityFile = "~/.ssh/ezKey";
      };
    };
  };

  programs.ssh-agent.enable = true;
}