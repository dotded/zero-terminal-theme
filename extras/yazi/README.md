# Yazi

Custom Yazi file manager settings and a coordinated dark theme with muted gold, moss-green and rust accents.

---

### Files

- **`yazi.toml`** — controls file browsing, sorting and previews.
- **`theme.toml`** — controls interface colours, borders, file-type highlighting and icons.
- **`keymap.toml`** — not included; Yazi's default keybindings remain active.

---

### Setup

1. Install [Yazi](https://yazi-rs.github.io/).
2. Open your Yazi configuration directory. On Windows, this is typically `%APPDATA%\yazi\config` (you can check the active directory with `yazi --debug`).
3. Back up any existing `yazi.toml` and `theme.toml` files.
4. Copy the two files from this folder into your Yazi configuration directory.
5. Start Yazi with `yazi`.

**Requirements:** A terminal with true-colour support. A Nerd Font is recommended for the folder icons.

---

### Browser Settings — `yazi.toml`

- **`[mgr] ratio = [1, 3, 3]`** — sets the relative widths of the parent, current and preview columns. Change the three numbers to adjust the layout.
- **`sort_by = "natural"`** — sorts names naturally, so `file2` appears before `file10`.
- **`sort_dir_first = true`** — places folders before files.
- **`show_hidden = false`** — hides dotfiles and other hidden entries by default. Change to `true` to show them.
- **`show_symlink = true`** — shows symbolic-link targets.
- **`[preview] wrap = "yes"`** — wraps long lines in text previews.

---

### Theme Settings — `theme.toml`

- **`[mgr]`** — current directory, search highlighting, selection markers and pane borders.
- **`[tabs]`** — active and inactive tab colours.
- **`[mode]`** — normal, select and unset mode indicators.
- **`[status]`** — permissions, progress indicators and status text.
- **`[which]`, `[confirm]`, `[input]`, `[help]`** — shortcut hints, confirmation dialogs, input fields and help panels.
- **`[filetype]`** — colours for images, media, archives, directories and other files.
- **`[icon]`** — folder icons and their colour. These glyphs are intended for a Nerd Font.

To change the palette, replace the hexadecimal colours (such as `#CBC190` for gold, `#858C58` for moss green and `#C46245` for rust) in `theme.toml`. Keep the surrounding TOML syntax intact.

---

### Customisation Notes

These files are independent of the PowerShell profile. If you use a PowerShell `y` function for changing your shell's working directory after exiting Yazi, that integration must be configured separately.
