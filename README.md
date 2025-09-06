# boxocluster

Run your own Virtual HPC cluster using QEMU

## Getting Started

running is as simple as grabbing the head node's disk image and the docker-compose file and running the stack.

### Linux

Docker is native on linux. Ensure you have docker-compose v2 installed, then do the following:

```bash
git clone https://github.com/dhelgerson/boxocluster.git
cd boxocluster
curl -LO https://j3b.in/boxocluster/boxocluster-node-1.qcow2
docker compose up -d
docker compose logs -f &
```

- follow the instructions to connect to your new virtual cluster

### Windows

Docker Desktop is recommended for Windows.

1. **Download Docker Desktop**

   * Go to [Docker Desktop for Windows](https://www.docker.com/products/docker-desktop/).
   * Download the installer for Windows.

2. **Run the installer**

   * Double-click the `.exe` file and follow the prompts.
   * When asked, enable:

     * **Use WSL 2 instead of Hyper-V** (recommended for most users).
     * Install the **required WSL 2 feature** if you don’t already have it.

3. **Restart your machine** (if prompted).

4. **Verify installation**

   * Open **PowerShell** or **Command Prompt** and run:

     ```powershell
     docker --version
     docker compose version
     ```
   * You should see Docker and Docker Compose versions printed.

5. From here, you can follow the steps for Linux.

### macOS

Docker Desktop is recommended for macOS.

1. **Download Docker Desktop**

   * Go to [Docker Desktop for Mac](https://www.docker.com/products/docker-desktop/).
   * Download the `.dmg` installer for macOS.

2. **Install Docker Desktop**

   * Open the downloaded `.dmg` file.
   * Drag the Docker icon into your **Applications** folder.
   * Launch Docker from **Applications**.

3. **Grant permissions if prompted**

   * You may need to enter your macOS password to allow Docker to install helper tools.

4. **Verify installation**

   * Open **Terminal** and run:

     ```bash
     docker --version
     docker compose version
     ```
   * You should see Docker and Docker Compose versions printed.

5. From here, you can follow the steps for Linux.
