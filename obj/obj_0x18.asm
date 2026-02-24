;===============================================================================
; Objeto 0x18 - Elevator em forma de xícara na Launch Base
; ->>>
;===============================================================================
; Offset_0x01D916:
		move.l	#Cup_Elevator_Mappings, Obj_Map(A0) ; Offset_0x01DF66, $000C
		move.w	#$440D, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0080, Obj_Priority(A0)				 ; $0008
		move.b	#$20, Obj_Width(A0)				 ; $0007
		move.b	#$10, Obj_Height(A0)					 ; $0006
		move.w	Obj_X(A0), Obj_Control_Var_00(A0)		  ; $0010, $0030
		move.w	Obj_Y(A0), Obj_Control_Var_02(A0)		  ; $0014, $0032
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x01DA02
		move.l	#Offset_0x01DEA8, (A1)
		move.l	#Cup_Elevator_Mappings, Obj_Map(A1) ; Offset_0x01DF66, $000C
		move.w	#$440D, Obj_Art_VRAM(A1)				 ; $000A
		move.b	#$04, Obj_Flags(A1)				 ; $0004
		move.w	#$0100, Obj_Priority(A1)				 ; $0008
		move.b	#$20, Obj_Width(A1)				 ; $0007
		move.b	#$10, Obj_Height(A1)					 ; $0006
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		move.b	#$02, Obj_Map_Id(A1)					 ; $0022
		move.w	A0, Obj_Control_Var_10(A1)				 ; $0040
		move.w	A1, Obj_Control_Var_10(A0)				 ; $0040
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x01DA02
		move.l	#Offset_0x01DEB8, (A1)
		move.l	#Cup_Elevator_Mappings, Obj_Map(A1) ; Offset_0x01DF66, $000C
		move.w	#$440D, Obj_Art_VRAM(A1)				 ; $000A
		move.b	#$04, Obj_Flags(A1)				 ; $0004
		move.w	#$0080, Obj_Priority(A1)				 ; $0008
		move.b	#$20, Obj_Width(A1)				 ; $0007
		move.b	#$10, Obj_Height(A1)					 ; $0006
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_X(A0), Obj_Control_Var_00(A1)		  ; $0010, $0030
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		move.b	#$01, Obj_Map_Id(A1)					 ; $0022
		addi.w	#$0018, Obj_X(A1)				 ; $0010
		btst	#$00, Obj_Status(A0)					 ; $002A
		bne.s	Offset_0x01D9FA
		subi.w	#$0030, Obj_X(A1)				 ; $0010
Offset_0x01D9FA:
		move.w	A0, Obj_Control_Var_10(A1)				 ; $0040
		move.w	A1, Obj_Control_Var_12(A0)				 ; $0042
Offset_0x01DA02:
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		andi.w	#$000F, D0
		lsl.w	#$05, D0
		move.w	D0, D1
		add.w	D0, D0
		add.w	D1, D0
		move.w	D0, Obj_Control_Var_08(A0)				 ; $0038
		move.w	#$0000, Obj_Angle(A0)					 ; $0026
		addi.w	#$0040, Obj_X(A0)				 ; $0010
		btst	#$00, Obj_Status(A0)					 ; $002A
		bne.s	Offset_0x01DA38
		subi.w	#$0080, Obj_X(A0)				 ; $0010
		move.w	#$8080, Obj_Angle(A0)					 ; $0026
Offset_0x01DA38:
		move.b	Obj_Subtype(A0), D1				 ; $002C
		andi.w	#$0070, D1
		beq.s	Offset_0x01DA5E
		move.w	D0, Obj_Control_Var_0A(A0)				 ; $003A
		add.w	D0, Obj_Control_Var_02(A0)				 ; $0032
		move.w	#$0006, Obj_Control_Var_06(A0)			 ; $0036
		btst	#$00, Obj_Subtype(A0)					 ; $002C
		beq.s	Offset_0x01DA5E
		addi.b	#$80, Obj_Flip_Angle(A0)				 ; $0027
Offset_0x01DA5E:
		move.l	#Offset_0x01DA64, (A0)
