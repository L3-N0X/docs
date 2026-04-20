---
author: ["Leon Gött"]
title: "The Best CLI Setup"
date: "2026-04-20"
description: "The best ZSH setup for a powerful and efficient command-line experience, including plugins, themes, and configuration tips."
summary: "The best ZSH setup for a powerful and efficient command-line experience, including plugins, themes, and configuration tips."
tags: ["cli", "zsh", "setup"]
categories: ["cli", "zsh"]
ShowToc: true
TocOpen: false
---

## Introduction

In this article, we will explore the best ZSH setup for a powerful and efficient command-line experience. We will cover essential plugins, themes, and configuration tips to enhance your productivity and make your terminal more enjoyable to use.

## ZSH installation

To install ZSH, you can use your package manager. For example, on Debian-based systems, you can run:

```bash
sudo apt install zsh
```

After installing ZSH, you can set it as your default shell with:

```bash
chsh -s $(which zsh)
```

On MacOS, ZSH is already installed, but you can update it to the latest version using Homebrew:

```bash
# Check existing zsh
zsh --version
which zsh

# Optional: install newer zsh with Homebrew
brew install zsh

# Set as default shell
chsh -s $(which zsh)
```

## Oh My Zsh

Oh My Zsh is a popular framework for managing your ZSH configuration. It comes with a variety of plugins and themes to enhance your terminal experience. To install Oh My Zsh, run the following command:

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

After installation, you can customize your `.zshrc` file to enable plugins and set your preferred theme.

### Theme

There are many themes available for Oh My Zsh, but one of the most popular and visually appealing themes is "Powerlevel10k". To install Powerlevel10k, run:

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
```

Then, set the theme in your `.zshrc` file:

```bash
sed -i.bak 's|^ZSH_THEME=.*|ZSH_THEME="powerlevel10k/powerlevel10k"|' ~/.zshrc
```

You can also manually edit your `.zshrc` file and set `ZSH_THEME="powerlevel10k/powerlevel10k"`.

After that, restart your terminal or run

```bash
exec zsh
```

When installing Powerlevel10k for the first time, it will prompt you to configure your prompt. You can choose the default options or customize it according to your preferences.

The default is already very good, but you can read trough the options so you know what it can do by default and change things if you want to.

Since Powerlevel10k uses a lot of icons, it is recommended to install a Nerd Font. You can download and install one from [Nerd Fonts](https://www.nerdfonts.com/).
I personally use "JetBrains Mono Nerd Font" or the "Fira Code Nerd Font", but you can choose any that you like.

> [!NOTE]
> You can always run `p10k configure` to reconfigure your Powerlevel10k prompt if you want to change the options later on.

### Plugins

Oh My Zsh comes with a variety of plugins that can enhance your terminal experience. Some of the most popular plugins include:

- `git`: Provides useful aliases and functions for working with Git.
- `docker`: Provides aliases and functions for working with Docker.
- `docker-compose`: Provides aliases and functions for working with Docker Compose.
- `bun`: Provides aliases and functions for working with the Bun JavaScript runtime.
- `npm`: Provides aliases and functions for working with npm.
- `zsh-autosuggestions`: Provides suggestions based on your command history as you type.
- `zsh-syntax-highlighting`: Highlights commands as you type, making it easier to spot errors.
- `tailscale`: Provides aliases and functions for working with Tailscale, a popular VPN service (only add, if you use Tailscale).
- `ssh`: Provides aliases and functions for working with SSH.
- `systemd`: Provides aliases and functions for working with systemd (linux only).

#### Installation

Some plugins, like `zsh-autosuggestions` and `zsh-syntax-highlighting`, need to be installed manually. You can install them using the following commands:

**For `zsh-syntax-highlighting`:**

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

On MacOS:

```bash
brew install zsh-autosuggestions
echo 'source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh' >> ~/.zshrc
```

**For `zsh-syntax-highlighting`:**

```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

On MacOS:

```bash
brew install zsh-syntax-highlighting
echo 'source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> ~/.zshrc
```

After installation, you need to enable the plugins.

To enable these plugins, simply add them to the `plugins` array in your `.zshrc` file. For example:

