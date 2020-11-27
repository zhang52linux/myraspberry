su -
wget -c -t 20 https://www.ivdone.top/wordpress/pic/p357/lrzsz-0.12.20.tar.gz
# 解压
tar -zxvf lrzsz-0.12.20.tar.gz
# 进入该目录
cd lrzsz-0.12.20
# 检测安装环境，生成MakeFile文件
# 检测环境,输入命令
./configure
# make工具编译与安装
make
make install
# 程序的默认安装路径为:/usr/local/bin
# 进入安装目录
cd /usr/local/bin
# 软链接
ln -s lrz rz
ln -s lsz sz
