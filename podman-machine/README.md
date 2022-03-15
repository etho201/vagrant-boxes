

# Podman-Machine Vagrant Box

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