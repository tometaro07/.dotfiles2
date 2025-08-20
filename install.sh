echo "Preparing to install Fedora from a minimal install"

echo "Installing Fedora groups"
sudo dnf group install admin-tools base-graphical dial-up fonts hardware-support multimedia networkmanager-submodules printing standard

echo "Installing Hyprland Packages for a SwayVM group like expirience"
sudo dnf copr enable tofik/nwg-shell
sudo dnf copr enable solopasha/hyprland

sudo dnf install hyprland hyprpaper hypridle hyprlock rofi-wayland grim slurp wlsunset xdg-desktop-portal-wlr xorg-x11-server-Xwayland nwg-look hyprpanel hyprsunset

sudo dnf install pip
pip install pywal gpustat

echo "Installing SwayVM group addapted"
sudo dnf install nautilus blueman nmtui bolt fprintd-pam gnome-keyring-pam gnome-themes-extra gvfs gvfs-smb imv kanshi lxqt-policykit mpv pavucontrol pinentry-gnome3 playerctl pulseaudio-utils system-config-printer wev wl-clipboard xarchiver xdg-desktop-portal-gtk glib2-devel

sudo dnf install gdm --setopt=install_weak_deps=False

echo "Install Ghostty and Starship"
sudo dnf copr enable pgdev/ghostty
sudo dnf copr enable atim/starship
sudo dnf install ghostty starship

sudo dnf remove kitty nwg-panel wofi
sudo dnf install wlr-randr

echo "Install Tools"
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

sudo dnf install qalc fzf vlc inkscape flatpak okular libreoffice shotwell gimp stow cabextract xorg-x11-font-utils neovim zathura-pdf-mupdf gnome-system-monitor gnome-calendar

sudo rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm

echo "Install social"
sudo dnf install thunderbird discord

wget -c https://proton.me/download/PassDesktop/linux/x64/ProtonPass.rpm
sudo dnf install ./ProtonPass.rpm
rm ProtonPass.rpm

echo "Setup config files"
stow hyprland/
stow terminal/

echo "Setup GDM"
sudo cp /usr/share/gnome-shell/gnome-shell-theme.gresource /usr/share/gnome-shell/gnome-shell-theme-original.gresource
sudo cp ~/.gdm-themes/theme/gnome-shell-theme.gresource /usr/share/gnome-shell

systemctl enable gdm.service
systemctl set-default graphical.target

echo "" >> ~/.bashrc
echo "# Starship" >> ~/.bashrc
echo 'eval "$(starship init bash)"' >> ~/.bashrc

echo "" >> ~/.bashrc
echo "# Vim" >> ~/.bashrc
echo "alias vim='nvim'" >> ~/.bashrc

echo "" >> ~/.bashrc
echo "# Set up fzf key bindings and fuzzy completion" >> ~/.bashrc 
echo 'eval "$(fzf --bash)"' >> ~/.bashrc
echo "export FZF_COMPLETION_PATH_OPTS='--walker file,dir,follow,hidden'" >> ~/.bashrc
echo "export FZF_COMPLETION_DIR_OPTS='--walker dir,follow,hidden'" >> ~/.bashrc

echo "Install Nvidia Drivers"
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo dnf update -y # and reboot if you are not on the latest kernel
sudo dnf install akmod-nvidia # rhel/centos users can use kmod-nvidia instead
sudo dnf install xorg-x11-drv-nvidia-cuda #optional for cuda/nvdec/nvenc support

sudo dnf install xorg-x11-drv-nvidia-power
sudo systemctl enable nvidia-{suspend,resume,hibernate}
# Optional: tweak "nvidia options NVreg_TemporaryFilePath=/var/tmp" from /etc/modprobe.d/nvidia.conf as needed if you have issue with /tmp as tmpfs with nvidia suspend )

sudo dnf install nvidia-vaapi-driver libva-utils vdpauinfo

sudo reboot
