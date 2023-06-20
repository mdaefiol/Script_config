#!/bin/bash

# Executar o comando sudo su no início do script
echo "Adicionando compatibilidade 32bits..."
sudo dpkg --add-architecture i386
sudo apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386
sudo apt-get install sshpass
sudo apt-get install ssh
sudo apt-get install zip
echo "Executando apt update..."
sudo apt update
echo "Executando apt upgrade..."
sudo apt upgrade


# Pedir ao usuário para inserir a senha do SCP
echo " "
read -s -p "Digite a senha root do seu computador: " sudopass
echo " "

# Passo 6
echo " "
echo " "
echo " "
echo "Realizando compatibilidade de HASH..."
echo " "
echo " "
echo "Copie as duas linhas abaixo:"
echo "HostKeyAlgorithms ssh-rsa,ssh-dss"
echo "PubkeyAcceptedKeyTypes ssh-rsa,ssh-dss"
echo " "
echo " "
echo "Agora, adicione as duas linhas copiadas dentro do arquivo my.conf que será aberto a seguir... "
echo " "
echo "Lembre-se: Feche o arquivo com CTRL + X, selecionando 'Y' (yes) para salvar as alterações."
echo " "
read -p "Digite 'ok' para prosseguir com a inclusão das linhas no arquivo my.conf: " resposta
if [[ $resposta != "ok" ]]; then
  echo "Operação cancelada pelo usuário."
  exit 0
fi
echo "Executando nano /etc/ssh/ssh_config.d/my.conf..."
sudo nano /etc/ssh/ssh_config.d/my.conf

# Aguarda o usuário editar o arquivo
echo " "
read -p "Pressione Enter quando terminar de editar o arquivo my.conf"

#Criando diretório para copiar arquivos do servidor 241
echo " "
echo "Criando diretório Boardcomm..."
cd ..
sudo mkdir Boardcomm
sudo chmod 777 Boardcomm
cd Boardcomm

#Copiando arquivos do servidor 241: login
echo " "
echo "Agora, digite seu nome de usuário para o servidor 241. Nesse passo, é importante ter em mãos seu usuário e senha do servidor."
read -p "Digite o nome de usuário: " username
# Pedir ao usuário para inserir a senha do SCP
read -s -p "Digite a senha para o servidor: " password
echo " "

# Execute o comando SSH no script
ssh -p 1337 -T $username@192.168.1.241 "exit"
# sudo echo $password | sshpass -p $password
# echo 'y'

# Comandos SCP utilizando o nome de usuário e senha fornecidos pelo usuário
echo "Copiando arquivos de configuração..."
sudo echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/dev_game/adm.data .
sudo echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/dev_game/hli.pic30.bin .
sudo echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/dev_game/tool .
sudo echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/dev_game/programmer .
echo "Arquivos de configuração foram copiados."
echo " "

# Copiando o arquivo com o jogo
echo "Copiando arquivos do jogo..."
sudo echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/games .
echo "Arquivos do jogo foram copiados."
echo " "

# Unzip 
cd games
unzip donuts-plus.zip 
rm donuts-plus.zip 
cd 

