<!-- panvimdoc-ignore-start -->

<img src="https://github.com/formadi/dotfiles/raw/main/.config/nvim/doc/screenshot2.png"/>


nvim 0.10.0 이상에서 확인
- 심플한 구조,
- plugin 관리를 용이하게 하기 위해 개별 파일로 구성 (Install, config, keymap).
- [cappuccin(Mocha)](https://github.com/catppuccin/nvim) 외 다수의 colors scheme 적용.
- 배경은 모두 투명처리 (배경색은 터미널 배경색)
- Normal/Visual 모드에서 ;(semi-colon) 키인으로 Command 모드 변경.
- 저장 시, 자동으로 Trailing whitespace 제거.
- DAP : rust, python, objc, swift, c, c++
- note-taking : Neorg
- Zen Mode : [No-pain-pain.nvim](https://github.com/shortcuts/no-neck-pain.nvim) + [zen-mode.nvim](https://github.com/folke/zen-mode.nvim)
- leader 키 : space

------

### Themes

catppuccin
<img src="https://github.com/formadi/dotfiles/blob/main/.config/nvim/doc/catppuccin.png"/>

<details>
  <summary>everforest</summary>
  <img src="https://github.com/formadi/dotfiles/blob/main/.config/nvim/doc/everforest.png"/>
</details>
<details>
  <summary>iceberg</summary>
  <img src="https://github.com/formadi/dotfiles/blob/main/.config/nvim/doc/iceberg.png"/>
</details>
<details>
  <summary>nord</summary>
  <img src="https://github.com/formadi/dotfiles/blob/main/.config/nvim/doc/nord.png"/>
</details>
<details>
  <summary>vscode</summary>
  <img src="https://github.com/formadi/dotfiles/blob/main/.config/nvim/doc/vscode.png"/>
</details>

------

### DAP
<details>
  <summary>rust</summary>
  <img src="https://github.com/formadi/dotfiles/blob/main/.config/nvim/doc/rust-dap.png"/>
</details>
<details>
  <summary>python</summary>
  <img src="https://github.com/formadi/dotfiles/blob/main/.config/nvim/doc/python-dap.png"/>
</details>
<details>
  <summary>swift</summary>
  <img src="https://github.com/formadi/dotfiles/blob/main/.config/nvim/doc/swift-dap.png"/>
</details>

------
### kitty, zen-mode, neorg, image(highly experimental plugin)
<details>
  <summary>screenshot</summary>
  <img src="https://github.com/formadi/dotfiles/blob/main/.config/nvim/doc/kitty3.png"/>
</details>


### Plugins
- 별도의 comment가 없는 것은 기본 키맵을 사용하는 것임.
```
aerial 키맵
<leader>at : aerial toggle (right)
<leader>af : aerial toggle (float)
```
```
harpoon 키맵
<leader>ha : append
<leader>hr : remove
<leader>hc : remove all (clear)
<leader>hn : next
<leader>hp : previous
<leader>hq : quick menu
```
```
lazygit 키맵
<leader>l : LazyGit
```
```
nvim-lint 키맵
<leader>ll : Trigger linting for current file
```
```
neo-tree 키맵
<leader>ef  : float
<leader>el  : left
<leader>er  : right
<leader>ee  : toggle
<leader>nc  : focus
<leader>eb  : current buffer's directory
```
```
neorg 키맵
<leader>np  : Neorg (popup)
<leader>njt : Journal Today
<leader>njy : Journal Yesterday
<leader>njn : Journal Tomorrow
<leader>nc  : toggle concealer
<leader>nd  : insert date
<leader>nt  : show toc
<leader>ni  : goto index
<leader>nl  : looking-glass
<leader>nn  : new note
<leader>nm  : change workspace
```
[3rd/image.nvim](https://github.com/3rd/image.nvim)
```
- kitty terminal emuator에서 사용가능, neorg에 image를 삽입할 수 있는 plug-in

# 필수 설치
brew install imagemagick luarocks lua51

# luarocks을 이용한 magick 설치
luarocks --local --lua-version=5.1 install magick

# 위의 magick 설치까지만 하면 정상적으로 동작해야 함.
# 만일 magick을 설치했음에도, 설치 하지 않았다는 오류가 발생한다면.. 아래의 dylib 설정을 시도 해 본다.
# dylib 설정
# imagemagick 버전에 따라 폴더명과 libMagicWand-****.dylib 파일명은 다를 수 있음
sudo ln -sv /opt/homebrew/Cellar/imagemagick/7.1.1-23/lib/libMagickWand-7.Q16HDRI.dylib /usr/local/lib/libMagickWand-7.Q16HDRI.dylib

# tmux를 사용하는 경우
# .tmux.conf 파일에 아래의 내용을 추가
set -gq allow-passthrough on
# .tmux.conf 파일을 저장한 후, shell 에서 tmux source ~/.tmux.conf 를 실행
```
```
zen mode 키맵
<leader>zz : toggle default zen mode (3 buffers)
<leader>zt : toggle deep zen mode (single buffer)
<leader>zr : resize zen-window to 120
<leader>zi : increase zen-window size
<leader>zd : decrease zen-window size
```
```
Xcodebuild 키맵
<leader>xp : show popup menu
<leader>xb : build
<leader>xc : show config
<leader>xd : debug
<leader>xl : select project
<leader>xr : run
<leader>xs : setup
```
