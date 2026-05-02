# Configurar git
read -p "Introduce tu nombre para Git: " git_name
read -p "Introduce tu email para Git: " git_email

git config --global user.name "$git_name"
git config --global user.email "$git_email"

# update
sudo dnf update -y

# utilidades
sudo dnf install pipx unzip xclip yq jq fzf -y

# zoxide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# peticiones http
sudo dnf install curl wget httpie -y

#sql
sudo dnf install sqlite3 sqlitebrowser -y

# vscode
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc &&
  echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo >/dev/null
dnf check-update &&
  sudo dnf install code -y

# Nerd fonts
wget -q https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip -o JetBrainsMono.zip -d ~/.local/share/fonts
fc-cache -f -v

# gh cli
sudo dnf install dnf5-plugins
sudo dnf config-manager addrepo --from-repofile=https://cli.github.com/packages/rpm/gh-cli.repo
sudo dnf install gh --repo gh-cli -y

# entorno javascript
sudo dnf install npm nodejs -y
curl -fsSL https://bun.sh/install | bash

# docker
sudo dnf remove docker \
  docker-client \
  docker-client-latest \
  docker-common \
  docker-latest \
  docker-latest-logrotate \
  docker-logrotate \
  docker-selinux \
  docker-engine-selinux \
  docker-engine

sudo dnf config-manager addrepo --from-repofile https://download.docker.com/linux/fedora/docker-ce.repo -y
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo systemctl enable --now docker
sudo usermod -aG docker $USER

# lazydocker
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

#neovim
sudo dnf install nvim -y

#lazyvim
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

wget https://github.com/Strophox/tetro-tui/releases/download/v3.1.0/tetro-tui_v3.1_x86_64-unknown-linux-gnu.zip

#tetro-tui
URL="https://github.com/Strophox/tetro-tui/releases/download/v3.1.0/tetro-tui_v3.1_x86_64-unknown-linux-gnu.zip"
TMP_DIR="$(mktemp -d)"

wget -q "$URL" -O "$TMP_DIR/tetro.zip"

unzip -q "$TMP_DIR/tetro.zip" -d "$TMP_DIR"

chmod +x "$TMP_DIR/tetro-tui"
sudo mv "$TMP_DIR/tetro-tui" /usr/local/bin/tetro-tui

rm -rf "$TMP_DIR"

pipx install csvkit

# modificar bashrc
# función helper
add_to_bashrc() {
  local line="$1"
  grep -qxF "$line" ~/.bashrc || echo "$line" >>~/.bashrc
}

# inicializaciones
add_to_bashrc 'eval "$(fzf --bash)"'
add_to_bashrc 'eval "$(zoxide init bash)"'

# aliases
add_to_bashrc 'alias cd="z"'
add_to_bashrc 'alias n="nvim"'
add_to_bashrc 'alias c="code"'
