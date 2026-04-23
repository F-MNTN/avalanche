# NixFlakes
My dendritic (tree-like) nix flake setup

 # Niri
 config in `home/hosts/niri.kdl`

refer to the [Niri - Documentation]
 # Noctalia-Shell
 config in `home/common/noctalia.nix`

refer to the [Noctalia - Documentation]
# Features
## Feature: NVF - NeoVim Manager
lauches via `nvim`

config in `home/common/nvf-configuration.nix`

refer to the [NVF - Documentation]
## Feature: SOPS
### starting on a new host
- Paste your key into this file
    - `~/.config/sops/age/keys.txt`
### adding a secret
- Add it to secrets.yaml (using `sops secrets/secrets.yaml`)
- Declare it in the sops.secrets block
- Reference it via config.sops.secrets.<name>.path
#### Template structure in secrets.yaml
```yaml
github_email: "REPLACEME@email.com"
wifi:
    eduroam:
        email: "REPLACEME@email.com"
        password: "supersecretdontstealpls"
``` 
## Feature: Fprintd authentification
replace fingerprint file with your own if you want to use fingerprints to authenticate.
- put it in `modules/MyDevice/calib-data.bin` and make sure to import the `fprintauth.nix` in `modules/MyDevice/default.nix`.
If issues arise refer to [vitor-grunwaldt's Guide] and [uunicorn's python-validity driver] as they were the basis of this setup.

> # TODO:
> [x] niri as a wm
>   [x] tuigreet + greetd
>   [x] touchpad support
> [x] noctalia-shell as a gui
>   [x] set some decent default hotkeys
> [x] nvf for neovim
>   [x] set some decent default hotkeys
> [x] encrypt secrets via sops
> [x] fprintd for auth
> [x] high quality bluetooth audio
> [x] push it on a public github (no leaks)
> [ ] fonts
>   [ ] hack as default mono font
>   [ ] jetbrains as default system font
>   [ ] noto-color as default emoji font
> [ ] screenshots 
>   [ ] create a screenshot-script using grim
>   [ ] tie it together in `niri.kdl` with hotkeys
> [ ] adjust setupscript.sh to actually work with
>   [ ] selecting or creating a new host
>   [ ] updating hardware.nix for a selected host on demand
>   [ ] creating their own user
> [ ] adjust nvim
>   [ ] keymaps
>       [ ] git as `<leader>gg`
>       [ ] harpoon as `<leader>1-4` without overlaps
>   [ ] dashboard-alpha
>       [ ] make buttons work/put useful buttons on dashboard
> [ ] dmenu pickers
>   [ ] clipboard history pickers
>       [ ] text
>       [ ] screenshots
>   [ ] emoji picker
> [ ] screen recording
>   [ ] do research how that would work
>   [ ] test with obs/discord
> [ ] create modules/options to import/enable for specifics
>   [ ] gaming
>   [ ] development
>   [ ] media editing/creation
>   [ ] implement these as toggle-able options in `setupscript.sh` to opt-in
> [ ] screenshot/screen recording dmenu command integration `MOD + Space -> "record window" "record screen" "screenshot window" "screenshot"`

[NVF - Documentation]: https://nvf.notashelf.dev/configuring.html
[Niri - Documentation]: https://niri-wm.github.io/niri/Configuration%3A-Introduce tion.html
[Noctalia - Documentation]: https://docs.noctalia.dev/getting-started/keybinds/
[vitor-grunwaldt's Guide]: https://github.com/viktor-grunwaldt/t480-fingerprint-nixos/blob/main/SETUP.md
[uunicorn's python-validity driver]: https://github.com/uunicorn/python-validity
