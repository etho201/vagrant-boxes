

# Podman-Machine Vagrant Box (deprecated)

## UPDATE: As of Podman v4.1.0, Podman now supports mounting the host machine’s home directory into the podman machine VMs by default.

Thanks to the latest update made to Podman, this Vagrant box is now deprecated. If you used this README before, here is how you can revert back and use the new podman machine that comes with Podman.

1. Make sure you have at least Podman v4.1.0 installed

    ```bash
    podman --version
    ```

2. Run the following to point the default connection to the native podman-machine and recreate the machine so that it matches the latest version of Podman.

    ```bash
    podman-remote system connection default podman-machine-default
    podman machine list
    podman machine rm podman-machine-default
    podman machine init
    podman machine start
    podman machine info
    ```

3. That's it. From this point on, you should just need to run `podman machine start` and bind mounting will work without any fuss.

---

## Getting Started (deprecated -- see note above)

You can of course use the new podman-machine that comes with Podman by typing `podman machine init` and `podman machine start`, but that currently lacks the ability to bind mount the host system. This Vagrant box solves that problem (see [Bind Mounting](#bind-mounting) for more info).

1. Install Podman on your host machine:

    ### MacOS:
    ```bash
    brew install podman
    ```

    ### Windows:
    ```bash
    chocolatey install podman
    ```

2. Ensure you have `ed25519` SSH keys configured on your system (saved under `~/.ssh/id_ed25519`).

    ```bash
    ssh-keygen -t ed25519
    ```

    > **NOTE:** podman-remote performs better with `ed25519` (as opposed to RSA)

3. Start the Podman Vagrant Box

    ```bash
    vagrant up
    ```

4. Configure Podman to connect to the Oracle Linux Podman instance:

    ```bash
    podman-remote system connection add vagrant --identity ~/.ssh/id_ed25519 ssh://vagrant@192.168.56.100/run/user/1000/podman/podman.sock

    podman-remote system connection default vagrant
    ```

5. You can verify things are working by typing:

    ```bash
    podman info
    ```

---

## Bind Mounting
- The host system is mounted under `/mnt` (similar to what is done in WSL). To bind mount the host system, proceed the $(pwd) with `/mnt`.

    ```bash
    PWD=/mnt$(pwd)
    ```

    > **NOTE:** You'll need to run this command any time you see `-v $(PWD)` in a `podman run` commmand.