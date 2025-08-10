; =============== S U B R O U T I N E =======================================


sub_0:
			di
			di
			im	1
			jp	loc_59
; ---------------------------------------------------------------------------
			db	0
; ---------------------------------------------------------------------------

loc_8:
			ld	hl, (tb_adr_str)
			ld	b, 0
			add	hl, bc
			ex	af, af'
			ld	a, (hl)
			inc	hl
			ld	h, (hl)
			ld	l, a
			ex	af, af'
			ret
; ---------------------------------------------------------------------------
			db	0
			db	0
			db	0
; ---------------------------------------------------------------------------

loc_18:
			ld	c, a
			ld	b, 0
			add	hl, bc
			add	hl, bc
			nop
			nop
			nop

loc_20:
			ld	a, (hl)
			inc	hl
			ld	h, (hl)
			ld	l, a
			ret
; ---------------------------------------------------------------------------
			db	0
			db	0
			db	0
			db	0
			db	0
			db	0
			db	0
			db	0
			db	0
			db	0
			db	0
			db	0
			db	0
			db	0
			db	0
			db	0
			db	0
			db	0
			db	0
; ---------------------------------------------------------------------------
			di
			push    af
			push    iy
			exx
			call    sub_7C6
			call    sub_B3
			ld      hl, 6000h
			xor     a
			ld      e, 1
			ld      (hl), a
			ld      (hl), e
			ld      (hl), e
			ld      (hl), e
			ld      (hl), e
			ld      (hl), a
			ld      (hl), a
			ld      (hl), a
			ld      (hl), a
			exx
			pop     iy
			pop     af
			ld      b, 1
			ret
; ---------------------------------------------------------------------------

loc_59:						         ; CODE XREF: sub_0:loc_4↑j
			ld      sp, 2000h
			ld      c, 0

loc_5E:						         ; CODE XREF: sub_0+63↓j
			ld      b, 0

loc_60:						         ; CODE XREF: sub_0:loc_60↓j
			djnz    $
			dec     c
			jr      z, loc_5E
			ld      a, 6
			ld      (byte_1C04), a
			xor     a
			ld      (byte_1C06), a
			ld      (byte_1C07), a
			call    sub_72C
			ld      a, 5
			ld      (byte_1C08), a
			ld      hl, 6000h
			ld      d, 1
			xor     a
			ld      (hl), a
			ld      (hl), d
			ld      (hl), d
			ld      (hl), d
			ld      (hl), d
			ld      (hl), a
			ld      (hl), a
			ld      (hl), a
			ld      (hl), a
			ei
			jp      loc_DAD
; End of function sub_0


; =============== S U B R O U T I N E =======================================


sub_8C:						         ; CODE XREF: sub_15B+F↓p
									    ; sub_15B+15↓p ...

; FUNCTION CHUNK AT 00A8 SIZE 00000002 BYTES

			bit     7, (ix+1)
			ret     nz
			bit     2, (ix+0)
			ret     nz
			add     a, (ix+1)
			bit     2, (ix+1)
			jr      nz, loc_A8
; End of function sub_8C


; =============== S U B R O U T I N E =======================================


sub_9F:						         ; CODE XREF: sub_15B+3B↓p
									    ; sub_15B+42↓p ...
			ld      (4000h), a
			nop
			ld      a, c
			ld      (4001h), a
			ret
; End of function sub_9F

; ---------------------------------------------------------------------------
; START OF FUNCTION CHUNK FOR sub_8C

loc_A8:						         ; CODE XREF: sub_8C+11↑j
			sub     4
; END OF FUNCTION CHUNK FOR sub_8C

; =============== S U B R O U T I N E =======================================


sub_AA:						         ; CODE XREF: sub_64F+13A↓p
			ld      (4002h), a
			nop
			ld      a, c
			ld      (4003h), a
			ret
; End of function sub_AA


; =============== S U B R O U T I N E =======================================


sub_B3:						         ; CODE XREF: sub_0+40↑p
			call    sub_64F
			call    sub_7B0
			call    sub_6C9
			call    loc_424
			call    sub_EE
			ld      hl, 6000h
			ld      a, (byte_1C04)
			ld      (hl), a
			rra
			ld      (hl), a
			rra
			ld      (hl), a
			rra
			ld      (hl), a
			xor     a
			ld      d, 1
			ld      (hl), d
			ld      (hl), a
			ld      (hl), a
			ld      (hl), a
			ld      (hl), a
			xor     a
			ld      (byte_1C19), a
			ld      ix, byte_1C40
			bit     7, (ix+0)
			call    nz, sub_90E
			ld      b, 8
			ld      ix, byte_1C70
			jr      loc_108
; End of function sub_B3


; =============== S U B R O U T I N E =======================================


sub_EE:						         ; CODE XREF: sub_B3+C↑p
			ld      a, 1
			ld      (byte_1C19), a
			ld      hl, 6000h
			xor     a
			ld      e, 1
			ld      (hl), e
			ld      (hl), a
			ld      (hl), e
			ld      (hl), e
			ld      (hl), e
			ld      (hl), a
			ld      (hl), a
			ld      (hl), a
			ld      (hl), a
			ld      ix, byte_1DF0
			ld      b, 7

loc_108:						        ; CODE XREF: sub_B3+39↑j
									    ; sub_EE+28↓j
			push    bc
			bit     7, (ix+0)
			call    nz, sub_119
			ld      de, 30h ; '0'
			add     ix, de
			pop     bc
			djnz    loc_108
			ret
; End of function sub_EE


; =============== S U B R O U T I N E =======================================


sub_119:						        ; CODE XREF: sub_EE+1F↑p

; FUNCTION CHUNK AT 0284 SIZE 00000019 BYTES
; FUNCTION CHUNK AT 0CE7 SIZE 00000073 BYTES

			bit     7, (ix+1)
			jp      nz, loc_CE7
			call    sub_27C
			jr      nz, loc_13C
			call    sub_1B9
			bit     4, (ix+0)
			ret     nz
			call    sub_2E0
			call    sub_3B1
			call    sub_30B
			call    sub_15B
			jp      loc_284
; ---------------------------------------------------------------------------

loc_13C:						        ; CODE XREF: sub_119+A↑j
			bit     4, (ix+0)
			ret     nz
			call    sub_2AF
			ld      a, (ix+1Eh)
			or      a
			jr      z, loc_150
			dec     (ix+1Eh)
			jp      z, sub_29D

loc_150:						        ; CODE XREF: sub_119+2F↑j
			call    sub_3B1
			bit     6, (ix+0)
			ret     nz
			call    sub_30B
; End of function sub_119


; =============== S U B R O U T I N E =======================================


sub_15B:						        ; CODE XREF: sub_119+1D↑p
			bit     2, (ix+0)
			ret     nz
			bit     0, (ix+0)
			jp      nz, loc_174

loc_167:						        ; CODE XREF: sub_15B+1E↓j
			ld      a, 0A4h
			ld      c, h
			call    sub_8C
			ld      a, 0A0h
			ld      c, l
			call    sub_8C
			ret
; ---------------------------------------------------------------------------

loc_174:						        ; CODE XREF: sub_15B+9↑j
			ld      a, (ix+1)
			cp      2
			jr      nz, loc_167
			call    sub_1A9
			ld      b, 4
			ld      hl, unk_1A5

loc_183:						        ; CODE XREF: sub_15B+47↓j
			push    bc
			ld      a, (hl)
			inc     hl
			push    hl
			ex      de, hl
			ld      c, (hl)
			inc     hl
			ld      b, (hl)
			inc     hl
			ex      de, hl
			ld      l, (ix+0Dh)
			ld      h, (ix+0Eh)
			add     hl, bc
			push    af
			ld      c, h
			call    sub_9F
			pop     af
			sub     4
			ld      c, l
			call    sub_9F
			pop     hl
			pop     bc
			djnz    loc_183
			ret
; End of function sub_15B

; ---------------------------------------------------------------------------
unk_1A5:    db 0ADh			         ; DATA XREF: sub_15B+25↑o
			db 0AEh
			db 0ACh
			db 0A6h

; =============== S U B R O U T I N E =======================================


sub_1A9:						        ; CODE XREF: sub_15B+20↑p
									    ; ROM:0C1D↓p
			ld      de, word_1C2A
			ld      a, (byte_1C19)
			or      a
			ret     z
			ld      de, word_1C1A
			ret     p
			ld      de, word_1C22
			ret
; End of function sub_1A9


; =============== S U B R O U T I N E =======================================


sub_1B9:						        ; CODE XREF: sub_119+C↑p
									    ; sub_119+BD3↓p
			ld      e, (ix+3)
			ld      d, (ix+4)
			res     1, (ix+0)
			res     4, (ix+0)

loc_1C7:						        ; CODE XREF: ROM:0965↓j
			ld      a, (de)
			inc     de
			cp      0E0h
			jp      nc, loc_958
			ex      af, af'
			call    sub_29D
			ex      af, af'
			bit     3, (ix+0)
			jp      nz, loc_22A
			or      a
			jp      p, loc_24A
			sub     81h
			jp      p, loc_1E8
			call    sub_D8F
			jr      loc_216
; ---------------------------------------------------------------------------

loc_1E8:						        ; CODE XREF: sub_1B9+27↑j
			add     a, (ix+5)
			ld      hl, word_81D
			push    af
			rst     loc_18
			pop     af
			bit     7, (ix+1)
			jr      nz, loc_210
			push    de
			ld      d, 8
			ld      e, 12
			ex      af, af'
			xor     a

loc_1FE:						        ; CODE XREF: sub_1B9+4B↓j
			ex      af, af'
			sub     e
			jr      c, loc_207
			ex      af, af'
			add     a, d
			jr      loc_1FE
; ---------------------------------------------------------------------------
			ex      af, af'

loc_207:						        ; CODE XREF: sub_1B9+47↑j
			add     a, e
			ld      hl, word_8C5
			rst     loc_18
			ex      af, af'
			or      h
			ld      h, a
			pop     de

loc_210:						        ; CODE XREF: sub_1B9+3C↑j
			ld      (ix+0Dh), l
			ld      (ix+0Eh), h

loc_216:						        ; CODE XREF: sub_1B9+2D↑j
			ld      a, (de)
			or      a
			jp      p, loc_249
			ld      a, (ix+0Ch)
			ld      (ix+0Bh), a
			jr      loc_250
; ---------------------------------------------------------------------------
			ld      a, (de)
			inc     de
			ld      (ix+11h), a
			jr      loc_248
; ---------------------------------------------------------------------------

loc_22A:						        ; CODE XREF: sub_1B9+1E↑j
			ld      h, a
			ld      a, (de)
			inc     de
			ld      l, a
			or      h
			jr      z, loc_23D
			ld      a, (ix+5)
			ld      b, 0
			or      a
			jp      p, loc_23B
			dec     b

loc_23B:						        ; CODE XREF: sub_1B9+7E↑j
			ld      c, a
			add     hl, bc

loc_23D:						        ; CODE XREF: sub_1B9+76↑j
			ld      (ix+0Dh), l
			ld      (ix+0Eh), h
			ld      a, (de)
			inc     de
			ld      (ix+11h), a

loc_248:						        ; CODE XREF: sub_1B9+6F↑j
			ld      a, (de)

loc_249:						        ; CODE XREF: sub_1B9+5F↑j
			inc     de

loc_24A:						        ; CODE XREF: sub_1B9+22↑j
									    ; sub_90E+33↓j
			call    sub_272
			ld      (ix+0Ch), a

loc_250:						        ; CODE XREF: sub_1B9+68↑j
									    ; sub_90E+3D↓j
			ld      (ix+3), e
			ld      (ix+4), d
			ld      a, (ix+0Ch)
			ld      (ix+0Bh), a
			bit     1, (ix+0)
			ret     nz
			xor     a
			ld      (ix+25h), a
			ld      (ix+22h), a
			ld      (ix+17h), a
			ld      a, (ix+1Fh)
			ld      (ix+1Eh), a
			ret
; End of function sub_1B9


; =============== S U B R O U T I N E =======================================


sub_272:						        ; CODE XREF: sub_1B9:loc_24A↑p
									    ; ROM:loc_A43↓p
			ld      b, (ix+2)
			dec     b
			ret     z
			ld      c, a

loc_278:						        ; CODE XREF: sub_272+7↓j
			add     a, c
			djnz    loc_278
			ret
; End of function sub_272


; =============== S U B R O U T I N E =======================================


sub_27C:						        ; CODE XREF: sub_119+7↑p
									    ; sub_90E↓p ...
			ld      a, (ix+0Bh)
			dec     a
			ld      (ix+0Bh), a
			ret
; End of function sub_27C

; ---------------------------------------------------------------------------
; START OF FUNCTION CHUNK FOR sub_119

loc_284:						        ; CODE XREF: sub_119+20↑j
			ld      a, (ix+0Dh)
			or      (ix+0Eh)
			ret     z
			ld      a, (ix+0)
			and     6
			ret     nz
			ld      a, (ix+1)
			or      0F0h
			ld      c, a
			ld      a, 28h ; '('
			call    sub_9F
			ret
; END OF FUNCTION CHUNK FOR sub_119

; =============== S U B R O U T I N E =======================================


sub_29D:						        ; CODE XREF: sub_119+34↑j
									    ; sub_1B9+16↑p ...
			ld      a, (ix+0)
			and     6
			ret     nz

loc_2A3:						        ; CODE XREF: ROM:0C81↓p
			ld      c, (ix+1)
			bit     7, c
			ret     nz
; End of function sub_29D

; START OF FUNCTION CHUNK FOR sub_7F6

loc_2A9:						        ; CODE XREF: sub_7F6+D↓j
			ld      a, 28h ; '('
			call    sub_9F
			ret
; END OF FUNCTION CHUNK FOR sub_7F6

; =============== S U B R O U T I N E =======================================


sub_2AF:						        ; CODE XREF: sub_119+28↑p
			ld      a, (ix+18h)
			or      a
			ret     z
			ret     m
			dec     a
			ld      c, 0Ah
			rst     loc_8
			rst     loc_18
			call    sub_D5D
			ld      h, (ix+1Dh)
			ld      l, (ix+1Ch)
			ld      de, unk_3F3
			ld      b, 4
			ld      c, (ix+19h)

loc_2CB:						        ; CODE XREF: sub_2AF+2E↓j
			push    af
			sra     c
			push    bc
			jr      nc, loc_2D9
			add     a, (hl)
			and     7Fh
			ld      c, a
			ld      a, (de)
			call    sub_8C