```bash
plugins=(git docker docker-compose bun npm zsh-autosuggestions zsh-syntax-highlighting tailscale ssh systemd)
```

After adding the plugins, restart your terminal or run `exec zsh` to apply the changes.

> [!HINT]
> Most plugins auto-configure many different aliases and functions for you, so make sure to check the documentation of each plugin to see what it offers and how to use it effectively.
> Some useful aliases include `gst` for `git status`, `gco` for `git checkout`, `dps` for `docker ps`, `dcupd` for `docker-compose up -d`, and many more. You can also create your own aliases in the `.zshrc` file if you have specific commands that you use frequently.

## Installation of additional tools

### eza

Eza is a modern replacement for the `ls` command, providing a more colorful and informative output. To install eza, you can use your package manager. For example, on Debian-based systems, you can run:

```bash
sudo apt install eza
```

On MacOS, you can install eza using Homebrew:

```bash
brew install eza
```

After installing eza, you can create an alias for it in your `.zshrc` file to replace the default `ls` command:

```bash
alias ls='eza --group-directories-first'
alias ll='eza -l --header --icons --git --group-directories-first -h'
alias la='eza -la --header --icons --git --group-directories-first -h'
alias lt='eza --tree --icons --level=2 --group-directories-first'
```

When you don't like editing the `.zshrc` file, you can also run these commands directly in your terminal:

```bash
cat <<'EOF' >> ~/.zshrc
alias ls='eza --group-directories-first'
alias l='eza --icons --group-directories-first'
alias ll='eza -l -h --header --icons --git --group-directories-first'
alias la='eza -la -h --header --icons --git --group-directories-first'
alias lt='eza --tree --level=2 --icons --group-directories-first'
EOF
```

Now, whenever you run `ls`, it will use eza instead, providing a more colorful and informative output. You can also use the `ll`, `la`, and `lt` aliases for different views of your files and directories. The `l` command includes icons while being similar to the default `ls` command.

### fzf

Fzf is a powerful command-line fuzzy finder that can be used to quickly search and navigate through files, command history, and more. To install fzf, you can use your package manager. For example, on Debian-based systems, you can run:

```bash
sudo apt install fzf
```

On MacOS, you can install fzf using Homebrew:

```bash
brew install fzf
```

After installing fzf, you can enable it in your terminal by adding the following lines to your `.zshrc` file:

```bash
source <(fzf --zsh)
```

or you can run this command directly in your terminal:

```bash
echo 'source <(fzf --zsh)' >> ~/.zshrc
```

This will enable fzf for command history search, file search, and more. You can try it now by pressing `Ctrl+R` to search through your command history or by running `fzf` to search through your files.

This makes finding previous commands much faster and more efficient, especially if you have a long command history. You can also use the `fzf` command to search for files in the current directory and its subdirectories.

You can customize the key bindings and behavior of fzf by referring to the fzf documentation.

> [!NOTE]
> Fzf can be cutomized for better Ctrl+R history search by adding the following lines to your `.zshrc` file:
>
> ```bash
> export FZF_CTRL_R_OPTS="
> --height 60%
> --layout reverse
> --border top
> --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
> --color header:italic
> --header 'CTRL-R: search history, CTRL-Y: copy command'
> "
>
> # This must be after the export of FZF_CTRL_R_OPTS
> source <(fzf --zsh)
> ```

### zoxide

Zoxide is a smarter `cd` command that learns your habits and allows you to quickly navigate to frequently used directories. To install zoxide, you can use your package manager. For example, on Debian-based systems, you can run:

```bash
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
```

On MacOS, you can install zoxide using Homebrew:

```bash
brew install zoxide
```

run these commands to enable zoxide in your terminal:

```bash
echo 'eval "$(zoxide init zsh)"' >> ~/.zshrc
exec zsh
```

to verify that zoxide is working, you can run:

```bash
zoxide --version
```

Now, you can start using zoxide to navigate your directories. For example, if you want to go to a directory that you have visited before, you can simply type:

```bash
z myproject
```

This will take you to the most frequently visited directory that matches "myproject". You can also use `z -l` to list all the directories that zoxide has learned, and `z -c` to clear the database if you want to start fresh.

