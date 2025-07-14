echo "Preparing to install Fedora from a minimal install"

echo "Install Ghostty and Starship"
sudo dnf copr enable pgdev/ghostty
sudo dnf install ghostty

sudo dnf copr enable atim/starship
sudo dnf install starship

echo "Install Tools"

sudo dnf copr enable pennbauman/ports
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null

sudo dnf install micro qalc fzf lf vlc inkscape flatpak code texlive-scheme-full texlive-chktex okular libreoffice shotwell gimp stow cabextract xorg-x11-font-utils

sudo rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm

echo "Install social"

sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo dnf install thunderbird discord

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrep
flatpak install flathub com.spotify.Client

echo "Setup config files"
cd ~/.dotfiles2
stow gnome/
