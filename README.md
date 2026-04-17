# NixFlakes
My dendritic (tree-like) nix flake setup
# SOPS
## starting on a new host
- Paste your key into this file
    - ```~/.config/sops/age/keys.txt```
## adding a secret
- Add it to secrets.yaml (using sops secrets/secrets.yaml).
- Declare it in the sops.secrets block in Nix.
- Reference it via config.sops.secrets.<name>.path
### Template structure in secrets.yaml
```
github_email: REPLACEME@email.com
wifi:
    eduroam:
        email: REPLACEME@email.com
        password: supersecretdontstealpls
``` 
> # TODO:
> - update setupscript.sh
> - correctly set screnshots with grim
> - enable fingerprint authentification with fprintd (maybe have to switch away from tuigreet to sddm)

