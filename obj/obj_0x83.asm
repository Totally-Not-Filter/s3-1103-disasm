;===============================================================================
; Objeto 0x83 - Inimigo macaco na Angel Island
; ->>>
;===============================================================================
; Offset_0x043F1C:
		jsr		Object_Check_Range(PC)		   ; Offset_0x04326E
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x043F32(PC, D0), D1
		jsr		Offset_0x043F32(PC, D1)
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X(PC) ; Offset_0x042B3C
;-------------------------------------------------------------------------------
Offset_0x043F32:
		dc.w	Offset_0x043F38-Offset_0x043F32
		dc.w	Offset_0x043F82-Offset_0x043F32
		dc.w	Offset_0x043FA0-Offset_0x043F32
;-------------------------------------------------------------------------------
Offset_0x043F38:
		lea		Monkey_Dude_Setup_Data(PC), A1			; Offset_0x044420
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		lsr.w	#$02, D0
		move.b	D0, Obj_Subtype(A0)				 ; $002C
		lsr.w	#$01, D0
		move.b	D0, Obj_Control_Var_09(A0)				 ; $0039
		move.l	#Offset_0x04447A, Obj_Child_Data(A0)			 ; $0030
		move.w	#$003B, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x043F88, Obj_Child(A0)			 ; $0034
		btst	#$00, Obj_Flags(A0)				 ; $0004
		bne.w	Offset_0x043F7A
		lea		Offset_0x044446(PC), A2
		jmp		Load_Child_Object_Link_List_Repeat_A2(PC) ; Offset_0x041EA0
Offset_0x043F7A:
		lea		Offset_0x04444C(PC), A2
		jmp		Load_Child_Object_Link_List_Repeat_A2(PC) ; Offset_0x041EA0
;-------------------------------------------------------------------------------
Offset_0x043F82:
		jmp		(Animate_Raw_Wait).l			   ; Offset_0x042F82
;-------------------------------------------------------------------------------
Offset_0x043F88:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		clr.b	Obj_Ani_Frame(A0)				 ; $0023
		clr.b	Obj_Ani_Time(A0)				 ; $0024
		move.l	#Offset_0x04447E, Obj_Child_Data(A0)			 ; $0030
		rts
;-------------------------------------------------------------------------------
Offset_0x043FA0:
		jsr		Animate_Raw_Multi_Delay(PC)			   ; Offset_0x04215C
		tst.w	D2
		beq.s	Offset_0x043FC8
		btst	#$02, Obj_Control_Var_08(A0)			 ; $0038
		bne.s	Offset_0x043FCA
		cmpi.b	#$00, Obj_Map_Id(A0)					 ; $0022
		bne.s	Offset_0x043FC8
		addq.w	#$08, Obj_Y(A0)					 ; $0014
		subq.b	#$01, Obj_Control_Var_09(A0)			 ; $0039
		cmpi.b	#$01, Obj_Control_Var_09(A0)			 ; $0039
		beq.s	Offset_0x043FDE
Offset_0x043FC8:
		rts
Offset_0x043FCA:
		cmpi.b	#$02, Obj_Map_Id(A0)					 ; $0022
		bne.s	Offset_0x043FC8
		subq.b	#$01, Obj_Control_Var_09(A0)			 ; $0039
		beq.s	Offset_0x043FDE
		subq.w	#$08, Obj_Y(A0)					 ; $0014
		rts
Offset_0x043FDE:
		move.b	#$02, Obj_Routine(A0)					 ; $0005
		move.b	Obj_Subtype(A0), Obj_Control_Var_09(A0)	  ; $002C, $0039
		bchg	#02, Obj_Control_Var_08(A0)				 ; $0038
		move.w	#$003B, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x04447A, Obj_Child_Data(A0)			 ; $0030
		move.b	#$00, Obj_Map_Id(A0)					 ; $0022
		clr.b	Obj_Ani_Frame(A0)				 ; $0023
		clr.b	Obj_Ani_Time(A0)				 ; $0024
		rts
;-------------------------------------------------------------------------------
Offset_0x04400E:
		bset	#$03, Obj_Control_Var_08(A0)			 ; $0038
Offset_0x044014:
		lea		Offset_0x04442C(PC), A1
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		clr.b	Obj_Routine(A0)					 ; $0005
		move.b	Obj_Subtype(A0), D0				 ; $002C
		add.b	D0, D0
		move.b	D0, Obj_Control_Var_0B(A0)				 ; $003B
		move.b	D0, Obj_Control_Var_0A(A0)				 ; $003A
		tst.b	Obj_Subtype(A0)					 ; $002C
		bne.s	Offset_0x044058
		move.l	#Offset_0x044092, (A0)
		moveq	#$0E, D0
		btst	#$03, Obj_Control_Var_08(A0)			 ; $0038
		bne.s	Offset_0x044046
		neg.w	D0
