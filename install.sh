echo "Preparing to install Fedora from a minimal install"

echo "Installing Fedora groups"
sudo dnf group install admin-tools base-graphical dial-up fonts hardware-support multimedia networkmanager-submodules printing standard

echo "Installing Hyprland Packages for a SwayVM group like expirience"
sudo dnf install hyprland hyprpaper hypridle hyprlock woofi swaync grim polkit slurp waybar wlsunset xdg-desktop-portal-wlr xorg-x11-server-Xwayland

echo "Installing SwayVM group addapted"
sudo dnf install NetworkManager-l2tp-gnome NetworkManager-libreswan-gnome NetworkManager-openconnect-gnome NetworkManager-openvpn-gnome NetworkManager-pptp-gnome NetworkManager-sstp-gnome NetworkManager-vpnc-gnome nautilus blueman bolt fprintd-pam gnome-keyring-pam gnome-themes-extra gvfs gvfs-smb imv kanshi lxqt-policykit mpv network-manager-applet pavucontrol pinentry-gnome3 playerctl pulseaudio-utils  sddm system-config-printer wev wl-clipboard wlr-randr xarchiver xdg-desktop-portal-gtk firefox

echo "Install Ghostty and Starship"
sudo dnf copr enable pgdev/ghostty
sudo dnf install ghostty

sudo dnf copr enable atim/starship
sudo dnf install starship

sudo dnf remove kitty

echo "Install Tools"

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null

sudo dnf install micro qalc fzf lf vlc inkscape flatpak code texlive-scheme-full texlive-chktex okular libreoffice shotwell gimp stow cabextract xorg-x11-font-utils

sudo rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm

echo "Install social"

sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo dnf install thunderbird discord

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrep
flatpak install flathub com.spotify.Client

echo "Setup sddm"
systemctl enable sddm.service
systemctl set-default graphical.target

echo "Setup config files"