loc_2D9:						        ; CODE XREF: sub_2AF+20↑j
			pop     bc
			inc     de
			inc     hl
			pop     af
			djnz    loc_2CB
			ret
; End of function sub_2AF


; =============== S U B R O U T I N E =======================================


sub_2E0:						        ; CODE XREF: sub_119+14↑p
									    ; sub_119+BDB↓p
			bit     7, (ix+7)
			ret     z
			bit     1, (ix+0)
			ret     nz
			ld      e, (ix+20h)
			ld      d, (ix+21h)
			push    ix
			pop     hl
			ld      b, 0
			ld      c, 24h ; '$'
			add     hl, bc
			ex      de, hl
			ldi
			ldi
			ldi
			ld      a, (hl)
			srl     a
			ld      (de), a
			xor     a
			ld      (ix+22h), a
			ld      (ix+23h), a
			ret
; End of function sub_2E0


; =============== S U B R O U T I N E =======================================


sub_30B:						        ; CODE XREF: sub_119+1A↑p
									    ; sub_119+3F↑p ...
			ld      a, (ix+7)
			or      a
			ret     z
			cp      80h
			jr      nz, loc_35C
			dec     (ix+24h)
			ret     nz
			inc     (ix+24h)
			push    hl
			ld      l, (ix+22h)
			ld      h, (ix+23h)
			ld      e, (ix+20h)
			ld      d, (ix+21h)
			push    de
			pop     iy
			dec     (ix+25h)
			jr      nz, loc_347
			ld      a, (iy+1)
			ld      (ix+25h), a
			ld      a, (ix+26h)
			ld      c, a
			and     80h
			rlca
			neg
			ld      b, a
			add     hl, bc
			ld      (ix+22h), l
			ld      (ix+23h), h

loc_347:						        ; CODE XREF: sub_30B+23↑j
			pop     bc
			add     hl, bc
			dec     (ix+27h)
			ret     nz
			ld      a, (iy+3)
			ld      (ix+27h), a
			ld      a, (ix+26h)
			neg
			ld      (ix+26h), a
			ret
; ---------------------------------------------------------------------------

loc_35C:						        ; CODE XREF: sub_30B+7↑j
			dec     a
			ex      de, hl
			ld      c, 8
			rst     loc_8
			rst     loc_18
			jr      loc_367
; ---------------------------------------------------------------------------

loc_364:						        ; CODE XREF: sub_30B+82↓j
									    ; sub_30B+85↓j
			ld      (ix+25h), a

loc_367:						        ; CODE XREF: sub_30B+57↑j
									    ; sub_30B+95↓j
			push    hl
			ld      c, (ix+25h)
			ld      b, 0
			add     hl, bc
			ld      a, (hl)
			pop     hl
			bit     7, a
			jp      z, loc_3A2
			cp      82h
			jr      z, loc_38B
			cp      80h
			jr      z, loc_38F
			cp      84h
			jr      z, loc_392
			ld      h, 0FFh
			jr      nc, loc_3A4
			set     6, (ix+0)
			pop     hl
			ret
; ---------------------------------------------------------------------------

loc_38B:						        ; CODE XREF: sub_30B+6C↑j
			inc     bc
			ld      a, (bc)
			jr      loc_364
; ---------------------------------------------------------------------------

loc_38F:						        ; CODE XREF: sub_30B+70↑j
			xor     a
			jr      loc_364
; ---------------------------------------------------------------------------

loc_392:						        ; CODE XREF: sub_30B+74↑j
			inc     bc
			ld      a, (bc)
			add     a, (ix+22h)
			ld      (ix+22h), a
			inc     (ix+25h)
			inc     (ix+25h)
			jr      loc_367
; ---------------------------------------------------------------------------

loc_3A2:						        ; CODE XREF: sub_30B+67↑j
			ld      h, 0

loc_3A4:						        ; CODE XREF: sub_30B+78↑j
			ld      l, a
			ld      b, (ix+22h)
			inc     b
			ex      de, hl

loc_3AA:						        ; CODE XREF: sub_30B+A0↓j
			add     hl, de
			djnz    loc_3AA
			inc     (ix+25h)
			ret
; End of function sub_30B


; =============== S U B R O U T I N E =======================================


sub_3B1:						        ; CODE XREF: sub_119+17↑p
									    ; sub_119:loc_150↑p ...
			ld      h, (ix+0Eh)
			ld      l, (ix+0Dh)
			ld      b, 0
			ld      a, (ix+10h)
			or      a
			jp      p, loc_3C2
			ld      b, 0FFh

loc_3C2:						        ; CODE XREF: sub_3B1+C↑j
			ld      c, a
			add     hl, bc
			ret
; End of function sub_3B1


; =============== S U B R O U T I N E =======================================


sub_3C5:						        ; CODE XREF: sub_AA6+18↓p
			ld      hl, (word_1C37)
			ld      a, (byte_1C19)
			or      a
			jr      z, sub_3D4
			ld      l, (ix+2Ah)
			ld      h, (ix+2Bh)
; End of function sub_3C5


; =============== S U B R O U T I N E =======================================


sub_3D4:						        ; CODE XREF: sub_3C5+7↑j
									    ; sub_AA6+11↓p ...
			xor     a
			or      b
			ret     z
			ld      de, 19h

loc_3DA:						        ; CODE XREF: sub_3D4+7↓j
			add     hl, de
			djnz    loc_3DA
			ret
; End of function sub_3D4

