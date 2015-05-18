ln -sft ~/. ~/.environment_configs/.bash_aliases
ln -sft ~/. ~/.environment_configs/.mongorc.js
ln -sft ~/. ~/.environment_configs/.screenrc
ln -sft ~/. ~/.environment_configs/.vimrc

if ! grep -Fxq "if [ -f ~/.bash_aliases ]; then" ~/.bashrc
then
    printf "# User specific aliases and functions\nif [ -f ~/.bash_aliases ]; then\n\t. ~/.bash_aliases\nfi\n" >>~/.bashrc
fi
