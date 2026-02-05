# Chaotic-AUR Automated Installer

> Because life is too short to wait for AUR packages to compile. Get your pre-compiled binaries served fresh, fast, and automated. ⚡

A streamlined Bash script to automate the setup of the **Chaotic-AUR** repository on Arch Linux and its derivatives. This script handles key importation, keyring installation, and configuration updates in one go.

## Quick Start

```bash
curl -fsSL [https://raw.githubusercontent.com/jricardo88/chaotic_aur/main/install-chaotic.sh](https://raw.githubusercontent.com/jricardo88/chaotic_aur/main/install-chaotic.sh) | bash
How It Works
The script automates the official installation steps for Chaotic-AUR. It fetches the primary GPG key from Ubuntu's keyservers, locally signs it to establish trust, and installs the necessary keyring and mirrorlist packages directly from the official CDN.

Finally, it intelligently appends the repository to your pacman.conf and synchronizes your databases so you can start installing packages immediately.

Features
Automated Key Management: Fetches and signs the primary key (3056513887B78AEB) automatically.

Smart Configuration: Safely appends the [chaotic-aur] section only if it's not already present, preventing duplicate entries.

Database Sync: Runs pacman -Sy upon completion for a "ready-to-go" experience.

Manual Installation
If you prefer to inspect the code before running it:

Bash
git clone [https://github.com/jricardo88/chaotic_aur.git](https://github.com/jricardo88/chaotic_aur.git)
cd chaotic_aur
chmod +x install-chaotic.sh
./install-chaotic.sh
Requirements
OS: Arch Linux or Arch-based distributions (EndeavourOS, Manjaro, etc.).

Dependencies: curl, pacman, and sudo privileges.

License
Chaotic-AUR Automated Installer is released under the MIT License.
