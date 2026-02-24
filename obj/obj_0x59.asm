;===============================================================================
; Objeto 0x59 - Roda azul ativada através de "Spindash" na Marble Garden.
; ->>>
;===============================================================================
; Offset_0x01C930:
		move.l	#Dash_Trigger_Mappings, Obj_Map(A0) ; Offset_0x01CB06,$000C
		move.w	#$235F, Obj_Art_VRAM(A0)				 ; $000A
		ori.b	#$04, Obj_Flags(A0)				 ; $0004
		move.b	#$10, Obj_Width(A0)				 ; $0007
		move.b	#$10, Obj_Height(A0)					 ; $0006
		move.w	#$0280, Obj_Priority(A0)				 ; $0008
		bset	#$06, Obj_Flags(A0)				 ; $0004
		move.w	#$0001, Obj_Sub_Y(A0)					 ; $0016
		lea		Obj_Speed_X(A0), A2				 ; $0018
		move.w	Obj_X(A0), (A2)+				 ; $0010
		move.w	Obj_Y(A0), (A2)+				 ; $0014
		move.w	#$0000, (A2)+
		move.l	#Offset_0x01C978, (A0)
Offset_0x01C978:
		move.w	#$001B, D1
		move.w	#$0010, D2
		move.w	Obj_X(A0), D4					 ; $0010
		lea		(Offset_0x01CAEA).l, A2
		jsr		(Solid_Object_3).l			   ; Offset_0x01360E
		swap	D6
		andi.w	#$0033, D6
		beq.s	Offset_0x01C9FE
		move.b	D6, D0
		andi.b	#$11, D0
		beq.s	Offset_0x01C9CC
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		cmpi.b	#$09, Obj_Ani_Number(A1)				 ; $0020
		bne.s	Offset_0x01C9CC
		move.w	#$003C, Obj_Control_Var_00(A0)			 ; $0030
		move.b	#$01, Obj_Control_Var_02(A0)			 ; $0032
		move.b	Obj_Status(A1), D0				 ; $002A
		add.b	Obj_Status(A0), D0				 ; $002A
		andi.b	#$01, D0
		bne.s	Offset_0x01C9CC
		move.b	#$FF, Obj_Control_Var_02(A0)			 ; $0032
Offset_0x01C9CC:
		andi.b	#$22, D6
		beq.s	Offset_0x01C9FE
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		cmpi.b	#$09, Obj_Ani_Number(A1)				 ; $0020
		bne.s	Offset_0x01C9FE
		move.w	#$003C, Obj_Control_Var_00(A0)			 ; $0030
		move.b	#$01, Obj_Control_Var_02(A0)			 ; $0032
		move.b	Obj_Status(A1), D0				 ; $002A
		add.b	Obj_Status(A0), D0				 ; $002A
		andi.b	#$01, D0
		bne.s	Offset_0x01C9FE
		move.b	#$FF, Obj_Control_Var_02(A0)			 ; $0032
Offset_0x01C9FE:
		tst.w	Obj_Control_Var_00(A0)					 ; $0030
		beq.s	Offset_0x01CA7C
		move.b	Obj_Subtype(A0), D0				 ; $002C
		andi.w	#$000F, D0
		lea		(Level_Trigger_Array).w, A3			 ; $FFFFF7E0
		lea		(A3, D0), A3
		subq.w	#$01, Obj_Control_Var_00(A0)			 ; $0030
		bne.s	Offset_0x01CA26
		move.b	#$00, (A3)
		move.b	#$00, Obj_Map_Id(A0)					 ; $0022
		bra.s	Offset_0x01CA7C
Offset_0x01CA26:
		move.b	#$01, (A3)
		move.b	Obj_Status(A0), D6				 ; $002A
		andi.w	#$0018, D6
		beq.s	Offset_0x01CA4E
		move.w	D6, D0
		andi.w	#$0008, D0
		beq.s	Offset_0x01CA42
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		bsr.s	Offset_0x01CA82
Offset_0x01CA42:
		andi.w	#$0010, D6
		beq.s	Offset_0x01CA4E
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		bsr.s	Offset_0x01CA82
Offset_0x01CA4E:
		subq.b	#$01, Obj_Ani_Time(A0)					 ; $0024
		bpl.s	Offset_0x01CA68
		move.b	#$01, Obj_Ani_Time(A0)					 ; $0024
		move.b	Obj_Control_Var_02(A0), D0				 ; $0032
		add.b	D0, $001D(A0)
		andi.b	#$03, $001D(A0)
