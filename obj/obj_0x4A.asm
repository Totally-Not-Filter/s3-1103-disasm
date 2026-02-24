;===============================================================================
; Objeto 0x4A - Bumper na Carnival Night / Balloon Park / Glowing Spheres Bonus
; ->>>
;===============================================================================
; Offset_0x029188:
		move.l	#Bumper_Mappings, Obj_Map(A0)	; Offset_0x0293D4, $000C
		move.w	#$4364, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$04, Obj_Flags(A0)				 ; $0004
		move.b	#$10, Obj_Width(A0)				 ; $0007
		move.b	#$10, Obj_Height(A0)					 ; $0006
		move.w	#$0080, Obj_Priority(A0)				 ; $0008
		move.b	#$D7, Obj_Col_Flags(A0)					 ; $0028
		move.w	Obj_X(A0), Obj_Control_Var_00(A0)		  ; $0010, $0030
		move.w	Obj_Y(A0), Obj_Control_Var_02(A0)		  ; $0014, $0032
		tst.w	(Two_Player_Flag).w					 ; $FFFFFFD8
		beq.s	Offset_0x0291DE
		move.l	#Bumper_Mappings_2P, Obj_Map(A0) ; Offset_0x00293F4, $000C
		move.w	#$2300, Obj_Art_VRAM(A0)				 ; $000A
		move.l	#Offset_0x029322, (A0)
		bra.w	Offset_0x029322
Offset_0x0291DE:
		move.l	#Offset_0x029220, (A0)
		move.b	Obj_Subtype(A0), D0				 ; $002C
		beq.s	Offset_0x029220
		move.b	D0, Obj_Angle(A0)				 ; $0026
		move.l	#Offset_0x0291F4, (A0)
Offset_0x0291F4:
		move.b	(Level_Frame_Count+$01).w, D0		 ; $FFFFFE05
		btst	#$00, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x029202
		neg.b	D0
Offset_0x029202:
		add.b	Obj_Angle(A0), D0				 ; $0026
		jsr		(CalcSine).l					 ; Offset_0x001B20
		asr.w	#$02, D1
		asr.w	#$02, D0
		add.w	Obj_Control_Var_00(A0), D1				 ; $0030
		add.w	Obj_Control_Var_02(A0), D0				 ; $0032
		move.w	D1, Obj_X(A0)					 ; $0010
		move.w	D0, Obj_Y(A0)					 ; $0014
Offset_0x029220:
		tst.b	Obj_Col_Prop(A0)				 ; $0029
		beq.w	Offset_0x0292E6
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		bclr	#$00, Obj_Col_Prop(A0)					 ; $0029
		beq.s	Offset_0x029236
		bsr.s	Offset_0x02924C
Offset_0x029236:
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		bclr	#$01, Obj_Col_Prop(A0)					 ; $0029
		beq.s	Offset_0x029244
		bsr.s	Offset_0x02924C
Offset_0x029244:
		clr.b	Obj_Col_Prop(A0)				 ; $0029
		bra.w	Offset_0x0292E6
Offset_0x02924C:
		move.w	Obj_X(A0), D1					 ; $0010
		move.w	Obj_Y(A0), D2					 ; $0014
		sub.w	Obj_X(A1), D1					 ; $0010
		sub.w	Obj_Y(A1), D2					 ; $0014
		jsr		(CalcAngle).l					 ; Offset_0x001DB8
		move.b	(Level_Frame_Count).w, D1			 ; $FFFFFE04
		andi.w	#$0003, D1
		add.w	D1, D0
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
		move.b	#$01, Obj_Ani_Number(A0)				 ; $0020
		moveq	#Small_Bumper_Sfx, D0					  ; -$75
		jsr		(Play_Music).l					 ; Offset_0x001176
		move.w	Obj_Respaw_Ref(A0), D0					 ; $0048
		beq.s	Offset_0x0292BA
		move.w	D0, A2
		cmpi.b	#$8A, (A2)
		bcc.s	Offset_0x0292E4
		addq.b	#$01, (A2)
Offset_0x0292BA:
		moveq	#$01, D0
		move.w	A1, A3
		jsr		(Add_Points).l					 ; Offset_0x007AEC
		jsr		(AllocateObject).l			 ; Offset_0x011DD8
		bne.s	Offset_0x0292E4
		move.l	#Obj_Enemy_Points, (A1)		   ; Offset_0x023E42
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		move.b	#$04, Obj_Map_Id(A1)					 ; $0022
Offset_0x0292E4:
		rts
