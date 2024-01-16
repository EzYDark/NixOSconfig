{ ... }:
{
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    enableBashCompletion = true;
    autosuggestions.enable = true;
    
    ohMyZsh = {
      enable = true;
      # theme = "";
      # plugins = [];
    };
  };
}