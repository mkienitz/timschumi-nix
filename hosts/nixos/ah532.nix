{inputs, ...}: {
  system = "x86_64-linux";
  modules = [
    (inputs.self + "/modules/variant-desktop.nix")

    ({
      config,
      lib,
      pkgs,
      modulesPath,
      ...
    }: {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      boot.initrd.availableKernelModules = ["xhci_pci" "ehci_pci" "ahci" "ums_realtek" "usb_storage" "sd_mod" "sr_mod"];
      boot.initrd.kernelModules = [];
      boot.kernelModules = ["kvm-intel"];
      boot.extraModulePackages = [];

      fileSystems."/" = {
        device = "/dev/disk/by-uuid/e0224b13-6b88-48e9-8446-7ca1d39fe228";
        fsType = "ext4";
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/F3DC-48DC";
        fsType = "vfat";
      };

      swapDevices = [];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      networking.hostName = "ah532";
    })
  ];
}
