# Oh My Posh

Custom adaptive Oh My Posh prompt for the **zero** terminal theme.

### Theme
- **File:** `zero-adaptive.omp.json`
- **Colours:** Uses the terminal's ANSI colour scheme
- **Font:** Nerd Font required for icons and separators

### Setup
1. Install [Oh My Posh](https://ohmyposh.dev/).
2. Place `zero-adaptive.omp.json` in your Oh My Posh configuration directory.
3. Load the theme in your PowerShell profile:

```powershell
oh-my-posh init pwsh --config "$HOME\.config\ohmyposh\zero-adaptive.omp.json" | Invoke-Expression
```