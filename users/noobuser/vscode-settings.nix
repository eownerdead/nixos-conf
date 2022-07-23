let
  fontSize = 16;
in
{
  "editor.bracketPairColorization.enabled" = true;
  "editor.guides.bracketPairs" = true;
  "editor.guides.bracketPairsHorizontal" = true;
  "editor.linkedEditing" = true;
  "editor.renderControlCharacters" = true;
  "editor.renderWhitespace" = "boundary";
  "editor.rulers" = [ 80 ];
  "editor.smoothScrolling" = true;
  "editor.stickyTabStops" = true;
  "editor.tabCompletion" = "on";
  "editor.wordWrap" = "on";
  "editor.wrappingIndent" = "indent";
  "editor.wrappingStrategy" = "advanced";

  "editor.cursorBlinking" = "phase";
  "editor.cursorSmoothCaretAnimation" = true;
  "editor.cursorSurroundingLines" = 5;

  "editor.fontFamily" = "'JetBrainsMono Nerd Font Mono',  'Noto Sans CJK JP'";
  "editor.fontSize" = fontSize;

  "editor.formatOnPaste" = true;
  "editor.formatOnType" = true;

  "diffEditor.wordWrap" = "on";

  "editor.minimap.enabled" = false;

  "editor.quickSuggestionsDelay" = 0;
  "editor.suggest.preview" = true;
  "editor.suggestSelection" = "first";
  "editor.wordBasedSuggestionsMode" = "allDocuments";

  # "files.autoGuessEncoding" = true; # Cannot find module 'jschardet'
  "files.autoSave" = "afterDelay";
  "files.eol" = "\n";
  "files.exclude" = {
    "**/.DS_Store" = false;
    "**/.git" = false;
    "**/.hg" = false;
    "**/.svn" = false;
    "**/CVS" = false;
    "**/Thumbs.db" = false;
  };
  "files.insertFinalNewline" = true;
  "files.trimFinalNewlines" = true;
  "files.trimTrailingWhitespace" = true;
  "files.watcherExclude" = {
    "**/build/**" = true;
    "**/result/**" = true;
    "**/target/**" = true;
    "**/.venv/**" = true;
  };
  "workbench.list.smoothScrolling" = true;
  "workbench.productIconTheme" = "material-product-icons";

  "workbench.colorTheme" = "Ayu Mirage";
  "workbench.iconTheme" = "material-icon-theme";
  "workbench.tree.indent" = 16;
  "workbench.tree.renderIndentGuides" = "always";
  "workbench.view.alwaysShowHeaderActions" = true;

  "workbench.editor.highlightModifiedTabs" = true;
  "workbench.editor.limit.enabled" = true;
  "workbench.editor.limit.value" = 4;
  "workbench.editor.titleScrollbarSizing" = "large";

  "workbench.settings.editor" = "json";
  "workbench.settings.enableNaturalLanguageSearch" = false;

  "window.commandCenter" = true;
  "window.menuBarVisibility" = "visible";
  "window.restoreWindows" = "one";
  "window.titleBarStyle" = "custom";

  "window.openFilesInNewWindow" = "default";

  "explorer.confirmDelete" = false;
  "explorer.copyRelativePathSeparator" = "/";

  "debug.console.fontSize" = fontSize;
  "debug.showBreakpointsInOverviewRuler" = true;
  "debug.toolBarLocation" = "docked";

  "terminal.integrated.cursorBlinking" = true;
  "terminal.integrated.enableBell" = true;
  "terminal.integrated.fontSize" = fontSize;

  "problems.sortOrder" = "position";

  "update.mode" = "none";
  "telemetry.telemetryLevel" = "off";

  "security.workspace.trust.enabled" = false;

  "better-comments.tags" = [
    {
      "backgroundColor" = "transparent";
      "bold" = false;
      "color" = "#3498DB";
      "italic" = false;
      "strikethrough" = false;
      "tag" = "?";
      "underline" = false;
    }
    {
      "backgroundColor" = "transparent";
      "bold" = false;
      "color" = "#474747";
      "italic" = false;
      "strikethrough" = true;
      "tag" = "//";
      "underline" = false;
    }
    {
      "backgroundColor" = "transparent";
      "bold" = true;
      "color" = "#FF8C00";
      "italic" = false;
      "strikethrough" = false;
      "tag" = "todo";
      "underline" = false;
    }
  ];

  "clangd.arguments" = [
    "-fallback-style=\"{DisableFormat =true}\""
    "-clang-tidy"
    "-pch-storage=memory"
    "-cross-file-rename"
    "-completion-parse=auto"
    "-log=info"
    "-enable-config"
  ];

  "commentTranslate.hover.string" = true;
  "commentTranslate.multiLineMerge" = true;
  "commentTranslate.targetLanguage" = "ja";

  "errorLens.gutterIconsEnabled" = true;
  "errorLens.statusBarColorsEnabled" = true;

  "git.enableSmartCommit" = true;

  "indentRainbow.colors" = [
    "rgba(255,255,59,0.3)"
    "rgba(76,176,80,0.3)"
    "rgba(244,67,54,0.3)"
    "rgba(33,150,243,0.3)"
  ];
  "indentRainbow.tabmixColor" = "rgba(213,0,0,0.6)";

  "nix.enableLanguageServer" = true;

  "python.languageServer" = "Jedi";
  "python.linting.flake8Enabled" = true;
  "python.linting.mypyEnabled" = true;
  "python.linting.pydocstyleEnabled" = true;
  "python.linting.pylintEnabled" = false;

  "rust-analyzer.checkOnSave.command" = "clippy";
  "rust-analyzer.experimental.procAttrMacros" = true;
  "rust-analyzer.inlayHints.enable" = false;
  "rust-analyzer.updates.askBeforeDownload" = true;

  "sourcetrail.startServerAtStartup" = true;

  "xml.codeLens.enabled" = true;
  "xml.validation.resolveExternalEntities" = true;

  "yaml.format.proseWrap" = "always";
  "yaml.format.singleQuote" = true;
}
