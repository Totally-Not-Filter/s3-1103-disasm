 the screen.

DMAScrollArrows:
                Subq.w  #1,ArrowDelay                           ; Determine if arrow buffers or blanks should
                Bne.s   @NoTogg                                 ;  be DMA'ed this makes the arrows flash.

                Move.w  #15,ArrowDelay                          ; Reset delay between flashes.
                Eor.w   #1,ArrowToggle                          ; Toggle between blanks and arrows.

@NoTogg:
                Tst.w   ArrowToggle                             ; Branch to relevent bit.
                Beq.s   @ArrowsOff

; ====== Arrows on, DMA the buffers. ======

                Lea     UpArrowBuffer,A0                        ; Source.
                Lea     ScrollBBase+(27*2)+(21*64),A1           ; Destination.
                Move.w  #1,D0                                   ; Number of words.
                Move.l  #VDP_VRAMWrite,D1                       ; Set to write to VRAM.   
                Moveq   #2,D2                                   ; Auto increment.        
                Jsr     PushDMA                                 ; Move characters to VRAM.

                Lea     DownArrowBuffer,A0                      ; Source.
                Lea     ScrollBBase+(27*2)+(26*64),A1           ; Destination.
                Move.w  #1,D0                 