# Copiando o arquivo com o jogo
echo "Copiando libs para funcionamento do jogo..."
sudo su << EOF
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/liblber-2.4.so.2.5.4 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libldap_r-2.4.so.2.5.4 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libldap_r-2.4.so.2.5.4 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libmysqlclient.so.16.0.0 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libsasl2.so.2.0.23 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libgnutls.so.26.14.12 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libtasn1.so.3.1.7 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libgcrypt.so.11.5.2 /lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libstdc++.so.6.0.13 /usr/lib/libstdc++.so.6.0.13
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libQtCore.so.4.6.2 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libQtGui.so.4.6.2 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libQtNetwork.so.4.6.2 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libSDL-1.2.so.0.11.3 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libz.so.1.2.3.3 /lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libgthread-2.0.so.0.2400.1 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libglib-2.0.so.0.2400.1 /lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libfontconfig.so.1.4.4 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libaudio.so.2.4 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libpng.so /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libfreetype.so.6.3.22 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libgobject-2.0.so.0.2400.1 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libSM.so.6.0.1 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libICE.so.6.3.0 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libXrender.so.1.3.0 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libXext.so.6.4.0 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libX11.so.6.3.0 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libpulse-simple.so.0.0.3 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libpulse.so.0.12.2 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libdirectfb-1.2.so.0.8.0 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libfusion-1.2.so.0.8.0 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libdirect-1.2.so.0.8.0 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libpcre.so.3.12.1 /lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libexpat.so.1.5.2 /lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libXt.so.6.0.0 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libXau.so.6.0.0 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libuuid.so.1.3.0 /lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libxcb.so.1.1.0 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libXtst.so.6.1.0 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libXdmcp.so.6.0.0 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libwrap.so.0.7.6 /lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libsndfile.so.1.0.21 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libdbus-1.so.3.4.0 /lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libXi.so.6.1.0 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libFLAC.so.8.2.0 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libvorbisenc.so.2.0.6 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libvorbis.so.0.4.3 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libogg.so.0.6.0 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libpulsecommon-0.9.21.so /usr/lib
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libaviplay-0.7.so.0.0.48 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libevent-1.4.so.2.1.3 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libcurl.so /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libhiredis.so.0.13 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libjson-c.so.3.0.0 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libmysqlpp.so.3.0.9 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libavcodec.so.52.20.1 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libavformat.so.52.31.0 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libXinerama.so.1.0.0 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libXxf86vm.so.1.0.0 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libXxf86dga.so.1.0.0 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libXft.so.2.1.13 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libmysqlclient.so.16.0.0 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libavutil.so.49.15.0 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libgsm.so.1.0.12 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libschroedinger-1.0.so.0.2.0 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libspeex.so.1.5.0 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libtheora.so.0.3.10 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libbz2.so.1.0.4 /lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/liboil-0.3.so.0.3.0 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/liblber-2.4.so.2.5.4 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libldap_r-2.4.so.2.5.4 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libssl.so.0.9.8 /lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libcrypto.so.0.9.8 /lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libsasl2.so.2.0.23 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libgssapi_krb5.so.2.2 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libgnutls.so.26.14.12 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libkrb5.so.3.3 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libk5crypto.so.3.1 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libcom_err.so.2.1 /lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libkrb5support.so.0.1 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libkeyutils-1.2.so /lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libtasn1.so.3.1.7 /usr/lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libgcrypt.so.11.5.2 /lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libgpg-error.so.0.4.0 /lib/
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libqrencode.so.3.9.0 /usr/local/lib/libqrencode.so.3.9.0
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libstdc++.so.6.0.13 /usr/lib
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libpthread-2.11.1.so /lib
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libm-2.11.1.so /lib
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/libgcc_s.so.1 /lib
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/lib/libc-2.11.1.so /lib
echo $password | sshpass -p $password scp -P 1337 -r $username@192.168.1.241:/home/shared/orion-dev/libs/lib/ld-2.11.1.so /lib
EOF
echo "Bibliotecas foram copiadas..."

