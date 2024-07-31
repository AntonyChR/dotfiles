vim_dir="$(pwd)/vim"

for file in $vim_dir/*; do
    echo "source $file" >> ~/.vimrc
done

ECHO_GREEN "Vim files linked to .vimrc"


