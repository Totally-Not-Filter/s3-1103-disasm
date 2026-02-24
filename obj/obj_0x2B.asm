;-------------------------------------------------------------------------------
; Objeto 0x2B - Pontes que viram na Angel Island
; ->>>
;-------------------------------------------------------------------------------
; Offset_0x021B1C:
		move.l	#Flipping_Bridge_Mappings, Obj_Map(A0) ; Offset_0x021E78, $000C
		move.w	#$42F0, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$80, Obj_Width(A0)				 ; $0007
		move.b	#$04, Obj_Height(A0)					 ; $0006
		move.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0200, Obj_Priority(A0)				 ; $0008
		move.w	Obj_Y(A0), Obj_Control_Var_00(A0)		  ; $0014, $0030
		move.l	#Offset_0x021C8E, Obj_Control_Var_02(A0)		 ; $0032
		move.b	Obj_Subtype(A0), D0				 ; $002C
		bpl.s	Offset_0x021B5E
		move.l	#Offset_0x021D0E, Obj_Control_Var_02(A0)		 ; $0032
Offset_0x021B5E:
		move.b	D0, D1
		andi.w	#$000F, D0
		addi.w	#$0010, D0
		move.b	D0, Obj_Control_Var_07(A0)				 ; $0037
		lsr.b	#$04, D1
		andi.w	#$0007, D1
		move.b	D1, Obj_Ani_Time_2(A0)					 ; $0025
		moveq	#$01, D1
		btst	#$00, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x021B86
		moveq	#-$01, D1
		subq.b	#$01, Obj_Control_Var_07(A0)			 ; $0037
Offset_0x021B86:
		move.b	D1, Obj_Control_Var_06(A0)				 ; $0036
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x021C20
		move.l	#Offset_0x021C48, (A1)
		move.l	#Flipping_Bridge_Mappings, Obj_Map(A1) ; Offset_0x021E78, $000C
		move.w	#$42F0, Obj_Art_VRAM(A1)				 ; $000A
		move.b	#$04, Obj_Flags(A1)				 ; $0004
		move.b	#$80, Obj_Width(A1)				 ; $0007
		move.b	#$40, Obj_Height(A1)					 ; $0006
		move.w	#$0200, Obj_Priority(A1)				 ; $0008
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		bset	#$06, Obj_Flags(A1)				 ; $0004
		move.w	#$0008, Obj_Sub_Y(A1)					 ; $0016
		move.w	Obj_Y(A0), D2					 ; $0014
		move.w	Obj_X(A0), D3					 ; $0010
		subi.w	#$0070, D3
		addi.w	#$0020, D2
		move.w	#$0008, D4
		tst.b	Obj_Subtype(A0)					 ; $002C
		bpl.s	Offset_0x021BFA
		subi.w	#$0010, D2
		move.w	#$0004, D4
Offset_0x021BFA:
		moveq	#$00, D1
		lea		Obj_Speed_X(A1), A2				 ; $0018
		move.w	Obj_Sub_Y(A1), D6				 ; $0016
		subq.w	#$01, D6
Offset_0x021C06:
		move.w	D3, (A2)+
		move.w	D2, (A2)+
		move.w	D1, (A2)+
		addq.w	#$02, D1
		andi.w	#$000F, D1
		addi.w	#$0020, D3
		sub.w	D4, D2
		dbra	D6, Offset_0x021C06
		move.w	A1, Obj_Control_Var_0C(A0)				 ; $003C
Offset_0x021C20:
		move.l	#Offset_0x021C26, (A0)
Offset_0x021C26:
		move.w	Obj_Control_Var_0C(A0), A3				 ; $003C
		bsr.w	Offset_0x021C4E
		moveq	#$00, D1
		move.b	Obj_Width(A0), D1				 ; $0007
		move.l	Obj_Control_Var_02(A0), A2				 ; $0032
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Offset_0x021D8E).l
		jmp		(MarkObjGone_3).l				   ; Offset_0x011B3E
;-------------------------------------------------------------------------------
Offset_0x021C48:
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Offset_0x021C4E:
		subq.b	#$01, Obj_Ani_Time(A0)					 ; $0024
		bpl.s	Offset_0x021C7E
		move.b	Obj_Ani_Time_2(A0), Obj_Ani_Time(A0)	  ; $0025, $0024
		lea		$001D(A3), A2
		move.w	Obj_Sub_Y(A3), D6				 ; $0016
		subq.w	#$01, D6
		move.b	Obj_Control_Var_07(A0), D2				 ; $0037
		move.b	Obj_Control_Var_06(A0), D1				 ; $0036
		bmi.s	Offset_0x021C80
Offset_0x021C6E:
		add.b	D1, (A2)
		cmp.b	(A2), D2
		bhi.s	Offset_0x021C78
		move.b	#$00, (A2)
Offset_0x021C78:
		addq.w	#$06, A2
		dbra	D6, Offset_0x021C6E
Offset_0x021C7E:
		rts
