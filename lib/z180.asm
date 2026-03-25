; Large portions of this code are copied from, or inspired by: 
;   John Winans' z80-retro-cpm project.  
;   Wayne Warthen's RomWBW project
; All of their Copyright is retained by original authors

; base address for re-located on-board control registers
Z180_BASE:              .equ    $C0


; Other control registers
rcr_addr:               .equ    Z180_BASE + $36
dcntl_addr:             .equ    Z180_BASE + $32
cmr_addr:               .equ    Z180_BASE + $1E
ccr_addr:               .equ    Z180_BASE + $1F

; MMU registers
cbr_addr:               .equ    Z180_BASE + $38
bbr_addr:               .equ    Z180_BASE + $39
cbar_addr:              .equ    Z180_BASE + $3A

;dcntl_addr:             .equ    Z180_BASE + $32

; bottom of the unbanked RAM segment
ram_start:              .equ    $8000

; Define the location of the "standard" memory bank, which will hold the bottom of the TPA
; and the zero page
low_bank:               .equ    +(1024-64) >> 2      ; note this is same address as CBR, but
                                        ; this should work because logical address of 
                                        ; bottom of bank area is 0x0000


; Define the memory size to be used for the CP/M configuration
MEM:                    .equ 60

; The CPM origin will be at: (MEM-7)*1024
; This screwy convention is due to the way that that the CP/M origin is defined.
CPM_BASE:	            .equ	(MEM-7)*1024

LOAD_BASE:	            .equ	$C000		; where the boot loader reads the image from the SD card