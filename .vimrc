"========================插件目录============================="
call plug#begin("~/.vim/plugged")

Plug 'ycm-core/YouCompleteMe'
Plug 'jiangmiao/auto-pairs'
Plug 'Chiel92/vim-autoformat'
Plug 'tpope/vim-commentary'
Plug 'altercation/vim-colors-solarized'

call plug#end()


"========================基础设置============================="
syntax enable
syntax on     " 语法高亮
set number    " 设置行数
"set paste     " 设置粘贴模式(会导致autopairs失效)
set fileencodings=ucs-bom,utf-8,utf-16,gbk,big5,gb18030,latin1  
set encoding=utf-8 " 解决复制粘贴乱码问题
set fileencoding=utf-8 " 解决复制粘贴乱码问题
set termencoding=utf-8 " 解决按:wq 时出现乱码问题
set backspace=2 " 解决插入模式下delete/backspce键失效问题
let &t_TI = ""  " 解决插件安装界面出现乱码 >4;2m 
let &t_TE = ""  " 解决插件安装界面出现乱码 >4;2m
set mouse=v "设置为v模式，即表示在可视模式在可以使用鼠标进行拖拉操作
set completeopt-=preview "关闭预览
set foldmethod=syntax " 进入vim命令模式, za即可折叠或者关闭当前块 zM关闭所有折叠 zR打开所有折叠
autocmd BufNewFile *.[ch],*.hpp,*.cpp,Makefile,*.mk,*.sh exec ":call SetTitle()" 
func SetComment()
	call setline(1,"/*================================================================") 
	call append(line("."),   "*   Copyright (C) ".strftime("%Y")." Sangfor Ltd. All rights reserved.")
	call append(line(".")+1, "*   ") 
	call append(line(".")+2, "*   文件名称：".expand("%:t")) 
	call append(line(".")+3, "*   创 建 者：reap")
	call append(line(".")+4, "*   创建日期：".strftime("%Y年%m月%d日")) 
	call append(line(".")+5, "*   描    述：") 
	call append(line(".")+6, "*")
	call append(line(".")+7, "================================================================*/") 
	call append(line(".")+8, "")
	call append(line(".")+9, "")
endfunc
" 加入shell,Makefile注释
func SetComment_sh()
	call setline(3, "#================================================================") 
	call setline(4, "#   Copyright (C) ".strftime("%Y")." Sangfor Ltd. All rights reserved.")
	call setline(5, "#   ") 
	call setline(6, "#   文件名称：".expand("%:t")) 
	call setline(7, "#   创 建 者：reap")
	call setline(8, "#   创建日期：".strftime("%Y年%m月%d日")) 
	call setline(9, "#   描    述：") 
	call setline(10, "#")
	call setline(11, "#================================================================")
	call setline(12, "")
	call setline(13, "")
endfunc 
" 定义函数SetTitle，自动插入文件头 
func SetTitle()
	if &filetype == 'make' 
		call setline(1,"") 
		call setline(2,"")
		call SetComment_sh()
 
	elseif &filetype == 'sh' 
		call setline(1,"#!/bin/bash") 
		call setline(2,"")
		call SetComment_sh()
		
	else
	     call SetComment()
	     if expand("%:e") == 'hpp' 
		  call append(line(".")+10, "#ifndef _".toupper(expand("%:t:r"))."_H") 
		  call append(line(".")+11, "#define _".toupper(expand("%:t:r"))."_H") 
		  call append(line(".")+12, "#ifdef __cplusplus") 
		  call append(line(".")+13, "extern \"C\"") 
		  call append(line(".")+14, "{") 
		  call append(line(".")+15, "#endif") 
		  call append(line(".")+16, "") 
		  call append(line(".")+17, "#ifdef __cplusplus") 
		  call append(line(".")+18, "}") 
		  call append(line(".")+19, "#endif") 
		  call append(line(".")+20, "#endif //".toupper(expand("%:t:r"))."_H") 
 
	     elseif expand("%:e") == 'h' 
	  	call append(line(".")+10, "#pragma once") 
	     elseif &filetype == 'c' 
	  	call append(line(".")+10,"#include \"".expand("%:t:r").".h\"") 
	     elseif &filetype == 'cpp' 
	  	call append(line(".")+10, "#include \"".expand("%:t:r").".h\"") 
	     endif
	endif
endfunc


"========================插件配置============================="
"vim-autopairs
let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"'}     " 设置要自动配对的符号

"vim-autoformat的映射
noremap <F3> :Autoformat<CR>
let g:autoformat_verbosemode=1
"vim-autoformat
let g:formatdef_clangformat_google = '"clang-format -style google -"' " 我比较喜欢 google 风格的代码
"安装方式:sudo apt install clang-format
let g:formatters_c = ['clangformat_google'] 
let g:formatters_cpp = ['clangformat_google']
" 对python的支持:sudo apt install python-autopep8 && pip install autopep8 不需要配置，可以自动识别python语言
"vi/vim默认不支持c++11的语法提示，添加如下让它支持
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
"python的格式化支持
let g:formatdef_autopep8 = "'autopep8 - --range '.a:firstline.' '.a:lastline"
let g:formatters_python = ['autopep8']
" 对shell脚本的支持
" sudo apt install golang-go
" snap install shfmt 
" 不需要配置即可生效
" other config=================>
" 补全功能在注释中同样有效                                         
let g:ycm_complete_in_comments=1                                   
" 开启tags补全引擎                                                 
let g:ycm_collect_identifiers_from_tags_files=1                    
" 键入第一个字符时就开始列出匹配项                                 
let g:ycm_min_num_of_chars_for_completion=1
" ./install.py --clang-completer 可以提供c++的错误语法提示
" ============================>
"YouCompleteMe的依赖安装，编译
"cd ~/.vim/plugged/YouCompleteMe
"sudo apt update && sudo apt install python3-dev cmake && sudo apt install build-essential
"python3 install.对python的支持


""========================c++代码调式配置============================="
"< F5> 编译和运行C++
map <f5> :call CompileRunGpp()<cr>
func! CompileRunGpp()
exec "w"
exec "!g++ % -o %<"
exec "! ./%<"
endfunc


"========================主题配置============================="
"整体面板主题,及设置真彩色
set t_Co=256
colorscheme gruvbox             "设置主题为gruvbox 
set background=dark             "设置背景为黑色
set guioptions=                 "去掉两边的scrollbar

"vim底部主题powerline
" set rtp+=~/.local/lib/python2.7/site-packages/powerline/bindings/vim/
set rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim/
set laststatus=2
set showtabline=2
set noshowmode
"安装步骤
"sudo apt install python-pip
"pip install git+git://github.com/powerline/powerline

"配置256色""

