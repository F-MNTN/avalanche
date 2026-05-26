# NixFlakes

My dendritic (tree-like) nix flake setup

# The `setup-host.sh` script
## How to execute
You need `python3` and `git` to exectute this script.
While not strictly required by the script `sops` and `age` are required for setup too.
The easiest way on nix to get them without rebuilding to run `nix-shell -p python3 git sops age`.

### setting up ``sops``
age-keygen -o /home/mntn/.config/sops/age/keys.txt
1. ``mkdir -p /home/mntn/.config/sops/age`` to create directory
2. ``age-keygen -o ~/.config/sops/age/keys.txt`` to generate a public-private keypair
3. add your public key to ``.sops.yaml``
    1. ```yaml
        keys:
          - &admin   age1xxxxxxxx   # admin key — stays on chronos, used for re-encryption
          - &chronos age1xxxxxxxx
          - &newhostname age1xxxxxxxx   # ← add this
         
        creation_rules:
          - path_regex: secrets/.*\.yaml$
            key_groups:
              - age:
                  - *admin
                  - *chronos
                  - *newhostname   # ← and this
       ```
    2. if this is your first machine repeat the same for ``age-keygen -o /home/mntn/.config/sops/age/admin.txt``
    3. then encrypt the secrets using ``SOPS_AGE_KEY_FILE=/home/mntn/.config/sops/age/admin.txt sops updatekeys secrets/secrets.yaml``
4. ``git add`` the changes
5. Now you are free to run ``sops secrets/secrets.yaml`` and add/change your secrets
5. Then just run the script using `sudo bash setup-host.sh`.

>[!Info] Why have the admin key
> The admin key is the only one that needs to be present to ``sops updatekeys secrets/secrets.yaml``.
> Other hosts only need to have their own host key to decrypt

# Niri
config in `home/hosts/niri.kdl`
refer to the [Niri - Documentation](https://niri-wm.github.io/niri/Configuration%3A-Introduction.html)

# Noctalia-Shell
config in `home/common/noctalia.nix`
refer to the [Noctalia - Documentation](https://docs.noctalia.dev/getting-started/keybinds/)

# Features
## Feature: NVF - NeoVim Manager
config in `home/common/nvf-configuration.nix`
refer to the [NVF - Documentation](https://nvf.notashelf.dev/configuring.html)

## Feature: SOPS
All credentials are centralized in `secrets/secrets.yaml` and encrypted with the keys in `~/.config/sops/age/keys.txt`.
### starting on a new host
- Paste your key into this file
    - `~/.config/sops/age/keys.txt`
Then follow the `setup-host.sh` script.
### Sops split
Secrets are split across two layers:

| File | Module type | Purpose |
|---|---|---|
| modules/common/sops-system.nix | NixOS | Secrets read by system services (e.g. NetworkManager for eduroam) |
| home/common/sops-user.nix | home-manager | Secrets read by user programs (e.g. git email) |

The split is forced by process boundaries — NetworkManager runs as root before any user session exists, so eduroam credentials must be available at the system level.

### adding a secret
- Add it to secrets.yaml (using `sops secrets/secrets.yaml`)
- Declare it in the corresponding sops.secrets block
- Reference it via config.sops.secrets.<name>.path

#### Example template structure in secrets.yaml
```secrets/secrets.yaml
github:
    email: "REPLACEME@email.com"
wifi:
    eduroam:
        email: "REPLACEME@email.com"
        password: "supersecretdontstealpls"
``` 

## Feature: Fprintd authentification
replace fingerprint file with your own if you want to use fingerprints to authenticate.
- put it in `modules/MyDevice/calib-data.bin` and make sure to import the `fprintauth.nix` in `modules/MyDevice/default.nix`.
If issues arise refer to [vitor-grunwaldt's Guide](https://github.com/viktor-grunwaldt/t480-fingerprint-nixos/blob/main/SETUP.md) and [uunicorn's python-validity driver](https://github.com/uunicorn/python-validity) as they were the basis of this setup.

> # TODO:
> - [x] niri as a wm
>   - [x] tuigreet + greetd
>   - [x] touchpad support
> - [x] noctalia-shell as a gui
>   - [x] set some decent default hotkeys
> - [x] nvf for neovim
>   - [x] set some decent default hotkeys
> - [x] encrypt secrets via sops
> - [x] fprintd for auth
> - [x] high quality bluetooth audio
> - [x] push it on a public github (no leaks)
> - [x] fonts
>   - [x] hack as default mono font
>   - [x] jetbrains as default system font
>   - [x] noto-color as default emoji font
> - [x] screenshots 
>   - [x] create a screenshot-script using grim
>   - [x] tie it together in `niri.kdl` with hotkeys
> - [x] adjust setupscript.sh to actually work with
>   - [x] selecting or creating a new host
>   - [x] updating hardware.nix for a selected host on demand
> - [ ] adjust nvim
>   - [ ] make whichkey show defaults
>   - [x] keymaps
>       - [x] git as `<leader>gg`
>       - [x] harpoon as `<leader>1-4` without overlaps
>   - [x] dashboard-alpha
>       - [x] make buttons work/put useful buttons on dashboard
>   - [ ] markdown/obsidian ready
>       - [x] integrate markdown renderer for `.md`
>       - [ ] include latex parsing
> - [ ] dmenu pickers
>   - [ ] clipboard history pickers
>       - [ ] text
>       - [ ] screenshots
>   - [ ] emoji picker
> - [x] screen recording
>   - [x] do research how that would work
>   - [x] test with obs/discord
> - [ ] create modules/options to import/enable for specifics
>   - [ ] gaming
>   - [ ] development
>   - [ ] media editing/creation
>   - [ ] implement these as toggle-able options in `setupscript.sh` to opt-in
> - [ ] screenshot/screen recording dmenu command integration `MOD + Space -> "record window" "record screen" "screenshot window" "screenshot"`
> - [ ] Hosts
>   - [x] Chronos
>   - [x] Aether
>   - [ ] Apollo
>   - [ ] Haephestus
>
