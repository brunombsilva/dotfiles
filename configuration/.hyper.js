module.exports = {
    config: {
      updateChannel: 'stable',

      fontSize: 12,
      fontFamily: 'Menlo, "DejaVu Sans Mono", Consolas, "Lucida Console", monospace',

      cursorColor: 'rgba(248,28,229,0.8)',
      cursorShape: 'BLOCK',
      cursorBlink: true,

      showWindowControls: true,

      //shell: 'C:\\Windows\\System32\\wsl.exe',
      shellArgs: [],
      env: {},

      bell: 'SOUND',

      copyOnSelect: false,

      quickEdit: false
    },

    plugins: [
      //'hyperline',
      //'hyper-statusline'
      'hyper-match',
      'hyper-snazzy'
    ],

    keymaps: {
      // 'window:devtools': 'cmd+alt+o',
    }
  };