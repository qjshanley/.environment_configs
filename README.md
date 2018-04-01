environment_configs
===================

Configs for vim, ssh, screen, etc.

# Installs & Configuration

## Software
### Install Xcode [Download](https://developer.apple.com/download/)
Some applications require Xcode to compile correctly. Might as well get it out of the way.

### Install Google Chrome [Website](https://www.google.com/chrome/)
```
System Preferences -> General -> Default Web Browser: Google Chrome
```
### Install GitKraken [Website](https://www.gitkraken.com/)

### Install iTerm2 [Website](www.iterm2.com) | [Download](https://www.iterm2.com/downloads.html) | [Manual](https://www.iterm2.com/documentation.html)
```
iTerm2 -> Preferences -> Profiles -> Keys
```

Key Combination | Action
--------------- | ------
Shift Up | [1;2A
Ctrl Up | [1;5A
Ctrl Shift Up | [1;6A
Alt/Opt Up | [1;9A
Shift Down | [1;2B
Ctrl Down | [1;5B
Ctrl Shift Down | [1;6B
Alt/Opt Down | [1;9B
Shift Left | [1;2D
Ctrl Left | [1;5D
Ctrl Shift Left | [1;6D
Alt/Opt Left | [1;9D
Shift Right | [1;2C
Ctrl Right | [1;5C
Ctrl Shift Right | [1;6C
Alt/Opt Right | [1;9C

### Install GNU Bash v4.4.18 [Website](https://www.gnu.org/software/bash/) | [Mirror](http://ftpmirror.gnu.org/bash/) | [Download](http://ftpmirror.gnu.org/bash/bash-4.4.18.tar.gz) | [Manual](https://www.gnu.org/software/bash/manual/bash.html)
```
SOFTWARE="bash" && VERSION="4.4.18" && cd /tmp/
curl -O -J -L http://ftpmirror.gnu.org/${SOFTWARE}/${SOFTWARE}-${VERSION}.tar.gz
tar xzvf ${SOFTWARE}-${VERSION}.tar.gz
cd ${SOFTWARE}-${VERSION}
./configure --prefix=/usr/local && make && sudo make install
cd /tmp/ && rm -rf ${SOFTWARE}-${VERSION}* && cd
```
```
System Preferences -> Users & Groups -> Unlock -> Right Click Account -> Advanced Options -> Login Shell: /usr/local/bin/bash
```

### Install GNU Screen v4.6.2 [Website](https://www.gnu.org/software/screen/) | [Mirror](http://ftpmirror.gnu.org/screen/) | [Download](http://ftpmirror.gnu.org/screen/screen-4.6.2.tar.gz) | [Manual](https://www.gnu.org/software/screen/manual/screen.html)
```
SOFTWARE="screen" && VERSION="4.6.2" && cd /tmp/
curl -O -J -L http://ftpmirror.gnu.org/${SOFTWARE}/${SOFTWARE}-${VERSION}.tar.gz
tar xzvf ${SOFTWARE}-${VERSION}.tar.gz
cd ${SOFTWARE}-${VERSION}
./configure --prefix=/usr/local && make && sudo make install
cd /tmp/ && rm -rf ${SOFTWARE}-${VERSION}* && cd
```

### Install GNU Autoconf v2.69 [Website](https://www.gnu.org/software/autoconf/) | [Mirror](http://ftpmirror.gnu.org/autoconf/) | [Download](http://ftpmirror.gnu.org/autoconf/autoconf-2.69.tar.gz) | [Manual](https://www.gnu.org/software/autoconf/manual/autoconf.html)
```
SOFTWARE="autoconf" && VERSION="2.69" && cd /tmp/
curl -O -J -L http://ftpmirror.gnu.org/${SOFTWARE}/${SOFTWARE}-${VERSION}.tar.gz
tar xzvf ${SOFTWARE}-${VERSION}.tar.gz
cd ${SOFTWARE}-${VERSION}
./configure --prefix=/usr/local && make && sudo make install
cd /tmp/ && rm -rf ${SOFTWARE}-${VERSION}* && cd
```

### Install GNU Automake v1.16 [Website](https://www.gnu.org/software/automake/) | [Mirror](http://ftpmirror.gnu.org/automake/) | [Download](http://ftpmirror.gnu.org/automake/automake-1.16.tar.gz) | [Manual](https://www.gnu.org/software/automake/manual/automake.html)
```
SOFTWARE="automake" && VERSION="1.16" && cd /tmp/
curl -O -J -L http://ftpmirror.gnu.org/${SOFTWARE}/${SOFTWARE}-${VERSION}.tar.gz
tar xzvf ${SOFTWARE}-${VERSION}.tar.gz
cd ${SOFTWARE}-${VERSION}
./configure --prefix=/usr/local && make && sudo make install
cd /tmp/ && rm -rf ${SOFTWARE}-${VERSION}* && cd
```

### Install pkg-config v0.29.2 [Website](https://pkg-config.freedesktop.org/) | [Releases](https://pkg-config.freedesktop.org/releases/) | [Download](https://pkg-config.freedesktop.org/releases/pkg-config-0.29.2.tar.gz)
```
SOFTWARE="pkg-config" && VERSION="0.29.2" && cd /tmp/
curl -O -J -L https://pkg-config.freedesktop.org/releases/${SOFTWARE}-${VERSION}.tar.gz
tar xzvf ${SOFTWARE}-${VERSION}.tar.gz
cd ${SOFTWARE}-${VERSION}
./configure --prefix=/usr/local && make && sudo make install
cd /tmp/ && rm -rf ${SOFTWARE}-${VERSION}* && cd
```

### Install universal-ctags [Website](https://ctags.io/) | [Download](https://github.com/universal-ctags/ctags) | [Manual](http://docs.ctags.io/en/latest/)
```
mkdir -p ~/code/github && cd ~/code/github
git clone https://github.com/universal-ctags/ctags.git
cd ctags && ./autogen.sh
./configure --prefix=/usr/local && make && sudo make install
```

### Install Vim [Website](https://www.vim.org/) | [Download](https://www.vim.org/download.php) | [Manual](http://vimdoc.sourceforge.net/htmldoc/help.html)
```
mkdir -p ~/code/github && cd ~/code/github
git clone https://github.com/vim/vim.git
cd vim/src
./configure --prefix=/usr/local && make && sudo make install
```

### Install karibener [Website](https://pqrs.org/osx/karabiner/) | [Manual](https://pqrs.org/osx/karabiner/document.html)
Setup key mappings in Karabiner-Elements Preferences

From Key | To Key
-------- | ------
caps_lock | escape
escape | caps_lock
right_command | right_control

### System Keyboard
```
System Preferences -> Keyboard
```
Uncheck autocorrections and smart quotes

Replace | With
------- | ----
`&&shrug` | `¯\_(ツ)_/¯`

### System Sound
Disable the annoying alert beep thing.
```
System Preferences -> Sound -> Sound Effects -> Alert volume: off
```

# Useful Links
GNU Manuals https://www.gnu.org/manual/
