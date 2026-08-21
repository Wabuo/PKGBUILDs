# pkgbuilds

My PKGBUILDs for Arch Linux / the AUR.

## Packages

| Package | AUR |
| --- | --- |
| [bar-lobby-git](bar-lobby-git/) | <https://aur.archlinux.org/packages/bar-lobby-git> |
| [betterleaks](betterleaks/) | <https://aur.archlinux.org/packages/betterleaks> |
| [recoil-engine-rc](recoil-engine-rc/) | <https://aur.archlinux.org/packages/recoil-engine-rc> |
| [recoil-engine](recoil-engine/) | not on the AUR (yet) |

## License

Unless stated otherwise, everything in this repository is licensed under the
[0BSD](https://spdx.org/licenses/0BSD.html) license (see LICENSE).

Package directories may contain their own `LICENSE` / `REUSE.toml` files, and
the upstream software built by each PKGBUILD remains under its own license —
those take precedence where they differ.

## Contributing

Found a bug? Feel free to open an issue or send a pull request.

All commits in this repository are SSH-signed.

### Git hooks

This repository ships its git hooks — they keep `.SRCINFO` files in sync with
the PKGBUILDs and block commits/pushes that would carry stale metadata.
After cloning, enable them once:

    git config core.hooksPath hooks
