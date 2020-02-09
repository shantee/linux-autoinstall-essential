#!/bin/bash

show_logo(){
  clear
  echo -e "\e[1;49;32m ____________________________________________________________\e[0m"
  echo -e "\e[1;49;32m                 __ _                     \e[0m"
  echo -e "\e[1;49;32m                / /(*)_ __  _   ___  __   \e[0m"
  echo -e "\e[1;49;32m               / / | | '_ \| | | \ \/ /   \e[0m"
  echo -e "\e[1;49;32m              / /__| | | | | |_|  X  X    \e[0m"
  echo -e "\e[1;49;32m              \____/_|_| |_|\__,_/_/\_\   \e[0m"
  echo -e "\e[1;49;32m   _______       _____      _________           ________ \e[0m"
  echo -e "\e[1;49;32m   ___    |___  ___  /________  ____/______________  __/ \e[0m"
  echo -e "\e[1;49;32m   __  /| |  / / /  __/  __ \  /   _  __ \_  __ \_  /_   \e[0m"
  echo -e "\e[1;49;32m   _  ___ / /_/ // /_ / /_/ / /___ / /_/ /  / / /  __/   \e[0m"
  echo -e "\e[1;49;32m   /_/  |_\__,_/ \__/ \____/\____/ \____//_/ /_//_/      \e[0m"
  echo -e "\e[1;49;32m    auto install basic softwares, libraries & config     \e[0m"
  echo -e "\e[1;49;32m ____________________________________________________________\e[0m"
  echo
}
create_ser(){
  echo
  echo -e "\e[1m======  Creating command : ser in /usr/bin/ser  ======\e[0m"
  FILE="/usr/bin/ser"
  echo '#!/bin/bash'>>$FILE
  echo 'type http-server >/dev/null 2>&1 || { echo >&2 "you need to install http-server (npm install http-server)"; exit 1; }'>>$FILE
  echo 'if [ "$1" == "stop" ]; then'>>$FILE
  echo 'p=$(pidof http-server)'>>$FILE
  echo 'kill $p'>>$FILE
  echo 'echo "extinction du serveur: "$p'>>$FILE
  echo 'else'>>$FILE
  echo 'http-server -a localhost &'>>$FILE
  echo 'p=$(pidof http-server)'>>$FILE
  echo 'echo "PID : "$p'>>$FILE
  echo 'echo "to stop : ser stop"'>>$FILE
  echo 'fi'>>$FILE
  chmod +x /usr/bin/ser
}

install_rtl8821(){
  echo 
  echo -e "\e[1m==========  Installing WIFI DRIVER RTL8821  ==========\e[0m" 
  apt-get install --reinstall git dkms build-essential linux-headers-$(uname -r)
  cd "$TMPDIR"||echo -e "\e[101mProblemn changing dir.\e[0m"
  git clone https://github.com/tomaspinho/rtl8821ce
  cd rtl8821ce||echo -e "\e[101mError entering dir rtl8821ce.\e[0m"
  chmod +x dkms-install.sh
  chmod +x dkms-remove.sh
  sudo ./dkms-install.sh
}

install_nunustudio(){
  echo 
  echo -e "\e[1m=============  Installing nunuStudio  ===============\e[0m"  
  cd "$SOFTDIR"||echo -e "\e[101mProblemn changing dir.\e[0m"
  git clone https://github.com/tentone/nunuStudio --progress
  echo -e "\e[102m*************************************\e[0m"
  echo -e "\e[102mCreating command nunu (/usr/bin/nunu)\e[0m"
  echo -e "\e[102m*************************************\e[0m"
  NUNU='/usr/bin/nunu'
  echo "#!/bin/bash">>$NUNU
  echo "cd ~/logiciels/nunuStudio">>$NUNU
  echo "npm start & ">>$NUNU
  echo "echo ''">>$NUNU
  echo "echo -e '\e[102m+++++++ TIME TO CREATE +++++++\e[0m'">>$NUNU
  echo "cd ~/">>$NUNU
  echo "echo ''">>$NUNU
  echo "cd ~/">>$NUNU
  chmod +x /usr/bin/nunu
}
## restore bash profile
set_bashprofile(){
 echo 
 echo -e "\e[1m===========  Restoring bash profile  ==============\e[0m"
 cp data/.bashrc $HOME/.bashrc
 cp data/.profile $HOME/.profile
}
install_arduino(){
  cd "$SOFTDIR"||echo -e "\e[101mProblemn changing dir.\e[0m"
  echo 
  echo -e "\e[1m==============  Installing ArduinoIDE  ==============\e[0m" 
  curl -fSL  https://downloads.arduino.cc/arduino-nightly-linux64.tar.xz |tar xvpJ
}
install_charles(){
  echo 
  echo -e "\e[1m==============  Installing Charles-Proxy  ==============\e[0m"
  wget -q -O - https://www.charlesproxy.com/packages/apt/PublicKey | sudo apt-key add -
  sh -c 'echo deb https://www.charlesproxy.com/packages/apt/ charles-proxy main > /etc/apt/sources.list.d/charles.list'
  apt update
  apt install charles-proxy
}
install_bootrepair(){
  echo 	
  echo -e "\e[1m==============  Installing BOOT-REPAIR  ================\e[0m"
  add-apt-repository -y ppa:yannubuntu/boot-repair
  apt-get -y update
  apt-get install -y boot-repair
}

install_micro(){
  echo 
  echo -e "\e[1m==============  Installing MICRO  ======================\e[0m"
  wget -O "$TMPDIR"/mic https://getmic.ro && bash "$TMPDIR"/mic
  mv "$TMPDIR"/micro /usr/bin/micro
}
install_nvm(){
  echo	
  echo -e "\e[1m==============  Installing NVM  =========================\e[0m"
  wget -qO- "https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh" --show-progress | bash
  nvm use node
  chown -R $USER:$(id -gn $USER) $HOME/.config
  nvm install-latest-npm 
}
## installation dans USERSOFTDIR ####################################################
userinstall_nunustudio(){
  cd "$USERSOFTDIR"||echo -e "\e[101mProblemn changing dir.\e[0m"
  git clone https://github.com/tentone/nunuStudio --progress
  echo -e "\e[102m*************************************\e[0m"
  echo -e "\e[102mCreating command nunu (/usr/bin/nunu)\e[0m"
  echo -e "\e[102m*************************************\e[0m"
  NUNU='/usr/bin/nunu'
  echo "#!/bin/bash">>$NUNU
  echo "cd ~/logiciels/nunuStudio">>$NUNU
  echo "npm start & ">>$NUNU
  echo "echo ''">>$NUNU
  echo "echo -e '\e[102m+++++++ TIME TO CREATE +++++++\e[0m'">>$NUNU
  echo "cd ~/">>$NUNU
  echo "echo ''">>$NUNU
  echo "cd ~/">>$NUNU
  chmod +x /usr/bin/nunu
}
userinstall_arduino(){
  echo 
  echo -e "\e[1m==============  Installing ArduinoIDE  ==============\e[0m" 
  cd "$USERSOFTDIR"||echo -e "\e[101mProblemn changing dir.\e[0m"
  curl -fSL  https://downloads.arduino.cc/arduino-nightly-linux64.tar.xz |tar xvpJ
}
#########################################################################################
