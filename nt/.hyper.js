// .. todo:: Why isn't hyper parsing the Escape key anymore?? That's concerning...
// Future versions of Hyper may add additional config options,
// which will not automatically be merged into this file.
// See https://hyper.is#cfg for all currently supported options.

module.exports = {
  config: {
    // choose either `'stable'` for receiving highly polished,
    // or `'canary'` for less polished but more frequent updates
    updateChannel: "canary",

    // default font size in pixels for all tabs
    fontSize: 17,

    // font family with optional fallbacks
    fontFamily:
      'Hack, "DejaVu Sans Mono", Consolas, "Lucida Console", monospace',

    // default font weight: 'normal' or 'bold'
    fontWeight: "normal",

    // font weight for bold characters: 'normal' or 'bold'
    fontWeightBold: "bold",

    // line height as a relative unit
    lineHeight: 1,

    // letter spacing as a relative unit
    letterSpacing: 0,

    // terminal cursor background color and opacity (hex, rgb, hsl, hsv, hwb or cmyk)
    cursorColor: "rgba(248,28,229,0.8)",

    // terminal text color under BLOCK cursor
    cursorAccentColor: "#000",

    // `'BEAM'` for |, `'UNDERLINE'` for _, `'BLOCK'` for █
    cursorShape: "BLOCK",

    // set to `true` (without backticks and without quotes) for blinking cursor
    cursorBlink: false,

    // color of the text
    foregroundColor: "#fff",

    // terminal background color
    // opacity is only supported on macOS
    backgroundColor: "#000",

    // terminal selection color
    selectionColor: "rgba(248,28,229,0.3)",

    // border color (window, tabs)
    borderColor: "#333",

    // custom CSS to embed in the main window
    css: "",

    // custom CSS to embed in the terminal window
    termCSS: "",

    // if you're using a Linux setup which show native menus, set to false
    // default: `true` on Linux, `true` on Windows, ignored on macOS
    showHamburgerMenu: "false",

    // set to `false` (without backticks and without quotes) if you want to hide the minimize, maximize and close buttons
    // additionally, set to `'left'` if you want them on the left, like in Ubuntu
    // default: `true` (without backticks and without quotes) on Windows and Linux, ignored on macOS
    showWindowControls: "",

    // custom padding (CSS format, i.e.: `top right bottom left`)
    padding: "12px 14px",

    // the full list. if you're going to provide the full color palette,
    // including the 6 x 6 color cubes and the grayscale map, just provide
    // an array here instead of a color map object
    colors: {
      // black: '#000000',
      black: "#1D2021",
      // red: '#C51E14',
      red: "#F73028",
      green: "#1DC121",
      // yellow: '#C7C329',
      yellow: "#F7B125",
      // blue: '#0A2FC4',
      // that actually doesn't look very good at all
      blue: "#83A598",
      magenta: "#C839C5",
      cyan: "#20C5C6",
      // white: '#C7C7C7',
      white: "#FAEFBB",
      lightBlack: "#928374",
      // lightBlack: '#686868',
      lightRed: "#FD6F6B",
      lightGreen: "#67F86F",
      lightYellow: "#FFFA72",
      lightBlue: "#6A76FB",
      lightMagenta: "#FD7CFC",
      lightCyan: "#68FDFE",
      lightWhite: "#FFFFFF"
    },

    // the shell to run when spawning a new session (i.e. /usr/local/bin/fish)
    // if left empty, your system's login shell will be used by default
    //
    // Windows
    // - Make sure to use a full path if the binary name doesn't work
    // - Remove `--login` in shellArgs
    //
    // Bash on Windows
    // - Example: `C:\\Windows\\System32\\bash.exe`
    //
    // ugh the temptation to do that. But i won't
    //
    // PowerShell on Windows
    // - Example: `C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe`
    // shell: "C:\\pwsh\\7-preview\\pwsh.exe",
    // shell: 'cmd.exe',
    // here's a wild one for ya
    // shell: "C:\\tools\\Cmder\\vendor\\conemu-maximus5\\ConEmuC.exe -Run",
    // Doesn't work.
    // shell: "C:\\tools\\Cmder\\vendor\\conemu-maximus5\\ConEmu\\ConEmuC64.exe",
    shell: "C:\\pwsh\\7-preview\\pwsh.exe",

    shellArgs: [
      "-ExecutionPolicy",
      "Bypass",
      "-NoLogo",
      "-NoExit",
      "-Command",
      "Invoke-Expression C:\\tools\\Cmder\\vendor\\profile.ps1"
    ],
    // for setting shell arguments (i.e. for using interactive shellArgs: `['-i']`)
    // by default `['--login']` will be used

    // if you want to use cmd these are some good shell args
    //shellArgs: ['/k', '[cmder_root]\\vendor\\init.bat'],

    // shell: ['ConEmu']
    // shellArgs: [
    //   '/C',
    //   'pwsh',
    //   '-Command',
    //   'Set-Location C:\\Users\\faris',
    //   '-ArgumentList',
    //   '-NoExit',
    //   '-NoLogo',
    //   '-new_console:z'
    //   // 'Invoke-Expression [CMDER_ROOT]]\\vendor\\profile.ps1'
    // ],

    // shell: 'C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe',
    //  shellArgs: ['-ExecutionPolicy', 'Bypass', '-NoLogo', '-NoProfile', '-NoExit', '-Command', 'Invoke-Expression [CMDER_ROOT]\\vendor\\profile.ps1'],
    //  if you want a custom dir to start cmd in:
    // shellArgs: ['/k', 'cd /d D:\\Custom^ Folder & %CMDER_ROOT%\\vendor\\init.bat'],
    // and for powershell
    // shellArgs: ['-NoExit', '-Command', 'Set-Location C:\\projects'],
    // set the tabname
    // shellArgs: ['/k', 'title Cmder & %CMDER_ROOT%\\vendor\\init.bat'],

    // for environment variables
    // unset cmder_root it's fucking up pipenv
    env: {
      "TERM": "cygwin",
      "CMDER_ROOT": ""
    },
    // env: {},

    // set to `false` for no bell
    bell: "false",

    // if `true` (without backticks and without quotes), selected text will automatically be copied to the clipboard
    copyOnSelect: true,

    // if `true` (without backticks and without quotes), hyper will be set as the default protocol client for SSH
    defaultSSHApp: true,

    // if `true` (without backticks and without quotes), on right click selected text will be copied or pasted if no
    // selection is present (`true` by default on Windows and disables the context menu feature)
    quickEdit: false,

    // choose either `'vertical'`, if you want the column mode when Option key is hold during selection (Default)
    // or `'force'`, if you want to force selection regardless of whether the terminal is in mouse events mode
    // (inside tmux or vim with mouse mode enabled for example).
    macOptionSelectionMode: "vertical",

    // URL to custom bell
    // bellSoundURL: 'http://example.com/bell.mp3',

    // Whether to use the WebGL renderer. Set it to false to use canvas-based
    // rendering (slower, but supports transparent backgrounds)
    webGLRenderer: true,

    // for advanced config flags please refer to https://hyper.is/#cfg
    gruvboxTheme: {
      style: "dark", // or 'light'
      contrast: "hard" // or 'soft', 'hard'
    }

    // holy shit it worked
  },

  hypercwd: {
    initialWorkingDirectory: "C:\\Users\\faris"
  },
  // a list of plugins to fetch and install from npm
  // format: [@org/]project[#version]
  // examples:
  //   `hyperpower`
  //   `@company/project`
  //   `project#1.0.1`
  plugins: ["hyperpower", "hyperterm-gruvbox", "hyperlinks", "hypercwd"],

  // in development, you can create a directory under
  // `~/.hyper_plugins/local/` and include it here
  // to load it and avoid it being `npm install`ed
  localPlugins: ["hyper-init", "hypertabs"],

  keymaps: {
    // Example
    // 'window:devtools': 'cmd+alt+o',
    // all the linux ones
    "window:devtools": "ctrl+shift+i",
    // 'window:reload': 'ctrl+shift+r',
    // 'window:reload': 'Cmd+Alt+r',
    "window:reloadFull": "ctrl+shift+f5",
    "window:preferences": "ctrl+,",
    // NO DON'T DO THIS
    // 'window:hamburgerMenu': 'alt',
    "window:hamburgerMenu": "Ctrl+Alt+F1+F2+F3+F4+F5+Cmd+Del",
    "zoom:reset": "ctrl+0",
    "zoom:in": "ctrl+=",
    "zoom:out": "ctrl+-",
    "window:new": "ctrl+shift+n",
    "window:minimize": "ctrl+shift+m",
    "window:zoom": "ctrl+shift+alt+m",
    "window:toggleFullScreen": "f11",
    "tab:new": "ctrl+shift+t",
    "tab:next": [
      "ctrl+shift+]",
      // "ctrl+shift+right",
      // "ctrl+alt+right"
      // 'ctrl+tab'
    ],
    "tab:prev": [
      "ctrl+shift+[",
      // "ctrl+shift+left",
      // "ctrl+alt+left"
      // 'ctrl+shift+tab'
    ],
    // wth?
    // 'tab:jump:prefix': 'ctrl',
    "pane:next": "ctrl+pageup",
    "pane:prev": "ctrl+pagedown",
    "editor:undo": "ctrl+shift+z",
    "editor:redo": "ctrl+shift+y",
    "editor:cut": "ctrl+shift+x",
    "editor:copy": "ctrl+shift+c",
    "editor:paste": "ctrl+shift+v",
    "editor:selectAll": "ctrl+shift+a",
    "editor:movePreviousWord": [
      "ctrl+left"
      // 'Alt+b'
    ],
    "editor:moveNextWord": [
      "ctrl+right"
      // 'Alt+f'
    ],
    "editor:moveBeginningLine": [
      "home"
      //   'Ctrl-a'
    ],
    "editor:moveEndLine": [
      "end"
      // 'Ctrl-e'
    ],
    "editor:deletePreviousWord": [
      "ctrl+backspace"
      // 'Ctrl-w'
    ],
    "editor:deleteNextWord": [
      "ctrl+del"
      //  'Meta+d'
    ],
    "editor:deleteBeginningLine": [
      "ctrl+home"
      // 'Ctrl+u'
    ],
    "editor:deleteEndLine": [
      "ctrl+end"
      // 'Ctrl+k'
    ]
    // 'editor:clearBuffer': 'ctrl+shift+l',
    // 'editor:break': 'ctrl+c',
    // 'plugins:update': 'ctrl+shift+u'
  }
};
