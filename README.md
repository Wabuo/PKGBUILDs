# PKGBUILDs

My PKGBUILDs for the Arch Buble and for AUR packages maintained by me. <br>
PR's welcome ☺.

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


<br><br><br><br>

_____

#### Workflow

This repository is the source of truth; the AUR repos are published from it.

- **Releasing changes:** edit / commit here, `git push` to GitHub, then run:

      ./publish.sh

  Unchanged packages are skipped automatically.
- **Pull requests:** very welcome! Once merged into `main`, publishing works
  exactly as above.
- All commits in this repository are SSH-signed.

##### Git hooks

This repository ships its git hooks — they keep `.SRCINFO` files in sync with
the PKGBUILDs and block commits/pushes that would carry stale metadata.
After cloning, enable them once:

    git config core.hooksPath .githooks

##### Publishing to the AUR

`scripts/publish.sh` subtree-pushes each package directory to its AUR repo.
The very first run after migrating from standalone AUR clones needs a one-time
history resync:

    AUR_OVERWRITE=1 ./publish.sh

Afterwards, `./publish.sh` must remain the only writer of the AUR repos.
