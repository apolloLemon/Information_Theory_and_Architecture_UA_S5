global chrono_start
global chrono_stop
global chrono_print
extern printf
 
; ===============================================
; DATA
; ===============================================
section .data
 
; number of cycles when we start and stop
; it is a 64 bits value but we code it has 2 32 bits values
cpu_cycles_start: dd 0,0
cpu_cycles_stop: dd 0, 0
 
; difference between start and stop
cpu_cycles_diff: dd 0,0
 
; print 64 bits value
msg: db "cycles=%llu", 10,0
 
; ===============================================
; CODE
; ===============================================
section .text
 
; --------------------------------------------
; void chrono_start();
chrono_start:
  pushad
  xor   eax,eax
  cpuid
  ; read counter has two 32 bits values in edx:eax
  rdtsc
  ; save it
  mov   [cpu_cycles_start],eax
  mov   [cpu_cycles_start + 4],edx
  popad
  ret
 
; --------------------------------------------
; void chrono_stop();  
chrono_stop:
  pushad
  xor   eax,eax
  cpuid
  rdtsc
  mov   [cpu_cycles_stop], eax
  mov   [cpu_cycles_stop + 4], edx
  ; compute difference and store it
  sub   eax,[cpu_cycles_start]
  sbb   edx,[cpu_cycles_start+4]
  mov   [cpu_cycles_diff],eax
  mov   [cpu_cycles_diff + 4],edx
  popad
  ret
 
; --------------------------------------------
; void chrono_print();
chrono_print:
  pushad 
  mov   eax, [cpu_cycles_diff]
  mov   edx, [cpu_cycles_diff + 4]
  push  edx
  push  eax
  push  dword msg
  call  printf
  add   esp,12
  popad
  ret