### bat

Bat is a modern replacement for the `cat` command, providing syntax highlighting and other features. To install bat, you can use your package manager. For example, on Debian-based systems, you can run:

```bash
sudo apt install bat
```

On MacOS, you can install bat using Homebrew:

```bash
brew install bat
```

> [!HINT]
> If the `bat` command does not work after installation, it might be because the binary is named `batcat` on some systems. You can create a symlink to make it work with the `bat` command (only required on some Debian and Ubuntu based systems):

```bash
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat
```

The `bat` command can be used just like `cat` and both commands are there to paste the content of files to the terminal, but `bat` provides syntax highlighting and other features that make it more pleasant to use. You can also create an alias for `cat` to use `bat` instead, as shown in the configuration section below.

> [!NOTE]
> Common configuration includes the following settings in your `.zshrc` file:
>
> ```bash
> export BAT_THEME="OneHalfDark"
> alias cat='bat --paging=never'
>
> # Or MacOS light/dark aware theme+
> alias cat='bat --theme auto:system --theme-dark default --theme-light GitHub'
> ```

### yazi

Yazi is a modern file explorer for the terminal, providing a more interactive experience for navigating and managing files. It uses Vim-like keybindings and supports features like file previews and batch operations.

If you don't want to learn the Vim keybindings, I recommend to just use it for changing the directory by configuring the following `y` command, but you might want to learn copying and moving files with it as well because it makes this very fast and easy.

To install yazi, you can use your package manager. For example, on Debian-based systems, you can run:

```bash
sudo apt install ffmpeg 7zip jq poppler-utils fd-find ripgrep fzf zoxide imagemagick
```

on MacOS, you can install the dependencies using Homebrew:

```bash
brew update
brew install yazi ffmpeg-full sevenzip jq poppler fd ripgrep fzf zoxide resvg imagemagick-full font-symbols-only-nerd-font
brew link ffmpeg-full imagemagick-full -f --overwrite
```

To enable the `y` command for changing directories with yazi, add the following function to your `.zshrc` file:

```bash
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  command yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd < "$tmp"
  [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}
```

then reload your terminal or run `exec zsh` to apply the changes.

#### Usage

To use yazi, simply run the `y` command in your terminal. This will open the yazi file explorer in the current directory. You can navigate through the directories using the arrow keys or Vim-like keybindings (h, j, k, l), but you can also just use the arrow keys if you don't want to learn the Vim keybindings.

When started, you can navigate to a new directory, and pressing `Ctrl+C` will quit yazi and change the terminal's current directory to the one you navigated to.

The easiest way to copy and paste in Yazi is: select files with Space if needed, press y to copy or x to cut, then move to the target directory and press p to paste. If you want to overwrite existing files during paste, use P instead of p, and if you change your mind before pasting, Y or X cancels the yank status.

## Bonus

### docker

Here is another guide on how to properly install and setup Docker on your system, which is a very useful tool for running applications in containers:

**Fast installation:**

```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh ./get-docker.sh --dry-run
```

**Detailed installation:**

```bash
# Remove old versions of Docker if they exist
sudo apt remove $(dpkg --get-selections docker.io docker-compose docker-compose-v2 docker-doc podman-docker containerd runc | cut -f1)

sudo apt update
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update

# Install Docker Engine + Compose plugin + Buildx
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

to verify, run

```bash
sudo systemctl status docker
docker --version

# To try a container, run:
sudo docker run hello-world
```

to run without `sudo`, you can add your user to the `docker` group:

```bash
sudo usermod -aG docker $USER
newgrp docker
```

## Aliases you might want to add

Here are some useful aliases that you can add to your `.zshrc` file to enhance your command-line experience:

```bash
# Create a directory and navigate into it
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Disk usage with human-readable format and max depth of 1
alias duh='du -h --max-depth=1'

# Update and upgrade packages (Debian-based systems)
alias update='sudo apt update && sudo apt upgrade -y'

# Clear the terminal
alias cls='clear'

# Tree view of directories using eza
alias tree='eza --tree --group-directories-first'

