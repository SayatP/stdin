.section .bss
.comm arr, 2

.section .text
.globl _start

# for read() or write()
# %rax should contain a number of the syscall
#       read() syscall number is 0 in linux. 0x2000003 in macos.
#      write() syscall number is 1 in linux. 0x2000004 in macos.
# %rdi should contain a file descriptor.
#       stdin is 0, and stdout is 1
# %rsi shoud contain a buffer address (where to write the input, or where from output to console)
# %rdx should contain length of the buffer in bytes.

#exit() syscall number is 60 in linux. 0x2000001 in macos.

_start:
      mov $0, %rax                 # syscall number for read
      mov $0, %rdi                 # where to read from: stdin
      mov $arr, %rsi                 # buffer adr
      mov $2, %rdx                 # length of the buffer in bytes
      syscall

      mov  $1, %rax                # system call for write
      mov  $1, %rdi                # file handle for stdout
      mov  $arr, %rsi              # address of string to output
      mov  $2, %rdx                # number of bytes
      syscall

      mov   $60, %rax           # system call for exit
      movb  arr(,%rdi,1), %dil       # second char in buffer -> return code
      syscall
