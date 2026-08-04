# Hanwen's Homebrew Tap

Homebrew formulae and casks for Hanwen Guo's personal projects.

## Install

You can use fully qualified names without tapping first:

```sh
brew install hanwenguo/tap/lantai
brew install hanwenguo/tap/weibian
brew install --cask hanwenguo/tap/font-akvesoi
```

The macOS app builds are ad-hoc signed and are not notarized by Apple. Install
them with `--no-quarantine` only after deciding that you trust the corresponding
GitHub release:

```sh
brew install --cask --no-quarantine hanwenguo/tap/browstay
brew install --cask --no-quarantine hanwenguo/tap/emacs-ns-static
brew install --cask --no-quarantine hanwenguo/tap/emacs-ns-static-master
brew install --cask --no-quarantine hanwenguo/tap/emacs-ns-static-igc
```

Homebrew verifies every downloaded archive against the SHA-256 checksum in this
tap. `--no-quarantine` bypasses Apple's Gatekeeper quarantine check; it does not
disable Homebrew's checksum verification.

Alternatively, tap the repository once and use short package names:

```sh
brew tap hanwenguo/tap
brew install lantai
```

## Packages

| Token | Kind | Contents |
| --- | --- | --- |
| `lantai` | Formula | BibLaTeX-backed headless reference manager |
| `weibian` | Formula | `wb` Typst document compiler and site builder |
| `font-akvesoi` | Cask | All four Akvesoi families in nine TTC weights |
| `browstay` | Cask | Universal macOS 14+ browser-routing app |
| `emacs-ns-static` | Cask | Daily Emacs 31 Apple Silicon build |
| `emacs-ns-static-master` | Cask | Daily Emacs master Apple Silicon build |
| `emacs-ns-static-igc` | Cask | Emacs IGC-branch Apple Silicon build |

The Emacs casks require Apple Silicon and macOS 15 or newer. Each installs
`Emacs.app`, `Emacs Client.app`, `emacs`, `emacsclient`, `ebrowse`, and `etags`.
The three channels conflict with one another and with the official `emacs-app`
channels because they install the same app bundles and command-line tools.

## Automation

The updater checks upstream GitHub releases every six hours. When a version
changes, it opens or refreshes `automation/package-updates`, creates a pull
request with `gh`, and dispatches the test workflow for the exact head commit.
Formulae are built on Apple Silicon and Intel macOS and on ARM64 and x86-64
Linux. After every matrix job succeeds, the workflow invokes Homebrew's
head-SHA-checked `brew pr-pull` flow to publish bottles to GitHub Releases and
land the update.

Human pull requests use the same tests and can be published by manually running
the `brew pr-pull` workflow with the reviewed pull request number and head SHA.