Offset_0x021C80:
		add.b	D1, (A2)
		bcs.s	Offset_0x021C86
		move.b	D2, (A2)
Offset_0x021C86:
		addq.w	#$06, A2
		dbra	D6, Offset_0x021C80
		rts
;-------------------------------------------------------------------------------
Offset_0x021C8E:
		dc.b	$E4, $E4, $E4, $E4, $E4, $E4, $E4, $E4
		dc.b	$E4, $E4, $E4, $E4, $E4, $E4, $E4, $E4
		dc.b	$EC, $EC, $EC, $EC, $EC, $EC, $EC, $EC
		dc.b	$EC, $EC, $EC, $EC, $EC, $EC, $EC, $EC
		dc.b	$F4, $F4, $F4, $F4, $F4, $F4, $F4, $F4
		dc.b	$F4, $F4, $F4, $F4, $F4, $F4, $F4, $F4
		dc.b	$FC, $FC, $FC, $FC, $FC, $FC, $FC, $FC
		dc.b	$FC, $FC, $FC, $FC, $FC, $FC, $FC, $FC
		dc.b	$04, $04, $04, $04, $04, $04, $04, $04
		dc.b	$04, $04, $04, $04, $04, $04, $04, $04
		dc.b	$0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C
		dc.b	$0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C
		dc.b	$14, $14, $14, $14, $14, $14, $14, $14
		dc.b	$14, $14, $14, $14, $14, $14, $14, $14
		dc.b	$1C, $1C, $1C, $1C, $1C, $1C, $1C, $1C
		dc.b	$1C, $1C, $1C, $1C, $1C, $1C, $1C, $1C
;-------------------------------------------------------------------------------
Offset_0x021D0E:
		dc.b	$F4, $F4, $F4, $F4, $F4, $F4, $F4, $F4
		dc.b	$F4, $F4, $F4, $F4, $F4, $F4, $F4, $F4
		dc.b	$F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8
		dc.b	$F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8
		dc.b	$FC, $FC, $FC, $FC, $FC, $FC, $FC, $FC
		dc.b	$FC, $FC, $FC, $FC, $FC, $FC, $FC, $FC
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$04, $04, $04, $04, $04, $04, $04, $04
		dc.b	$04, $04, $04, $04, $04, $04, $04, $04
		dc.b	$08, $08, $08, $08, $08, $08, $08, $08
		dc.b	$08, $08, $08, $08, $08, $08, $08, $08
		dc.b	$0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C
		dc.b	$0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C
		dc.b	$10, $10, $10, $10, $10, $10, $10, $10
		dc.b	$10, $10, $10, $10, $10, $10, $10, $10
;-------------------------------------------------------------------------------
Offset_0x021D8E:
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		moveq	#$03, D6
		movem.l D1-D4, -(A7)
		bsr.s	Offset_0x021DA4
		movem.l (A7)+, D1-D4
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		addq.b	#$01, D6
Offset_0x021DA4:
		btst	D6, Obj_Status(A0)				 ; $002A
		beq.s	Offset_0x021DFA
		move.w	D1, D2
		add.w	D2, D2
		btst	#$01, Obj_Status(A1)					 ; $002A
		bne.s	Offset_0x021DC6
		move.w	Obj_X(A1), D0					 ; $0010
		sub.w	Obj_X(A0), D0					 ; $0010
		add.w	D1, D0
		bmi.s	Offset_0x021DC6
		cmp.w	D2, D0
		bcs.s	Offset_0x021DDA
Offset_0x021DC6:
		bclr	#$03, Obj_Status(A1)					 ; $002A
		bset	#$01, Obj_Status(A1)					 ; $002A
		bclr	D6, Obj_Status(A0)				 ; $002A
		moveq	#$00, D4
		rts
Offset_0x021DDA:
		lsr.w	#$05, D0
		add.w	D0, D0
		move.w	D0, D3
		add.w	D0, D0
		add.w	D3, D0
		move.b	$1D(A3, D0), D0
		cmpi.b	#$05, D0
		bcs.s	Offset_0x021DC6
		move.w	D4, D2
		jsr		(Solid_Object_Sloped_2).l		   ; Offset_0x013A90
		moveq	#$00, D4
		rts
Offset_0x021DFA:
		tst.w	Obj_Speed_Y(A1)					 ; $001A
		bmi.s	Offset_0x021E76
		move.w	Obj_X(A1), D0					 ; $0010
		sub.w	Obj_X(A0), D0					 ; $0010
		add.w	D1, D0
		bmi.s	Offset_0x021E76
		add.w	D1, D1
		cmp.w	D1, D0
		bcc.s	Offset_0x021E76
		btst	#$00, Obj_Flags(A0)				 ; $0004
		beq.s	Offset_0x021E1E
		not.w	D0
		add.w	D1, D0
