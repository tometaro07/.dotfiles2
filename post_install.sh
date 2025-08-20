echo "Last packages to install on a functioning OS"

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrep
flatpak install flathub app.zen_browser.zen
flatpak install flathub com.spotify.Client
flatpak install flathub app.grayjay.Grayjay

sudo dnf install texlive-scheme-full --setopt=install_weak_deps=False
