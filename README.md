# NixFlakes
My dendritic (tree-like) nix flake setup

 # Niri
 config in ``` home/hosts/niri.kdl ```

refer to the [Niri - Documentation]
 # Noctalia-Shell
 config in ``` home/common/noctalia.nix ```

refer to the [Noctalia - Documentation]
# Features
## Feature: NVF - NeoVim Manager
lauches via ```bash nvim```

config in ```bash home/common/nvf-configuration.nix ```

refer to the [NVF - Documentation]
## Feature: SOPS
### starting on a new host
- Paste your key into this file
    - ```~/.config/sops/age/keys.txt```
### adding a secret
- Add it to secrets.yaml (using ```sops secrets/secrets.yaml```)
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
- put it in ```modules/MyDevice/calib-data.bin``` and make sure to import the ```fprintauth.nix``` in ```modules/MyDevice/default.nix```.
If issues arise refer to [vitor-grunwaldt's Guide] and [uunicorn's python-validity driver] as they were the basis of this setup.

> # TODO:
> - update setupscript.sh
> - correctly set screnshots with grim

[NVF - Documentation]: https://nvf.notashelf.dev/configuring.html
[Niri - Documentation]: https://niri-wm.github.io/niri/Configuration%3A-Introduction.html
[Noctalia - Documentation]: https://docs.noctalia.dev/getting-started/keybinds/
[vitor-grunwaldt's Guide]: https://github.com/viktor-grunwaldt/t480-fingerprint-nixos/blob/main/SETUP.md
[uunicorn's python-validity driver]: https://github.com/uunicorn/python-validity
