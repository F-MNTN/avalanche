# NixFlakes
My dendritic (tree-like) nix flake setup

> # Niri
> config in ``` home/hosts/niri.kdl ```

> # Noctalia-Shell
> config in ``` home/common/noctalia.nix ```

> # Features
> ## NVF - NeoVim Manager
> - lauches via ``` nvim ```
> - config in ``` home/common/nvf-configuration.nix ```
> ## SOPS
> ### starting on a new host
> - Paste your key into this file
>     - ```~/.config/sops/age/keys.txt```
> ### adding a secret
> - Add it to secrets.yaml (using ```sops secrets/secrets.yaml```)
> - Declare it in the sops.secrets block
> - Reference it via config.sops.secrets.<name>.path
> #### Template structure in secrets.yaml
> ```yaml
> github_email: "REPLACEME@email.com"
> wifi:
>     eduroam:
>         email: "REPLACEME@email.com"
>         password: "supersecretdontstealpls"
> ``` 
> ## Fprintd authentification
> replace fingerprint file with your own if you want to use fingerprints to authenticate.
> - put it in ```modules/MyDevice/calib-data.bin``` and make sure to import the ```fprintauth.nix``` in ```modules/MyDevice/default.nix```.

> # TODO:
> - update setupscript.sh
> - correctly set screnshots with grim
