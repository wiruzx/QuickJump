![QuickJump](logo.png)

[AceJump](http://www.emacswiki.org/emacs/AceJump)-like plugin for Xcode

QuickJump allows you navigate to any visible position in the editor.

Just Toggle QuickJump, type a character and then type the matching character

See demo:

---

![Demo gif](http://i.imgur.com/O7GSm4w.gif)

---

## Features

- **Word mode**  
Jump to first char of the word
- **Char mode**  
Jump to any char on the screen
- **Line mode**  
Jump to begining of any line on the screen

## Version 1.1

Please note, that in version **1.0** there was only one mode - `char` mode, so title for shortcut was `Toggle QuickJump` in keyboard settings

In **1.1** I've also added `line` and `word` modes, so titles for shortcutes have changed.
If you'd like to continue using only `char` you need to go to the keyboard settings and change `Toggle QuickJump` to `QuickJump: char mode` and that's it.
But you also may add shortcutes for other modes

## Installation

### Alcatraz

Available through [Alcatraz](http://alcatraz.io)

### Manual

1. Clone the project
2. Open `QuickJump.xcodeproj` file
3. Build project and restart Xcode

### Set shortcut

Go to `System Preferences > Keyboard > Shortcuts > App shortcuts` and press the + button

Then chose Xcode and change menu title to:
- `QuickJump: char mode` to add the char mode shortcut
- `QuickJump: word mode` to add the word mode shortcut
- `QuickJump: line mode` to add the line mode shortcut

![System preferences](http://i.imgur.com/egusoRa.png)

## License

QuickJump is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
