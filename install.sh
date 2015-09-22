IGNORED_FILES=(
  tags
  $0
  com.googlecode.iterm2.plist
)

for file in *
do
    link_from=$(pwd)/$file
    if [[ "${IGNORED_FILES[@]}" =~ "${file} " || "${IGNORED_FILES[${#IGNORED_FILES[@]}-1]}" == "${file}" ]]; then
        echo "Ignoring $file..."
    else
        link_to=~/.$file
        if [[ "$file" == "flake8" ]]; then
            link_to=~/.config/flake8
        elif [[ "$file" == "sshconfig" ]]; then
            link_to=~/.ssh/config
        fi

        if [ ! -L $link_to ]; then
            echo "Linking $link_from to $link_to..."
            ln -s $link_from $link_to
        fi
    fi
done