Offset_0x01DA64:
		bsr.w	Offset_0x01DAC4
		move.w	Obj_X(A0), D4					 ; $0010
		move.b	Obj_Angle(A0), D0				 ; $0026
		jsr		(CalcSine).l					 ; Offset_0x001B20
		asr.w	#$02, D1
		add.w	Obj_Control_Var_00(A0), D1				 ; $0030
		move.w	D1, Obj_X(A0)					 ; $0010
		moveq	#$00, D1
		move.b	Obj_Width(A0), D1				 ; $0007
		addi.w	#$000B, D1
		moveq	#$00, D2
		move.b	Obj_Height(A0), D2				 ; $0006
		move.w	D2, D3
		addq.w	#$01, D3
		lea		Obj_Control_Var_0C(A0), A2				 ; $003C
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		moveq	#$03, D6
		move.w	(Control_Ports_Buffer_Data).w, D0			 ; $FFFFF604
		movem.l D1-D4, -(A7)
		bsr.w	Offset_0x01DD7A
		movem.l (A7)+, D1-D4
		lea		Obj_Control_Var_0D(A0), A2				 ; $003D
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		moveq	#$04, D6
		move.w	(Control_Ports_Buffer_Data+$02).w, D0		 ; $FFFFF606
		bsr.w	Offset_0x01DD7A
		bra.w	Offset_0x01DD18
