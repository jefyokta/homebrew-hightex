# homebrew-hightex

Official Homebrew tap for [HighTex Desktop](https://github.com/jefyokta/hightex-desktop),
a local-first desktop document editor for academic writing.

## Installation

### Latest version (recommended)

```sh
brew tap jefyokta/hightex
brew trust jefyokta/hightex
brew install --cask hightex   # macOS
brew install hightex          # Linux
```

This always resolves to the newest published release. No version number
needed.

### A specific version

```sh
brew install --cask hightex@0.0.15   # macOS
brew install hightex@0.0.15          # Linux
```

Pinned installs are frozen on purpose — `hightex update` will refuse to run
on them. To move to a different version, uninstall and install the new pin,
or switch to the unpinned `hightex` formula above.
If the version you want isn't listed, ask the maintainer to run `make-versioned.sh <version>`, or open an issue.

## Updating

For the latest-tracking install:
```sh
hightex update
```
This fetches the newest release from GitHub directly and replaces the
installed app — no need to run `brew upgrade` first.

For pinned installs, `hightex update` is a no-op by design.

## Uninstalling

```sh
brew uninstall --cask hightex          # macOS, latest
brew uninstall hightex                 # Linux, latest
```

## Troubleshooting

**macOS — app blocked by Gatekeeper on first launch**

The Cask runs `xattr -cr` automatically during install. If you still see a
warning, run:
```sh
xattr -cr /Applications/HighTex.app
```

**Linux — "fuse: failed to exec fusermount3"**

The AppImage requires FUSE:
```sh
sudo apt install libfuse2    # Debian / Ubuntu
sudo dnf install fuse        # Fedora / RHEL
sudo pacman -S fuse2         # Arch
```


---

## For maintainers

**To freeze a version as permanently installable** (in addition to the bump
above, or independently for an older release):
```sh
./make-versioned.sh 0.0.11
```
This generates `Casks/hightex@0.0.11.rb` and `Formula/hightex@0.0.11.rb` from
the release assets and commits them. Update the version list above when you
do this.
