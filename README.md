Square Root Simplifier in ARM Assembly
======================================
An ARM Assembly program that simplifies square roots.
Input number can be up to 8 digits long.

### Usage
Clone the repository then `cd` to the directory:
```
$ git clone https://github.com/s7a19t4r/asm-sqrtsimplify
$ cd asm-sqrtsimplify
```

##### Native ARM
1. Verify system architecture to match syntax and ability to run ARM binaries. 
Run the following commands to run the Bash script:
    ```
    $ ./check-arch.sh
    ```
    If the result is successful, proceed. If not, use alternative options below (QEMU Emulator or Virtual Machine)

    If permission to run Bash script is denied, run
    ```
    $ chmod +x check-arch.sh
    ```
    then run script again

2. Assembler and linker should be automatically installed, use makefile with `native` to compile (defaults to `native`):
    ```
    $ make native
    ```
3. Run ELF
    ```
    $ ./main.elf
    ```

##### Emulator (QEMU)
macOS not supported due to absence of `qemu-user` package, which includes necessary commands
1. Install QEMU:
    ```
    $ sudo apt install qemu-user
    ```
2. Install GNU cross-compiler for ARM architecture
    ```
    $ sudo apt install gcc-arm-linux-gnueabi
    ```

3. Use makefile with `virtual` to compile:
    ```
    $ make virtual
    ```

4. Run ELF with QEMU emulator
    ```
    $ qemu-arm ./main.elf
    ```

##### Virtual Machine (QEMU)
[raspi_github_link]: https://github.com/s7a19t4r/raspi-setup
To setup Raspberry-Pi virtual machine using QEMU, visit the [GitHub repository][raspi_github_link] for my VM setup configurations.