Offset_0x044046:
		add.w	D0, Obj_X(A0)					 ; $0010
		subq.w	#$02, Obj_Y(A0)					 ; $0014
		move.w	Obj_Y(A0), Obj_Control_Var_0E(A0)		  ; $0014, $003E
		jmp		Child_Display_Or_Delete(PC)			   ; Offset_0x04245C
Offset_0x044058:
		cmpi.b	#$08, Obj_Subtype(A0)					 ; $002C
		beq.s	Offset_0x04406A
		move.l	#Offset_0x0441E2, (A0)
		jmp		Child_Display_Or_Delete(PC)			   ; Offset_0x04245C
Offset_0x04406A:
		move.l	#Offset_0x044212, (A0)
		move.b	#$06, Obj_Map_Id(A0)					 ; $0022
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		move.w	Obj_Child_Ref(A1), A1					 ; $0046
		move.w	A1, Obj_Control_Var_0E(A0)				 ; $003E
		move.w	Obj_Child_Ref(A1), A1					 ; $0046
		move.w	Obj_Child_Ref(A1), A1					 ; $0046
		move.w	A1, Obj_Height_3(A0)					 ; $0044
		jmp		Child_Display_Or_Delete(PC)			   ; Offset_0x04245C
;-------------------------------------------------------------------------------
Offset_0x044092:
		bsr.w	Offset_0x0442C6
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x0440A8(PC, D0), D1
		jsr		Offset_0x0440A8(PC, D1)
		jmp		Child_Display_Or_Delete(PC)			   ; Offset_0x04245C
;-------------------------------------------------------------------------------
Offset_0x0440A8:
		dc.w	Offset_0x0440B4-Offset_0x0440A8
		dc.w	Offset_0x0440F0-Offset_0x0440A8
		dc.w	Offset_0x044148-Offset_0x0440A8
		dc.w	Offset_0x04417A-Offset_0x0440A8
		dc.w	Offset_0x0441B0-Offset_0x0440A8
		dc.w	Offset_0x0440F6-Offset_0x0440A8
;-------------------------------------------------------------------------------
Offset_0x0440B4:
		move.b	Obj_Control_Var_0C(A0), D0				 ; $003C
		btst	#$03, Obj_Control_Var_08(A0)			 ; $0038
		beq.s	Offset_0x0440CE
		addq.b	#$04, D0
		cmpi.b	#$80, D0
		bcc.s	Offset_0x0440DC
		move.b	D0, Obj_Control_Var_0C(A0)				 ; $003C
		rts
Offset_0x0440CE:
		subq.b	#$04, D0
		cmpi.b	#$80, D0
		bls.s	Offset_0x0440DC
		move.b	D0, Obj_Control_Var_0C(A0)				 ; $003C
		rts
Offset_0x0440DC:
		move.b	#$02, Obj_Routine(A0)					 ; $0005
Offset_0x0440E2:
		bsr.w	Offset_0x0443FE
		move.l	#Offset_0x044136, Obj_Child(A0)			 ; $0034
Offset_0x0440EE:
		rts
;-------------------------------------------------------------------------------
Offset_0x0440F0:
		bsr.w	Offset_0x0442EA
		beq.s	Offset_0x04413A
;-------------------------------------------------------------------------------
Offset_0x0440F6:
		btst	#$03, Obj_Control_Var_08(A0)			 ; $0038
		beq.s	Offset_0x044114
		move.b	Obj_Control_Var_11(A0), D1				 ; $0041
		bsr.w	Offset_0x044306
		subi.b	#$20, D0
		cmpi.b	#$60, D0
		bcc.s	Offset_0x044126
		bra.w	Offset_0x044132
Offset_0x044114:
		move.b	Obj_Control_Var_11(A0), D1				 ; $0041
		bsr.w	Offset_0x044306
		subi.b	#$80, D0
		cmpi.b	#$60, D0
		bcs.s	Offset_0x044132
Offset_0x044126:
		neg.w	Obj_Control_Var_10(A0)					 ; $0040
		move.b	Obj_Control_Var_11(A0), D1				 ; $0041
		bsr.w	Offset_0x044306
Offset_0x044132:
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x044136:
		bra.w	Offset_0x0443FE
