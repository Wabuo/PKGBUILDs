#!/bin/sh
# Publish changed packages to the AUR via git subtree push.
#
# Usage:        ./publish.sh [pkg ...]
# First run:    AUR_OVERWRITE=1 ./publish.sh   (one-time history resync)
#
# After the first run, this script must be the ONLY thing that ever
# pushes to these AUR repos, otherwise pushes become non-fast-forward.

set -u

aur_pkgs="bar-lobby-git betterleaks recoil-engine-rc"
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

    printf '%s: publishing ... ' "$pkg"
    if git subtree push --prefix="$pkg" "ssh://aur@aur.archlinux.org/${pkg}.git" master; then
        :
    else
        echo "ERROR: pushing '$pkg' failed." >&2
        echo "       If this is a non-fast-forward rejection and you are migrating" >&2
        echo "       from the old per-package clones, run ONCE:" >&2
        echo "           AUR_OVERWRITE=1 ./publish.sh $pkg" >&2
        status=1
    fi
done

exit $status
