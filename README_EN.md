# Phoebe Chibi · Codex Desktop Pet

An unofficial, fan-made Codex v2 desktop pet inspired by Phoebe from *Wuthering Waves*. It includes idle, movement, wave, jump, waiting, working, completion, failure, and 16-direction look animations.

![Animation overview](assets/animations.png)

## Install on Windows

Run this command in PowerShell:

```powershell
$p="$env:TEMP\install-codex-phoebe-pet.ps1"; irm https://raw.githubusercontent.com/RuichiXu/codex-phoebe-pet/main/install.ps1 -OutFile $p; & $p
```

Restart Codex after installation. The pet is installed to:

```text
%USERPROFILE%\.codex\pets\phoebe-chibi
```

Run the same command again to update.

## Install from a clone

```powershell
git clone https://github.com/RuichiXu/codex-phoebe-pet.git
cd codex-phoebe-pet
.\install.ps1
```

## Uninstall

From a cloned copy of the repository:

```powershell
.\uninstall.ps1
```

You can also remove `%USERPROFILE%\.codex\pets\phoebe-chibi` manually.

## Technical details

- Codex pet sprite version: v2
- Atlas: 8 columns × 11 rows, 1536 × 2288, RGBA WebP
- Standard states: idle, running right, running left, waving, jumping, failed, waiting, working, and review
- Look states: 16 directions at 22.5° intervals

## Disclaimer

This is an unofficial fan project and is not affiliated with or endorsed by Kuro Games. *Wuthering Waves*, Phoebe, and related names, designs, and intellectual property belong to their respective rights holders. This repository is intended for personal, non-commercial use. Character artwork is not licensed under the code license. See [NOTICE.md](NOTICE.md).

Installer code is available under the MIT License; character artwork is excluded. See [LICENSE-CODE](LICENSE-CODE).