Offset_0x01DAC4:
		move.w	Obj_Control_Var_06(A0), D0				 ; $0036
		move.w	Offset_0x01DAD0(PC, D0), D1
		jmp		Offset_0x01DAD0(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x01DAD0:
		dc.w	Offset_0x01DAE0-Offset_0x01DAD0
		dc.w	Offset_0x01DAF2-Offset_0x01DAD0
		dc.w	Offset_0x01DB7A-Offset_0x01DAD0
		dc.w	Offset_0x01DAE0-Offset_0x01DAD0
		dc.w	Offset_0x01DB86-Offset_0x01DAD0
		dc.w	Offset_0x01DBF4-Offset_0x01DAD0
		dc.w	Offset_0x01DC02-Offset_0x01DAD0
		dc.w	Offset_0x01DC70-Offset_0x01DAD0
;-------------------------------------------------------------------------------
Offset_0x01DAE0:
		tst.w	Obj_Control_Var_0C(A0)					 ; $003C
		beq.s	Offset_0x01DAF0
		move.w	#$0001, Obj_Control_Var_04(A0)			 ; $0034
		addq.w	#$02, Obj_Control_Var_06(A0)			 ; $0036
Offset_0x01DAF0:
		rts
;-------------------------------------------------------------------------------
Offset_0x01DAF2:
		move.w	Obj_Control_Var_0A(A0), D0				 ; $003A
		cmp.w	Obj_Control_Var_08(A0), D0				 ; $0038
		bne.s	Offset_0x01DB24
		tst.b	Obj_Subtype(A0)					 ; $002C
		bpl.s	Offset_0x01DB12
		move.w	#$000C, Obj_Control_Var_06(A0)			 ; $0036
		move.w	#$0600, Obj_Timer(A0)					 ; $002E
		bra.w	Offset_0x01DC02
Offset_0x01DB12:
		move.w	#$0080, Obj_Priority(A0)				 ; $0008
		move.w	#$0000, Obj_Control_Var_04(A0)			 ; $0034
		addq.w	#$02, Obj_Control_Var_06(A0)			 ; $0036
		rts
Offset_0x01DB24:
		addq.w	#$04, Obj_Control_Var_0A(A0)			 ; $003A
		move.w	Obj_Control_Var_0A(A0), D0				 ; $003A
		move.w	D0, D1
		mulu.w	#$0155, D0
		lsr.w	#$08, D0
		add.b	Obj_Flip_Angle(A0), D0					 ; $0027
		move.b	D0, Obj_Angle(A0)				 ; $0026
		move.w	Obj_Control_Var_02(A0), D0				 ; $0032
		sub.w	D1, D0
		move.w	D0, Obj_Y(A0)					 ; $0014
		cmpi.w	#$0200, Obj_Priority(A0)				 ; $0008
		bne.s	Offset_0x01DB64
		tst.b	Obj_Angle(A0)					 ; $0026
		bpl.s	Offset_0x01DB62
		move.w	#$0080, Obj_Priority(A0)				 ; $0008
		moveq	#Hoverpad_Sfx, D0				  ; -$80
		jsr		(PlaySound).l					; Offset_0x001176
Offset_0x01DB62:
		rts
Offset_0x01DB64:
		tst.b	Obj_Angle(A0)					 ; $0026
		bmi.s	Offset_0x01DB78
		move.w	#$0200, Obj_Priority(A0)				 ; $0008
		moveq	#Hoverpad_Sfx, D0				  ; -$80
		jsr		(PlaySound).l					; Offset_0x001176
Offset_0x01DB78:
		rts
;-------------------------------------------------------------------------------
Offset_0x01DB7A:
		tst.w	Obj_Control_Var_0C(A0)					 ; $003C
		bne.s	Offset_0x01DB84
		addq.w	#$02, Obj_Control_Var_06(A0)			 ; $0036
Offset_0x01DB84:
		rts
;-------------------------------------------------------------------------------
Offset_0x01DB86:
		tst.w	Obj_Control_Var_0A(A0)					 ; $003A
		bne.s	Offset_0x01DB9E
		move.w	#$0080, Obj_Priority(A0)				 ; $0008
		move.w	#$0000, Obj_Control_Var_04(A0)			 ; $0034
		addq.w	#$02, Obj_Control_Var_06(A0)			 ; $0036
		rts
Offset_0x01DB9E:
		subq.w	#$04, Obj_Control_Var_0A(A0)			 ; $003A
		move.w	Obj_Control_Var_0A(A0), D0				 ; $003A
		move.w	D0, D1
		mulu.w	#$0155, D0
		lsr.w	#$08, D0
		add.b	Obj_Flip_Angle(A0), D0					 ; $0027
		move.b	D0, Obj_Angle(A0)				 ; $0026
		move.w	Obj_Control_Var_02(A0), D0				 ; $0032
		sub.w	D1, D0
		move.w	D0, Obj_Y(A0)					 ; $0014
		cmpi.w	#$0200, Obj_Priority(A0)				 ; $0008
		bne.s	Offset_0x01DBDE
		tst.b	Obj_Angle(A0)					 ; $0026
		bpl.s	Offset_0x01DBDC
		move.w	#$0080, Obj_Priority(A0)				 ; $0008
		moveq	#Hoverpad_Sfx, D0				  ; -$80
		jsr		(PlaySound).l					; Offset_0x001176
Offset_0x01DBDC:
		rts
Offset_0x01DBDE:
		tst.b	Obj_Angle(A0)					 ; $0026
		bmi.s	Offset_0x01DBF2
		move.w	#$0200, Obj_Priority(A0)				 ; $0008
		moveq	#Hoverpad_Sfx, D0				  ; -$80
		jsr		(PlaySound).l					; Offset_0x001176
Offset_0x01DBF2:
		rts
;-------------------------------------------------------------------------------
Offset_0x01DBF4:
		tst.w	Obj_Control_Var_0C(A0)					 ; $003C
		bne.s	Offset_0x01DC00
		move.w	#$0000, Obj_Control_Var_06(A0)			 ; $0036
Offset_0x01DC00:
		rts
;-------------------------------------------------------------------------------
Offset_0x01DC02:
		cmpi.w	#$1000, Obj_Timer(A0)					 ; $002E
		bne.s	Offset_0x01DC2E
		move.b	Obj_Angle(A0), D0				 ; $0026
		addi.b	#$40, D0
		cmpi.b	#$F0, D0
		bcs.s	Offset_0x01DC34
		move.b	#$C0, Obj_Angle(A0)				 ; $0026
		move.w	Obj_Control_Var_12(A0), A1				 ; $0042
		move.w	#$7FFF, Obj_Control_Var_00(A1)			 ; $0030
		addq.w	#$02, Obj_Control_Var_06(A0)			 ; $0036
		rts
Offset_0x01DC2E:
		addi.w	#$0010, Obj_Timer(A0)					 ; $002E
Offset_0x01DC34:
		move.b	Obj_Timer(A0), D0				 ; $002E
		add.b	D0, Obj_Angle(A0)				 ; $0026
		cmpi.w	#$0200, Obj_Priority(A0)				 ; $0008
		bne.s	Offset_0x01DC5A
		tst.b	Obj_Angle(A0)					 ; $0026
		bpl.s	Offset_0x01DC58
		move.w	#$0080, Obj_Priority(A0)				 ; $0008
		moveq	#Hoverpad_Sfx, D0				  ; -$80
		jsr		(PlaySound).l					; Offset_0x001176
Offset_0x01DC58:
		rts
Offset_0x01DC5A:
		tst.b	Obj_Angle(A0)					 ; $0026
		bmi.s	Offset_0x01DC6E
		move.w	#$0200, Obj_Priority(A0)				 ; $0008
		moveq	#Hoverpad_Sfx, D0				  ; -$80
		jsr		(PlaySound).l					; Offset_0x001176
Offset_0x01DC6E:
		rts
;-------------------------------------------------------------------------------
Offset_0x01DC70:
		cmpi.w	#$16C0, Obj_Control_Var_00(A0)			 ; $0030
		bcs.s	Offset_0x01DCEC
		move.w	#$16C0, Obj_Control_Var_00(A0)			 ; $0030
		move.w	#$FE00, Obj_Speed_X(A0)					 ; $0018
		move.w	#$0000, Obj_Speed_Y(A0)					 ; $001A
		move.l	#Offset_0x01DCF4, (A0)
		moveq	#Hurt_Sfx, D0					   ; $35
		jsr		(PlaySound).l					; Offset_0x001176
		lea		Obj_Control_Var_0C(A0), A2				 ; $003C
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		move.w	#$FD00, D0
		bsr.s	Offset_0x01DCB2
		lea		Obj_Control_Var_0D(A0), A2				 ; $003D
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		move.w	#$FC00, D0
Offset_0x01DCB2:
		move.b	#$12, $0002(A2)
		tst.b	(A2)
		beq.s	Offset_0x01DCEA
		move.b	#$04, Obj_Routine(A1)					 ; $0005
		bclr	#$03, Obj_Status(A1)					 ; $002A
		bclr	#$05, Obj_Status(A1)					 ; $002A
		bset	#$01, Obj_Status(A1)					 ; $002A
		move.w	D0, Obj_Speed_Y(A1)				 ; $001A
		move.w	#$FE00, Obj_Speed_X(A1)					 ; $0018
		move.w	#$0000, Obj_Inertia(A1)					 ; $001C
		move.b	#$1A, Obj_Ani_Number(A1)				 ; $0020
Offset_0x01DCEA:
		rts
Offset_0x01DCEC:
		addi.w	#$0010, Obj_Control_Var_00(A0)			 ; $0030
		rts
;-------------------------------------------------------------------------------
Offset_0x01DCF4:
		jsr		(ObjectFall)				   ; Offset_0x0110FE
		tst.b	Obj_Flags(A0)					 ; $0004
		bmi.s	Offset_0x01DD06
		move.w	#$7FFF, Obj_X(A0)				 ; $0010
Offset_0x01DD06:
		move.b	(Level_Frame_Count+$01).w, D0		 ; $FFFFFE05
		andi.b	#$01, D0
		beq.s	Offset_0x01DD16
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
Offset_0x01DD16:
		rts
Offset_0x01DD18:
		move.w	Obj_Control_Var_00(A0), D0				 ; $0030
		andi.w	#$FF80, D0
		sub.w	(Camera_X_Left).w, D0				 ; $FFFFF7DA
		cmpi.w	#$0280, D0
		bhi.w	Offset_0x01DD32
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x01DD32:
		move.w	Obj_Respaw_Ref(A0), D0					 ; $0048
		beq.s	Offset_0x01DD3E
		move.w	D0, A2
		bclr	#$07, (A2)
Offset_0x01DD3E:
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		moveq	#$03, D6
		bsr.s	Offset_0x01DD54
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		moveq	#$04, D6
		bsr.s	Offset_0x01DD54
		jmp		(DeleteObject).l				   ; Offset_0x011138
Offset_0x01DD54:
		bclr	D6, Obj_Status(A0)				 ; $002A
		beq.w	Offset_0x01DD78
		move.w	#$0100, Obj_Priority(A1)				 ; $0008
		clr.b	Obj_Timer(A1)					 ; $002E
		bclr	#$03, Obj_Status(A1)					 ; $002A
		bclr	#$05, Obj_Status(A1)					 ; $002A
		bset	#$01, Obj_Status(A1)					 ; $002A
Offset_0x01DD78:
		rts
Offset_0x01DD7A:
		tst.b	(A2)
		bne.s	Offset_0x01DDE0
		tst.b	$0002(A2)
		beq.s	Offset_0x01DD8A
		subq.b	#$01, $0002(A2)
		rts
Offset_0x01DD8A:
		move.b	Obj_Angle(A0), D0				 ; $0026
		subi.b	#$20, D0
		cmpi.b	#$40, D0
		bcs.w	Offset_0x01DEA6
		jsr		(Solid_Object_2_A1).l			   ; Offset_0x0135CC
		btst	D6, Obj_Status(A0)				 ; $002A
		beq.w	Offset_0x01DEA6
		tst.w	Obj_Control_Var_04(A0)					 ; $0034
		bne.s	Offset_0x01DDC6
		move.w	Obj_X(A1), D0					 ; $0010
		sub.w	Obj_X(A0), D0					 ; $0010
		addi.w	#$0008, D0
		bmi.w	Offset_0x01DEA6
		cmpi.w	#$0010, D0
		bcc.w	Offset_0x01DEA6
Offset_0x01DDC6:
		move.b	#$01, (A2)
		move.b	#$01, Obj_Timer(A1)				 ; $002E
		clr.w	Obj_Speed_X(A1)					 ; $0018
		clr.w	Obj_Speed_Y(A1)					 ; $001A
		clr.w	Obj_Inertia(A1)					 ; $001C
		bra.w	Offset_0x01DE7A
Offset_0x01DDE0:
		cmpi.b	#$04, Obj_Routine(A1)					 ; $0005
		bcc.s	Offset_0x01DE60
		andi.b	#$70, D0
		beq.w	Offset_0x01DE7A
		tst.b	(Knuckles_Control_Lock_Flag).w		 ; $FFFFFAA9
		bne.w	Offset_0x01DE7A
		move.w	#$0100, Obj_Priority(A1)				 ; $0008
		clr.b	Obj_Timer(A1)					 ; $002E
		bclr	D6, Obj_Status(A0)				 ; $002A
		bclr	#$03, Obj_Status(A1)					 ; $002A
		bclr	#$05, Obj_Status(A1)					 ; $002A
		bset	#$01, Obj_Status(A1)					 ; $002A
		move.b	#$01, Obj_Control_Var_10(A1)			 ; $0040
		move.b	#$0E, Obj_Height_2(A1)					 ; $001E
		move.b	#$07, Obj_Width_2(A1)					 ; $001F
		move.b	#$02, Obj_Ani_Number(A1)				 ; $0020
		bset	#$02, Obj_Status(A1)					 ; $002A
		move.b	#$00, (A2)
		move.b	#$12, $0002(A2)
		btst	#$0A, D0
		beq.s	Offset_0x01DE4C
		move.w	#$FE00, Obj_Speed_X(A1)					 ; $0018
Offset_0x01DE4C:
		btst	#$0B, D0
		beq.s	Offset_0x01DE58
		move.w	#$0200, Obj_Speed_X(A1)					 ; $0018
Offset_0x01DE58:
		move.w	#$FB80, Obj_Speed_Y(A1)					 ; $001A
		rts
Offset_0x01DE60:
		bclr	D6, Obj_Status(A0)				 ; $002A
		move.w	#$0100, Obj_Priority(A1)				 ; $0008
		clr.b	Obj_Timer(A1)					 ; $002E
		move.b	#$00, (A2)
		move.b	#$3C, $0002(A2)
		rts
Offset_0x01DE7A:
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), D0					 ; $0014
		subi.w	#$0010, D0
		move.w	D0, Obj_Y(A1)					 ; $0014
		move.w	#$0280, Obj_Priority(A1)				 ; $0008
		move.b	Obj_Angle(A0), D0				 ; $0026
		addi.b	#$20, D0
		cmpi.b	#$C0, D0
		bcs.s	Offset_0x01DEA6
		move.w	#$0100, Obj_Priority(A1)				 ; $0008
