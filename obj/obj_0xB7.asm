;===============================================================================
; Objeto 0xB7 - Nave do Robotnik usada pelo Sonic / Miles na Launch Base 2
; ->>>
;===============================================================================
; Offset_0x0493CC:
		lea		Egg_Mobile_Setup_Data(PC), A1		   ; Offset_0x0495AE
		jsr		(SetupObjectAttributes).l				 ; Offset_0x041D72
		move.l	#Offset_0x0493E8, (A0)
		move.w	Obj_Y(A0), Obj_Control_Var_0A(A0)		  ; $0014, $003A
		bset	#$00, Obj_Flags(A0)				 ; $0004
Offset_0x0493E8:
		moveq	#$00, D0
		move.b	Obj_Boss_Hit(A0), D0					 ; $0029
		beq.s	Offset_0x049440
		clr.b	Obj_Boss_Hit(A0)				 ; $0029
		cmpi.b	#$02, D0
		beq.s	Offset_0x049440
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		tst.b	Obj_Timer(A1)					 ; $002E
		bne.s	Offset_0x049440
		move.b	#$81, Obj_Timer(A1)				 ; $002E
		bclr	#$00, Obj_Status(A1)					 ; $002A
		move.b	#$00, Obj_Ani_Number(A1)				 ; $0020
		move.l	#Offset_0x049444, (A0)
		jsr		(Swing_Setup).l				   ; Offset_0x03669A
		move.w	#$0100, Obj_Speed_X(A0)					 ; $0018
		move.w	#$01DF, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x04945E, Obj_Child(A0)			 ; $0034
		lea		(LBz_Robotnik_Ship_Data_2).l, A2		   ; Offset_0x03659E
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
Offset_0x049440:
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X(PC) ; Offset_0x042B3C
;-------------------------------------------------------------------------------
Offset_0x049444:
		jsr		(Swing_Up_And_Down).l			   ; Offset_0x04232E
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		bsr.w	Offset_0x049592
		jsr		(Run_Object_Wait_Timer_A0).l			   ; Offset_0x0423D2
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X(PC) ; Offset_0x042B3C
;-------------------------------------------------------------------------------
Offset_0x04945E:
		move.w	#$003F, Obj_Timer(A0)					 ; $002E
		clr.w	Obj_Speed_X(A0)					 ; $0018
		move.l	#Offset_0x049472, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x049472:
		move.l	#Offset_0x049480, (A0)
		move.w	#$0100, Obj_Speed_X(A0)					 ; $0018
		rts
;-------------------------------------------------------------------------------
Offset_0x049480:
		jsr		(Swing_Up_And_Down).l			   ; Offset_0x04232E
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		bsr.w	Offset_0x049592
		move.w	(Obj_Knuckles_Mem_Address).w, A1			 ; $FFFFFAA4
		move.w	Obj_X(A1), D0					 ; $0010
		sub.w	Obj_X(A0), D0					 ; $0010
		cmpi.w	#$0050, D0
		bcc.s	Offset_0x0494BC
		bset	#$01, Obj_Control_Var_08(A1)			 ; $0038
		move.l	#Offset_0x049444, (A0)
		move.w	#$001F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x0494C0, Obj_Child(A0)			 ; $0034
Offset_0x0494BC:
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X(PC) ; Offset_0x042B3C
;-------------------------------------------------------------------------------
Offset_0x0494C0:
		move.l	#Offset_0x0494D4, (A0)
		move.w	#$FE00, Obj_Speed_X(A0)					 ; $0018
		move.w	#$FE00, Obj_Speed_Y(A0)					 ; $001A
		rts
;-------------------------------------------------------------------------------
Offset_0x0494D4:
		jsr		(Move_Light_Gravity).l		   ; Offset_0x0426C2
		bsr.w	Offset_0x049592
		tst.w	Obj_Speed_Y(A0)					 ; $001A
		bmi.s	Offset_0x049514
		move.w	Obj_Y(A0), D0					 ; $0014
		cmp.w	Obj_Control_Var_0A(A0), D0				 ; $003A
		bcs.s	Offset_0x049514
		move.l	#Offset_0x049444, (A0)
		st		(Boss_Attack_Started).w				 ; $FFFFFAA2
		st		(Earthquake_Flag).w					 ; $FFFFEECC
		clr.w	Obj_Speed_X(A0)					 ; $0018
		move.w	#$00FF, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x049532, Obj_Child(A0)				   ; $0034
		jsr		(Swing_Setup).l				   ; Offset_0x03669A
Offset_0x049514:
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X(PC) ; Offset_0x042B3C
;-------------------------------------------------------------------------------
; Offset_0x049518:
		jsr		(Swing_Up_And_Down).l			   ; Offset_0x04232E
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		bsr.w	Offset_0x049592
		jsr		(Run_Object_Wait_Timer_A0).l			   ; Offset_0x0423D2
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X(PC) ; Offset_0x042B3C
;-------------------------------------------------------------------------------
Offset_0x049532:
		move.l	#Offset_0x049444, (A0)
		move.w	#$0100, Obj_Speed_X(A0)					 ; $0018
		move.w	#$017F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x04954E, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x04954E:
		move.l	#Offset_0x04955A, (A0)
		clr.w	Obj_Speed_X(A0)					 ; $0018
		rts
;-------------------------------------------------------------------------------
Offset_0x04955A:
		jsr		(Swing_Up_And_Down).l			   ; Offset_0x04232E
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		bsr.w	Offset_0x049592
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X(PC) ; Offset_0x042B3C
;-------------------------------------------------------------------------------
; Offset_0x04956E:
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		clr.b	Obj_Timer(A1)					 ; $002E
		bset	#$01, Obj_Status(A1)					 ; $002A
		move.w	#$0400, Obj_Speed_X(A1)					 ; $0018
		move.w	#$FA00, Obj_Speed_Y(A1)					 ; $001A
		move.b	#$02, Obj_Ani_Number(A1)				 ; $0020
		clr.b	Obj_Control_Var_10(A1)					 ; $0040
Offset_0x049592:
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		move.w	Obj_X(A0), D0					 ; $0010
		subq.w	#$04, D0
		move.w	D0, Obj_X(A1)					 ; $0010
		move.w	Obj_Y(A0), D0					 ; $0014
		subi.w	#$0012, D0
		move.w	D0, Obj_Y(A1)					 ; $0014
		rts
;-------------------------------------------------------------------------------
Egg_Mobile_Setup_Data:						   ; Offset_0x0495AE
		dc.l	Robotnik_Ship_Mappings		   ; Offset_0x10D020
		dc.w	$852E, $0080
		dc.b	$20, $20, $0A, $D7
;-------------------------------------------------------------------------------
; Offset_0x0495BA:
		dc.w	$0000
		dc.l	Obj_0xB7_LBz_Egg_Mobile		   ; Offset_0x0493CC
		dc.b	$00, $00
;-------------------------------------------------------------------------------
; Offset_0x0495C2:
		dc.b	$00, $05, $01, $05, $02, $05, $03, $05
		dc.b	$FC, $00
;===============================================================================
; Objeto 0xB7 - Nave do Robotnik usada pelo Sonic / Miles na Launch Base 2
; <<<-
;===============================================================================