; ---------------------------------------------------------------------------
unk_3DE:    db 0B0h			         ; DATA XREF: sub_3FB↓o
			db  30h ; 0
			db  38h ; 8
			db  34h ; 4
			db  3Ch ; <
			db  50h ; P
			db  58h ; X
			db  54h ; T
			db  5Ch ; \
			db  60h ; `
			db  68h ; h
			db  64h ; d
			db  6Ch ; l
			db  70h ; p
			db  78h ; x
			db  74h ; t
			db  7Ch ; |
			db  80h
			db  88h
			db  84h
			db  8Ch
unk_3F3:    db  40h ; @			     ; DATA XREF: sub_2AF+14↑o
									    ; sub_A1C+1↓o
			db  48h ; H
			db  44h ; D
			db  4Ch ; L
unk_3F7:    db  90h			         ; DATA XREF: sub_CCD↓o
			db  98h
			db  94h
			db  9Ch

; =============== S U B R O U T I N E =======================================


sub_3FB:						        ; CODE XREF: sub_AA6:loc_AC1↓p
									    ; sub_472+6E7↓p
			ld      de, unk_3DE
			ld      c, (ix+0Ah)
			ld      a, 0B4h
			call    sub_8C
			call    sub_41C
			ld      (ix+1Bh), a
			ld      b, 14h

loc_40E:						        ; CODE XREF: sub_3FB+16↓j
			call    sub_41C
			djnz    loc_40E
			ld      (ix+1Ch), l
			ld      (ix+1Dh), h
			jp      sub_A1C
; End of function sub_3FB


; =============== S U B R O U T I N E =======================================


sub_41C:						        ; CODE XREF: sub_3FB+B↑p
									    ; sub_3FB:loc_40E↑p
			ld      a, (de)
			inc     de
			ld      c, (hl)
			inc     hl
			call    sub_8C
			ret
; End of function sub_41C

; ---------------------------------------------------------------------------

loc_424:						        ; CODE XREF: sub_B3+9↑p
			ld      a, (byte_1C09)

; =============== S U B R O U T I N E =======================================


sub_427:						        ; CODE XREF: ROM:0C65↓p

; FUNCTION CHUNK AT 0477 SIZE 000000B7 BYTES
; FUNCTION CHUNK AT 0547 SIZE 00000098 BYTES
; FUNCTION CHUNK AT 0816 SIZE 00000007 BYTES

			cp      0FFh
			jp      z, loc_816
			cp      32h ; '2'
			jp      c, loc_477
			cp      0DAh
			jp      c, loc_547
			cp      0E0h
			jp      c, sub_72C
			cp      0F0h
			jp      nc, sub_72C
			sub     0E0h
			ld      hl, off_44B
			rst     loc_18
			xor     a
			ld      (byte_1C18), a
			jp      (hl)
; End of function sub_427

; ---------------------------------------------------------------------------
off_44B:    dw loc_6AC			      ; DATA XREF: sub_427+1B↑o
			dw sub_72C
			dw sub_7A0
			dw loc_453
; ---------------------------------------------------------------------------

loc_453:						        ; DATA XREF: ROM:0451↑o
			ld      ix, byte_1DF0
			ld      b, 7
			ld      a, 1
			ld      (byte_1C19), a

loc_45E:						        ; CODE XREF: ROM:046C↓j
			push    bc
			bit     7, (ix+0)
			call    nz, sub_472
			ld      de, 30h ; '0'
			add     ix, de
			pop     bc
			djnz    loc_45E
			call    sub_52E
			ret

; =============== S U B R O U T I N E =======================================


sub_472:						        ; CODE XREF: ROM:0463↑p

; FUNCTION CHUNK AT 09E1 SIZE 00000006 BYTES
; FUNCTION CHUNK AT 0AEA SIZE 00000099 BYTES

			push    hl
			push    hl
			jp      loc_9E1
; End of function sub_472

; ---------------------------------------------------------------------------
; START OF FUNCTION CHUNK FOR sub_427

loc_477:						        ; CODE XREF: sub_427+7↑j
			sub     1
			ret     m
			push    af
			call    sub_72C
			pop     af
			push    af
			ld      hl, byte_8DD
			add     a, l
			ld      l, a
			adc     a, h
			sub     l
			ld      h, a
			ld      (loc_48B+1), hl

loc_48B:						        ; DATA XREF: sub_427+61↑w
			ld      a, (byte_8DD)
			ld      (byte_1C04), a
			ld      hl, 6000h
			ld      (hl), a
			rra
			ld      (hl), a
			rra
			ld      (hl), a
			rra
			ld      (hl), a
			xor     a
			ld      d, 1
			ld      (hl), d
			ld      (hl), a
			ld      (hl), a
			ld      (hl), a
			ld      (hl), a
			ld      a, 0B6h
			ld      (4002h), a
			nop
			ld      a, 0C0h
			ld      (4003h), a
			pop     af
			ld      c, 4
			rst     loc_8
			rst     loc_18
			push    hl
			push    hl
			rst     loc_20
			ld      (word_1C37), hl
			pop     hl
			pop     iy
			ld      a, (iy+5)
			ld      (byte_1C13), a
			ld      (byte_1C05), a
			ld      de, 6
			add     hl, de
			ld      (word_1C33), hl
			ld      hl, byte_533
			ld      (word_1C35), hl
			ld      de, byte_1C40
			ld      b, (iy+2)
			ld      a, (iy+4)

loc_4DB:						        ; CODE XREF: sub_427+D3↓j
			push    bc
			ld      hl, (word_1C35)
			ldi
			ldi
			ld      (de), a
			inc     de
			ld      (word_1C35), hl
			ld      hl, (word_1C33)
			ldi
			ldi
			ldi
			ldi
			ld      (word_1C33), hl
			call    sub_615
			pop     bc
			djnz    loc_4DB
			ld      a, (iy+3)
			or      a
			jp      z, sub_52E
			ld      b, a
			ld      hl, byte_541
			ld      (word_1C35), hl
			ld      de, byte_1D60
			ld      a, (iy+4)

loc_510:						        ; CODE XREF: sub_427+105↓j
			push    bc
			ld      hl, (word_1C35)
			ldi
			ldi
			ld      (de), a
			inc     de
			ld      (word_1C35), hl
			ld      hl, (word_1C33)
			ld      bc, 6
			ldir
			ld      (word_1C33), hl
			call    loc_61C
			pop     bc
			djnz    loc_510
; END OF FUNCTION CHUNK FOR sub_427

; =============== S U B R O U T I N E =======================================


sub_52E:						        ; CODE XREF: ROM:046E↑p
									    ; sub_427+D9↑j ...
			xor     a
			ld      (byte_1C09), a
			ret
; End of function sub_52E

; ---------------------------------------------------------------------------
byte_533:   db  80h,   6			    ; DATA XREF: sub_427+A5↑o
									    ; sub_72C+D↓o
			db  80h,   0
			db  80h,   1
			db  80h,   2
			db  80h,   4
			db  80h,   5
			db  80h,   6
byte_541:   db  80h, 80h			    ; DATA XREF: sub_427+DD↑o
			db  80h,0A0h
			db  80h,0C0h
; ---------------------------------------------------------------------------
; START OF FUNCTION CHUNK FOR sub_427

loc_547:						        ; CODE XREF: sub_427+C↑j
			sub     32h ; '2'
			ex      af, af'
			ld      hl, 6000h
			xor     a
			ld      e, 1
			ld      (hl), e
			ld      (hl), a
			ld      (hl), e
			ld      (hl), e
			ld      (hl), e
			ld      (hl), a
			ld      (hl), a
			ld      (hl), a
			ld      (hl), a
			xor     a
			ld      c, 6
			ld      (byte_1C19), a
			ex      af, af'
			rst     loc_8
			rst     loc_18
			push    hl
			rst     loc_20
			ld      (word_1C39), hl
			xor     a
			ld      (byte_1C15), a
			pop     hl
			push    hl
			pop     iy
			ld      a, (iy+2)
			ld      (byte_1C3B), a
			ld      de, 4
			add     hl, de
			ld      b, (iy+3)

loc_57C:						        ; CODE XREF: sub_427+1B3↓j
			push    bc
			push    hl
			inc     hl
			ld      c, (hl)
			call    sub_5DF
			set     2, (hl)
			push    ix
			ld      a, (byte_1C19)
			or      a
			jr      z, loc_590
			pop     hl
			push    iy

loc_590:						        ; CODE XREF: sub_427+164↑j
			pop     de
			pop     hl
			ldi
			ld      a, (de)
			cp      2
			call    z, loc_75D
			ldi
			ld      a, (byte_1C3B)
			ld      (de), a
			inc     de
			ldi
			ldi
			ldi
			ldi
			call    sub_615
			bit     7, (ix+0)
			jr      z, loc_5BE
			ld      a, (ix+1)
			cp      (iy+1)
			jr      nz, loc_5BE
			set     2, (iy+0)

loc_5BE:						        ; CODE XREF: sub_427+189↑j
									    ; sub_427+191↑j
			push    hl
			ld      hl, (word_1C39)
			ld      a, (byte_1C19)
			or      a
			jr      z, loc_5CC
			push    iy
			pop     ix

loc_5CC:						        ; CODE XREF: sub_427+19F↑j
			ld      (ix+2Ah), l
			ld      (ix+2Bh), h
			call    sub_29D
			call    sub_76A
			pop     hl
			pop     bc
			djnz    loc_57C
			jp      sub_52E
; END OF FUNCTION CHUNK FOR sub_427

; =============== S U B R O U T I N E =======================================


sub_5DF:						        ; CODE XREF: sub_427+159↑p
									    ; sub_472+689↓p
			bit     7, c
			jr      nz, loc_5EB
			ld      a, c
			bit     2, a
			jr      z, loc_602
			dec     a
			jr      loc_602
; ---------------------------------------------------------------------------

loc_5EB:						        ; CODE XREF: sub_5DF+2↑j
			ld      a, 1Fh
			call    sub_D98
			ld      a, 0FFh
			ld      (7F11h), a
			ld      a, c
			srl     a
			srl     a
			srl     a
			srl     a
			srl     a
			add     a, 2

loc_602:						        ; CODE XREF: sub_5DF+7↑j
									    ; sub_5DF+A↑j
			sub     2
			ld      (byte_1C32), a
			push    af
			ld      hl, off_62F
			rst     loc_18
			push    hl
			pop     ix
			pop     af
			ld      hl, off_63F
			rst     loc_18
			ret
; End of function sub_5DF


; =============== S U B R O U T I N E =======================================


sub_615:						        ; CODE XREF: sub_427+CF↑p
									    ; sub_427+182↑p
			ex      af, af'
			xor     a
			ld      (de), a
			inc     de
			ld      (de), a
			inc     de
			ex      af, af'

loc_61C:						        ; CODE XREF: sub_427+101↑p
			ex      de, hl
			ld      (hl), 30h ; '0'
			inc     hl
			ld      (hl), 0C0h
			inc     hl
			ld      (hl), 1
			ld      b, 24h ; '$'

loc_627:						        ; CODE XREF: sub_615+15↓j
			inc     hl
			ld      (hl), 0
			djnz    loc_627
			inc     hl
			ex      de, hl
			ret
; End of function sub_615

; ---------------------------------------------------------------------------
off_62F:    dw byte_1DF0			    ; DATA XREF: sub_5DF+29↑o
			dw byte_1E20
			dw byte_1E50
			dw byte_1E80
			dw byte_1EB0
			dw byte_1EE0
			dw byte_1F10
			dw byte_1F10
off_63F:    dw byte_1CD0			    ; DATA XREF: sub_5DF+31↑o
			dw byte_1D00
			dw byte_1D30
			dw byte_1C40
			dw byte_1D60
			dw byte_1D90
			dw byte_1DC0
			dw byte_1DC0

; =============== S U B R O U T I N E =======================================


sub_64F:						        ; CODE XREF: sub_B3↑p

; FUNCTION CHUNK AT 0771 SIZE 0000002F BYTES

			ld      hl, byte_1C10
			ld      a, (hl)
			or      a
			ret     z
			jp      m, loc_660
			pop     de
			dec     a
			ret     nz
			ld      (hl), 2
			jp      loc_771
; ---------------------------------------------------------------------------

loc_660:						        ; CODE XREF: sub_64F+6↑j
			xor     a
			ld      (hl), a
			ld      a, (byte_1C0D)
			or      a
			jp      nz, sub_72C
			ld      ix, byte_1C70
			ld      b, 6

loc_66F:						        ; CODE XREF: sub_64F+39↓j
			ld      a, (byte_1C11)
			or      a
			jr      nz, loc_67B
			bit     7, (ix+0)
			jr      z, loc_683

loc_67B:						        ; CODE XREF: sub_64F+24↑j
			ld      c, (ix+0Ah)
			ld      a, 0B4h
			call    sub_8C

loc_683:						        ; CODE XREF: sub_64F+2A↑j
			ld      de, 30h ; '0'
			add     ix, de
			djnz    loc_66F
			ld      ix, byte_1F40
			ld      b, 7

loc_690:						        ; CODE XREF: sub_64F+5A↓j
			bit     7, (ix+0)
			jr      z, loc_6A4
			bit     7, (ix+1)
			jr      nz, loc_6A4
			ld      c, (ix+0Ah)
			ld      a, 0B4h
			call    sub_8C

loc_6A4:						        ; CODE XREF: sub_64F+45↑j
									    ; sub_64F+4B↑j
			ld      de, 30h ; '0'
			add     ix, de
			djnz    loc_690
			ret
; End of function sub_64F

; ---------------------------------------------------------------------------

loc_6AC:						        ; DATA XREF: ROM:off_44B↑o
			ld      a, 28h ; '('
			ld      (byte_1C0D), a
			ld      a, 6
			ld      (byte_1C0F), a
			ld      (byte_1C0E), a

; =============== S U B R O U T I N E =======================================


sub_6B9:						        ; CODE XREF: sub_6C9+6↓p
			xor     a
			ld      (byte_1C40), a
			ld      (byte_1DC0), a
			ld      (byte_1D60), a
			ld      (byte_1D90), a
			jp      sub_7A0
; End of function sub_6B9


; =============== S U B R O U T I N E =======================================


sub_6C9:						        ; CODE XREF: sub_B3+6↑p
			ld      hl, byte_1C0D
			ld      a, (hl)
			or      a
			ret     z
			call    m, sub_6B9
			res     7, (hl)
			ld      a, (byte_1C0F)
			dec     a
			jr      z, loc_6DE
			ld      (byte_1C0F), a
			ret
; ---------------------------------------------------------------------------

loc_6DE:						        ; CODE XREF: sub_6C9+F↑j
			ld      a, (byte_1C0E)
			ld      (byte_1C0F), a
			ld      a, (byte_1C0D)
			dec     a
			ld      (byte_1C0D), a
			jr      z, sub_72C
			ld      a, (byte_1C04)
			ld      hl, 6000h
			ld      (hl), a
			rra
			ld      (hl), a
			rra
			ld      (hl), a
			rra
			ld      (hl), a
			xor     a
			ld      d, 1
			ld      (hl), d
			ld      (hl), a
			ld      (hl), a
			ld      (hl), a
			ld      (hl), a
			ld      ix, byte_1C40
			ld      b, 6

loc_708:						        ; CODE XREF: sub_6C9+60↓j
			inc     (ix+6)
			jp      p, loc_713
			dec     (ix+6)
			jr      loc_724
; ---------------------------------------------------------------------------

loc_713:						        ; CODE XREF: sub_6C9+42↑j
			bit     7, (ix+0)
			jr      z, loc_724
			bit     2, (ix+0)
			jr      nz, loc_724
			push    bc
			call    sub_A1C
			pop     bc

loc_724:						        ; CODE XREF: sub_6C9+48↑j
									    ; sub_6C9+4E↑j ...
			ld      de, 30h ; '0'
			add     ix, de
			djnz    loc_708
			ret
; End of function sub_6C9


; =============== S U B R O U T I N E =======================================


sub_72C:						        ; CODE XREF: sub_0+71↑p
									    ; sub_427+11↑j ...
			ld      hl, byte_1C09
			ld      de, word_1C0A
			ld      bc, 336h
			ld      (hl), 0
			ldir
			ld      ix, byte_533
			ld      b, 6

loc_73F:						        ; CODE XREF: sub_72C+1F↓j
			push    bc
			call    sub_7F6
			call    sub_76A
			inc     ix
			inc     ix
			pop     bc
			djnz    loc_73F
			ld      b, 7
			xor     a
			ld      (byte_1C0D), a
			call    sub_7A0
			ld      c, 0
			ld      a, 2Bh ; '+'
			call    sub_9F

loc_75D:						        ; CODE XREF: sub_427+170↑p
									    ; sub_90E+28↓p
			xor     a
			ld      (byte_1C12), a
			ld      c, a
			ld      a, 27h ; '''
			call    sub_9F
			jp      sub_52E
; End of function sub_72C


; =============== S U B R O U T I N E =======================================


sub_76A:						        ; CODE XREF: sub_427+1AE↑p
									    ; sub_72C+17↑p
			ld      a, 90h
			ld      c, 0
			jp      sub_80A
; End of function sub_76A

; ---------------------------------------------------------------------------
; START OF FUNCTION CHUNK FOR sub_64F

loc_771:						        ; CODE XREF: sub_64F+E↑j
			call    sub_7A0
			push    bc
			push    af
			ld      b, 3
			ld      a, 0B4h
			ld      c, 0

loc_77C:						        ; CODE XREF: sub_64F+133↓j
			push    af
			call    sub_9F
			pop     af
			inc     a
			djnz    loc_77C
			ld      b, 2
			ld      a, 0B4h

loc_788:						        ; CODE XREF: sub_64F+13F↓j
			push    af
			call    sub_AA
			pop     af
			inc     a
			djnz    loc_788
			ld      c, 0
			ld      b, 6
			ld      a, 28h ; '('

loc_796:						        ; CODE XREF: sub_64F+14D↓j
			push    af
			call    sub_9F
			inc     c
			pop     af
			djnz    loc_796
			pop     af
			pop     bc
; END OF FUNCTION CHUNK FOR sub_64F

; =============== S U B R O U T I N E =======================================


sub_7A0:						        ; CODE XREF: sub_6B9+D↑j
									    ; sub_72C+27↑p ...
			push    bc
			ld      b, 4
			ld      a, 9Fh

loc_7A5:						        ; CODE XREF: sub_7A0+A↓j
			ld      (7F11h), a
			add     a, 20h ; ' '
			djnz    loc_7A5
			pop     bc
			jp      sub_52E
; End of function sub_7A0


; =============== S U B R O U T I N E =======================================


sub_7B0:						        ; CODE XREF: sub_B3+3↑p
			ld      a, (byte_1C05)
			ld      hl, byte_1C13
			add     a, (hl)
			ld      (hl), a
			ret     nc
			ld      hl,  byte_1C40+0Bh
			ld      de, 30h ; '0'
			ld      b, 9

loc_7C1:						        ; CODE XREF: sub_7B0+13↓j
			inc     (hl)
			add     hl, de
			djnz    loc_7C1
			ret
; End of function sub_7B0


; =============== S U B R O U T I N E =======================================


sub_7C6:						        ; CODE XREF: sub_0+3D↑p
			ld      a, r
			ld      (byte_1C17), a
			ld      de, word_1C0A
			call    sub_7D4
			call    sub_7D4
; End of function sub_7C6


; =============== S U B R O U T I N E =======================================


sub_7D4:						        ; CODE XREF: sub_7C6+8↑p
									    ; sub_7C6+B↑p
			ld      a, (de)
			or      a
			ret     z
			sub     1
			ld      c, 0
			rst     loc_8
			ld      c, a
			ld      b, 0
			add     hl, bc
			ld      a, (byte_1C18)
			cp      (hl)
			jr      z, loc_7E8
			jr      nc, loc_7F2

loc_7E8:						        ; CODE XREF: sub_7D4+10↑j
			ld      a, (de)
			ld      (byte_1C09), a
			ld      a, (hl)
			and     7Fh
			ld      (byte_1C18), a

loc_7F2:						        ; CODE XREF: sub_7D4+12↑j
			xor     a
			ld      (de), a
			inc     de
			ret
; End of function sub_7D4


; =============== S U B R O U T I N E =======================================


sub_7F6:						        ; CODE XREF: sub_72C+14↑p
									    ; sub_472:loc_9E1↓p

; FUNCTION CHUNK AT 02A9 SIZE 00000006 BYTES

			call    sub_806
			ld      a, 40h ; '@'
			ld      c, 7Fh
			call    sub_80A
			ld      c, (ix+1)
			jp      loc_2A9
; End of function sub_7F6


; =============== S U B R O U T I N E =======================================


sub_806:						        ; CODE XREF: sub_7F6↑p
									    ; ROM:0A96↓p
			ld      a, 80h
			ld      c, 0FFh
; End of function sub_806


; =============== S U B R O U T I N E =======================================


sub_80A:						        ; CODE XREF: sub_76A+4↑j
									    ; sub_7F6+7↑p
			ld      b, 4

loc_80C:						        ; CODE XREF: sub_80A+9↓j
			push    af
			call    sub_8C
			pop     af
			add     a, 4
			djnz    loc_80C
			ret
; End of function sub_80A

; ---------------------------------------------------------------------------
; START OF FUNCTION CHUNK FOR sub_427

loc_816:						        ; CODE XREF: sub_427+2↑j
			ld      a, 1
			ld      (byte_1C07), a
			pop     hl
			ret
; END OF FUNCTION CHUNK FOR sub_427
; ---------------------------------------------------------------------------
word_81D:   dw   3FFh,  3FFh,  3FFh,  3FFh,  3FFh,  3FFh,  3FFh,  3FFh,  3FFh,  3F7h,  3BEh,  388h
									    ; DATA XREF: sub_1B9+32↑o
			dw   356h,  326h,  2F9h,  2CEh,  2A5h,  280h,  25Ch,  23Ah,  21Ah,  1FBh,  1DFh,  1C4h
			dw   1ABh,  193h,  17Dh,  167h,  153h,  140h,  12Eh,  11Dh,  10Dh,  0FEh,  0EFh,  0E2h
			dw   0D6h,  0C9h,  0BEh,  0B4h,  0A9h,  0A0h,   97h,   8Fh,   87h,   7Fh,   78h,   71h
			dw    6Bh,   65h,   5Fh,   5Ah,   55h,   50h,   4Bh,   47h,   43h,   40h,   3Ch,   39h
			dw    36h,   33h,   30h,   2Dh,   2Bh,   28h,   26h,   24h,   22h,   20h,   1Fh,   1Dh
			dw    1Bh,   1Ah,   18h,   17h,   16h,   15h,   13h,   12h,   11h,   10h,     0,     0
word_8C5:   dw   284h,  2ABh,  2D3h,  2FEh,  32Dh,  35Ch,  38Fh,  3C5h,  3FFh,  43Ch,  47Ch,  4C0h
									    ; DATA XREF: sub_1B9+4F↑o
byte_8DD:   db    6			         ; DATA XREF: sub_427+59↑o
									    ; sub_427:loc_48B↑r
			db    6
			db    6
			db    6
			db    6
			db    6
			db    7
			db    7
			db    7
			db    7
			db    7
			db    7
			db    7
			db    8
			db    8
			db    8
			db    8
			db    8
			db    8
			db    8
			db    8
			db    8
			db    9
			db    9
			db    9
			db    9
			db    9
			db    9
			db    9
			db    9
			db    9
			db    9
			db    9
			db    9
			db  0Ah
			db  0Ah
			db  0Ah
			db  0Ah
			db  0Ah
			db  0Ah
			db  0Ah
			db  0Ah
			db  0Ah
			db  0Ah
			db  0Ah
			db  0Ah
			db  0Ah
			db  0Bh
			db  0Bh

; =============== S U B R O U T I N E =======================================


sub_90E:						        ; CODE XREF: sub_B3+30↑p
			call    sub_27C
			ret     nz
			ld      e, (ix+3)
			ld      d, (ix+4)

loc_918:						        ; CODE XREF: sub_90E+47↓j
			ld      a, (de)
			inc     de
			cp      0E0h
			jp      nc, loc_94E
			or      a
			jp      m, loc_927
			dec     de
			ld      a, (ix+0Dh)

loc_927:						        ; CODE XREF: sub_90E+12↑j
			ld      (ix+0Dh), a
			cp      80h
			jp      z, loc_93E
			res     7, a
			push    de
			ex      af, af'
			call    sub_29D
			call    loc_75D
			ex      af, af'
			ld      (byte_1C06), a
			pop     de

loc_93E:						        ; CODE XREF: sub_90E+1E↑j
			ld      a, (de)
			inc     de
			or      a
			jp      p, loc_24A
			dec     de
			ld      a, (ix+0Ch)
			ld      (ix+0Bh), a
			jp      loc_250
; ---------------------------------------------------------------------------

loc_94E:						        ; CODE XREF: sub_90E+E↑j
			ld      hl, loc_954
			jp      loc_95B
; ---------------------------------------------------------------------------

loc_954:						        ; DATA XREF: sub_90E:loc_94E↑o
			inc     de
			jp      loc_918
; ---------------------------------------------------------------------------

loc_958:						        ; CODE XREF: sub_1B9+12↑j
			ld      hl, loc_964

loc_95B:						        ; CODE XREF: sub_90E+43↑j
			push    hl
			sub     0E0h
			ld      hl, off_968
			rst     loc_18
			ld      a, (de)
			jp      (hl)
; End of function sub_90E

; ---------------------------------------------------------------------------

loc_964:						        ; DATA XREF: sub_90E:loc_958↑o
			inc     de
			jp      loc_1C7
; ---------------------------------------------------------------------------
off_968:    dw loc_9BA			      ; DATA XREF: sub_90E+50↑o
			dw loc_9D9
			dw loc_9DD
			dw loc_9E1
			dw loc_9E7
			dw loc_A03
			dw loc_A05
			dw loc_A3D
			dw loc_A43
			dw loc_9CE
			dw loc_9B6
			dw loc_A4D
			dw loc_A63
			dw loc_A7D
			dw loc_A83
			dw loc_A90
			dw loc_ACF
			dw loc_ADD
			dw loc_AEA
			dw loc_B83
			dw loc_AE5
			dw loc_BA2
			dw loc_BAB
			dw loc_BB1
			dw loc_BC8
			dw loc_BE2
			dw loc_BF5
			dw loc_BFB
			dw locret_C02
			dw loc_C03
			dw loc_C11
			dw loc_C58
off_9A8:    dw loc_C5F			      ; DATA XREF: ROM:loc_C58↓o
			dw loc_C63
			dw loc_C6B
			dw loc_CA6
			dw loc_CB4
			dw loc_CC3
			dw loc_CDE
; ---------------------------------------------------------------------------

loc_9B6:						        ; DATA XREF: ROM:097C↑o
			ld      (byte_1C06), a
			ret
; ---------------------------------------------------------------------------

loc_9BA:						        ; DATA XREF: ROM:off_968↑o
			ld      c, 3Fh ; '?'
			ld      a, (ix+0Ah)
			and     c
			push    de
			ex      de, hl
			or      (hl)
			ld      (ix+0Ah), a
			ld      c, a
			ld      a, 0B4h
			call    sub_8C
			pop     de
			ret
; ---------------------------------------------------------------------------

loc_9CE:						        ; DATA XREF: ROM:097A↑o
			ld      a, (ix+7)
			or      a
			ret     z
			set     7, (ix+7)
			dec     de
			ret
; ---------------------------------------------------------------------------

loc_9D9:						        ; DATA XREF: ROM:096A↑o
			ld      (ix+10h), a
			ret
; ---------------------------------------------------------------------------

loc_9DD:						        ; DATA XREF: ROM:096C↑o
			ld      (byte_1C16), a
			ret
; ---------------------------------------------------------------------------
; START OF FUNCTION CHUNK FOR sub_472

loc_9E1:						        ; CODE XREF: sub_472+2↑j
									    ; DATA XREF: ROM:096E↑o
			call    sub_7F6
			jp      loc_AEA
; END OF FUNCTION CHUNK FOR sub_472
; ---------------------------------------------------------------------------

loc_9E7:						        ; DATA XREF: ROM:0970↑o
			bit     7, (ix+1)
			jr      z, loc_9FA
			srl     a
			srl     a
			srl     a
			xor     0Fh
			and     0Fh
			jp      loc_A79
; ---------------------------------------------------------------------------

loc_9FA:						        ; CODE XREF: ROM:09EB↑j
			xor     7Fh
			and     7Fh
			ld      (ix+6), a
			jr      sub_A1C
; ---------------------------------------------------------------------------

loc_A03:						        ; DATA XREF: ROM:0972↑o
			inc     de
			ld      a, (de)

loc_A05:						        ; DATA XREF: ROM:0974↑o
			bit     7, (ix+1)
			ret     nz
			add     a, (ix+6)
			jp      p, loc_A19
			jp      pe, loc_A17
			xor     a
			jp      loc_A19
; ---------------------------------------------------------------------------

loc_A17:						        ; CODE XREF: ROM:0A10↑j
			ld      a, 7Fh

loc_A19:						        ; CODE XREF: ROM:0A0D↑j
									    ; ROM:0A14↑j
			ld      (ix+6), a

; =============== S U B R O U T I N E =======================================


sub_A1C:						        ; CODE XREF: sub_3FB+1E↑j
									    ; sub_6C9+57↑p ...
			push    de
			ld      de, unk_3F3
			ld      l, (ix+1Ch)
			ld      h, (ix+1Dh)
			ld      b, 4

loc_A28:						        ; CODE XREF: sub_A1C+1D↓j
			ld      a, (hl)
			or      a
			jp      p, loc_A30
			add     a, (ix+6)

loc_A30:						        ; CODE XREF: sub_A1C+E↑j
			and     7Fh
			ld      c, a
			ld      a, (de)
			call    sub_8C
			inc     de
			inc     hl
			djnz    loc_A28
			pop     de
			ret
; End of function sub_A1C

; ---------------------------------------------------------------------------

loc_A3D:						        ; DATA XREF: ROM:0976↑o
			set     1, (ix+0)
			dec     de
			ret
; ---------------------------------------------------------------------------

loc_A43:						        ; DATA XREF: ROM:0978↑o
			call    sub_272
			ld      (ix+1Eh), a
			ld      (ix+1Fh), a
			ret
; ---------------------------------------------------------------------------

loc_A4D:						        ; DATA XREF: ROM:097E↑o
			inc     de
			add     a, 28h ; '('
			ld      c, a
			ld      b, 0
			push    ix
			pop     hl
			add     hl, bc
			ld      a, (hl)
			dec     a
			jp      z, loc_A5E
			inc     de
			ret
; ---------------------------------------------------------------------------

loc_A5E:						        ; CODE XREF: ROM:0A59↑j
			xor     a
			ld      (hl), a
			jp      loc_BAB
; ---------------------------------------------------------------------------

loc_A63:						        ; DATA XREF: ROM:0980↑o
			bit     7, (ix+1)
			ret     z
			res     4, (ix+0)
			dec     (ix+17h)
			add     a, (ix+6)
			cp      0Fh
			jp      c, loc_A79
			ld      a, 0Fh

loc_A79:						        ; CODE XREF: ROM:09F7↑j
									    ; ROM:0A74↑j
			ld      (ix+6), a
			ret
; ---------------------------------------------------------------------------

loc_A7D:						        ; DATA XREF: ROM:0982↑o
			sub     40h ; '@'
			ld      (ix+5), a
			ret
; ---------------------------------------------------------------------------

loc_A83:						        ; DATA XREF: ROM:0984↑o
			call    sub_A8A
			call    sub_9F
			ret

; =============== S U B R O U T I N E =======================================


sub_A8A:						        ; CODE XREF: ROM:loc_A83↑p
			ex      de, hl
			ld      a, (hl)
			inc     hl
			ld      c, (hl)
			ex      de, hl
			ret
; End of function sub_A8A

; ---------------------------------------------------------------------------

loc_A90:						        ; DATA XREF: ROM:0986↑o
			bit     7, (ix+1)
			jr      nz, loc_AC6
			call    sub_806
			ld      a, (de)
			ld      (ix+8), a
			or      a
			jp      p, loc_ABC
			inc     de
			ld      a, (de)
			ld      (ix+0Fh), a

; =============== S U B R O U T I N E =======================================


sub_AA6:						        ; CODE XREF: sub_472+6C7↓p
			push    de
			ld      a, (ix+0Fh)
			sub     81h
			ld      c, 4
			rst     loc_8
			rst     loc_18
			rst     loc_20
			ld      a, (ix+8)
			and     7Fh
			ld      b, a
			call    sub_3D4
			jr      loc_AC1
; ---------------------------------------------------------------------------

loc_ABC:						        ; CODE XREF: ROM:0A9E↑j
			push    de
			ld      b, a
			call    sub_3C5

loc_AC1:						        ; CODE XREF: sub_AA6+14↑j
			call    sub_3FB
			pop     de
			ret
; End of function sub_AA6

; ---------------------------------------------------------------------------

loc_AC6:						        ; CODE XREF: ROM:0A94↑j
			or      a
			jp      p, loc_BA7
			inc     de
			jp      loc_BA7
; ---------------------------------------------------------------------------
			ret
; ---------------------------------------------------------------------------

loc_ACF:						        ; DATA XREF: ROM:0988↑o
			ld      (ix+20h), e
			ld      (ix+21h), d
			ld      (ix+7), 80h
			inc     de
			inc     de
			inc     de
			ret
; ---------------------------------------------------------------------------

loc_ADD:						        ; DATA XREF: ROM:098A↑o
			inc     de
			bit     7, (ix+1)
			jr      nz, loc_AE5
			ld      a, (de)

loc_AE5:						        ; CODE XREF: ROM:0AE2↑j
									    ; DATA XREF: ROM:0990↑o
			inc     a
			ld      (ix+7), a
			ret
; ---------------------------------------------------------------------------
; START OF FUNCTION CHUNK FOR sub_472

loc_AEA:						        ; CODE XREF: sub_472+572↑j
									    ; DATA XREF: ROM:098C↑o
			res     7, (ix+0)
			ld      a, 1Fh
			ld      (byte_1C15), a
			call    sub_29D
			ld      c, (ix+1)
			push    ix
			call    sub_5DF
			ld      a, (byte_1C19)
			or      a
			jr      z, loc_B6C
			xor     a
			ld      (byte_1C18), a
			push    hl
			ld      hl, (word_1C37)
			pop     ix
			res     2, (ix+0)
			bit     7, (ix+1)
			jr      nz, loc_B71
			bit     7, (ix+0)
			jr      z, loc_B6C
			ld      a, 2
			cp      (ix+1)
			jr      nz, loc_B32
			ld      a, 4Fh ; 'O'
			bit     0, (ix+0)
			jr      nz, loc_B2F
			and     0Fh

loc_B2F:						        ; CODE XREF: sub_472+6B9↑j
			call    sub_C3A

loc_B32:						        ; CODE XREF: sub_472+6B1↑j
			ld      a, (ix+8)
			or      a
			jp      p, loc_B3E
			call    sub_AA6
			jr      loc_B69
; ---------------------------------------------------------------------------

loc_B3E:						        ; CODE XREF: sub_472+6C4↑j
			ld      b, a
			push    hl
			ld      hl, 6000h
			ld      a, (byte_1C04)
			ld      (hl), a
			rra
			ld      (hl), a
			rra
			ld      (hl), a
			rra
			ld      (hl), a
			xor     a
			ld      d, 1
			ld      (hl), d
			ld      (hl), a
			ld      (hl), a
			ld      (hl), a
			ld      (hl), a
			pop     hl
			call    sub_3D4
			call    sub_3FB
			ld      a, (ix+18h)
			or      a
			jp      p, loc_B6C
			ld      e, (ix+19h)
			ld      d, (ix+1Ah)

loc_B69:						        ; CODE XREF: sub_472+6CA↑j
			call    sub_CCD

loc_B6C:						        ; CODE XREF: sub_472+690↑j
									    ; sub_472+6AA↑j ...
			pop     ix
			pop     hl
			pop     hl
			ret
; ---------------------------------------------------------------------------

loc_B71:						        ; CODE XREF: sub_472+6A4↑j
			bit     0, (ix+0)
			jr      z, loc_B6C
			ld      a, (ix+1Ah)
			or      a
			jp      p, loc_B81
			ld      (7F11h), a

loc_B81:						        ; CODE XREF: sub_472+709↑j
			jr      loc_B6C
; END OF FUNCTION CHUNK FOR sub_472
; ---------------------------------------------------------------------------

loc_B83:						        ; DATA XREF: ROM:098E↑o
			bit     2, (ix+1)
			ret     nz
			ld      a, 0DFh
			ld      (7F11h), a
			ld      a, (de)
			ld      (ix+1Ah), a
			set     0, (ix+0)
			or      a
			jr      nz, loc_B9E
			res     0, (ix+0)
			ld      a, 0FFh

loc_B9E:						        ; CODE XREF: ROM:0B96↑j
			ld      (7F11h), a
			ret
; ---------------------------------------------------------------------------

loc_BA2:						        ; DATA XREF: ROM:0992↑o
			bit     7, (ix+1)
			ret     z

loc_BA7:						        ; CODE XREF: ROM:0AC7↑j
									    ; ROM:0ACB↑j
			ld      (ix+8), a
			ret
; ---------------------------------------------------------------------------

loc_BAB:						        ; CODE XREF: ROM:0A60↑j
									    ; ROM:0BC3↓j
									    ; DATA XREF: ...
			ex      de, hl
			ld      e, (hl)
			inc     hl
			ld      d, (hl)
			dec     de
			ret
; ---------------------------------------------------------------------------

loc_BB1:						        ; DATA XREF: ROM:0996↑o
			inc     de
			add     a, 28h ; '('
			ld      c, a
			ld      b, 0
			push    ix
			pop     hl
			add     hl, bc
			ld      a, (hl)
			or      a
			jr      nz, loc_BC1
			ld      a, (de)
			ld      (hl), a

loc_BC1:						        ; CODE XREF: ROM:0BBD↑j
			inc     de
			dec     (hl)
			jp      nz, loc_BAB
			inc     de
			ret
; ---------------------------------------------------------------------------

loc_BC8:						        ; DATA XREF: ROM:0998↑o
			ld      c, a
			inc     de
			ld      a, (de)
			ld      b, a
			push    bc
			push    ix
			pop     hl
			dec     (ix+9)
			ld      c, (ix+9)
			dec     (ix+9)
			ld      b, 0
			add     hl, bc
			ld      (hl), d
			dec     hl
			ld      (hl), e
			pop     de
			dec     de
			ret
; ---------------------------------------------------------------------------

loc_BE2:						        ; DATA XREF: ROM:099A↑o
			push    ix
			pop     hl
			ld      c, (ix+9)
			ld      b, 0
			add     hl, bc
			ld      e, (hl)
			inc     hl
			ld      d, (hl)
			inc     (ix+9)
			inc     (ix+9)
			ret
; ---------------------------------------------------------------------------

loc_BF5:						        ; DATA XREF: ROM:099C↑o
			res     7, (ix+7)
			dec     de
			ret
; ---------------------------------------------------------------------------

loc_BFB:						        ; DATA XREF: ROM:099E↑o
			add     a, (ix+5)
			ld      (ix+5), a
			ret
; ---------------------------------------------------------------------------

locret_C02:						     ; DATA XREF: ROM:09A0↑o
			ret
; ---------------------------------------------------------------------------

loc_C03:						        ; DATA XREF: ROM:09A2↑o
			cp      1
			jr      nz, loc_C0C
			set     3, (ix+0)
			ret
; ---------------------------------------------------------------------------

loc_C0C:						        ; CODE XREF: ROM:0C05↑j
			res     3, (ix+0)
			ret
; ---------------------------------------------------------------------------

loc_C11:						        ; DATA XREF: ROM:09A4↑o
			ld      a, (ix+1)
			cp      2
			jr      nz, loc_C44
			set     0, (ix+0)
			ex      de, hl
			call    sub_1A9
			ld      b, 4

loc_C22:						        ; CODE XREF: ROM:0C34↓j
			push    bc
			ld      a, (hl)
			inc     hl
			push    hl
			ld      hl, unk_C48
			add     a, a
			ld      c, a
			ld      b, 0
			add     hl, bc
			ldi
			ldi
			pop     hl
			pop     bc
			djnz    loc_C22
			ex      de, hl
			dec     de
			ld      a, 4Fh ; 'O'

; =============== S U B R O U T I N E =======================================


sub_C3A:						        ; CODE XREF: sub_472:loc_B2F↑p
			ld      (byte_1C12), a
			ld      c, a
			ld      a, 27h ; '''
			call    sub_9F
			ret
; End of function sub_C3A

; ---------------------------------------------------------------------------

loc_C44:						        ; CODE XREF: ROM:0C16↑j
			inc     de
			inc     de
			inc     de
			ret
; ---------------------------------------------------------------------------
unk_C48:    db    0			         ; DATA XREF: ROM:0C26↑o
			db    0
			db  32h ; 2
			db    1
			db  8Eh
			db    1
			db 0E4h
			db    1
			db  34h ; 4
			db    2
			db  7Eh ; ~
			db    2
			db 0C2h
			db    2
			db 0F0h
			db    2
; ---------------------------------------------------------------------------

loc_C58:						        ; DATA XREF: ROM:09A6↑o
			ld      hl, off_9A8
			rst     loc_18
			inc     de
			ld      a, (de)
			jp      (hl)
; ---------------------------------------------------------------------------

loc_C5F:						        ; DATA XREF: ROM:off_9A8↑o
			ld      (byte_1C05), a
			ret
; ---------------------------------------------------------------------------

loc_C63:						        ; DATA XREF: ROM:09AA↑o
			push    ix
			call    sub_427
			pop     ix
			ret
; ---------------------------------------------------------------------------

loc_C6B:						        ; DATA XREF: ROM:09AC↑o
			ld      (byte_1C11), a
			or      a
			jr      z, loc_C8E
			push    ix
			push    de
			ld      ix, byte_1C40
			ld      b, 9
			ld      de, 30h ; '0'

loc_C7D:						        ; CODE XREF: ROM:0C86↓j
			res     7, (ix+0)
			call    loc_2A3
			add     ix, de
			djnz    loc_C7D
			pop     de
			pop     ix
			jp      sub_7A0
; ---------------------------------------------------------------------------

loc_C8E:						        ; CODE XREF: ROM:0C6F↑j
			push    ix
			push    de
			ld      ix, byte_1C40
			ld      b, 9
			ld      de, 30h ; '0'

loc_C9A:						        ; CODE XREF: ROM:0CA0↓j
			set     7, (ix+0)
			add     ix, de
			djnz    loc_C9A
			pop     de
			pop     ix
			ret
; ---------------------------------------------------------------------------

loc_CA6:						        ; DATA XREF: ROM:09AE↑o
			ex      de, hl
			ld      e, (hl)
			inc     hl
			ld      d, (hl)
			inc     hl
			ld      c, (hl)
			ld      b, 0
			inc     hl
			ex      de, hl
			ldir
			dec     de
			ret
; ---------------------------------------------------------------------------

loc_CB4:						        ; DATA XREF: ROM:09B0↑o
			ld      b, 9
			ld      hl, 1C42h

loc_CB9:						        ; CODE XREF: ROM:0CC0↓j
			push    bc
			ld      bc, 30h ; '0'
			ld      (hl), a
			add     hl, bc
			pop     bc
			djnz    loc_CB9
			ret
; ---------------------------------------------------------------------------

loc_CC3:						        ; DATA XREF: ROM:09B2↑o
			ld      (ix+18h), 80h
			ld      (ix+19h), e
			ld      (ix+1Ah), d

; =============== S U B R O U T I N E =======================================


sub_CCD:						        ; CODE XREF: sub_472:loc_B69↑p
			ld      hl, unk_3F7
			ld      b, 4

loc_CD2:						        ; CODE XREF: sub_CCD+D↓j
			ld      a, (de)
			inc     de
			ld      c, a
			ld      a, (hl)
			inc     hl
			call    sub_8C
			djnz    loc_CD2
			dec     de
			ret
; End of function sub_CCD

; ---------------------------------------------------------------------------

loc_CDE:						        ; DATA XREF: ROM:09B4↑o
			ld      (ix+18h), a
			inc     de
			ld      a, (de)
			ld      (ix+19h), a
			ret
; ---------------------------------------------------------------------------
; START OF FUNCTION CHUNK FOR sub_119

loc_CE7:						        ; CODE XREF: sub_119+4↑j
			call    sub_27C
			jr      nz, loc_CF9
			call    sub_1B9
			bit     4, (ix+0)
			ret     nz
			call    sub_2E0
			jr      loc_D05
; ---------------------------------------------------------------------------

loc_CF9:						        ; CODE XREF: sub_119+BD1↑j
			ld      a, (ix+1Eh)
			or      a
			jr      z, loc_D05
			dec     (ix+1Eh)
			jp      z, sub_D8F

loc_D05:						        ; CODE XREF: sub_119+BDE↑j
									    ; sub_119+BE4↑j
			call    sub_3B1
			call    sub_30B
			bit     2, (ix+0)
			ret     nz
			ld      c, (ix+1)
			ld      a, l
			and     0Fh
			or      c
			ld      (7F11h), a
			ld      a, l
			and     0F0h
			or      h
			rrca
			rrca
			rrca
			rrca
			ld      (7F11h), a
			ld      a, (ix+8)
			or      a
			ld      c, 0
			jr      z, loc_D36
			dec     a
			ld      c, 0Ah
			rst     loc_8
			rst     loc_18
			call    sub_D5D
			ld      c, a

loc_D36:						        ; CODE XREF: sub_119+C12↑j
			bit     4, (ix+0)
			ret     nz
			ld      a, (ix+6)
			add     a, c
			bit     4, a
			jr      z, loc_D45
			ld      a, 0Fh

loc_D45:						        ; CODE XREF: sub_119+C28↑j
			or      (ix+1)
			add     a, 10h
			bit     0, (ix+0)
			jr      nz, loc_D54
			ld      (7F11h), a
			ret
; ---------------------------------------------------------------------------

loc_D54:						        ; CODE XREF: sub_119+C35↑j
			add     a, 20h ; ' '
			ld      (7F11h), a
			ret
; END OF FUNCTION CHUNK FOR sub_119
; ---------------------------------------------------------------------------
; START OF FUNCTION CHUNK FOR sub_D5D

loc_D5A:						        ; CODE XREF: sub_D5D+1B↓j
									    ; sub_D5D+26↓j
			ld      (ix+17h), a
; END OF FUNCTION CHUNK FOR sub_D5D

; =============== S U B R O U T I N E =======================================


sub_D5D:						        ; CODE XREF: sub_2AF+B↑p
									    ; sub_119+C19↑p

; FUNCTION CHUNK AT 0D5A SIZE 00000003 BYTES

			push    hl
			ld      c, (ix+17h)
			ld      b, 0
			add     hl, bc
			ld      a, (hl)
			pop     hl
			bit     7, a
			jr      z, loc_D8B
			cp      83h
			jr      z, loc_D7A
			cp      81h
			jr      z, loc_D85
			cp      80h
			jr      z, loc_D82
			inc     bc
			ld      a, (bc)
			jr      loc_D5A
; ---------------------------------------------------------------------------

loc_D7A:						        ; CODE XREF: sub_D5D+F↑j
			set     4, (ix+0)
			pop     hl
			jp      sub_D8F
; ---------------------------------------------------------------------------

loc_D82:						        ; CODE XREF: sub_D5D+17↑j
			xor     a
			jr      loc_D5A
; ---------------------------------------------------------------------------

loc_D85:						        ; CODE XREF: sub_D5D+13↑j
			pop     hl
			set     4, (ix+0)
			ret
; ---------------------------------------------------------------------------

loc_D8B:						        ; CODE XREF: sub_D5D+B↑j
			inc     (ix+17h)
			ret
; End of function sub_D5D


; =============== S U B R O U T I N E =======================================


sub_D8F:						        ; CODE XREF: sub_1B9+2A↑p
									    ; sub_119+BE9↑j ...
			set     4, (ix+0)
			bit     2, (ix+0)
			ret     nz
; End of function sub_D8F


; =============== S U B R O U T I N E =======================================


sub_D98:						        ; CODE XREF: sub_5DF+E↑p
			ld      a, 1Fh
			add     a, (ix+1)
			or      a
			ret     p
			ld      (7F11h), a
			bit     0, (ix+0)
			ret     z
			ld      a, 0FFh
			ld      (7F11h), a
			ret
; End of function sub_D98

; ---------------------------------------------------------------------------
; START OF FUNCTION CHUNK FOR sub_0

loc_DAD:						        ; CODE XREF: sub_0+89↑j
									    ; ROM:0E36↓j ...
			di
			ld      a, 2Bh ; '+'
			ld      c, 0
			call    sub_9F

loc_DB5:						        ; CODE XREF: sub_0+DC1↓j
									    ; ROM:0E28↓j
			ei
			ld      a, (byte_1C07)
			or      a
			jp      nz, loc_E49
			ld      a, (byte_1C06)
			or      a
			jr      z, loc_DB5
			ld      a, 2Bh ; '+'
			ld      c, 80h
			di
			call    sub_9F
			ei
			ld      iy, unk_E39
			ld      hl, byte_1C06
			ld      a, (hl)
			dec     a
			set     7, (hl)
			ld      hl, 8000h
			rst     loc_18
			ld      c, 80h
			ld      a, (hl)
			ld      (loc_DED+1), a
			ld      (loc_E0A+1), a
			inc     hl
			ld      e, (hl)
			inc     hl
			ld      d, (hl)
			inc     hl
			ld      a, (hl)
			inc     hl
			ld      h, (hl)
			ld      l, a
; END OF FUNCTION CHUNK FOR sub_0

loc_DED:						        ; CODE XREF: ROM:0E2F↓j
									    ; DATA XREF: sub_0+DDE↑w
			ld      b, 0Ah
			ei

loc_DF0:						        ; CODE XREF: ROM:loc_DF0↓j
			djnz    $
			di
			ld      a, 2Ah ; '*'
			ld      (4000h), a
			ld      a, (hl)
			rlca
			rlca
			rlca
			rlca
			and     0Fh
			ld      (loc_E03+2), a
			ld      a, c

loc_E03:						        ; DATA XREF: ROM:0DFF↑w
			add     a, (iy+0)
			ld      (4001h), a
			ld      c, a

loc_E0A:						        ; DATA XREF: sub_0+DE1↑w
			ld      b, 0Ah
			ei

loc_E0D:						        ; CODE XREF: ROM:loc_E0D↓j
			djnz    $
			di
			ld      a, 2Ah ; '*'
			ld      (4000h), a
			ld      a, (hl)
			and     0Fh
			ld      (loc_E1C+2), a
			ld      a, c

loc_E1C:						        ; DATA XREF: ROM:0E18↑w
			add     a, (iy+0)
			ld      (4001h), a
			ei
			ld      c, a
			ld      a, (byte_1C06)
			or      a
			jp      p, loc_DB5
			inc     hl
			dec     de
			ld      a, d
			or      e
			jp      nz, loc_DED
			xor     a
			ld      (byte_1C06), a
			jp      loc_DAD
; ---------------------------------------------------------------------------
unk_E39:    db    0			         ; DATA XREF: sub_0+DCC↑o
			db    1
			db    2
			db    4
			db    8
			db  10h
			db  20h
			db  40h ; @
			db  80h
			db 0FFh
			db 0FEh
			db 0FCh
			db 0F8h
			db 0F0h
			db 0E0h
			db 0C0h
; ---------------------------------------------------------------------------
; START OF FUNCTION CHUNK FOR sub_0

loc_E49:						        ; CODE XREF: sub_0+DBA↑j
			di
			ld      a, 2Bh ; '+'
			ld      (4000h), a
			nop
			ld      a, 80h
			ld      (4001h), a
			ld      hl, 6000h
			xor     a
			ld      e, 1
			ld      (hl), e
			ld      (hl), e
			ld      (hl), e
			ld      (hl), e
			ld      (hl), e
			ld      (hl), a
			ld      (hl), a
			ld      (hl), a
			ld      (hl), a
			ld      hl, 8000h
			ld      de, 6CAAh
			ld      a, 2Ah ; '*'
			ld      (4000h), a

loc_E6F:						        ; CODE XREF: sub_0+E7B↓j
			ld      a, (hl)
			ld      (4001h), a
			ld      b, 0Dh

loc_E75:						        ; CODE XREF: sub_0:loc_E75↓j
			djnz    $
			inc     hl
			dec     de
			ld      a, d
			or      e
			jp      nz, loc_E6F
			xor     a
			ld      (byte_1C07), a
			call    sub_72C
			jp      loc_DAD
; END OF FUNCTION CHUNK FOR sub_0
; ---------------------------------------------------------------------------
			db 0EFh
			db  14h
			db  8Bh
			db  33h ; 3
			db 0C2h
			db 0D3h
			db 0D4h
			db 0D5h
			db  84h
			db 0D6h
			db 0C1h
			db  80h
			db  87h
			db  80h
			db  8Fh
			db 0C6h
			db 0A0h
			db 0A3h
			db 0A5h
			db 0A7h
			db 0A9h
			db 0ABh
			db 0ADh
			db  89h
			db 0AFh
			db 0C1h
			db 0D3h
			db 0D4h
			db  80h
			db 0D5h
			db  84h
			db 0D6h
			db 0C9h
			db  80h
			db  87h
			db  90h
			db  99h
			db  8Fh
			db 0A4h
			db 0A6h
			db 0A8h
			db 0AAh
			db 0ACh
			db  82h
			db 0AEh
			db 0C9h
			db 0B0h
			db 0B1h
			db 0B2h
			db 0B3h
			db 0B5h
			db 0B7h
			db 0C0h
			db 0CCh
			db 0D3h
			db 0D4h
			db  80h
			db 0D5h
			db  84h
			db 0D6h
			db 0C4h
			db  80h
			db  87h
			db  91h
			db  9Ah
			db 0A1h
			db  8Ah
			db 0A2h
			db 0C6h
			db 0B4h
			db 0B6h
			db 0B8h
			db 0C1h
			db 0CDh
			db 0D3h
			db 0D4h
			db  80h
			db 0D5h
			db  84h
			db 0D6h
			db 0C3h
			db  80h
			db  88h
			db  92h
			db  9Ah
			db  8Dh
			db 0A2h
			db 0C4h
			db 0B9h
			db 0C2h
			db 0CEh
			db 0D3h
			db 0D4h
			db  80h
			db 0D5h
			db  84h
			db 0D6h
			db 0C3h
			db  81h
			db  89h
			db  93h
			db  9Bh
			db  8Dh
			db 0A2h
			db 0C0h
			db 0BAh
			db  80h
			db 0C3h
			db 0C1h
			db 0D3h
			db 0D4h
			db  80h
			db 0D5h
			db  84h
			db 0D6h
			db 0C3h
			db  81h
			db  89h
			db  94h
			db  9Ch
			db  8Eh
			db 0A2h
			db 0C3h
			db 0C3h
			db 0C4h
			db 0D3h
			db 0D4h
			db  80h
			db 0D5h
			db  84h
			db 0D6h
			db 0C3h
			db  81h
			db  89h
			db  95h
			db  9Dh
			db  8Eh
			db 0A2h
			db  80h
			db 0C4h
			db 0C1h
			db 0D3h
			db 0D4h
			db  80h
			db 0D5h
			db  84h
			db 0D6h
			db 0C3h
			db  81h
			db  89h
			db  96h
			db  9Eh
			db  8Eh
			db 0A2h
			db  80h
			db 0C4h
			db 0C1h
			db 0D3h
			db 0D4h
			db  80h
			db 0D5h
			db  84h
			db 0D6h
			db 0C3h
			db  81h
			db  89h
			db  97h
			db  9Eh
			db  8Dh
			db 0A2h
			db 0C4h
			db 0BBh
			db 0C5h
			db 0C4h
			db 0D3h
			db 0D4h
			db  80h
			db 0D5h
			db  84h
			db 0D6h
			db 0C3h
			db  81h
			db  89h
			db  98h
			db  9Fh
			db  8Dh
			db 0A2h
			db 0C4h
			db 0BBh
			db 0C6h
			db 0CFh
			db 0D3h
			db 0D4h
			db  80h
			db 0D5h
			db  84h
			db 0D6h
			db 0C3h
			db  81h
			db  89h
			db  98h
			db  9Fh
			db  8Dh
			db 0A2h
			db 0C4h
			db 0BBh
			db 0C7h
			db 0D0h
			db 0D3h
			db 0D4h
			db  80h
			db 0D5h
			db  84h
			db 0D6h
			db 0C3h
			db  82h
			db  89h
			db  98h
			db  9Fh
			db  8Dh
			db 0A2h
			db 0C4h
			db 0BBh
			db 0C8h
			db 0D0h
			db 0D3h
			db 0D4h
			db  80h
			db 0D5h
			db  84h
			db 0D6h
			db 0C3h
			db  83h
			db  8Ah
			db  98h
			db  9Fh
			db  8Dh
			db 0A2h
			db 0C4h
			db 0BCh
			db 0C9h
			db 0D1h
			db 0D3h
			db 0D4h
			db  80h
			db 0D5h
			db  84h
			db 0D6h
			db 0C3h
			db  84h
			db  8Bh
			db  98h
			db  9Fh
			db  8Dh
			db 0A2h
			db 0C4h
			db 0BDh
			db 0C7h
			db 0D2h
			db 0D3h
			db 0D4h
			db  80h
			db 0D5h
			db  84h
			db 0D6h
			db 0C3h
			db  85h
			db  8Ch
			db  98h
			db  9Fh
			db  8Dh
			db 0A2h
			db 0C4h
			db 0BEh
			db 0CAh
			db 0D2h
			db 0D3h
			db 0D4h
			db  80h
			db 0D5h
			db  84h
			db 0D6h
			db 0C3h
			db  86h
			db  8Dh
			db  98h
			db  9Fh
			db  8Dh
			db 0A2h
			db 0C4h
			db 0BEh
			db 0CBh
			db 0D2h
			db 0D3h
			db 0D4h
			db  80h
			db 0D5h
			db  84h
			db 0D6h
			db 0C3h
			db  86h
			db  8Eh
			db  98h
			db  9Fh
			db  8Dh
			db 0A2h
			db 0C4h
			db 0BFh
			db 0C7h
			db 0D2h
			db 0D3h
			db 0D4h
			db  80h
			db 0D5h
			db  84h
			db 0D6h
			db 0C3h
			db  86h
			db  8Dh
			db  98h
			db  9Fh
			db  8Dh
			db 0A2h
			db 0C4h
			db 0BEh
			db 0CBh
			db 0D2h
			db 0D3h
			db 0D4h
			db  80h
			db 0D5h
			db  84h
			db 0D6h
			db 0C3h
			db  85h
			db  8Ch
			db  98h
			db  9Fh
			db  8Dh
			db 0A2h
			db 0C4h
			db 0BEh
			db 0CAh
			db 0D2h
			db 0D3h
			db 0D4h
			db  80h
			db 0D5h
			db  84h
			db 0D6h
			db 0C3h
			db  84h
			db  8Bh
			db  98h
			db  9Fh
			db  8Dh
			db 0A2h
			db 0C4h
			db 0BDh
			db 0C7h
			db 0D2h
			db 0D3h
			db 0D4h
			db  80h
			db 0D5h
			db  84h
			db 0D6h
			db 0C3h
			db  83h
			db  8Ah
			db  98h
			db  9Fh
			db  8Dh
			db 0A2h
			db 0C4h
			db 0BCh
			db 0C9h
			db 0D1h
			db 0D3h
			db 0D4h
			db  80h
			db 0D5h
			db  84h
			db 0D6h
			db 0C3h
			db  82h
			db  89h
			db  98h
			db  9Fh
			db  8Dh
			db 0A2h
			db 0C4h
			db 0BBh
			db 0C8h
			db 0D0h
			db 0D3h
			db 0D4h
			db  80h
			db 0D5h
			db  84h
			db 0D6h
			db 0C3h
			db  81h
			db  89h
			db  98h
			db  9Fh
			db  8Dh
			db 0A2h
			db 0C4h
			db 0BBh
			db 0C7h
			db 0D0h
			db 0D3h
			db 0D4h
			db  80h
			db 0D5h
			db  84h
			db 0D6h
			db 0C3h
			db  81h
			db  89h
			db  98h
			db  9Fh
			db  8Dh
			db 0A2h
			db 0C4h
			db 0BBh
			db 0C6h
			db 0CFh
			db 0D3h
			db 0D4h
			db  80h
			db 0D5h
			db  84h
			db 0D6h
			db 0C3h
			db  81h
			db  89h
			db  97h
			db  9Eh
			db  8Dh
			db 0A2h
			db 0C4h
			db 0BBh
			db 0C5h
			db 0C4h
			db 0D3h
			db 0D4h
			db  80h
			db 0D5h
			db  84h
			db 0D6h
			db 0C3h
			db  81h
			db  89h
			db  96h
			db  9Eh
			db  8Eh
			db 0A2h
			db  80h
			db 0C4h
			db 0C1h
			db 0D3h
			db 0D4h
			db  80h
			db 0D5h
			db  84h
			db 0D6h
			db 0C3h
			db  81h
			db  89h
			db  95h
			db  9Dh
			db  8Eh
			db 0A2h
			db  80h
			db 0C4h
			db 0C1h
			db 0D3h
			db 0D4h
			db  80h
			db 0D5h
			db  84h
			db 0D6h
			db 0C3h
			db  81h
			db  89h
			db  94h
			db  9Ch
			db  8Eh
			db 0A2h
			db 0C3h
			db 0C3h
			db 0C4h
			db 0D3h
			db 0D4h
			db  80h
			db 0D5h
			db  84h
			db 0D6h
			db 0C3h
			db  81h
			db  89h
			db  93h
			db  9Bh
			db  8Dh
			db 0A2h
			db 0C0h
			db 0BAh
			db  80h
			db 0C3h
			db 0C1h
			db 0D3h
			db 0D4h
			db  80h
			db 0D5h
			db  84h
			db 0D6h
			db 0C3h
			db  80h
			db  88h
			db  92h
			db  9Ah
			db  8Dh
			db 0A2h
			db 0C4h
			db 0B9h
			db 0C2h
			db 0CEh
			db 0D3h
			db 0D4h
			db  80h
			db 0D5h
			db  84h
			db 0D6h
			db 0C4h
			db  80h
			db  87h
			db  91h
			db  9Ah
			db 0A1h
			db  8Ah
			db 0A2h
			db 0C6h
			db 0B4h
			db 0B6h
			db 0B8h
			db 0C1h
			db 0CDh
			db 0D3h
			db 0D4h
			db  80h
			db 0D5h
			db  84h
			db 0D6h
			db 0C9h
			db  80h
			db  87h
			db  90h
			db  99h
			db  8Fh
			db 0A4h
			db 0A6h
			db 0A8h
			db 0AAh
			db 0ACh
			db  82h
			db 0AEh
			db 0C9h
			db 0B0h
			db 0B1h
			db 0B2h
			db 0B3h
			db 0B5h
			db 0B7h
			db 0C0h
			db 0CCh
			db 0D3h
			db 0D4h
			db  80h
			db 0D5h
			db  84h
			db 0D6h
			db 0C1h
			db  80h
			db  87h
			db  80h
			db  8Fh
			db 0C6h
			db 0A0h
			db 0A3h
			db 0A5h
			db 0A7h
			db 0A9h
			db 0ABh
			db 0ADh
			db  89h
			db 0AFh
			db 0C1h
			db 0D3h
			db 0D4h
			db  80h
			db 0D5h
			db  84h
			db 0D6h
			db 0C9h
			db  80h
			db  87h
			db  8Fh
			db  68h ; h
			db  80h
			db  8Ah
			db  97h
			db 0C3h
			db 0EFh
			db  14h
			db  8Bh
			db  33h ; 3
			db 0C2h
			db 0D3h
			db 0D4h
			db 0D5h
			db  84h
			db 0D6h
			db 0C9h
			db  80h
			db  87h
			db  8Fh
			db  68h ; h
			db  80h
			db  8Ah
			db  97h
			db 0C3h
			db 0EFh
			db  14h
			db  8Bh
			db  33h ; 3
			db 0C2h
			db 0D3h
			db 0D4h
			db 0D5h
			db  84h
			db 0D6h
			db 0C9h
			db  80h
			db  87h
			db  8Fh
			db  68h ; h
			db  80h
			db  8Ah
			db  97h
			db 0C3h
			db 0EFh
			db  14h
			db  8Bh
			db  33h ; 3
			db 0C2h
			db 0D3h
			db 0D4h
			db 0D5h
			db  84h
			db 0D6h
			db 0C9h
			db  80h
			db  87h
			db  8Fh
			db  68h ; h
			db  80h
			db  8Ah
			db  97h
			db 0C3h
			db 0EFh
			db  14h
			db  8Bh
			db  33h ; 3
			db 0C2h
			db 0D3h
			db 0D4h
			db 0D5h
			db  84h
			db 0D6h
			db 0C1h
			db  80h
			db  87h
			db  80h
			db  8Fh
			db 0C6h
			db 0A0h
			db 0A3h
			db 0A5h
			db 0A7h
			db 0A9h
			db 0ABh
			db 0ADh
			db  89h
			db 0AFh
			db 0C1h
			db 0D3h
			db 0D4h
			db  80h
			db 0D5h
			db  84h
			db 0D6h
			db 0C1h
			db  80h
			db  87h
			db  80h
			db  8Fh
			db 0C0h
			db  7Eh ; ~
			db  80h
			db  74h ; t
			db 0CFh
			db 0BFh
			db  76h ; v
			db  78h ; x
			db 0AAh
			db  3Ch ; <
			db  6Dh ; m
			db  7Eh ; ~
			db  9Ah
			db  72h ; r
			db 0A6h
			db 0BCh
			db 0C7h
			db 0D0h
			db 0D5h
			db 0D3h
			db 0D4h
			db  81h
			db 0D5h
			db  84h
			db 0D6h
			db 0C1h
			db  80h
			db  87h
			db  80h
			db  8Fh
			db  81h
			db  74h ; t
			db 0D2h
			db 0C0h
			db 0D3h
			db  6Ah ; j
			db  1Bh
			db  3Dh ; =
			db  6Eh ; n
			db  7Fh ; 
			db  9Bh
			db  73h ; s
			db 0A7h
			db 0D0h
			db 0F8h
			db  2Eh ; .
			db 0D5h
			db 0D3h
			db 0D4h
			db 0D5h
			db 0DDh
			db 0E0h
			db  84h
			db 0D6h
			db 0C1h
			db  80h
			db  87h
			db  80h
			db  8Fh
			db  80h
			db  74h ; t
			db 0D2h
			db  75h ; u
			db 0C1h
			db 0D4h
			db 0FBh
			db  1Ch
			db  3Eh ; >
			db  6Fh ; o
			db  80h
			db  9Ch
			db  85h
			db 0A8h
			db 0D1h
			db 0F9h
			db  2Fh ; /
			db 0D5h
			db 0D3h
			db 0D4h
			db 0D5h
			db 0DEh
			db  85h
			db 0D6h
			db 0C1h
			db  80h
			db  87h
			db  80h
			db  8Fh
			db 0D4h
			db  74h ; t
			db  75h ; u
			db  76h ; v
			db 0C2h
			db 0EDh
			db  11h
			db  2Bh ; +
			db  4Bh ; K
			db  73h ; s
			db  8Eh
			db 0A3h
			db 0ADh
			db 0B6h
			db 0C0h
			db 0C8h
			db 0D2h
			db 0D5h
			db 0D3h
			db 0D4h
			db 0D5h
			db 0DFh
			db  85h
			db 0D6h
			db 0C1h
			db  80h
			db  87h
			db  80h
			db  8Fh
			db 0C5h
			db  75h ; u
			db  76h ; v
			db  77h ; w
			db 0AAh
			db 0ACh
			db  12h
			db  89h
			db  2Ch ; ,
			db 0C2h
			db 0D3h
			db 0D4h
			db 0D9h
			db  86h
			db 0D6h
			db 0C1h
			db  80h
			db  87h
			db  80h
			db  8Fh
			db 0C5h
			db  76h ; v
			db  77h ; w
			db  78h ; x
			db 0AAh
			db 0ACh
			db 0F5h
			db  89h
			db 0ACh
			db 0C2h
			db 0D3h
			db 0D4h
			db 0DAh
			db  86h
			db 0D6h
			db 0C1h
			db  80h
			db  87h
			db  80h
			db  8Fh
			db 0C5h
			db  77h ; w
			db  78h ; x
			db  6Ah ; j
			db 0ABh
			db 0ACh
			db 0F5h
			db  89h
			db 0ACh
			db 0C2h
			db 0D3h
			db 0D4h
			db 0DBh
			db  86h
			db 0D6h
			db 0C1h
			db  80h
			db  87h
			db  80h
			db  8Fh
			db 0C5h
			db  78h ; x
			db  6Ah ; j
			dw byte_15D1
			dw 1852h
			dw word_16A0
			dw word_1702
			dw off_120E
			dw off_134B
			dw 32h
off_120E:   dw unk_1222			     ; DATA XREF: ROM:1208↑o
			dw unk_122E
			dw unk_123B
			dw unk_1247
			dw unk_1289
			dw unk_12BE
			dw unk_12FB
			dw unk_1315
			dw unk_132F
			dw unk_1337
unk_1222:   db  40h ; @			     ; DATA XREF: ROM:off_120E↑o
			db  60h ; `
			db  70h ; p
			db  60h ; `
			db  50h ; P
			db  30h ; 0
			db  10h
			db 0F0h
			db 0D0h
			db 0B0h
			db  90h
			db  83h
unk_122E:   db    0			         ; DATA XREF: ROM:1210↑o
			db    2
			db    4
			db    6
			db    8
			db  0Ah
			db  0Ch
			db  0Eh
			db  10h
			db  12h
			db  14h
			db  18h
			db  81h
unk_123B:   db    0			         ; DATA XREF: ROM:1212↑o
			db    0
			db    1
			db    3
			db    1
			db    0
			db 0FFh
			db 0FDh
			db 0FFh
			db    0
			db  82h
			db    2
unk_1247:   db    0			         ; DATA XREF: ROM:1214↑o
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    2
			db    4
			db    6
			db    8
			db  0Ah
			db  0Ch
			db  0Ah
			db    8
			db    6
			db    4
			db    2
			db    0
			db 0FEh
			db 0FCh
			db 0FAh
			db 0F8h
			db 0F6h
			db 0F4h
			db 0F6h
			db 0F8h
			db 0FAh
			db 0FCh
			db 0FEh
			db    0
			db  82h
			db  29h ; )
unk_1289:   db    0			         ; DATA XREF: ROM:1216↑o
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    2
			db    4
			db    6
			db    8
			db  0Ah
			db  0Ch
			db  0Ah
			db    8
			db    6
			db    4
			db    2
			db    0
			db 0FEh
			db 0FCh
			db 0FAh
			db 0F8h
			db 0F6h
			db 0F4h
			db 0F6h
			db 0F8h
			db 0FAh
			db 0FCh
			db 0FEh
			db  82h
			db  1Bh
unk_12BE:   db    0			         ; DATA XREF: ROM:1218↑o
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    3
			db    6
			db    3
			db    0
			db 0FDh
			db 0FAh
			db 0FAh
			db 0FDh
			db    0
			db  82h
			db  33h ; 3
unk_12FB:   db    0			         ; DATA XREF: ROM:121A↑o
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    2
			db    4
			db    2
			db    0
			db 0FEh
			db 0FCh
			db 0FEh
			db    0
			db  82h
			db  11h
unk_1315:   db 0FEh			         ; DATA XREF: ROM:121C↑o
			db 0FFh
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    1
			db    1
			db    0
			db    0
			db 0FFh
			db 0FFh
			db  82h
			db  11h
unk_132F:   db    3			         ; DATA XREF: ROM:121E↑o
			db    2
			db    1
			db    0
			db    0
			db    0
			db    1
			db  81h
unk_1337:   db    0			         ; DATA XREF: ROM:1220↑o
			db    0
			db    0
			db    0
			db    1
			db    1
			db    1
			db    1
			db    2
			db    2
			db    1
			db    1
			db    1
			db    0
			db    0
			db    0
			db  84h
			db    1
			db  82h
			db    4
off_134B:   dw unk_1399			     ; DATA XREF: ROM:120A↑o
			dw unk_139B
			dw unk_13A2
			dw unk_13BB
			dw unk_13C7
			dw unk_13D2
			dw unk_13E1
			dw unk_13EA
			dw unk_13FB
			dw unk_1406
			dw unk_141B
			dw unk_1425
			dw unk_142E
			dw unk_1430
			dw unk_1432
			dw unk_1439
			dw unk_1458
			dw unk_145F
			dw unk_146A
			dw unk_1479
			dw unk_147F
			dw unk_1490
			dw unk_149B
			dw unk_14B0
			dw unk_14C9
			dw unk_14D2
			dw unk_14D9
			dw unk_14E2
			dw unk_14F3
			dw unk_1520
			dw unk_1523
			dw unk_1527
			dw unk_1534
			dw unk_1546
			dw unk_154D
			dw unk_1556
			dw unk_155A
			db 0F5h
			db    0
			db  26h ; &
			db    0
unk_1399:   db    2			         ; DATA XREF: ROM:off_134B↑o
			db  83h
unk_139B:   db    0			         ; DATA XREF: ROM:134D↑o
			db    2
			db    4
			db    6
			db    8
			db  10h
			db  83h
unk_13A2:   db    2			         ; DATA XREF: ROM:134F↑o
			db    1
			db    0
			db    0
			db    1
			db    2
			db    2
			db    2
			db    2
			db    2
			db    2
			db    2
			db    2
			db    2
			db    2
			db    2
			db    2
			db    3
			db    3
			db    3
			db    4
			db    4
			db    4
			db    5
			db  81h
unk_13BB:   db    0			         ; DATA XREF: ROM:1351↑o
			db    0
			db    2
			db    3
			db    4
			db    4
			db    5
			db    5
			db    5
			db    6
			db    6
			db  81h
unk_13C7:   db    3			         ; DATA XREF: ROM:1353↑o
			db    0
			db    1
			db    1
			db    1
			db    2
			db    3
			db    4
			db    4
			db    5
			db  81h
unk_13D2:   db    0			         ; DATA XREF: ROM:1355↑o
			db    0
			db    1
			db    1
			db    2
			db    3
			db    4
			db    5
			db    5
			db    6
			db    8
			db    7
			db    7
			db    6
			db  81h
unk_13E1:   db    1			         ; DATA XREF: ROM:1357↑o
			db  0Ch
			db    3
			db  0Fh
			db    2
			db    7
			db    3
			db  0Fh
			db  80h
unk_13EA:   db    0			         ; DATA XREF: ROM:1359↑o
			db    0
			db    0
			db    2
			db    3
			db    3
			db    4
			db    5
			db    6
			db    7
			db    8
			db    9
			db  0Ah
			db  0Bh
			db  0Eh
			db  0Fh
			db  83h
unk_13FB:   db    3			         ; DATA XREF: ROM:135B↑o
			db    2
			db    1
			db    1
			db    0
			db    0
			db    1
			db    2
			db    3
			db    4
			db  81h
unk_1406:   db    1			         ; DATA XREF: ROM:135D↑o
			db    0
			db    0
			db    0
			db    0
			db    1
			db    1
			db    1
			db    2
			db    2
			db    2
			db    3
			db    3
			db    3
			db    3
			db    4
			db    4
			db    4
			db    5
			db    5
			db  81h
unk_141B:   db  10h			         ; DATA XREF: ROM:135F↑o
			db  20h
			db  30h ; 0
			db  40h ; @
			db  30h ; 0
			db  20h
			db  10h
			db    0
			db 0F0h
			db  80h
unk_1425:   db    0			         ; DATA XREF: ROM:1361↑o
			db    0
			db    1
			db    1
			db    3
			db    3
			db    4
			db    5
			db  83h
unk_142E:   db    0			         ; DATA XREF: ROM:1363↑o
			db  81h
unk_1430:   db    2			         ; DATA XREF: ROM:1365↑o
			db  83h
unk_1432:   db    0			         ; DATA XREF: ROM:1367↑o
			db    2
			db    4
			db    6
			db    8
			db  10h
			db  83h
unk_1439:   db    9			         ; DATA XREF: ROM:1369↑o
			db    9
			db    9
			db    8
			db    8
			db    8
			db    7
			db    7
			db    7
			db    6
			db    6
			db    6
			db    5
			db    5
			db    5
			db    4
			db    4
			db    4
			db    3
			db    3
			db    3
			db    2
			db    2
			db    2
			db    1
			db    1
			db    1
			db    0
			db    0
			db    0
			db  81h
unk_1458:   db    1			         ; DATA XREF: ROM:136B↑o
			db    1
			db    1
			db    0
			db    0
			db    0
			db  81h
unk_145F:   db    3			         ; DATA XREF: ROM:136D↑o
			db    0
			db    1
			db    1
			db    1
			db    2
			db    3
			db    4
			db    4
			db    5
			db  81h
unk_146A:   db    0			         ; DATA XREF: ROM:136F↑o
			db    0
			db    1
			db    1
			db    2
			db    3
			db    4
			db    5
			db    5
			db    6
			db    8
			db    7
			db    7
			db    6
			db  81h
unk_1479:   db  0Ah			         ; DATA XREF: ROM:1371↑o
			db    5
			db    0
			db    4
			db    8
			db  83h
unk_147F:   db    0			         ; DATA XREF: ROM:1373↑o
			db    0
			db    0
			db    2
			db    3
			db    3
			db    4
			db    5
			db    6
			db    7
			db    8
			db    9
			db  0Ah
			db  0Bh
			db  0Eh
			db  0Fh
			db  83h
unk_1490:   db    3			         ; DATA XREF: ROM:1375↑o
			db    2
			db    1
			db    1
			db    0
			db    0
			db    1
			db    2
			db    3
			db    4
			db  81h
unk_149B:   db    1			         ; DATA XREF: ROM:1377↑o
			db    0
			db    0
			db    0
			db    0
			db    1
			db    1
			db    1
			db    2
			db    2
			db    2
			db    3
			db    3
			db    3
			db    3
			db    4
			db    4
			db    4
			db    5
			db    5
			db  81h
unk_14B0:   db  10h			         ; DATA XREF: ROM:1379↑o
			db  20h
			db  30h ; 0
			db  40h ; @
			db  30h ; 0
			db  20h
			db  10h
			db    0
			db  10h
			db  20h
			db  30h ; 0
			db  40h ; @
			db  30h ; 0
			db  20h
			db  10h
			db    0
			db  10h
			db  20h
			db  30h ; 0
			db  40h ; @
			db  30h ; 0
			db  20h
			db  10h
			db    0
			db  80h
unk_14C9:   db    0			         ; DATA XREF: ROM:137B↑o
			db    0
			db    1
			db    1
			db    3
			db    3
			db    4
			db    5
			db  83h
unk_14D2:   db    0			         ; DATA XREF: ROM:137D↑o
			db    2
			db    4
			db    6
			db    8
			db  16h
			db  83h
unk_14D9:   db    0			         ; DATA XREF: ROM:137F↑o
			db    0
			db    1
			db    1
			db    3
			db    3
			db    4
			db    5
			db  83h
unk_14E2:   db    4			         ; DATA XREF: ROM:1381↑o
			db    4
			db    4
			db    4
			db    3
			db    3
			db    3
			db    3
			db    2
			db    2
			db    2
			db    2
			db    1
			db    1
			db    1
			db    1
			db  83h
unk_14F3:   db    0			         ; DATA XREF: ROM:1383↑o
			db    0
			db    0
			db    0
			db    1
			db    1
			db    1
			db    1
			db    2
			db    2
			db    2
			db    2
			db    3
			db    3
			db    3
			db    3
			db    4
			db    4
			db    4
			db    4
			db    5
			db    5
			db    5
			db    5
			db    6
			db    6
			db    6
			db    6
			db    7
			db    7
			db    7
			db    7
			db    8
			db    8
			db    8
			db    8
			db    9
			db    9
			db    9
			db    9
			db  0Ah
			db  0Ah
			db  0Ah
			db  0Ah
			db  81h
unk_1520:   db    0			         ; DATA XREF: ROM:1385↑o
			db  0Ah
			db  83h
unk_1523:   db    0			         ; DATA XREF: ROM:1387↑o
			db    2
			db    4
			db  81h
unk_1527:   db  30h ; 0			     ; DATA XREF: ROM:1389↑o
			db  20h
			db  10h
			db    0
			db    0
			db    0
			db    0
			db    0
			db    8
			db  10h
			db  20h
			db  30h ; 0
			db  81h
unk_1534:   db    0			         ; DATA XREF: ROM:138B↑o
			db    4
			db    4
			db    4
			db    4
			db    4
			db    4
			db    4
			db    4
			db    4
			db    4
			db    6
			db    6
			db    6
			db    8
			db    8
			db  0Ah
			db  83h
unk_1546:   db    0			         ; DATA XREF: ROM:138D↑o
			db    2
			db    3
			db    4
			db    6
			db    7
			db  81h
unk_154D:   db    2			         ; DATA XREF: ROM:138F↑o
			db    1
			db    0
			db    0
			db    0
			db    2
			db    4
			db    7
			db  81h
unk_1556:   db  0Fh			         ; DATA XREF: ROM:1391↑o
			db    1
			db    5
			db  83h
unk_155A:   db    8			         ; DATA XREF: ROM:1393↑o
			db    6
			db    2
			db    3
			db    4
			db    5
			db    6
			db    7
			db    8
			db    9
			db  0Ah
			db  0Bh
			db  0Ch
			db  0Dh
			db  0Eh
			db  0Fh
			db  10h
			db  83h
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    0
			db    1
			db    1
			db    1
			db    1
			db    1
			db    1
			db    1
			db    1
			db    1
			db    1
			db    2
			db    2
			db    2
			db    2
			db    2
			db    2
			db    2
			db    2
			db    2
			db    2
			db    3
			db    3
			db    3
			db    3
			db    3
			db    3
			db    3
			db    3
			db    3
			db    3
			db    4
			db    4
			db    4
			db    4
			db    4
			db    4
			db    4
			db    4
			db    4
			db    4
			db    5
			db    5
			db    5
			db    5
			db    5
			db    5
			db    5
			db    5
			db    5
			db    5
			db    6
			db    6
			db    6
			db    6
			db    6
			db    6
			db    6
			db    6
			db    6
			db    6
			db    7
			db    7
			db    7
			db    7
			db    7
			db    7
			db    7
			db    7
			db    7
			db    7
			db    8
			db    8
			db    8
			db    8
			db    8
			db    8
			db    8
			db    8
			db    8
			db    8
			db    9
			db    9
			db    9
			db    9
			db    9
			db    9
			db    9
			db    9
			db    9
			db    9
			db  83h
byte_15D1:  db  80h, 80h, 80h, 80h, 80h, 80h, 80h, 80h, 80h, 80h, 80h, 80h, 80h, 80h, 80h, 7Fh
									    ; DATA XREF: ROM:1200↑o
			db  7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh
			db  7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh
			db  7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh
			db  7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh
			db  7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh
			db  7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh
			db  7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh
			db  7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh
			db  7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh
			db  7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh
			db  7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh
			db  7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh, 7Fh
word_16A0:  dw 8000h			        ; DATA XREF: ROM:1204↑o
			dw 0A210h
			dw 0BF24h
			dw 0D492h
			dw 0EE51h
			dw 0F468h
			dw 8000h
			dw 9BBBh
			dw 0B99Eh
			dw 0BF36h
			dw 0C499h
			dw 0CA37h
			dw 0D04Bh
			dw 8000h
			dw 0A52Ah
			dw 0AA9Ch
			dw 0B005h
			dw 0B66Fh
			dw 0BC62h
			dw 0D04Fh
			dw 0E642h
			dw 0F954h
			dw 8000h
			dw 8412h
			dw 8742h
			dw 8C3Eh
			dw 9521h
			dw 9A84h
			dw 0A31Ch
			dw 0AE04h
			dw 0BB19h
			dw 0BE82h
			dw 0C988h
			dw 0D620h
			dw 8000h
			dw 0A24Bh
			dw 0A993h
			dw 0ADCCh
			dw 0B83Ch
			dw 0BA99h
			dw 0C27Ah
			dw 0C76Ah
			dw 0C96Ah
			dw 0CA38h
			dw 0CCB8h
			dw 0DEAAh
			dw 0E95Eh
			dw 8000h
			dw 8592h
word_1702:  dw 0C000h			       ; DATA XREF: ROM:1206↑o
			dw 0C02Eh
			dw 0C05Ch
			dw 0C084h
			dw 0C0B6h
			dw 0C0EBh
			dw 0C11Ah
			dw 0C150h
			dw 0C191h
			dw 0C1BCh
			dw 0C20Bh
			dw 0C249h
			dw 0C283h
			dw 0C2AEh
			dw 0C2D1h
			dw 0C2F4h
			dw 0C317h
			dw 0C32Fh
			dw 0C34Ah
			dw 0C377h
			dw 0C39Fh
			dw 0C3CCh
			dw 0C3ECh
			dw 0C414h
			dw 0C41Eh
			dw 0C438h
			dw 0C460h
			dw 0C483h
			dw 0C498h
			dw 0C4C0h
			dw 0C4F1h
			dw 0C51Bh
			dw 0C548h
			dw 0C58Ch
			dw 0C59Dh
			dw 0C5D1h
			dw 0C609h
			dw 0C63Ah
			dw 0C671h
			dw 0C68Eh
			dw 0C6CEh
			dw 0C711h
			dw 0C739h
			dw 0C749h
			dw 0C762h
			dw 0C794h
			dw 0C7C5h
			dw 0C7DDh
			dw 0C7F6h
			dw 0C852h
			dw 0C87Fh
			dw 0C88Ch
			dw 0C89Bh
			dw 0C8C3h
			dw 0C8F9h
			dw 0C922h
			dw 0C94Ah
			dw 0C97Ch
			dw 0C997h
			dw 0C9BFh
			dw 0CA00h
			dw 0CA00h
			dw 0CA31h
			dw 0CA47h
			dw 0CA71h
			dw 0CA90h
			dw 0CAC2h
			dw 0CAF7h
			dw 0CB23h
			dw 0CB52h
			dw 0CB7Fh
			dw 0CBB2h
			dw 0CBC4h
			dw 0CC05h
			dw 0CC24h
			dw 0CC58h
			dw 0CC8Eh
			dw 0CCD8h
			dw 0CD05h
			dw 0CD32h
			dw 0CD66h
			dw 0CD96h
			dw 0CDC5h
			dw 0CDF6h
			dw 0CE20h
			dw 0CE6Ah
			dw 0CE99h
			dw 0CEC6h
			dw 0CF11h
			dw 0CF45h
			dw 0CF75h
			dw 0CFA6h
			dw 0CFD3h
			dw 0CFE4h
			dw 0CFFCh
			dw 0D032h
			dw 0D050h
			dw 0D07Fh
			dw 0D0B2h
			dw 0D0E4h
			dw 0D12Fh
			dw 0D14Dh
			dw 0D199h
			dw 0D1D1h
			dw 0D1FEh
			dw 0D22Bh
			dw 0D258h
			dw 0D288h
			dw 0D2AEh
			dw 0D2D4h
			dw 0D30Ah
			dw 0D337h
			dw 0D344h
			dw 0D378h
			dw 0D3AEh
			dw 0D3E2h
			dw 0D413h
			dw 0D42Dh
			dw 0D45Eh
			dw 0D494h
			dw 0D4C6h
			dw 0D4FCh
			dw 0D530h
			dw 0D57Ah
			dw 0D5A9h
			dw 0D5DCh
			dw 0D60Bh
			dw 0D63Fh
			dw 0D652h
			dw 0D688h
			dw 0D6D4h
			dw 0D6EAh
			dw 0D720h
			dw 0D73Fh
			dw 0D7A4h
			dw 0D7DBh
			dw 0D80Fh
			dw 0D850h
			dw 0D88Ch
			dw 0D8BAh
			dw 0D8D2h
			dw 0D8FAh
			dw 0D927h
			dw 0D956h
			dw 0D98Eh
			dw 0D9BBh
			dw 0D9E8h
			dw 0DA15h
			dw 0DA42h
			dw 0DA6Fh
			dw 0DA87h
			dw 0DAB7h
			dw 0DAE1h
			dw 0DAF7h
			dw 0DB52h
			dw 0DBA3h
			dw 0DC15h
			dw 0DC3Fh
			dw 0DC74h
			dw 0DCA1h
			dw 0DD1Ch
			dw 0DD71h
			dw 0DD9Dh
			dw 0DE17h
			dw 0DE4Bh
			dw 0DE73h
			dw 0DEB4h
			dw 0DEDCh
; end of 'ROM'

; ===========================================================================

; Segment type: Regular
			segment RAM
			org 1C00h
			ds 1
			ds 1
tb_adr_str: ds 2						; DATA XREF: sub_0:loc_8↑r
byte_1C04:  ds 1						; DATA XREF: sub_0+67↑w
									    ; sub_B3+12↑r ...
byte_1C05:  ds 1						; DATA XREF: sub_427+9B↑w
									    ; sub_7B0↑r ...
byte_1C06:  ds 1						; DATA XREF: sub_0+6B↑w
									    ; sub_90E+2C↑w ...
byte_1C07:  ds 1						; DATA XREF: sub_0+6E↑w
									    ; sub_427+3F1↑w ...
byte_1C08:  ds 1						; DATA XREF: sub_0+76↑w
byte_1C09:  ds 1						; DATA XREF: ROM:loc_424↑r
									    ; sub_52E+1↑w ...
word_1C0A:  ds 2						; DATA XREF: sub_72C+3↑o
									    ; sub_7C6+5↑o
			ds 1
byte_1C0D:  ds 1						; DATA XREF: sub_64F+13↑r
									    ; ROM:06AE↑w ...
byte_1C0E:  ds 1						; DATA XREF: ROM:06B6↑w
									    ; sub_6C9:loc_6DE↑r
byte_1C0F:  ds 1						; DATA XREF: ROM:06B3↑w
									    ; sub_6C9+B↑r ...
byte_1C10:  ds 1						; DATA XREF: sub_64F↑o
byte_1C11:  ds 1						; DATA XREF: sub_64F:loc_66F↑r
									    ; ROM:loc_C6B↑w
byte_1C12:  ds 1						; DATA XREF: sub_72C+32↑w
									    ; sub_C3A↑w
byte_1C13:  ds 1						; DATA XREF: sub_427+98↑w
									    ; sub_7B0+3↑o
			ds 1
byte_1C15:  ds 1						; DATA XREF: sub_427+141↑w
									    ; sub_472+67E↑w
byte_1C16:  ds 1						; DATA XREF: ROM:loc_9DD↑w
byte_1C17:  ds 1						; DATA XREF: sub_7C6+2↑w
byte_1C18:  ds 1						; DATA XREF: sub_427+20↑w
									    ; sub_7D4+C↑r ...
byte_1C19:  ds 1						; DATA XREF: sub_B3+25↑w
									    ; sub_EE+2↑w ...
word_1C1A:  ds 2						; DATA XREF: sub_1A9+8↑o
			ds 1
			ds 1
			ds 1
			ds 1
			ds 1
			ds 1
word_1C22:  ds 2						; DATA XREF: sub_1A9+C↑o
			ds 1
			ds 1
			ds 1
			ds 1
			ds 1
			ds 1
word_1C2A:  ds 2						; DATA XREF: sub_1A9↑o
			ds 1
			ds 1
			ds 1
			ds 1
			ds 1
			ds 1
byte_1C32:  ds 1						; DATA XREF: sub_5DF+25↑w
word_1C33:  ds 2						; DATA XREF: sub_427+A2↑w
									    ; sub_427+C1↑r ...
word_1C35:  ds 2						; DATA XREF: sub_427+A8↑w
									    ; sub_427+B5↑r ...
word_1C37:  ds 2						; DATA XREF: sub_3C5↑r
									    ; sub_427+8F↑w ...
word_1C39:  ds 2						; DATA XREF: sub_427+13D↑w
									    ; sub_427+198↑r
byte_1C3B:  ds 1						; DATA XREF: sub_427+14B↑w
									    ; sub_427+175↑r
			ds 1
			ds 1
			ds 1
			ds 1
byte_1C40:  ds 30h			          ; DATA XREF: sub_B3+28↑o
									    ; sub_427+AB↑o ...
byte_1C70:  ds 30h			          ; DATA XREF: sub_B3+35↑o
									    ; sub_64F+1A↑o
			ds 30h
byte_1CD0:  ds 30h			          ; DATA XREF: ROM:off_63F↑o
byte_1D00:  ds 30h			          ; DATA XREF: ROM:0641↑o
byte_1D30:  ds 30h			          ; DATA XREF: ROM:0643↑o
byte_1D60:  ds 30h			          ; DATA XREF: sub_427+E3↑o
									    ; ROM:0647↑o ...
byte_1D90:  ds 30h			          ; DATA XREF: ROM:0649↑o
									    ; sub_6B9+A↑w
byte_1DC0:  ds 30h			          ; DATA XREF: ROM:064B↑o
									    ; ROM:064D↑o ...
byte_1DF0:  ds 30h			          ; DATA XREF: sub_EE+14↑o
									    ; ROM:loc_453↑o ...
byte_1E20:  ds 30h			          ; DATA XREF: ROM:0631↑o
byte_1E50:  ds 30h			          ; DATA XREF: ROM:0633↑o
byte_1E80:  ds 30h			          ; DATA XREF: ROM:0635↑o
byte_1EB0:  ds 30h			          ; DATA XREF: ROM:0637↑o
byte_1EE0:  ds 30h			          ; DATA XREF: ROM:0639↑o
byte_1F10:  ds 30h			          ; DATA XREF: ROM:063B↑o
									    ; ROM:063D↑o
byte_1F40:  ds 30h			          ; DATA XREF: sub_64F+3B↑o
			ds 30h
			ds 30h
			ds 30h
; end of 'RAM'


			end
