ln -is config.toml ~/.cargo/config.toml
ln -is .tmux.conf ~/.tmux.conf
ln -is .gitconfig ~/.gitconfig
ln -is .zshrc ~/.zshrc

if [ ! -L "$HOME/.config/alacritty" ] ; then
    ln -s alacritty ~/.config/alacritty
fi

if [ ! -L "$HOME/.config/nvim" ] ; then
    ln -s nvim ~/.config/nvim
fi
