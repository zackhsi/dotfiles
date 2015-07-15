IGNORED_FILES=(tags $0)

for file in *
do
    if [[ "${IGNORED_FILES[@]}" =~ "${file} " || "${IGNORED_FILES[${#IGNORED_FILES[@]}-1]}" == "${file}" ]]; then
        # whatever you want to do when arr contains value
        echo "Ignoring $file..."
    else
        link_from=$(pwd)/$file
        link_to=~/.$file
        if [ ! -L $link_to ]; then
            echo "Linking $link_from to $link_to..."
            ln -s $link_from $link_to
        fi
    fi
done
