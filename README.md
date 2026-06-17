
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

I've tested this to be working with MestReNova 14.3.3 because that's all my university has licensed for. All features work, to my understanding, but do let me know if you can patch things up to higher versions.
