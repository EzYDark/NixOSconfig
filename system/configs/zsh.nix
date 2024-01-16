{ ... }:
{
  programs.zsh = {
    enable = true;
    syntaxHighlighting = true;
    enableBashCompletion = true;
    autosuggestions.enable = true;
    
    ohMyZsh = {
      enable = true;
      # theme = "";
      # plugins = [];
    };
  };
}