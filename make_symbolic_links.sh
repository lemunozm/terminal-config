ln -is $PWD/config.toml $HOME/.cargo/config.toml
ln -is $PWD/.tmux.conf $HOME/.tmux.conf
ln -is $PWD/.gitconfig $HOME/.gitconfig
ln -is $PWD/.zshrc $HOME/.zshrc
ln -is $PWD/.p10k.zsh $HOME/.p10k.zsh

if [ ! -L "$HOME/.config/alacritty" ] ; then
    ln -s $PWD/alacritty $HOME/.config/alacritty
fi

if [ ! -L "$HOME/.config/nvim" ] ; then
    ln -s $PWD/nvim $HOME/.config/nvim
fi
