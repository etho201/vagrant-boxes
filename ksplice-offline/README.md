# Ksplice Offline

## Live Patching:

1. Install the ksplice-offline client:

    ```bash
    dnf install ksplice-offline
    ```

2. Check the effective uname output for the kernel

    ```bash
    ksplice kernel uname -a
    uname -a
    ```

3. Install the uptrack-updates for the currently installed kernel release:

    ```bash
    dnf install uptrack-updates-`uname -r`
    ```

4. Check the effective uname output for the kernel

    ```bash
    ksplice kernel uname -a
    uname -a
    ```

## Backing out of patches without reboot:

1. Removing Ksplice updates is easy: just run `ksplice kernel remove --all` to uninstall all updates, bringing you back to your original stock kernel, or uninstall individual updates by specifying a Ksplice ID

    ```bash
    ksplice kernel remove --all
    ```

    or

    ```bash
    ksplice kernel remove ${KSPLICE_ID}
    ```

2. Next time you want to live-patch the system, simply run:

    ```bash
    ksplice kernel upgrade
    ```

---

> **NOTE:** Ksplice patches enable you to keep a system up to date while it is running. **You should also use the yum command to install the regular kernel RPM packages for released errata that are available from the Unbreakable Linux Network (ULN) or the Oracle Linux yum server. Your system will then be ready for the next maintenance window or reboot.** When you restart the system, you can boot it from a newer kernel version. Ksplice Uptrack uses the new kernel as a baseline for applying patches as they become available.