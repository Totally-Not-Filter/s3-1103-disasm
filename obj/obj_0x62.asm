;===============================================================================
; Objeto 0x62 - Barra de areia que dissolve ao ser tocada na Desert Palace
; ->>>
;===============================================================================
; Offset_0x02C47E:
		move.l	#Dissolving_Sand_Bar_Mappings, Obj_Map(A0) ; Offset_0x02C5DE, $000C
		move.w	#$4280, Obj_Art_VRAM(A0)				 ; $000A
		ori.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0200, Obj_Priority(A0)				 ; $0008
		move.b	#$20, Obj_Width(A0)				 ; $0007
		move.b	#$10, Obj_Height(A0)					 ; $0006
		tst.b	Obj_Subtype(A0)					 ; $002C
		beq.s	Offset_0x02C4BE
		move.l	#Dissolving_Sand_Bar_Mappings_2, Obj_Map(A0) ; Offset_0x02C61A, $000C
		move.b	#$30, Obj_Width(A0)				 ; $0007
		move.b	#$0F, Obj_Control_Var_0D(A0)			 ; $003D
Offset_0x02C4BE:
		move.b	Obj_Control_Var_0D(A0), Obj_Control_Var_0C(A0) ; $003D, $003C
		bset	#$07, Obj_Status(A0)					 ; $002A
		move.l	#Offset_0x02C4D0, (A0)
Offset_0x02C4D0:
		tst.b	Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x02C50A
		move.b	Obj_Status(A0), D0				 ; $002A
		andi.b	#$18, D0
		beq.s	Offset_0x02C4E6
		move.b	#$01, Obj_Control_Var_0A(A0)			 ; $003A
Offset_0x02C4E6:
		tst.b	Obj_Control_Var_0A(A0)					 ; $003A
		beq.s	Offset_0x02C50A
		subq.b	#$01, Obj_Control_Var_0C(A0)			 ; $003C
		bpl.s	Offset_0x02C50A
		tst.b	Obj_Ani_Number(A0)				 ; $0020
		bne.s	Offset_0x02C50A
		move.b	Obj_Control_Var_0D(A0), Obj_Control_Var_0C(A0) ; $003D, $003C
		move.b	#$00, Obj_Control_Var_0A(A0)			 ; $003A
		move.b	#$01, Obj_Ani_Number(A0)				 ; $0020
Offset_0x02C50A:
		lea		(Dissolving_Sand_Bar_Animate_Data).l, A1 ; Offset_0x02C58A
		jsr		(AnimateSprite).l				   ; Offset_0x01115E
		moveq	#$00, D0
		move.b	Obj_Map_Id(A0), D0				 ; $0022
		move.b	Offset_0x02C56A(PC, D0), D3
		bne.s	Offset_0x02C554
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		bclr	#$03, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x02C53A
		bclr	#$03, Obj_Status(A1)					 ; $002A
		bset	#$01, Obj_Status(A1)					 ; $002A
Offset_0x02C53A:
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		bclr	#$04, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x02C552
		bclr	#$03, Obj_Status(A1)					 ; $002A
		bset	#$01, Obj_Status(A1)					 ; $002A
Offset_0x02C552:
		bra.s	Offset_0x02C564
Offset_0x02C554:
		moveq	#$00, D1
		move.b	Obj_Width(A0), D1				 ; $0007
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Platform_Object).l			   ; Offset_0x013AF6
Offset_0x02C564:
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x02C56A:
		dc.b	$11, $11, $11, $11, $10, $0F, $0E, $0D
		dc.b	$0C, $0B, $0A, $09, $08, $07, $06, $05
		dc.b	$04, $03, $02, $01, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
;-------------------------------------------------------------------------------
Dissolving_Sand_Bar_Animate_Data:					   ; Offset_0x02C58A
		dc.w	Offset_0x02C592-Dissolving_Sand_Bar_Animate_Data
		dc.w	Offset_0x02C598-Dissolving_Sand_Bar_Animate_Data
		dc.w	Offset_0x02C5BF-Dissolving_Sand_Bar_Animate_Data
		dc.w	Offset_0x02C5C3-Dissolving_Sand_Bar_Animate_Data
Offset_0x02C592:
		dc.b	$09, $00, $01, $02, $03, $FF
Offset_0x02C598:
		dc.b	$00, $04, $05, $05, $06, $07, $07, $08
		dc.b	$09, $09, $0A, $0B, $0B, $0C, $0D, $0D
		dc.b	$0E, $0F, $0F, $10, $11, $11, $12, $13
		dc.b	$13, $14, $15, $15, $16, $17, $17, $18
		dc.b	$19, $19, $1A, $1B, $1B, $FD, $02
Offset_0x02C5BF:
		dc.b	$7F, $1C, $FD, $03
Offset_0x02C5C3:
		dc.b	$00, $1B, $1A, $19, $18, $17, $16, $15
		dc.b	$14, $13, $12, $11, $10, $0F, $0E, $0D
		dc.b	$0C, $0B, $0A, $09, $08, $07, $06, $05
		dc.b	$04, $FD, $00