;-------------------------------------------------------------------------------
Offset_0x04413A:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		bset	#$01, Obj_Control_Var_08(A0)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x044148:
		btst	#$03, Obj_Control_Var_08(A0)			 ; $0038
		beq.s	Offset_0x04415E
		moveq	#$04, D1
		bsr.w	Offset_0x044306
		cmpi.b	#$C0, D0
		bcc.s	Offset_0x04416C
		rts
Offset_0x04415E:
		moveq	#-$04, D1
		bsr.w	Offset_0x044306
		cmpi.b	#$40, D0
		bls.s	Offset_0x04416C
		rts
Offset_0x04416C:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		bset	#$02, Obj_Control_Var_08(A0)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x04417A:
		btst	#$03, Obj_Control_Var_08(A0)			 ; $0038
		beq.s	Offset_0x044190
		moveq	#-$08, D1
		bsr.w	Offset_0x044306
		moveq	#$60, D1
		cmp.b	D1, D0
		bls.s	Offset_0x04419E
		rts
Offset_0x044190:
		moveq	#$08, D1
		bsr.w	Offset_0x044306
		moveq	#-$60, D1
		cmp.b	D1, D0
		bcc.s	Offset_0x04419E
		rts
Offset_0x04419E:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		move.b	D1, Obj_Control_Var_0C(A0)				 ; $003C
		bclr	#$01, Obj_Control_Var_08(A0)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x0441B0:
		btst	#$03, Obj_Control_Var_08(A0)			 ; $0038
		bne.s	Offset_0x0441C6
		moveq	#-$02, D1
		bsr.w	Offset_0x044306
		moveq	#-$80, D1
		cmp.b	D1, D0
		bls.s	Offset_0x0441D4
		rts
Offset_0x0441C6:
		moveq	#$02, D1
		bsr.w	Offset_0x044306
		moveq	#-$80, D1
		cmp.b	D1, D0
		bcc.s	Offset_0x0441D4
		rts
Offset_0x0441D4:
		move.b	#$0A, Obj_Routine(A0)					 ; $0005
		move.b	D1, Obj_Control_Var_0C(A0)				 ; $003C
		bra.w	Offset_0x0440E2
;-------------------------------------------------------------------------------
Offset_0x0441E2:
		bsr.w	Offset_0x0442DE
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x0441F8(PC, D0), D1
		jsr		Offset_0x0441F8(PC, D1)
		jmp		Child_Display_Or_Delete(PC)			   ; Offset_0x04245C
;-------------------------------------------------------------------------------
Offset_0x0441F8:
		dc.w	Offset_0x0441FE-Offset_0x0441F8
		dc.w	Offset_0x044208-Offset_0x0441F8
		dc.w	Offset_0x044204-Offset_0x0441F8
;-------------------------------------------------------------------------------
Offset_0x0441FE:
		moveq	#$02, D1
		bsr.w	Offset_0x044330
;-------------------------------------------------------------------------------
Offset_0x044204:
		bra.w	Offset_0x044312
;-------------------------------------------------------------------------------
Offset_0x044208:
		moveq	#$04, D1
		bsr.w	Offset_0x044358
		bra.w	Offset_0x044312
;-------------------------------------------------------------------------------
Offset_0x044212:
		bsr.w	Offset_0x0442DE
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x044228(PC, D0), D1
		jsr		Offset_0x044228(PC, D1)
		jmp		Child_Display_Or_Delete(PC)			   ; Offset_0x04245C
;-------------------------------------------------------------------------------
Offset_0x044228:
		dc.w	Offset_0x04422E-Offset_0x044228
		dc.w	Offset_0x044238-Offset_0x044228
		dc.w	Offset_0x044234-Offset_0x044228
;-------------------------------------------------------------------------------
Offset_0x04422E:
		moveq	#$02, D1
		bsr.w	Offset_0x044330
;-------------------------------------------------------------------------------
Offset_0x044234:
		bra.w	Offset_0x044312
;-------------------------------------------------------------------------------
Offset_0x044238:
		bsr.w	Offset_0x04437A
		moveq	#$04, D1
		bsr.w	Offset_0x044358
		bra.w	Offset_0x044312
;-------------------------------------------------------------------------------
Offset_0x044246:
		lea		Offset_0x044432(PC), A1
		jsr		SetupObjectAttributes2(PC)			; Offset_0x041D76
		move.l	#Offset_0x04427C, (A0)
		move.l	#Offset_0x044483, Obj_Child_Data(A0)			 ; $0030
		move.l	#Offset_0x044290, Obj_Child(A0)			 ; $0034
		move.b	#$08, Obj_Height_2(A0)					 ; $001E
		move.w	#$FE00, Obj_Speed_X(A0)					 ; $0018
		move.w	#$FC00, Obj_Speed_Y(A0)					 ; $001A
		jmp		(MarkObjGone_5).l				   ; Offset_0x011BCC
