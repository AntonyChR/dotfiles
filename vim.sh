vim_dir="$(pwd)/vim"

for file in $vim_dir/*; do
    echo "source $file" >> ~/.vimrc
done
ln -s "$(pwd)/vim/coc-settings.json" ~/.vim/coc-settings.json

echo "Vim files linked to .vimrc"