;-------------------------------------------------------------------------------
Dissolving_Sand_Bar_Mappings:				   ; Offset_0x02C5DE
		dc.w	Offset_0x02C654-Dissolving_Sand_Bar_Mappings
		dc.w	Offset_0x02C662-Dissolving_Sand_Bar_Mappings
		dc.w	Offset_0x02C670-Dissolving_Sand_Bar_Mappings
		dc.w	Offset_0x02C67E-Dissolving_Sand_Bar_Mappings
		dc.w	Offset_0x02C68C-Dissolving_Sand_Bar_Mappings
		dc.w	Offset_0x02C68C-Dissolving_Sand_Bar_Mappings
		dc.w	Offset_0x02C68C-Dissolving_Sand_Bar_Mappings
		dc.w	Offset_0x02C68C-Dissolving_Sand_Bar_Mappings
		dc.w	Offset_0x02C69A-Dissolving_Sand_Bar_Mappings
		dc.w	Offset_0x02C69A-Dissolving_Sand_Bar_Mappings
		dc.w	Offset_0x02C69A-Dissolving_Sand_Bar_Mappings
		dc.w	Offset_0x02C69A-Dissolving_Sand_Bar_Mappings
		dc.w	Offset_0x02C6A8-Dissolving_Sand_Bar_Mappings
		dc.w	Offset_0x02C6A8-Dissolving_Sand_Bar_Mappings
		dc.w	Offset_0x02C6A8-Dissolving_Sand_Bar_Mappings
		dc.w	Offset_0x02C6A8-Dissolving_Sand_Bar_Mappings
		dc.w	Offset_0x02C6B6-Dissolving_Sand_Bar_Mappings
		dc.w	Offset_0x02C6B6-Dissolving_Sand_Bar_Mappings
		dc.w	Offset_0x02C6B6-Dissolving_Sand_Bar_Mappings
		dc.w	Offset_0x02C6B6-Dissolving_Sand_Bar_Mappings
		dc.w	Offset_0x02C6C4-Dissolving_Sand_Bar_Mappings
		dc.w	Offset_0x02C6C4-Dissolving_Sand_Bar_Mappings
		dc.w	Offset_0x02C6C4-Dissolving_Sand_Bar_Mappings
		dc.w	Offset_0x02C6C4-Dissolving_Sand_Bar_Mappings
		dc.w	Offset_0x02C6D2-Dissolving_Sand_Bar_Mappings
		dc.w	Offset_0x02C6D2-Dissolving_Sand_Bar_Mappings
		dc.w	Offset_0x02C6D2-Dissolving_Sand_Bar_Mappings
		dc.w	Offset_0x02C6D2-Dissolving_Sand_Bar_Mappings
		dc.w	Offset_0x02C7E4-Dissolving_Sand_Bar_Mappings
		dc.w	Offset_0x02C6E0-Dissolving_Sand_Bar_Mappings
;-------------------------------------------------------------------------------
Dissolving_Sand_Bar_Mappings_2:				   ; Offset_0x02C61A
		dc.w	Offset_0x02C6E0-Dissolving_Sand_Bar_Mappings_2
		dc.w	Offset_0x02C6FA-Dissolving_Sand_Bar_Mappings_2
		dc.w	Offset_0x02C714-Dissolving_Sand_Bar_Mappings_2
		dc.w	Offset_0x02C72E-Dissolving_Sand_Bar_Mappings_2
		dc.w	Offset_0x02C748-Dissolving_Sand_Bar_Mappings_2
		dc.w	Offset_0x02C748-Dissolving_Sand_Bar_Mappings_2
		dc.w	Offset_0x02C748-Dissolving_Sand_Bar_Mappings_2
		dc.w	Offset_0x02C748-Dissolving_Sand_Bar_Mappings_2
		dc.w	Offset_0x02C762-Dissolving_Sand_Bar_Mappings_2
		dc.w	Offset_0x02C762-Dissolving_Sand_Bar_Mappings_2
		dc.w	Offset_0x02C762-Dissolving_Sand_Bar_Mappings_2
		dc.w	Offset_0x02C762-Dissolving_Sand_Bar_Mappings_2
		dc.w	Offset_0x02C77C-Dissolving_Sand_Bar_Mappings_2
		dc.w	Offset_0x02C77C-Dissolving_Sand_Bar_Mappings_2
		dc.w	Offset_0x02C77C-Dissolving_Sand_Bar_Mappings_2
		dc.w	Offset_0x02C77C-Dissolving_Sand_Bar_Mappings_2
		dc.w	Offset_0x02C796-Dissolving_Sand_Bar_Mappings_2
		dc.w	Offset_0x02C796-Dissolving_Sand_Bar_Mappings_2
		dc.w	Offset_0x02C796-Dissolving_Sand_Bar_Mappings_2
		dc.w	Offset_0x02C796-Dissolving_Sand_Bar_Mappings_2
		dc.w	Offset_0x02C7B0-Dissolving_Sand_Bar_Mappings_2
		dc.w	Offset_0x02C7B0-Dissolving_Sand_Bar_Mappings_2
		dc.w	Offset_0x02C7B0-Dissolving_Sand_Bar_Mappings_2
		dc.w	Offset_0x02C7B0-Dissolving_Sand_Bar_Mappings_2
		dc.w	Offset_0x02C7CA-Dissolving_Sand_Bar_Mappings_2
		dc.w	Offset_0x02C7CA-Dissolving_Sand_Bar_Mappings_2
		dc.w	Offset_0x02C7CA-Dissolving_Sand_Bar_Mappings_2
		dc.w	Offset_0x02C7CA-Dissolving_Sand_Bar_Mappings_2
		dc.w	Offset_0x02C7E4-Dissolving_Sand_Bar_Mappings_2