Offset_0x021E1E:
		move.w	D0, D4
		lsr.w	#$01, D0
		move.b	$00(A2, D0), D3
		ext.w	D3
		move.w	Obj_Y(A0), D0					 ; $0014
		sub.w	D3, D0
		move.w	Obj_Y(A1), D2					 ; $0014
		move.b	Obj_Height_2(A1), D1					 ; $001E
		ext.w	D1
		add.w	D2, D1
		addq.w	#$04, D1
		sub.w	D1, D0
		bhi.s	Offset_0x021E76
		cmpi.w	#$FFF0, D0
		bcs.s	Offset_0x021E76
		tst.b	Obj_Timer(A1)					 ; $002E
		bne.s	Offset_0x021E76
		cmpi.b	#$06, Obj_Routine(A1)					 ; $0005
		bcc.s	Offset_0x021E76
		lsr.w	#$05, D4
		add.w	D4, D4
		move.w	D4, D1
		add.w	D4, D4
		add.w	D1, D4
		move.b	$1D(A3, D4), D4
		cmpi.b	#$05, D4
		bcs.s	Offset_0x021E76
		add.w	D0, D2
		addq.w	#$03, D2
		move.w	D2, Obj_Y(A1)					 ; $0014
		jmp		(Ride_Object_Set_Ride).l		   ; Offset_0x013C80
Offset_0x021E76:
		rts
;-------------------------------------------------------------------------------
Flipping_Bridge_Mappings:					   ; Offset_0x021E78
		dc.w	Offset_0x021EF0-Flipping_Bridge_Mappings
		dc.w	Offset_0x021EFE-Flipping_Bridge_Mappings
		dc.w	Offset_0x021EB8-Flipping_Bridge_Mappings
		dc.w	Offset_0x021EC6-Flipping_Bridge_Mappings
		dc.w	Offset_0x021ED4-Flipping_Bridge_Mappings
		dc.w	Offset_0x021EE2-Flipping_Bridge_Mappings
		dc.w	Offset_0x021EE2-Flipping_Bridge_Mappings
		dc.w	Offset_0x021EE2-Flipping_Bridge_Mappings
		dc.w	Offset_0x021EE2-Flipping_Bridge_Mappings
		dc.w	Offset_0x021EE2-Flipping_Bridge_Mappings
		dc.w	Offset_0x021EE2-Flipping_Bridge_Mappings
		dc.w	Offset_0x021EE2-Flipping_Bridge_Mappings
		dc.w	Offset_0x021EE2-Flipping_Bridge_Mappings
		dc.w	Offset_0x021EE2-Flipping_Bridge_Mappings
		dc.w	Offset_0x021EE2-Flipping_Bridge_Mappings
		dc.w	Offset_0x021EE2-Flipping_Bridge_Mappings
		dc.w	Offset_0x021EE2-Flipping_Bridge_Mappings
		dc.w	Offset_0x021EE2-Flipping_Bridge_Mappings
		dc.w	Offset_0x021EE2-Flipping_Bridge_Mappings
		dc.w	Offset_0x021EE2-Flipping_Bridge_Mappings
		dc.w	Offset_0x021EE2-Flipping_Bridge_Mappings
		dc.w	Offset_0x021EE2-Flipping_Bridge_Mappings
		dc.w	Offset_0x021EE2-Flipping_Bridge_Mappings
		dc.w	Offset_0x021EE2-Flipping_Bridge_Mappings
		dc.w	Offset_0x021EE2-Flipping_Bridge_Mappings
		dc.w	Offset_0x021EE2-Flipping_Bridge_Mappings
		dc.w	Offset_0x021EE2-Flipping_Bridge_Mappings
		dc.w	Offset_0x021EE2-Flipping_Bridge_Mappings
		dc.w	Offset_0x021EE2-Flipping_Bridge_Mappings
		dc.w	Offset_0x021EE2-Flipping_Bridge_Mappings
		dc.w	Offset_0x021EE2-Flipping_Bridge_Mappings
		dc.w	Offset_0x021EE2-Flipping_Bridge_Mappings
Offset_0x021EB8:
		dc.w	$0002
		dc.w	$F007, $00D6, $FFF0
		dc.w	$F007, $08D6, $0000
Offset_0x021EC6:
		dc.w	$0002
		dc.w	$F406, $00DE, $FFF0
		dc.w	$F406, $08DE, $0000
Offset_0x021ED4:
		dc.w	$0002
		dc.w	$F805, $00E4, $FFF0
		dc.w	$F805, $08E4, $0000
Offset_0x021EE2:
		dc.w	$0002
		dc.w	$FC04, $00E8, $FFF0
		dc.w	$FC04, $08E8, $0000
Offset_0x021EF0:
		dc.w	$0002
		dc.w	$F805, $10E4, $FFF0
		dc.w	$F805, $18E4, $0000
Offset_0x021EFE:
		dc.w	$0002
		dc.w	$F406, $10DE, $FFF0
		dc.w	$F406, $18DE, $0000
;-------------------------------------------------------------------------------
; Objeto 0x2B - Pontes que viram na Angel Island
; <<<-
;-------------------------------------------------------------------------------