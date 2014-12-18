ln -sft ~/. ~/.environment_configs/.bash_aliases
ln -sft ~/. ~/.environment_configs/.mongorc.js
ln -sft ~/. ~/.environment_configs/.profile
ln -sft ~/. ~/.environment_configs/.screenrc
ln -sft ~/. ~/.environment_configs/.vimrc
ln -sft ~/.ssh/. ~/.environment_configs/config
chmod 644 ~/.environment_configs/config

if ! grep -Fxq "if [ -f ~/.bash_aliases ]; then" ~/.bashrc
then
    printf "\nif [ -f ~/.bash_aliases ]; then\n\t. ~/.bash_aliases\nfi\n" >>~/.bashrc
fi
