# NixOS + DWM Configuration (Flakes)

## Description

This configuration is designed for **NixOS with DWM (Dynamic Window Manager)**. It includes several **custom Nix scripts** that may assist in building a personalized **NixOS + DWM** setup.

### Important

This configuration is tailored to a specific system. Copying it without understanding its structure and function is not recommended. If you choose to use it, be prepared to modify it accordingly.

---

## What Needs to Be Modified Before Use

### 1. Dotfiles Location

Dotfiles should be stored in:

$HOME/HOME/dotfiles

Additionally, update the username in the configuration to match your own. If you do not, you will need to rename your user account to **dash**.

### 2. Hardware Configuration File

Since hardware configurations vary, replace the existing file with one specific to your system. To generate a new configuration file, run:

sudo nixos-generate-config --show-hardware-config > /etc/nixos/hardware-configuration.nix

### 3. NVIDIA Configuration (If Applicable)

This configuration is set up for **offload mode**, which:

- Uses **Intel GPU** by default.
- Switches to **NVIDIA** for resource-intensive tasks.

#### Considerations:

- Your GPU may not support offload mode.
- Driver behavior varies across different hardware.
- Some GPUs require additional configuration steps.

If you have a **single GPU setup (Intel or NVIDIA only)**, adjustments will be necessary.

---

## How to Build the Configuration

Execute the following script:

./home/sh/sh-nixos/sapply

This will apply the configuration and rebuild the system.

---

## Why You Should Not Copy the Entire Configuration

If you do not understand its structure, you will likely encounter errors that are difficult to troubleshoot without knowledge of **Nix and Flakes**.

### Recommended Approach

Instead of copying the configuration outright, review its components, modify them as needed, and integrate them into your setup incrementally.