Offset_0x01DEA6:
		rts
;-------------------------------------------------------------------------------
Offset_0x01DEA8:
		move.w	Obj_Control_Var_10(A0), A1				 ; $0040
		move.w	Obj_Y(A1), Obj_Y(A0)			  ; $0014, $0014
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Offset_0x01DEB8:
		move.w	Obj_Control_Var_10(A0), A1				 ; $0040
		move.w	Obj_Y(A1), Obj_Y(A0)			  ; $0014, $0014
		move.b	Obj_Angle(A1), Obj_Angle(A0)			  ; $0026, $0026
		move.w	#$0180, Obj_Priority(A0)				 ; $0008
		move.b	Obj_Angle(A0), D0				 ; $0026
		bpl.s	Offset_0x01DEDA
		move.w	#$0080, Obj_Priority(A0)				 ; $0008
Offset_0x01DEDA:
		andi.b	#$FE, Obj_Flags(A0)				 ; $0004
		subi.b	#$40, D0
		bpl.s	Offset_0x01DEEC
		ori.b	#$01, Obj_Flags(A0)				 ; $0004
Offset_0x01DEEC:
		move.b	Obj_Angle(A0), D0				 ; $0026
		jsr		(CalcSine).l					 ; Offset_0x001B20
		move.w	D1, D2
		add.w	D1, D1
		add.w	D2, D1
		asr.w	#$05, D1
		add.w	Obj_Control_Var_00(A0), D1				 ; $0030
		move.w	D1, Obj_X(A0)					 ; $0010
		move.w	Obj_Control_Var_00(A0), D0				 ; $0030
		jmp		(MarkObjGone_2).l				   ; Offset_0x011B1A
;===============================================================================
; Objeto 0x18 - Elevator em forma de xícara na Launch Base
; <<<-
;===============================================================================