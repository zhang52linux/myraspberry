://github.com/vim/vim/archive/v8.2.1520.tar.gz
sudo apt install cmake

sudo apt install libncurses5-dev

cd vim-8.2.1520/src/

./configure --with-features=huge \
    --enable-python3interp=yes \
    --enable-pythoninterp=yes \
    --with-python-config-dir=/usr/lib/python2.7/config-arm-linux-gnueabihf/ \
    --enable-rubyinterp=yes \
    --enable-luainterp=yes \
    --enable-perlinterp=yes \
    --with-python3-config-dir=/usr/lib/python3.7/config-3.7m-arm-linux-gnueabihf/ \
    --enable-multibyte \
    --enable-cscope \
    --prefix=/usr/local

sudo make -j4

sudo make install

python install.py --clang-completer
最后可能有*.h not found 不用管

pip3 install virtualenv

