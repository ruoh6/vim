git clone https://gitee.com/chxuan/YouCompleteMe-clang.git ~/.vim/plugged/YouCompleteMe

    cd ~/.vim/plugged/YouCompleteMe
    distro=`get_linux_distro`
    read -p "Please choose to compile ycm with python2 or python3, if there is a problem with the current selection, please choose another one. [2/3] " version
    if [[ $version == "2" ]]; then
        echo "Compile ycm with python2."
        # alpine 忽略 --clang-completer 并将 let g:ycm_clangd_binary_path 注入 .vimrc
        {
            if [ ${distro} == "Alpine" ]; then
                echo "##########################################"
                echo "Apline Build, need without GLIBC."
                echo "##########################################"
                sed -i "273ilet g:ycm_clangd_binary_path='/usr/bin/clang'" ~/.vimrc
                python2.7 ./install.py
                return
            fi
        } || {
            python2.7 ./install.py --clang-completer
        } || {
            echo "##########################################"
            echo "Build error, trying rebuild without Clang."
            echo "##########################################"
            python2.7 ./install.py
        }
    else
        echo "Compile ycm with python3."
        {
            # alpine 跳过该步骤
            if [ ${distro} == "Alpine" ]; then
                echo "##########################################"
                echo "Apline Build, need without GLIBC."
                echo "##########################################"
                sed -i "273ilet g:ycm_clangd_binary_path='/usr/bin/clang'" ~/.vimrc
                python3 ./install.py
                return
            fi
        } || {
            python3 ./install.py --clang-completer
        } || {
            echo "##########################################"
            echo "Build error, trying rebuild without Clang."
            echo "##########################################"
            python3 ./install.py
        }
    fi
