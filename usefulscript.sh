# Rename all files in a folder to 1.jpg, 2.jpg, 3.jpg, etc.
ls | cat -n | while read n f; do mv "$f" "file-$n.jpg"; done