;-------------------------------------------------------------------------------
Offset_0x04427C:
		jsr		(Move_Light_Gravity).l		   ; Offset_0x0426C2
		jsr		Animate_Raw_Multi_Delay(PC)			   ; Offset_0x04215C
		jsr		Run_Object_Hit_Floor_A0(PC)			   ; Offset_0x0423E0
		jmp		(MarkObjGone_5).l				   ; Offset_0x011BCC
;-------------------------------------------------------------------------------
Offset_0x044290:
		move.l	#Offset_0x044298, (A0)
		rts
;-------------------------------------------------------------------------------
Offset_0x044298:
		jmp		(MarkObjGone_5).l				   ; Offset_0x011BCC
;-------------------------------------------------------------------------------
; Offset_0x04429E:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		move.b	Obj_Flags(A1), D0				 ; $0004
		btst	#$03, Obj_Control_Var_08(A0)			 ; $0038
		beq.s	Offset_0x0442B2
		bchg	#00, D0
Offset_0x0442B2:
		move.w	#$0200, Obj_Priority(A0)				 ; $0008
		btst	#$00, D0
		beq.s	Offset_0x0442C4
		move.w	#$0300, Obj_Priority(A0)				 ; $0008
Offset_0x0442C4:
		rts
;-------------------------------------------------------------------------------
Offset_0x0442C6:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		move.w	Obj_Y(A1), D0					 ; $0014
		subq.w	#$02, D0
		tst.b	Obj_Map_Id(A1)					 ; $0022
		beq.s	Offset_0x0442D8
		subq.w	#$02, D0
Offset_0x0442D8:
		move.w	D0, Obj_Y(A0)					 ; $0014
		rts
;-------------------------------------------------------------------------------
Offset_0x0442DE:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		move.w	Obj_Priority(A1), Obj_Priority(A0)		  ; $0008, $0008
		rts
;-------------------------------------------------------------------------------
Offset_0x0442EA:
		jsr		Find_Player(PC)				   ; Offset_0x042634
		cmpi.w	#$0080, D2
		bcc.s	Offset_0x044302
		btst	#$03, Obj_Control_Var_08(A0)			 ; $0038
		beq.s	Offset_0x0442FE
		subq.w	#$02, D0
Offset_0x0442FE:
		tst.w	D0
		rts
Offset_0x044302:
		moveq	#$01, D4
		rts
;-------------------------------------------------------------------------------
Offset_0x044306:
		move.b	Obj_Control_Var_0C(A0), D0				 ; $003C
		add.b	D1, D0
		move.b	D0, Obj_Control_Var_0C(A0)				 ; $003C
		rts
;-------------------------------------------------------------------------------
Offset_0x044312:
		subq.b	#$01, Obj_Control_Var_0B(A0)			 ; $003B
		bne.s	Offset_0x044328
		move.b	Obj_Control_Var_0A(A0), Obj_Control_Var_0B(A0) ; $003A, $003B
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		move.b	Obj_Control_Var_0C(A1), Obj_Control_Var_0C(A0) ; $003C, $003C
Offset_0x044328:
		moveq	#$05, D2
		jsr		Move_Sprite_Circular_Simple(PC)		   ; Offset_0x0426E2
		rts
;-------------------------------------------------------------------------------
Offset_0x044330:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$01, Obj_Control_Var_08(A1)			 ; $0038
		beq.s	Offset_0x044356
		move.b	D1, Obj_Routine(A0)				 ; $0005
		bset	#$01, Obj_Control_Var_08(A0)			 ; $0038
		move.b	Obj_Control_Var_0A(A0), D0				 ; $003A
		lsr.b	#$01, D0
		move.b	D0, Obj_Control_Var_0A(A0)				 ; $003A
		move.b	#$01, Obj_Control_Var_0B(A0)			 ; $003B
Offset_0x044356:
		rts
;-------------------------------------------------------------------------------
Offset_0x044358:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$01, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x044378
		move.b	D1, Obj_Routine(A0)				 ; $0005
		move.b	Obj_Control_Var_0A(A0), D0				 ; $003A
		add.b	D0, D0
		move.b	D0, Obj_Control_Var_0A(A0)				 ; $003A
		move.b	#$01, Obj_Control_Var_0B(A0)			 ; $003B
Offset_0x044378:
		rts