echo " " 
echo "Criando link simbolico para bibliotecas..."
sudo ln -s /usr/lib/liblber-2.4.so.2.5.4 /usr/lib/liblber-2.4.so.2
sudo ln -s /usr/lib/libldap_r-2.4.so.2.5.4 /usr/lib/libldap_r-2.4.so.2
sudo ln -s /usr/lib/libmysqlclient.so.16.0.0 /usr/lib/libmysqlclient.so.16
sudo ln -s /usr/lib/libsasl2.so.2.0.23 /usr/lib/libsasl2.so.2
sudo ln -s /usr/lib/libgnutls.so.26.14.12 /usr/lib/libgnutls.so.26
sudo ln -s /usr/lib/libtasn1.so.3.1.7 /usr/lib/libtasn1.so.3
sudo ln -s /lib/libgcrypt.so.11.5.2 /lib/libgcrypt.so.11
sudo ln -s /home/shared/orion-dev/libs/libstdc++.so.6.0.13 /usr/lib/libstdc++.so.6
sudo ln -s /usr/lib/libQtCore.so.4.6.2 /usr/lib/libQtCore.so.4
sudo ln -s /usr/lib/libQtGui.so.4.6.2 /usr/lib/libQtGui.so.4
sudo ln -s /usr/lib/libQtNetwork.so.4.6.2 /usr/lib/libQtNetwork.so.4
sudo ln -s /usr/lib/libSDL-1.2.so.0.11.3 /usr/lib/libSDL-1.2.so.0
sudo ln -s /lib/libz.so.1.2.3.3 /lib/libz.so.1
sudo ln -s /usr/lib/libgthread-2.0.so.0.2400.1 /usr/lib/libgthread-2.0.so.0
sudo ln -s /lib/libglib-2.0.so.0.2400.1 /lib/libglib-2.0.so.0
sudo ln -s /usr/lib/libfontconfig.so.1.4.4 /usr/lib/libfontconfig.so.1
sudo ln -s /usr/lib/libaudio.so.2.4 /usr/lib/libaudio.so.2
sudo ln -s /usr/lib/libpng.so /usr/lib/libpng12.so.0
sudo ln -s /usr/lib/libfreetype.so.6.3.22 /usr/lib/libfreetype.so.6
sudo ln -s /usr/lib/libgobject-2.0.so.0.2400.1 /usr/lib/libgobject-2.0.so.0
sudo ln -s /usr/lib/libSM.so.6.0.1 /usr/lib/libSM.so.6
sudo ln -s /usr/lib/libICE.so.6.3.0 /usr/lib/libICE.so.6
sudo ln -s /usr/lib/libXrender.so.1.3.0 /usr/lib/libXrender.so.1
sudo ln -s /usr/lib/libXext.so.6.4.0 /usr/lib/libXext.so.6
sudo ln -s /usr/lib/libX11.so.6.3.0 /usr/lib/libX11.so.6
sudo ln -s /usr/lib/libpulse-simple.so.0.0.3 /usr/lib/libpulse-simple.so.0
sudo ln -s /usr/lib/libpulse.so.0.12.2 /usr/lib/libpulse.so.0
sudo ln -s /usr/lib/libdirectfb-1.2.so.0.8.0 /usr/lib/libdirectfb-1.2.so.0
sudo ln -s /usr/lib/libfusion-1.2.so.0.8.0 /usr/lib/libfusion-1.2.so.0
sudo ln -s /usr/lib/libdirect-1.2.so.0.8.0 /usr/lib/libdirect-1.2.so.0
sudo ln -s /lib/libpcre.so.3.12.1 /lib/libpcre.so.3
sudo ln -s /lib/libexpat.so.1.5.2 /lib/libexpat.so.1
sudo ln -s /usr/lib/libXt.so.6.0.0 /usr/lib/libXt.so.6
sudo ln -s /usr/lib/libXau.so.6.0.0 /usr/lib/libXau.so.6
sudo ln -s /lib/libuuid.so.1.3.0 /lib/libuuid.so.1
sudo ln -s /usr/lib/libxcb.so.1.1.0 /usr/lib/libxcb.so.1
sudo ln -s /usr/lib/libXtst.so.6.1.0 /usr/lib/libXtst.so.6
sudo ln -s /usr/lib/libXdmcp.so.6.0.0 /usr/lib/libXdmcp.so.6
sudo ln -s /lib/libwrap.so.0.7.6 /lib/libwrap.so.0
sudo ln -s /usr/lib/libsndfile.so.1.0.21 /usr/lib/libsndfile.so.1
sudo ln -s /lib/libdbus-1.so.3.4.0 /lib/libdbus-1.so.3
sudo ln -s /usr/lib/libXi.so.6.1.0 /usr/lib/libXi.so.6
sudo ln -s /usr/lib/libFLAC.so.8.2.0 /usr/lib/libFLAC.so.8
sudo ln -s /usr/lib/libvorbisenc.so.2.0.6 /usr/lib/libvorbisenc.so.2
sudo ln -s /usr/lib/libvorbis.so.0.4.3 /usr/lib/libvorbis.so.0
sudo ln -s /usr/lib/libogg.so.0.6.0 /usr/lib/libogg.so.0
sudo ln -s /usr/lib/libaviplay-0.7.so.0.0.48 /usr/lib/libaviplay-0.7.so.0
sudo ln -s /usr/lib/libevent-1.4.so.2.1.3 /usr/lib/libevent-1.4.so.2
sudo ln -s /usr/local/lib/libcurl.so /usr/lib/libcurl.so
sudo ln -s /usr/local/lib/libhiredis.so.0.13 /usr/lib/libhiredis.so.0.13
sudo ln -s /usr/lib/libjson-c.so.3.0.0 /usr/lib/libjson-c.so.3
sudo ln -s /usr/lib/libmysqlpp.so.3.0.9 /usr/lib/libmysqlpp.so.3
sudo ln -s /usr/lib/libavcodec.so.52.20.1 /usr/lib/libavcodec.so.52
sudo ln -s /usr/lib/libavformat.so.52.31.0 /usr/lib/libavformat.so.52
sudo ln -s /usr/lib/libXinerama.so.1.0.0 /usr/lib/libXinerama.so.1
sudo ln -s /usr/lib/libXxf86vm.so.1.0.0 /usr/lib/libXxf86vm.so.1
sudo ln -s /usr/lib/libXxf86dga.so.1.0.0 /usr/lib/libXxf86dga.so.1
sudo ln -s /usr/lib/libXft.so.2.1.13 /usr/lib/libXft.so.2
sudo ln -s /usr/lib/libmysqlclient.so.16.0.0 /usr/lib/libmysqlclient.so.16
sudo ln -s /usr/lib/libavutil.so.49.15.0 /usr/lib/libavutil.so.49
sudo ln -s /usr/lib/libgsm.so.1.0.12 /usr/lib/libgsm.so.1
sudo ln -s /usr/lib/libschroedinger-1.0.so.0.2.0 /usr/lib/libschroedinger-1.0.so.0
sudo ln -s /usr/lib/libspeex.so.1.5.0 /usr/lib/libspeex.so.1
sudo ln -s /usr/lib/libtheora.so.0.3.10 /usr/lib/libtheora.so.0
sudo ln -s /lib/libbz2.so.1.0.4 /lib/libbz2.so.1.0
sudo ln -s /usr/lib/liboil-0.3.so.0.3.0 /usr/lib/liboil-0.3.so.0
sudo ln -s /usr/lib/liblber-2.4.so.2.5.4 /usr/lib/liblber-2.4.so.2
sudo ln -s /usr/lib/libldap_r-2.4.so.2.5.4 /usr/lib/libldap_r-2.4.so.2
sudo ln -s /usr/lib/libsasl2.so.2.0.23 /usr/lib/libsasl2.so.2
sudo ln -s /usr/lib/libgssapi_krb5.so.2.2 /usr/lib/libgssapi_krb5.so.2
sudo ln -s /usr/lib/libgnutls.so.26.14.12 /usr/lib/libgnutls.so.26
sudo ln -s /usr/lib/libkrb5.so.3.3 /usr/lib/libkrb5.so.3
sudo ln -s /usr/lib/libk5crypto.so.3.1 /usr/lib/libk5crypto.so.3
sudo ln -s /lib/libcom_err.so.2.1 /lib/libcom_err.so.2
sudo ln -s /usr/lib/libkrb5support.so.0.1 /usr/lib/libkrb5support.so.0
sudo ln -s /lib/libkeyutils-1.2.so /lib/libkeyutils.so.1
sudo ln -s /usr/lib/libtasn1.so.3.1.7 /usr/lib/libtasn1.so.3
sudo ln -s /lib/libgcrypt.so.11.5.2 /lib/libgcrypt.so.11
sudo ln -s /lib/libgpg-error.so.0.4.0 /lib/libgpg-error.so.0
sudo ln -s /usr/local/lib/libqrencode.so.3.9.0 /usr/lib/libqrencode.so.3
sudo ln -s /lib/libpthread-2.11.1.so /lib/libpthread.so.0
sudo ln -s /lib/libm-2.11.1.so /lib/libm.so.6
sudo ln -s /lib/libc-2.11.1.so /lib/libc.so.6
sudo ln -s /lib/ld-2.11.1.so /lib/ld-linux.so.2
echo "Criacao de links finalizada."
