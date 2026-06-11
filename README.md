
# MestReNova-nix

Simply import the overlay:

```nix
nova-nix = {
    url = "github:hideyosh1/nova-nix";
    inputs.nixpkgs.follows = "nixpkgs";
};
```

In your system configuration:
```nix
nixpkgs.overlays = [
    nova-nix.overlays.default
];
```

Then install `pkgs.mnova` as normal.

This is untested since I don't have a license right now.
