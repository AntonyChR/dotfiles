vim_dir="$(pwd)/vim"

for file in $vim_dir/*; do
    echo "source $file" >> ~/.vimrc
done

echo "Vim files linked to .vimrc"