Offset_0x01CA68:
		tst.b	Obj_Map_Id(A0)					 ; $0022
		beq.s	Offset_0x01CA76
		move.b	#$00, Obj_Map_Id(A0)					 ; $0022
		bra.s	Offset_0x01CA7C
Offset_0x01CA76:
		move.b	#$04, Obj_Map_Id(A0)					 ; $0022
Offset_0x01CA7C:
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
Offset_0x01CA82:
		move.w	Obj_X(A0), D1					 ; $0010
		subi.w	#$0010, D1
		btst	#$00, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x01CA96
		addi.w	#$0020, D1
Offset_0x01CA96:
		move.w	Obj_Y(A0), D2					 ; $0014
		addi.w	#$0010, D2
		sub.w	Obj_X(A1), D1					 ; $0010
		sub.w	Obj_Y(A1), D2					 ; $0014
		jsr		(CalcAngle).l					 ; Offset_0x001DB8
		jsr		(CalcSine).l					 ; Offset_0x001B20
		muls.w	#$F900, D1
		asr.l	#$08, D1
		move.w	D1, Obj_Speed_X(A1)				 ; $0018
		muls.w	#$F900, D0
		asr.l	#$08, D0
		move.w	D0, Obj_Speed_Y(A1)				 ; $001A
		bset	#$01, Obj_Status(A1)					 ; $002A
		bclr	#$04, Obj_Status(A1)					 ; $002A
		bclr	#$05, Obj_Status(A1)					 ; $002A
		clr.b	Obj_Control_Var_10(A1)					 ; $0040
		clr.b	Obj_Control_Var_0D(A1)					 ; $003D
		moveq	#Small_Bumper_Sfx, D0					  ; -$75
		jsr		(PlaySound).l					; Offset_0x001176
		rts
;-------------------------------------------------------------------------------
Offset_0x01CAEA:
		dc.b	$10, $10, $10, $10, $10, $10, $10, $10
		dc.b	$10, $0F, $0F, $0E, $0E, $0D, $0C, $0A
		dc.b	$08, $06, $04, $00, $FC, $F8, $F6, $F6
		dc.b	$F6, $F6, $F6, $F6
;-------------------------------------------------------------------------------
Dash_Trigger_Mappings:						   ; Offset_0x01CB06
		dc.w	Offset_0x01CB10-Dash_Trigger_Mappings
		dc.w	Offset_0x01CB24-Dash_Trigger_Mappings
		dc.w	Offset_0x01CB32-Dash_Trigger_Mappings
		dc.w	Offset_0x01CB46-Dash_Trigger_Mappings
		dc.w	Offset_0x01CB54-Dash_Trigger_Mappings
Offset_0x01CB10:
		dc.w	$0003
		dc.w	$0805, $003D, $FFE0
		dc.w	$0805, $083D, $FFF0
		dc.w	$F00F, $0824, $FFF0
Offset_0x01CB24:
		dc.w	$0002
		dc.w	$040A, $0041, $FFE4
		dc.w	$F00F, $0824, $FFF0
Offset_0x01CB32:
		dc.w	$0003
		dc.w	$0005, $004A, $FFE8
		dc.w	$1005, $104A, $FFE8
		dc.w	$F00F, $0824, $FFF0
Offset_0x01CB46:
		dc.w	$0002
		dc.w	$040A, $0841, $FFE4
		dc.w	$F00F, $0824, $FFF0
Offset_0x01CB54:
		dc.w	$0002
		dc.w	$F408, $0834, $FFF0
		dc.w	$FC09, $0837, $FFF8
;===============================================================================
; Objeto 0x59 - Roda azul ativada através de "Spindash" na Marble Garden.
; <<<-
;===============================================================================