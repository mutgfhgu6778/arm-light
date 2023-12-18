.syntax unified
.global main
.type main, %function
@ .global init_leds,write_column_pins,write_row_pins,write_column_pin,write_row_pin

main:

  bl init_leds

  mov r0, 0b00000
  bl write_column_pins

reset_big_loop:
  ldr r7, =pattern
  sub r7, 20
big_loop:
  add r7, 20
  ldr r0, =end_pattern
  cmp r7, r0
  bge reset_big_loop
  mov r6, 0
reset_loop:
  mov r5, 0
  ldr r0, =duration
  ldr r0, [r0]
  cmp r6, r0
  bge big_loop
loop:
  cmp r5, 5
  bge reset_loop

  mov r0, 1
  lsl r0, r5

  mov r1, 0
  mov r2, 5
  bl write_row_pins

  mov r0, r7
  ldr r1, [r0, r5, lsl 2]
  mov r0, r1

  bl write_column_pins

  ldr r0, =lights_on
  ldr r0, [r0]
  bl delay

  mov r0, 0b00000
  bl write_row_pins
  mov r1, 0b11111
  bl write_column_pins

  ldr r0, =lights_off
  ldr r0, [r0]
  bl delay

  add r5, 1
  add r6, 1
b loop


.size main, .-main

.data
pattern:
.word 0b01110
.word 0b11111
.word 0b11111
.word 0b01110
.word 0b00100

.word 0b00000
.word 0b01110
.word 0b01110
.word 0b00100
.word 0b00000

@ .word 0b01110
@ .word 0b11111
@ .word 0b11111
@ .word 0b01110
@ .word 0b00000

end_pattern:
.word 0

lights_on:
@ time that lights on
.word 15000

lights_off:
@ time that lights off
.word 5000

duration:
.word 150




@ main:

@   bl init_leds

@ loop:
@   mov  r0,1
@   mov r1,0
@   mov r2,0b11111
@   bl write_column_pin
@   mov  r0,1
@   mov r1,0
@   mov r2,0b11111
@   bl write_row_pin 

      
@   b loop


@ .data
@ image:
@   .word 0b10001 @ Column 1
@   .word 0b11010 @ Column 2
@   .word 0b10101 @ Column 3
@   .word 0b11111 @ Column 4
@   .word 0b00101 @ Column 5