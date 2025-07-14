{...}: {
  programs.zed-editor.userSettings = {
    debugger = {
      dock = "left";
    };
    icon_theme = "Zed (Default)";
    outline_panel = {
      dock = "left";
    };
    git_panel = {
      dock = "right";
    };
    project_panel = {
      dock = "right";
    };
    edit_predictions = {
      enabled_in_text_threads = false;
      mode = "subtle";
    };
    always_treat_brackets_as_autoclosed = true;
    ui_font_size = 16.5;
    ui_font_family = "Zed Plex Mono";
    agent = {
      profiles = {
        ask = {
          name = "Ask";
          tools = {
            contents = true;
            diagnostics = true;
            fetch = true;
            list_directory = true;
            now = true;
            find_path = true;
            read_file = true;
            open = true;
            grep = true;
            thinking = true;
            web_search = true;
            terminal = true;
          };
          enable_all_context_servers = false;
          context_servers = {};
        };
      };
      play_sound_when_agent_done = false;
      always_allow_tool_actions = true;
      inline_assistant_model = {
        provider = "google";
        model = "gemini-2.5-flash";
      };
      dock = "left";
      default_profile = "ask";
      default_model = {
        provider = "google";
        model = "gemini-2.5-pro";
      };
      version = 2;
      button = true;
    };
    features = {
      edit_prediction_provider = "zed";
      copilot = false;
    };
    telemetry = {
      diagnostics = false;
      metrics = false;
    };
    vim_mode = false;
    base_keymap = "VSCode";
    theme = "Catppuccin Macchiato - No Italics";
    buffer_font_size = 16.42;
    cursor_blink = false;
    lsp = {
      rust-analyzer = {
        initialization_options = {
          checkOnSave = true;
        };
        procMacro = {
          ignored = ["server"];
        };
      };
      ruff = {
        initialization_options = {
          settings = {
            lineLength = 80;
            lint = {
              extendSelect = [
                "I"
                "RUF"
                "E"
                "W"
                "F"
                "FAST"
                "NPY"
                "PL"
              ];
            };
          };
        };
      };
    };
    inlay_hints = {
      enabled = true;
      show_type_hints = true;
      show_parameter_hints = true;
      show_other_hints = true;
    };
    notification_panel = {
      button = false;
    };
    chat_panel = {
      button = "never";
    };
    collaboration_panel = {
      button = false;
    };
    terminal = {
      shell = "system";
      button = false;
      env = {
        EDITOR = "zed --wait";
      };
    };
    languages = {
      Python = {
        language_servers = [
          "pyright"
          "ruff"
        ];
        format_on_save = "on";
        formatter = [
          {
            code_actions = {
              source.organizeImports.ruff = true;
              source.fixAll.ruff = true;
            };
          }
          {
            language_server = {
              name = "ruff";
            };
          }
        ];
      };
    };
  };
}