Offset_0x0292E6:
		lea		(Bumper_Animate_Data).l, A1		 ; Offset_0x0293C6
		jsr		(AnimateSprite).l				   ; Offset_0x01115E
		move.w	Obj_Control_Var_00(A0), D0				 ; $0030
		andi.w	#$FF80, D0
		sub.w	(Camera_X_Left).w, D0				 ; $FFFFF7DA
		cmpi.w	#$0280, D0
		bhi.s	Offset_0x029310
		jsr		(Add_SpriteToCollisionResponseList).l		  ; Offset_0x00A540
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x029310:
		move.w	Obj_Respaw_Ref(A0), D0					 ; $0048
		beq.s	Offset_0x02931C
		move.w	D0, A2
		bclr	#$07, (A2)
Offset_0x02931C:
		jmp		(DeleteObject).l				   ; Offset_0x011138
Offset_0x029322:
		tst.b	Obj_Col_Prop(A0)				 ; $0029
		beq.w	Offset_0x0293AE
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		bclr	#$00, Obj_Col_Prop(A0)					 ; $0029
		beq.s	Offset_0x029338
		bsr.s	Offset_0x02934E
Offset_0x029338:
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		bclr	#$01, Obj_Col_Prop(A0)					 ; $0029
		beq.s	Offset_0x029346
		bsr.s	Offset_0x02934E
Offset_0x029346:
		clr.b	Obj_Col_Prop(A0)				 ; $0029
		bra.w	Offset_0x0293AE
Offset_0x02934E:
		move.w	Obj_X(A0), D1					 ; $0010
		move.w	Obj_Y(A0), D2					 ; $0014
		sub.w	Obj_X(A1), D1					 ; $0010
		sub.w	Obj_Y(A1), D2					 ; $0014
		jsr		(CalcAngle).l					 ; Offset_0x001DB8
		move.b	(Level_Frame_Count).w, D1			 ; $FFFFFE04
		andi.w	#$0003, D1
		add.w	D1, D0
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
		move.b	#$01, Obj_Ani_Number(A0)				 ; $0020
		moveq	#Small_Bumper_Sfx, D0					  ; -$75
		jsr		(Play_Music).l					 ; Offset_0x001176
		rts
Offset_0x0293AE:
		lea		(Bumper_Animate_Data).l, A1		 ; Offset_0x0293C6
		jsr		(AnimateSprite).l				   ; Offset_0x01115E
		jsr		(Add_SpriteToCollisionResponseList).l		  ; Offset_0x00A540
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Bumper_Animate_Data:						   ; Offset_0x0293C6
		dc.w	Offset_0x0293CA-Bumper_Animate_Data
		dc.w	Offset_0x0293CD-Bumper_Animate_Data
Offset_0x0293CA:
		dc.b	$0F, $00, $FF
Offset_0x0293CD:
		dc.b	$03, $01, $00, $01, $FD, $00, $00
;-------------------------------------------------------------------------------
Bumper_Mappings:							   ; Offset_0x0293D4
		dc.w	Offset_0x0293D8-Bumper_Mappings
		dc.w	Offset_0x0293E6-Bumper_Mappings
Offset_0x0293D8:
		dc.w	$0002
		dc.w	$F007, $0000, $FFF0
		dc.w	$F007, $0800, $0000
Offset_0x0293E6:
		dc.w	$0002
		dc.w	$F007, $0008, $FFF0
		dc.w	$F007, $0808, $0000
;-------------------------------------------------------------------------------
Bumper_Mappings_2P:							   ; Offset_0x0293F4
		dc.w	Offset_0x0293F8-Bumper_Mappings_2P
		dc.w	Offset_0x029400-Bumper_Mappings_2P
Offset_0x0293F8:
		dc.w	$0001
		dc.w	$F40A, $0000, $FFF4
Offset_0x029400:
		dc.w	$0001
		dc.w	$F40A, $0009, $FFF4
;===============================================================================
; Objeto 0x4A - Bumper na Carnival Night / Balloon Park / Glowing Spheres Bonus
; <<<-
;===============================================================================