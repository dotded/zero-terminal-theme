# PowerShell

PowerShell profile with prompt initialisation, file navigation, command-line colours and optional tool integrations.

---

### Configuration

- **File:** `Microsoft.PowerShell_profile.ps1`
- **Shells:** Windows PowerShell 5.1 and PowerShell 7
- **Purpose:** Configure terminal startup, functions, aliases and navigation

---

### Sections

- **Prompt and startup:** Loads `zero-adaptive.omp.json` from `$HOME\.config\ohmyposh\` if Oh My Posh and the theme are present. Runs Fastfetch unless `WT_NO_FASTFETCH=1` is set. Change `$themePath` to use a different theme.
- **Optional applications:** Adds `btop`, `cmatrix`, `y`, `pipes` and `cava` commands. `y` opens Yazi and changes PowerShell's directory to the directory selected when Yazi exits. Edit the executable/script paths in these functions to match your installation.
- **File navigation and colours:** Sets `EZA_COLORS` and defines `ls`, `ll`, `la` and `tree`. Change the colour values to customise file types; the functions use Eza when installed.
- **Zoxide:** Initialises the `z` directory-jumping command when Zoxide is available.
- **FZF styling:** Sets `FZF_DEFAULT_OPTS` to control the picker layout, prompt and colours. Edit these flags to change its appearance.
- **Directory selector:** `zz` (also `zi`) combines Zoxide and FZF with a right-hand preview. It requires the separate helper `Tools\FZF\preview.ps1`; update `$previewScript` if you store that helper elsewhere.

---

### Setup

1. Install the tools you want to use: [Oh My Posh](https://ohmyposh.dev/), [Fastfetch](https://github.com/fastfetch-cli/fastfetch), [Eza](https://github.com/eza-community/eza), [Zoxide](https://github.com/ajeetdsouza/zoxide), [FZF](https://github.com/junegunn/fzf) and/or the optional applications.
2. In PowerShell, run `$PROFILE` to see the profile path for your current shell. Windows PowerShell 5.1 and PowerShell 7 can use different profile paths.
3. Back up any existing profile before copying or merging this file into that location.
4. Adjust `$themePath`, the optional application paths and `$previewScript` for your computer.
5. Restart PowerShell to load the profile.

---

**Notes:** This repository provides configuration, not the external executables or helper scripts. Optional commands may require separate installation. Windows Terminal keybindings are configured in `settings.json`, not this profile. The profile intentionally does not include personal dashboard, clock, visualiser or star scripts.
