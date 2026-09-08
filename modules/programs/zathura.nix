{...}:
{
    programs.zathura = {
        enable = true;
        options = {
            synctex = true;
            synctex-editor-command = "nvim --remote-silent +%{line} %{input}";
            selection-clipboard = "clipboard";
        };
    };
}
