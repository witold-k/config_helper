mkdir -p ~/.config/kak/autoload

rm -rf ~/.config/kak/autoload/kaktree
ln -s $(readlink -f kaktree) ~/.config/kak/autoload/kaktree

rm -rf ~/.config/kak/autoload/kakoune-buffers
ln -s $(readlink -f kakoune-buffers) ~/.config/kak/autoload/kakoune-buffers

rm -rf ~/.config/kak/autoload/powerline.kak
ln -s $(readlink -f powerline.kak) ~/.config/kak/autoload/powerline.kak
