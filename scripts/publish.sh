#!/bin/sh
# Publish changed packages to the AUR via git subtree split + push.
#
# Usage:        ./publish.sh [pkg ...]
# First run:    AUR_OVERWRITE=1 ./publish.sh   (one-time history resync)
#
# After the first run, this script must be the ONLY thing that ever
# pushes to these AUR repos, otherwise pushes become non-fast-forward.
#
# Splits each package dir out of the current branch (main) and pushes
# it to the AUR repo's master branch.

set -u

aur_pkgs="bar-lobby-git betterleaks recoil-engine recoil-engine-rc"
status=0

if [ "$#" -gt 0 ]; then
    aur_pkgs="$*"
fi

for pkg in $aur_pkgs; do
    if [ ! -d "$pkg" ] || [ ! -f "$pkg/PKGBUILD" ]; then
        echo "ERROR: no package directory '$pkg' found." >&2
        status=1
        continue
    fi

    printf '%s: splitting subtree ... ' "$pkg"
    split=$(git subtree split --prefix="$pkg" main)
    if [ -z "$split" ]; then
        echo "ERROR: subtree split for '$pkg' failed." >&2
        status=1
        continue
    fi

    printf 'pushing ... '
    force=""
    if [ "${AUR_OVERWRITE:-0}" = "1" ]; then
        force="--force"
    fi

    if git push $force "ssh://aur@aur.archlinux.org/${pkg}.git" "$split:refs/heads/master"; then
        echo "ok"
    else
        echo "ERROR: pushing '$pkg' failed." >&2
        echo "       If this is a non-fast-forward rejection and you are migrating" >&2
        echo "       from the old per-package clones, run ONCE:" >&2
        echo "           AUR_OVERWRITE=1 ./publish.sh $pkg" >&2
        status=1
    fi
done

exit $status