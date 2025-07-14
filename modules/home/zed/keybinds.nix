{...}: {
  programs.zed-editor.userKeymaps = [
    {
      context = "Workspace";
      bindings = {};
    }
    {
      context = "Editor && vim_mode == insert && !menu";
      bindings = {};
    }
  ];
}
