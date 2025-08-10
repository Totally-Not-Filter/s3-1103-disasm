                Lea     ScrollBBase+($b*64)+(27*2),A1
                Jsr     Word_2GVRAM    
                Move.w  #AsciiOffset+CHR_Palette0+CHR_HighPri,D5 ; Color is different if in impulse.

                Bra     @DoneSeperators

@NotImpulse:
                Move.w  #AsciiOffset+CHR_Palette3+CHR_HighPri+'.',D0        ; Place decimal points and '/' seperators.
                Lea     ScrollBBase+($5*64)+(28*2),A1           
                Jsr     Word_2GVRAM     
                Lea     ScrollBBase+($7*64)+(27*2),A1
                Jsr     Word_2GVRAM     
                Lea     ScrollBBase+($d*64)+(28*2),A1
                Jsr     Word_2GVRAM     
                Move.w  #AsciiOffset+CHR_Palette3+CHR_HighPri+'/',D0  
                Lea     ScrollBBase+($9*64)+(27*2),A1
                Jsr     Word_2GVRAM    
                Lea     ScrollBBase+($b*64)+(27*2),A1
                Jsr     Word_2GVRAM    
                Move.w  #AsciiOffset+CHR_Palette3+CHR_HighPri,D5 ; Set up character color.

@DoneSeperators:
                Move.w  CurrentDistance,D7                      ; Get whole part of DISTANCE.
                Moveq   #3,D6                                   ; Three characters.
                Moveq   #'$',D2                                 ; Lead with a spaces.
                Lea     ScrollBBase+($5*64)+(25*2),A1           ; Screen destination.
                Jsr     PrintVal                                ; Print it.
                Move.w  CurrentDistance+2,D7                    ; Get fractional part of DISTANCE.
                Moveq   #2,D6                                   ; Two digits.
                Move.w  #'0'