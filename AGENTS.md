# Chezmoi Source Repository

This repository is the chezmoi source state used to manage home-directory files.

## Working here

- Source filenames use chezmoi attributes: for example, `dot_bashrc` maps to
  `~/.bashrc`, and `executable_` makes a target executable.
- Preview changes before applying them. Prefer `chezmoi diff`; use
  `chezmoi apply` only after reviewing the result.
- Keep repository-only files explicitly listed in `.chezmoiignore`; otherwise,
  a normal source file may be interpreted as a file to install under `$HOME`.
- Configuration is templated in `.chezmoi.toml.tmpl`. Do not place secrets in
  tracked source files.

## Noctalia

- The installed Noctalia version is **v5.0.1** (`noctalia --version`), provided
  by the system Nix profile.
- Its configuration source is `dot_config/noctalia/config.toml`, which maps to
  `~/.config/noctalia/config.toml`.

### Documentation

- [Noctalia documentation](https://docs.noctalia.dev/noctalia/)
- [Configuration reference](https://docs.noctalia.dev/noctalia/configuration/)
- [Bar configuration](https://docs.noctalia.dev/noctalia/bar/)
- [Clock widget](https://docs.noctalia.dev/noctalia/bar/widgets/clock/)

## References

- [Chezmoi documentation](https://www.chezmoi.io/)
- [Quick start](https://www.chezmoi.io/quick-start/)
- [Target file attributes and naming](https://www.chezmoi.io/user-guide/manage-files/)
- [Templates](https://www.chezmoi.io/user-guide/templating/)
- [Previewing and applying changes](https://www.chezmoi.io/user-guide/daily-operations/)
