# Zhiyin-zsh-theme

Inspired by [Zhiyin](https://github.com/W-Mai/BuZhiYin), [emoji-ps1](https://github.com/bigomega/emoji-ps1) and built on [ys-zsh-theme](https://github.com/ohmyzsh/ohmyzsh/blob/master/themes/ys.zsh-theme)

![](./demo.gif)

## Installation

1. Install `Zhiyin.otf` font, select it in your iTerm2 (under Non-ASCII font) and add it to your VS Code's font family.
2. `cp zhiyin.zsh-theme ~/.oh-my-zsh/themes/`, or just add this [code snippet](https://github.com/AmyangXYZ/zhiyin-zsh-theme/blob/9a37506a196b6457eff0c0aa65257db25f5026de/zhiyin.zsh-theme#L63-L117) to your favourite zsh theme.
   
3. Add `psanimate 0.08` to your `.zshrc`. 0.08 is the interval between frames, in seconds.

## Zhiyin Sing 

Sing upon ERR signal. Enable by adding below to zhiyin.zsh-theme, and copy `niganma.mp3` somewhere you like.

```shell
function zhiyin_sing {
    afplay ~/Downloads/niganma.mp3
}

trap zhiyin_sing ERR
```