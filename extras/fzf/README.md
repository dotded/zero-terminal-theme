# FZF Directory Preview

A PowerShell preview helper for an FZF and Zoxide directory navigator. It displays the contents of the highlighted directory using Eza, with a parchment, moss and rust colour palette.

---

### Files

- **`preview.ps1`** — reads the path selected by FZF and displays a two-level directory tree.
- **FZF settings** — the colours, layout and `zz` / `zi` functions are configured separately in the repository's PowerShell profile.

---

### Requirements

- **PowerShell** — runs the preview script; the supplied `zz` function launches it using `powershell.exe` (Windows PowerShell 5.1).
- **[fzf](https://github.com/junegunn/fzf)** — interactive directory selection.
- **[zoxide](https://github.com/ajeetdsouza/zoxide)** — supplies the directory history used by `zz`.
- **[Eza](https://github.com/eza-community/eza)** — renders the preview tree and icons. A Nerd Font is recommended for icons.

---

### Setup

1. Install the tools listed above and make sure they are available on your `PATH`.
2. Place `preview.ps1` at `$HOME\Tools\FZF\preview.ps1`, **or** edit `$previewScript` inside the `zz` function in your PowerShell profile to point to your preferred location.
3. Make sure your PowerShell profile includes the `zz` function and optional `zi` alias/function from this repository.
4. Open a new PowerShell session and run `zz` to browse directories. Press **Enter** to switch to the selected directory or **Esc** to cancel.

The preview script is **not** a standalone FZF configuration: it is called by the `--preview` option inside `zz`.

---

### How It Works

- **Selection file:** FZF passes a temporary file containing the highlighted directory path. The script reads that file instead of interpolating a directory path into a shell command.
- **Path validation:** Missing files, empty selections and nonexistent directories produce no preview.
- **Directory tree:** Eza lists hidden entries and displays a tree up to two levels deep, with directories first.
- **Colours:** ANSI true-colour sequences style the heading, directory path and footer.

---

### Customisation

- **Tree depth:** Change `--level=2` to `--level=1`, `--level=3` or another depth.
- **Hidden files:** Remove `--all` if you prefer not to display hidden entries.
- **Icons:** Change `--icons=always` to `--icons=never` if your font does not support them.
- **Colours:** Edit the RGB values assigned to `$gold`, `$moss` and `$rust` in `preview.ps1`.
- **Preview width:** Change `--preview-window=right:55%:wrap:border-left` in the PowerShell profile's `zz` function.
- **Navigation prompt and FZF palette:** Edit the `--prompt` and `--color` options in the PowerShell profile; they are not controlled by this script.

---

**Note:** The helper does not modify directories or files. The `zz` function handles changing the current directory after selection.
