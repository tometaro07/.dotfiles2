echo "Preparing to install Fedora from a minimal install"

echo "Installing Fedora groups"
sudo dnf group install admin-tools base-graphical dial-up fonts hardware-support multimedia networkmanager-submodules printing standard

echo "Installing Hyprland Packages for a SwayVM group like expirience"
sudo dnf copr enable tofik/nwg-shell
sudo dnf copr enable solopasha/hyprland

sudo dnf install hyprland hyprpaper hypridle hyprlock rofi-wayland swaync grim polkit slurp waybar wlsunset xdg-desktop-portal-wlr xorg-x11-server-Xwayland nwg-look hyprpanel hyprsunset

sudo dnf install pip
pip install pywal

echo "Installing SwayVM group addapted"
sudo dnf install nautilus blueman bolt fprintd-pam gnome-keyring-pam gnome-themes-extra gvfs gvfs-smb imv kanshi lxqt-policykit mpv pavucontrol pinentry-gnome3 playerctl pulseaudio-utils  sddm qt6-qtvirtualkeyboard qt6-qtmultimedia system-config-printer wev wl-clipboard wlr-randr xarchiver xdg-desktop-portal-gtk firefox

echo "Install Ghostty and Starship"
sudo dnf copr enable pgdev/ghostty
sudo dnf install ghostty

sudo dnf copr enable atim/starship
sudo dnf install starship

sudo dnf remove kitty

echo "Install Tools"

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

sudo dnf install qalc fzf vlc inkscape flatpak texlive-scheme-full texlive-chktex okular libreoffice shotwell gimp stow cabextract xorg-x11-font-utils
sudo rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm

echo "Install social"

sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo dnf install thunderbird discord

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrep
flatpak install flathub com.spotify.Client

echo "Install Others"

sudo dnf install gnome-system-monitor gnome-calendar

echo "Setup config files"
cd ~/.dotfiles2
stow hyprland/
stow terminal/

echo "Setup sddm"
cd ~/.sddm-layouts/SilentSDDM/
sudo mkdir -p /usr/share/sddm/themes/silent
sudo cp -rf . /usr/share/sddm/themes/silent/

sudo cp -r /usr/share/sddm/themes/silent/fonts/* /usr/share/fonts/

apply_theme () {
    echo -e "${grey}Editing '/etc/sddm.conf'...${reset}"
    if [[ -f /etc/sddm.conf ]]; then
        sudo cp -f /etc/sddm.conf /etc/sddm.conf.bkp
        echo -e "${green}Backup for SDDM config saved in '/etc/sddm.conf.bkp'${reset}"

        if grep -Pzq '\[Theme\]\nCurrent=' /etc/sddm.conf; then
            sudo sed -i '/^\[Theme\]$/{N;s/\(Current=\).*/\1silent/;}' /etc/sddm.conf
        else
            echo -e "\n[Theme]\nCurrent=silent" | sudo tee -a /etc/sddm.conf
        fi

        if ! grep -Pzq 'InputMethod=qtvirtualkeyboard' /etc/sddm.conf; then
            echo -e "\n[General]\nInputMethod=qtvirtualkeyboard" | sudo tee -a /etc/sddm.conf
        fi

        # "InputMethod" was supposed to automatically set "QT_IM_MODULE", but it doesn't, so we manually export it.
        if ! grep -Pzq 'GreeterEnvironment=QML2_IMPORT_PATH=/usr/share/sddm/themes/silent/components/,QT_IM_MODULE=qtvirtualkeyboard' /etc/sddm.conf; then
            echo -e "\n[General]\nGreeterEnvironment=QML2_IMPORT_PATH=/usr/share/sddm/themes/silent/components/,QT_IM_MODULE=qtvirtualkeyboard" | sudo tee -a /etc/sddm.conf
        fi
    else
        echo -e "[Theme]\nCurrent=silent" | sudo tee -a /etc/sddm.conf
        echo -e "\n[General]\nInputMethod=qtvirtualkeyboard" | sudo tee -a /etc/sddm.conf
        echo -e "GreeterEnvironment=QML2_IMPORT_PATH=/usr/share/sddm/themes/silent/components/,QT_IM_MODULE=qtvirtualkeyboard" | sudo tee -a /etc/sddm.conf
    fi
}

apply_theme

systemctl enable sddm.service
systemctl set-default graphical.target

echo "" >> ~/.bashrc
echo "# Starship" >> ~/.bashrc
echo 'eval "$(starship init bash)"' >> ~/.bashrc
