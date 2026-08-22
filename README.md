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
them only after deciding that you trust the corresponding GitHub release:

```sh
brew install --cask hanwenguo/tap/browstay
brew install --cask hanwenguo/tap/emacs-ns-static
brew install --cask hanwenguo/tap/emacs-ns-static@master
brew install --cask hanwenguo/tap/emacs-ns-static-native-comp
brew install --cask hanwenguo/tap/emacs-ns-static-native-comp@igc
```

Homebrew verifies every downloaded archive against the SHA-256 checksum in this
tap. Homebrew 6 no longer supports `--no-quarantine`. If Gatekeeper blocks the
first launch, approve the app explicitly in System Settings > Privacy & Security.
The tap does not remove quarantine automatically.

Alternatively, tap the repository once and use short package names:

```sh
brew tap hanwenguo/tap
brew trust --tap hanwenguo/tap
brew install lantai
```

Whole-tap trust allows Homebrew to load every current and future package in the
tap. Prefer the fully qualified commands above when you only want to trust one
specific formula or cask.

## Packages

| Token | Kind | Contents |
| --- | --- | --- |
| `lantai` | Formula | BibLaTeX-backed headless reference manager |
| `weibian` | Formula | `wb` Typst document compiler and site builder |
| `font-akvesoi` | Cask | All four Akvesoi families in nine TTC weights |
| `browstay` | Cask | Universal macOS 14+ browser-routing app |
| `emacs-ns-static` | Cask | Daily Emacs 31 Apple Silicon build |
| `emacs-ns-static@master` | Cask | Daily Emacs master Apple Silicon build |
| `emacs-ns-static-native-comp` | Cask | Daily Emacs 31 build with native compilation |
| `emacs-ns-static-native-comp@igc` | Cask | Emacs IGC-branch build with native compilation |

The formulae build from tagged source inside Homebrew. They support Apple
Silicon on macOS 15 and 26 and ARM64 or x86-64 Linux; Intel macOS is not
supported.

The Emacs casks require Apple Silicon and macOS 15 or newer. Each installs
`Emacs.app`, `Emacs Client.app`, `emacs`, `emacsclient`, `ebrowse`, and `etags`.
The four channels conflict with one another and with the official `emacs-app`
channels because they install the same app bundles and command-line tools. The
native-compilation channels invoke the Apple toolchain through `xcrun` at
runtime, so they additionally need Xcode or the Command Line Tools installed.

## Automation

The updater checks upstream GitHub releases every six hours. When a version
changes, it opens or refreshes `automation/package-updates`, creates a pull
request with `gh`, and dispatches the test workflow for the exact head commit.
Formulae are built on Apple Silicon macOS 15 and 26 and on ARM64 and x86-64 Linux.
After every matrix job succeeds, the workflow invokes Homebrew's
head-SHA-checked `brew pr-pull` flow to publish bottles to GitHub Releases and
land the update.

Human pull requests use the same tests and can be published by manually running
the `brew pr-pull` workflow with the reviewed pull request number and head SHA.
