# CAVA

A minimal CAVA audio visualiser configuration with moss-green bars, a transparent terminal background and smooth animation.

---

### Configuration

- **File:** `config`
- **Frame rate:** `60` FPS for fluid animation
- **Bar colour:** `#858C58` (moss green)
- **Background:** `default`, using the terminal's existing background
- **Gradient:** Disabled (`0`) for a single bar colour

---

### Setup

1. Install [CAVA](https://github.com/karlstav/cava) or a compatible Windows build.
2. Locate the configuration directory used by your CAVA installation. On this Windows setup, the file is stored at `%APPDATA%\cava\config`.
3. Back up any existing `config`, then copy this file into that directory.
4. Start CAVA. If your build requires an explicit configuration path, use its `-p` option to point to this file.

---

### General Settings

- `bars = 0` — lets CAVA automatically determine the number of bars based on the available width.
- `bar_width = 3` — sets each bar's width in character cells.
- `bar_spacing = 1` — leaves one character cell between bars.
- `framerate = 60` — targets 60 visual updates per second; lower this if you prefer reduced resource use.
- `sensitivity = 100` — sets the base audio sensitivity.
- `autosens = 1` — automatically adjusts sensitivity as audio levels change.

---

### Colours

- `background = default` — keeps your terminal's existing background.
- `foreground = '#858C58'` — changes the bars to moss green. Replace the hex code to match another theme.
- `gradient = 0` — disables multi-colour gradients.

---

### Smoothing

- `noise_reduction = 77` — reduces rapid fluctuations for steadier movement; adjust to taste.
- `monstercat = 1` — enables the Monstercat-style smoothing effect.
- `waves = 0` — disables wave-style smoothing.

---

**Note:** This file controls the visualiser's appearance and behaviour. Audio capture depends on the CAVA build and audio backend installed on your system. It does not install CAVA or configure an audio source.
