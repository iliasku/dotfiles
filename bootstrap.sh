#!/bin/bash

set -e
set -u

cat <<EOF

                             ,,                 ?   ??I
                         ,,,,,,,,,,            ???77??? 7??7
                         ,,,,,,,,,,            ????????????
                       7,,,,=   ,,,,7     7??????      I??? 77
                       ,,,,,    :,,,,       ???          ??????
                          ,,,?+,,,~      777??            ???
                         ,,,,7,,,,,      ?????            7??
                         =+  ,,7?7:???     I??            7????
                             ,,I?????????? I??            ??77
                                ?I???????7?????          ???
                             I?????   ???II7 ????      ???????
                       ,,,    ?????   I????  ????????????   7
                  ,,:  ,,,  ,,,7???II????    ??   ??I  ??7
                  ?,,,,,,,,,,,7??????????         ??7,,7
               ,? ,,,,7    ,,,,7,, ??  ??      ,,,  :,,? =,,7
              +,,,,,         :,,,, 77           ,,,,,,,,,,,,
                ,,=           ,,?           ,: =,,,,,,,,,,,,=:,,
               ,,,             ,,,:         ,,,,,,,:    ,,,,,,,,
             ,,,,,             ,,,,          ,,,,,        ,,,,7
                ,,            ,,=           ,,,,,          ,,,,,,
               ,,,:          ~,,,         ,,,,,,,          :,,,,,=
              :,,,,,?       ,,,,,,  ??       ,,,,7         ,,,,
                  :,,,,,,,,,,, ?I  ???   ??  ,,,,,        ,,,,,
                  ,,, :,,, :,,????????????? ,,,,,,,,,++,,,,,,,,,7
                   +   ,,    7 ????????????  7  ,,,,,,,,,,,,
                          7?????????I??????????7,,,,,,,,,,,,7
                            ?????       7?????  ,,   ,,?  ,,7
                            ????7        7????       ,,
                         ???????         7??????7
                          ??????         7?????
                            ?????        ????7
                           ???????7    7???????
                           ????????????????????
                               ????????????
                              7??7 ???? I??I
                                    ??


EOF

echo -n "Install OS packages? [Y/n]: "
read -n 1 INSTALL_PACKAGES

if [ "$INSTALL_PACKAGES" != "n" ]; then
    case "`uname`" in
    Linux)
        if grep "Debian" /etc/issue >/dev/null 2>&1; then
            wget -qO - https://raw.githubusercontent.com/ragnar-johannsson/dotfiles/master/deb-install.sh | bash
        else
            echo "Error: Unsupported Linux distro"
            exit 1
        fi
        ;;
    Darwin)
        curl -sSL https://raw.githubusercontent.com/ragnar-johannsson/dotfiles/master/osx-install.sh | bash
        ;;
    esac
fi

if [ -e "$HOME/.dotfiles" ]; then
    echo "Error: $HOME/.dotfiles already exists"
    exit 1
fi

git clone https://github.com/ragnar-johannsson/dotfiles.git "$HOME/.dotfiles" && cd "$HOME/.dotfiles"

echo -n "Setup symlinks? [Y/n]: "
read -n 1 SETUP_SYMLINKS
if [ "$SETUP_SYMLINKS" != "n" ]; then
    ./setup-links.sh
fi

echo -n "Fetch keys? [Y/n]: "
read -n 1 FETCH_KEYS
if [ "$FETCH_KEYS" != "n" ]; then
    ./setup-keys.sh
fi