;-------------------------------------------------------------------------------
Offset_0x04437A:
		btst	#$03, Obj_Control_Var_08(A0)			 ; $0038
		beq.s	Offset_0x0443A6
		btst	#$00, Obj_Control_Var_08(A0)			 ; $0038
		bne.w	Offset_0x0440EE
		move.w	Obj_Height_3(A0), A1					 ; $0044
		btst	#$02, Obj_Control_Var_08(A1)			 ; $0038
		beq.s	Offset_0x0443A4
		move.w	Obj_Control_Var_0E(A0), A1				 ; $003E
		cmpi.b	#$84, Obj_Control_Var_0C(A1)			 ; $003C
		bcs.s	Offset_0x0443D0
Offset_0x0443A4:
		rts
Offset_0x0443A6:
		btst	#$00, Obj_Control_Var_08(A0)			 ; $0038
		bne.w	Offset_0x0440EE
		move.w	Obj_Height_3(A0), A1					 ; $0044
		btst	#$02, Obj_Control_Var_08(A1)			 ; $0038
		beq.s	Offset_0x0443A4
		move.w	Obj_Control_Var_0E(A0), A1				 ; $003E
		cmpi.b	#$7C, Obj_Control_Var_0C(A1)			 ; $003C
		bcs.w	Offset_0x0440EE
		move.w	#$2548, Obj_Art_VRAM(A0)				 ; $000A
Offset_0x0443D0:
		bset	#$00, Obj_Control_Var_08(A0)			 ; $0038
		move.b	#$04, Obj_Map_Id(A0)					 ; $0022
		moveq	#Missile_Throw_Sfx, D0					   ; $56
		jsr		(Play_Music).l					 ; Offset_0x001176
		lea		(Offset_0x044462), A2
		jsr		SetupChildObject_Complex(PC)	   ; Offset_0x041DEA
		bne.s	Offset_0x0443A4
		btst	#$03, Obj_Control_Var_08(A0)			 ; $0038
		beq.s	Offset_0x0443A4
		neg.w	Obj_Speed_X(A1)					 ; $0018
		rts
;-------------------------------------------------------------------------------
Offset_0x0443FE:
		jsr		(PseudoRandomNumber).l			 ; Offset_0x001AFA
		move.w	(Random_Seed).w, D0					 ; $FFFFF636
		moveq	#$01, D1
		btst	#$00, D0
		beq.s	Offset_0x044412
		neg.w	D1
Offset_0x044412:
		move.w	D1, Obj_Control_Var_10(A0)				 ; $0040
		andi.w	#$003C, D0
		move.w	D0, Obj_Timer(A0)				 ; $002E
		rts
;-------------------------------------------------------------------------------
Monkey_Dude_Setup_Data:						   ; Offset_0x044420
		dc.l	Monkey_Dude_Mappings		   ; Offset_0x10E716
		dc.w	$2548, $0280
		dc.b	$20, $20, $00, $0B
;-------------------------------------------------------------------------------
Offset_0x04442C:
		dc.w	$0300
		dc.b	$04, $04, $03, $00
;-------------------------------------------------------------------------------
Offset_0x044432:
		dc.w	$A548, $0280
		dc.b	$20, $20, $06, $0B
;-------------------------------------------------------------------------------
Offset_0x04443A:
		dc.l	Monkey_Dude_Mappings		   ; Offset_0x10E716
		dc.w	$0548, $0280
		dc.b	$20, $20, $06, $18
;-------------------------------------------------------------------------------
Offset_0x044446:
		dc.w	$0004
		dc.l	Offset_0x044014
;-------------------------------------------------------------------------------
Offset_0x04444C:
		dc.w	$0004
		dc.l	Offset_0x04400E
;-------------------------------------------------------------------------------
		dc.w	$0000
		dc.l	Offset_0x044014
		dc.w	$0008
		dc.w	$0000
		dc.l	Offset_0x044246
		dc.w	$0000
;-------------------------------------------------------------------------------
Offset_0x044462:
		dc.w	$0000
		dc.l	Object_Settings_Check_X_Y			   ; Offset_0x043B1E
		dc.l	Offset_0x04443A
		dc.l	$00000000
		dc.l	Move_Light_Gravity			   ; Offset_0x0426C2
		dc.b	$00, $00
		dc.w	$FE00, $FC00
;-------------------------------------------------------------------------------
Offset_0x04447A:
		dc.w	$0700, $01FC
;-------------------------------------------------------------------------------
Offset_0x04447E:
		dc.b	$00, $07, $02, $07, $FC
;-------------------------------------------------------------------------------
Offset_0x044483
		dc.b	$08, $0F, $08, $0F, $09, $0F, $0A, $0F
		dc.b	$F8, $0A, $06, $7E, $FC
;===============================================================================
; Objeto 0x83 - Inimigo macaco na Angel Island
; <<<-
;===============================================================================