Offset_0x02C654:
		dc.w	$0002
		dc.w	$F00F, $0000, $FFE0
		dc.w	$F00F, $0010, $0000
Offset_0x02C662:
		dc.w	$0002
		dc.w	$F00F, $0010, $FFE0
		dc.w	$F00F, $0020, $0000
Offset_0x02C670:
		dc.w	$0002
		dc.w	$F00F, $0020, $FFE0
		dc.w	$F00F, $0030, $0000
Offset_0x02C67E:
		dc.w	$0002
		dc.w	$F00F, $0030, $FFE0
		dc.w	$F00F, $0000, $0000
Offset_0x02C68C:
		dc.w	$0002
		dc.w	$F00F, $0040, $FFE0
		dc.w	$F00F, $0040, $0000
Offset_0x02C69A:
		dc.w	$0002
		dc.w	$F00F, $0050, $FFE0
		dc.w	$F00F, $0050, $0000
Offset_0x02C6A8:
		dc.w	$0002
		dc.w	$F80F, $0060, $FFE0
		dc.w	$F80F, $0060, $0000
Offset_0x02C6B6:
		dc.w	$0002
		dc.w	$F80F, $0070, $FFE0
		dc.w	$F80F, $0070, $0000
Offset_0x02C6C4:
		dc.w	$0002
		dc.w	$000F, $0080, $FFE0
		dc.w	$000F, $0080, $0000
Offset_0x02C6D2:
		dc.w	$0002
		dc.w	$080E, $0090, $FFE0
		dc.w	$080E, $0090, $0000
Offset_0x02C6E0:
		dc.w	$0004
		dc.w	$F00F, $0000, $FFC0
		dc.w	$F00F, $0000, $FFE0
		dc.w	$F00F, $0010, $0000
		dc.w	$F00F, $0000, $0020
Offset_0x02C6FA:
		dc.w	$0004
		dc.w	$F00F, $0010, $FFC0
		dc.w	$F00F, $0000, $FFE0
		dc.w	$F00F, $0020, $0000
		dc.w	$F00F, $0000, $0020
Offset_0x02C714:
		dc.w	$0004
		dc.w	$F00F, $0020, $FFC0
		dc.w	$F00F, $0000, $FFE0
		dc.w	$F00F, $0030, $0000
		dc.w	$F00F, $0000, $0020
Offset_0x02C72E:
		dc.w	$0004
		dc.w	$F00F, $0030, $FFC0
		dc.w	$F00F, $0000, $FFE0
		dc.w	$F00F, $0000, $0000
		dc.w	$F00F, $0000, $0020
Offset_0x02C748:
		dc.w	$0004
		dc.w	$F00F, $0040, $FFC0
		dc.w	$F00F, $0040, $FFE0
		dc.w	$F00F, $0040, $0000
		dc.w	$F00F, $0040, $0020
Offset_0x02C762:
		dc.w	$0004
		dc.w	$F00F, $0050, $FFC0
		dc.w	$F00F, $0050, $FFE0
		dc.w	$F00F, $0050, $0000
		dc.w	$F00F, $0050, $0020
Offset_0x02C77C:
		dc.w	$0004
		dc.w	$F80F, $0060, $FFC0
		dc.w	$F80F, $0060, $FFE0
		dc.w	$F80F, $0060, $0000
		dc.w	$F80F, $0060, $0020
Offset_0x02C796:
		dc.w	$0004
		dc.w	$F80F, $0070, $FFC0
		dc.w	$F80F, $0070, $FFE0
		dc.w	$F80F, $0070, $0000
		dc.w	$F80F, $0070, $0020
Offset_0x02C7B0:
		dc.w	$0004
		dc.w	$000F, $0080, $FFC0
		dc.w	$000F, $0080, $FFE0
		dc.w	$000F, $0080, $0000
		dc.w	$000F, $0080, $0020
Offset_0x02C7CA:
		dc.w	$0004
		dc.w	$080E, $0090, $FFC0
		dc.w	$080E, $0090, $FFE0
		dc.w	$080E, $0090, $0000
		dc.w	$080E, $0090, $0020
Offset_0x02C7E4:
		dc.w	$0000
;===============================================================================
; Objeto 0x62 - Barra de areia que dissolve ao ser tocada na Desert Palace
; <<<-
;===============================================================================