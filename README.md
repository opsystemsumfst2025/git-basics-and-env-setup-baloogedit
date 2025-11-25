[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/gKowZKGE)
-----

# Lab 01: The Linux Environment

Welcome to the Operating Systems Seminar. 🐧

This course requires a **Linux Kernel**. You cannot complete this course using just the macOS Terminal (which is BSD/Darwin) or the standard Windows Command Prompt.

**Goal:** Set up a virtualized Linux environment, configure your development toolchain, and submit a cryptographic "proof of life" to GitHub.

-----

## 📚 Part 1: Choose Your Installation Path

You must install Ubuntu (22.04 or 24.04). Choose the instructions that match your physical computer.

### 🟦 Option A: Windows Users (Recommended: WSL2)

The "Windows Subsystem for Linux" allows you to run the Linux kernel directly inside Windows.

1.  **Install:** Open PowerShell as Administrator and run:
    ```powershell
    wsl --install
    ```
2.  **Restart:** Restart your computer.
3.  **Initialize:** Open the "Ubuntu" app from your Start menu. Create a username and password.
4.  **Video Guide:** [Install Linux on Windows 11 (2025) Step-by-Step WSL2 Guide for Beginners](https://www.youtube.com/watch?v=4hiA3NjFSqQ)

### 🍎 Option B: MacOS Users (Virtual Machine)

Since macOS is Unix-based but not *Linux*, you need a Virtual Machine.

**If you have an Apple Silicon Mac (M1, M2, M3 chip):**

1.  Download **UTM** (Free version from their site, not App Store).
2.  Download the **Ubuntu Server for ARM** ISO.
3.  Create a new VM in UTM: "Virtualize" -\> "Linux" -\> Select your ISO.
4.  **Video Guide:** [How to Install Ubuntu Linux VM on a Mac (M1 / M2 / M3 / M4 / M5) with UTM\!](https://www.youtube.com/watch?v=1PL-0-5BNXs)

**If you have an Intel Mac (Older):**

1.  Download **VirtualBox**.
2.  Download the **Ubuntu Desktop** ISO.
3.  Create a new VM in VirtualBox and mount the ISO.
4.  **Video Guide:** [How to Install VirtualBox & Ubuntu Desktop (Full Guide 2025)](https://www.youtube.com/watch?v=qK3ewSye81g)

-----

## 🛠️ Part 2: The Toolchain Setup

Once you are inside your Linux terminal (WSL or VM), run these commands to install the compilers and the visual verification tool.

```bash
# 1. Update the package list
sudo apt update

# 2. Install GCC (Compiler), Make, Git, and Neofetch
sudo apt install build-essential git neofetch

# 3. Verify installation
gcc --version
git --version
```

**New to Git?** Watch this first: [GitHub Tutorial for Beginners (2025)](https://www.youtube.com/watch?v=v5gnvDUWqFM)

-----

## 📝 Part 3: The Assignment

You need to clone this repository, write a C program, and generate a proof file.

### Step 1: Clone the Repo

1.  Copy the SSH or HTTPS URL from the green **Code** button above.
2.  In your Linux terminal:
    ```bash
    git clone <PASTE_URL_HERE>
    cd operating_systems_seminar_01-<YOUR_USERNAME>
    ```

### Step 2: Create `sys_check.c`

Create a C program that prints your Kernel version.

```c
#include <stdio.h>
#include <stdlib.h>
#include <sys/utsname.h>

int main() {
    struct utsname buffer;

    if (uname(&buffer) != 0) {
        perror("uname");
        exit(EXIT_FAILURE);
    }

    printf("OS Node: %s\n", buffer.nodename);
    printf("OS Name: %s\n", buffer.sysname);
    printf("Release: %s\n", buffer.release);
    
    // Check if we are actually on Linux
    // Note: MacOS will report "Darwin" here.
    return 0;
}
```

### Step 3: Create the `verify.sh` Script

This script generates the proof that you are running on a valid Linux system. It grabs the content of `/proc/version` (which contains the exact Kernel build info) and saves it.

Create a file named `verify.sh`:

```bash
#!/bin/bash

# 1. Compile the C code
echo "Compiling C Code..."
gcc sys_check.c -o sys_check

# 2. Run the C code and save output to a file
echo "Running System Check..."
./sys_check > proof.txt

# 3. APPEND the contents of the secret kernel file
# This file /proc/version ONLY exists on Linux systems.
# If you are on Mac/Windows without a VM, this will fail.
echo "------------------------------------------------" >> proof.txt
echo "KERNEL DEEP CHECK:" >> proof.txt
cat /proc/version >> proof.txt
echo "------------------------------------------------" >> proof.txt

echo "Verification Complete. 'proof.txt' generated."
```

**Make it executable:**

```bash
chmod +x verify.sh
```

-----

## 📸 Part 4: Visual Proof

1.  Run the command `neofetch` in your terminal.
      * *It will display the Ubuntu logo and your PC specs.*
2.  Take a screenshot of the terminal window.
3.  Name the file `screenshot.png` (or jpg).
4.  Move this image into the repository folder.
      * *WSL Users:* You can access your Windows files from Linux at `/mnt/c/Users/YourName/...` to copy the image in.
      * *VM Users:* You can drag and drop, or just log into GitHub inside the VM browser to upload.

-----

## 🚀 Part 5: Submission

Your repository must contain:

1.  `sys_check.c`
2.  `verify.sh`
3.  `proof.txt` (Generated by running `./verify.sh`)
4.  `screenshot.png` (The image of neofetch)

**Commands to submit:**

```bash
./verify.sh           # Make sure you run this first!
git add .
git commit -m "Setup complete with proof"
git push origin main
```

**Note:** If the `proof.txt` does not contain the text "Linux version...", your assignment will be marked as incomplete.
