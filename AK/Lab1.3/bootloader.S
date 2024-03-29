.syntax unified
.cpu cortex-m4
//.fpu softvfp
.thumb
.global bootload
.section .rodata
image: .incbin &quot;kernel.bin&quot;
end_of_image:
str_boot_start: .asciz &quot;bootloader started&quot;
str_boot_end: .asciz &quot;bootloader end&quot;
str_boot_indicate: .asciz &quot;#&quot;
.section .text
bootload:
ldr r0, =str_boot_start
bl dbgput_line
ldr r0, =end_of_image
ldr r1, =image
ldr r2, =_ram_start
sub r5, r0, r1
add r5, r5, r2
loop:
ldmdb r0!, {r3, r4}
stmdb r5!, {r3, r4}
cmp r0, r1
bhi loop
bl newline
ldr r0, =str_boot_end
bl dbgput_line
ldr lr, =bootload_end
add lr, #1
ldr r2, =_ram_start

add r2, #4 // go to reset_kernel
ldr r0, [r2]
bx r0
bootload_end:
b bootload_end
