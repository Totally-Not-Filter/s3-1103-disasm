;-------------------------------------------------------------------------------
; Poeira do Spindash, Freio e Splash de água no modo 2 jogadores
; ->>>
;-------------------------------------------------------------------------------
; Offset_0x0100DA:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x0100E8(PC, D0), D1
		jmp		Offset_0x0100E8(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x0100E8:
		dc.w	Offset_0x0100F0-Offset_0x0100E8
		dc.w	Offset_0x010126-Offset_0x0100E8
		dc.w	Offset_0x0101B4-Offset_0x0100E8
		dc.w	Offset_0x0101B8-Offset_0x0100E8
;-------------------------------------------------------------------------------
Offset_0x0100F0:
		addq.b	#$02, Obj_Routine(A0)					 ; $0005
		move.l	#Dust_Water_Splash_2P_Mappings, Obj_Map(A0) ; Offset_0x010260, $000C
		ori.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0080, Obj_Priority(A0)				 ; $0008
		move.b	#$10, Obj_Width(A0)				 ; $0007
		move.w	#$07E0, Obj_Art_VRAM(A0)				 ; $000A
		move.w	#Obj_Player_One, Obj_Player_Last(A0)	  ; $B000, $0042
		cmpa.w	#Obj_P1_Dust_Water_Splash, A0			 ; $CC54
		beq.s	Offset_0x010126
		move.w	#Obj_Player_Two, Obj_Player_Last(A0)	  ; $B04A, $0042
;-------------------------------------------------------------------------------
Offset_0x010126:
		move.w	Obj_Player_Last(A0), A2					 ; $0042
		moveq	#$00, D0
		move.b	Obj_Ani_Number(A0), D0					 ; $0020
		add.w	D0, D0
		move.w	Offset_0x01013A(PC, D0), D1
		jmp		Offset_0x01013A(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x01013A:
		dc.w	Offset_0x010142-Offset_0x01013A
		dc.w	Offset_0x010142-Offset_0x01013A
		dc.w	Offset_0x01014A-Offset_0x01013A
		dc.w	Offset_0x010192-Offset_0x01013A
;-------------------------------------------------------------------------------
Offset_0x010142:
		move.b	#$00, Obj_Map_Id(A0)					 ; $0022
		bra.s	Offset_0x01019A
;-------------------------------------------------------------------------------
Offset_0x01014A:
		cmpi.b	#$0C, Obj_Subtype(A2)					 ; $002C
		bcs.s	Offset_0x0101AC
		cmpi.b	#$04, Obj_Routine(A2)					 ; $0005
		bcc.s	Offset_0x0101AC
		tst.b	Obj_Player_Spdsh_Flag(A2)				 ; $003D
		beq.s	Offset_0x0101AC
		move.w	Obj_X(A2), Obj_X(A0)			  ; $0010, $0010
		move.w	Obj_Y(A2), Obj_Y(A0)			  ; $0014, $0014
		move.b	Obj_Status(A2), Obj_Status(A0)			  ; $002A, $002A
		andi.b	#$01, Obj_Status(A0)					 ; $002A
		tst.b	Obj_Ani_Flag(A0)				 ; $0021
		bne.s	Offset_0x01019A
		andi.w	#$7FFF, Obj_Art_VRAM(A0)				 ; $000A
		tst.w	Obj_Art_VRAM(A2)				 ; $000A
		bpl.s	Offset_0x01019A
		ori.w	#$8000, Obj_Art_VRAM(A0)				 ; $000A
		bra.s	Offset_0x01019A
;-------------------------------------------------------------------------------
Offset_0x010192:
		cmpi.b	#$0C, Obj_Subtype(A2)					 ; $002C
		bcs.s	Offset_0x0101AC
Offset_0x01019A:
		lea		(Dust_Water_Splash_2P_Animate_Data).l, A1 ; Offset_0x010246
		jsr		(AnimateSprite).l				   ; Offset_0x01115E
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x0101AC:
		move.b	#$00, Obj_Ani_Number(A0)				 ; $0020
		rts
Offset_0x0101B4:
		bra.w	DeleteObject				   ; Offset_0x011138
Offset_0x0101B8:
		move.w	Obj_Player_Last(A0), A2					 ; $0042
		cmpi.b	#$0D, Obj_Ani_Number(A2)				 ; $0020
		beq.s	Offset_0x0101D2
		move.b	#$02, Obj_Routine(A0)					 ; $0005
		move.b	#$00, Obj_Control_Var_06(A0)			 ; $0036
		rts
Offset_0x0101D2:
		move.b	#$00, Obj_Map_Id(A0)					 ; $0022
		subq.b	#$01, Obj_Control_Var_06(A0)			 ; $0036
		bpl.s	Offset_0x010244
		move.b	#$03, Obj_Control_Var_06(A0)			 ; $0036
		bsr.w	AllocateObject				 ; Offset_0x011DD8
		bne.s	Offset_0x010244
		move.l	(A0), (A1)
		move.w	Obj_X(A2), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A2), Obj_Y(A1)			  ; $0014, $0014
		addi.w	#$000C, Obj_Y(A1)				 ; $0014
		move.b	#$00, Obj_Status(A1)					 ; $002A
		move.b	#$03, Obj_Ani_Number(A1)				 ; $0020
		addq.b	#$02, Obj_Routine(A1)					 ; $0005
		move.l	Obj_Map(A0), Obj_Map(A1)		  ; $000C, $000C
		move.b	Obj_Flags(A0), Obj_Flags(A1)			  ; $0004, $0004
		move.w	#$0080, Obj_Priority(A1)				 ; $0008
		move.b	#$04, Obj_Width(A1)				 ; $0007
		move.w	Obj_Art_VRAM(A0), Obj_Art_VRAM(A1)		  ; $000A, $000A
		move.w	Obj_Player_Last(A0), Obj_Player_Last(A1)  ; $0042, $0042
		andi.w	#$7FFF, Obj_Art_VRAM(A1)				 ; $000A
		tst.w	Obj_Art_VRAM(A2)				 ; $000A
		bpl.s	Offset_0x010244
		ori.w	#$8000, Obj_Art_VRAM(A1)				 ; $000A
Offset_0x010244:
		rts
;-------------------------------------------------------------------------------
Dust_Water_Splash_2P_Animate_Data:					   ; Offset_0x010246
		dc.w	Offset_0x01024E-Dust_Water_Splash_2P_Animate_Data
		dc.w	Offset_0x010251-Dust_Water_Splash_2P_Animate_Data
		dc.w	Offset_0x010255-Dust_Water_Splash_2P_Animate_Data
		dc.w	Offset_0x01025B-Dust_Water_Splash_2P_Animate_Data
Offset_0x01024E:
		dc.b	$1F, $00, $FF
Offset_0x010251:
		dc.b	$03, $00, $FD, $00
Offset_0x010255:
		dc.b	$01, $01, $02, $03, $04, $FF
Offset_0x01025B:
		dc.b	$05, $05, $06, $07, $FC
;-------------------------------------------------------------------------------
Dust_Water_Splash_2P_Mappings:				   ; Offset_0x010260
		dc.w	Offset_0x010270-Dust_Water_Splash_2P_Mappings
		dc.w	Offset_0x010272-Dust_Water_Splash_2P_Mappings
		dc.w	Offset_0x01027A-Dust_Water_Splash_2P_Mappings
		dc.w	Offset_0x010282-Dust_Water_Splash_2P_Mappings
		dc.w	Offset_0x01028A-Dust_Water_Splash_2P_Mappings
		dc.w	Offset_0x010292-Dust_Water_Splash_2P_Mappings
		dc.w	Offset_0x01029A-Dust_Water_Splash_2P_Mappings
		dc.w	Offset_0x0102A2-Dust_Water_Splash_2P_Mappings
Offset_0x010270:
		dc.w	$0000
Offset_0x010272:
		dc.w	$0001
		dc.w	$0408, $0000, $FFEC
Offset_0x01027A:
		dc.w	$0001
		dc.w	$0408, $0003, $FFEC
Offset_0x010282:
		dc.w	$0001
		dc.w	$FC09, $0006, $FFEC
Offset_0x01028A:
		dc.w	$0001
		dc.w	$FC09, $000C, $FFEC
Offset_0x010292:
		dc.w	$0001
		dc.w	$FC00, $0012, $FFFC
Offset_0x01029A:
		dc.w	$0001
		dc.w	$FC00, $0013, $FFFC
Offset_0x0102A2:
		dc.w	$0001
		dc.w	$FC00, $0014, $FFFC
;-------------------------------------------------------------------------------
; Poeira do Spindash, Freio e Splash de água no modo 2 jogadores
; <<<-
;-------------------------------------------------------------------------------