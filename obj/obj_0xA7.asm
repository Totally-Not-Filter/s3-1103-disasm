;===============================================================================
; Objeto 0xA7 - Inimigo Blaster na Flying Battery
; ->>>
;===============================================================================
; Offset_0x04611C:
		jsr		(Object_Check_Range).l		   ; Offset_0x04326E
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x046134(PC, D0), D1
		jsr		Offset_0x046134(PC, D1)
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X(PC) ; Offset_0x042B3C
;-------------------------------------------------------------------------------
Offset_0x046134:
		dc.w	Offset_0x046144-Offset_0x046134
		dc.w	Offset_0x04618C-Offset_0x046134
		dc.w	Offset_0x0461F6-Offset_0x046134
		dc.w	Offset_0x0461F6-Offset_0x046134
		dc.w	Offset_0x04623C-Offset_0x046134
		dc.w	Offset_0x04625E-Offset_0x046134
		dc.w	Offset_0x046286-Offset_0x046134
		dc.w	Offset_0x046296-Offset_0x046134
;-------------------------------------------------------------------------------
Offset_0x046144:
		lea		Blaster_Setup_Data(PC), A1			   ; Offset_0x046312
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.b	#$10, Obj_Height_2(A0)					 ; $001E
		bset	#$01, Obj_Flags(A0)				 ; $0004
		bclr	#$01, Obj_Flags(A0)				 ; $0004
		beq.s	Offset_0x046164
		st		Obj_Control_Var_0C(A0)					 ; $003C
Offset_0x046164:
		move.b	#$0E, Obj_Height_2(A0)					 ; $001E
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		add.w	D0, D0
		move.w	D0, Obj_Timer(A0)				 ; $002E
		add.w	D0, D0
		move.w	D0, Obj_Control_Var_0A(A0)				 ; $003A
		move.l	#Offset_0x0461E0, Obj_Child(A0)			 ; $0034
		move.w	#$FF80, D4
		jmp		Set_Velocity_X_Track_Player_One(PC)	   ; Offset_0x042E4C
;-------------------------------------------------------------------------------
Offset_0x04618C:
		bsr.w	Offset_0x0462EE
		jsr		Find_Player(PC)				   ; Offset_0x042634
		cmpi.w	#$0060, D2
		bcc.s	Offset_0x0461A8
		btst	#$00, Obj_Flags(A0)				 ; $0004
		beq.s	Offset_0x0461A4
		subq.w	#$02, D0
Offset_0x0461A4:
		tst.w	D0
		beq.s	Offset_0x0461BE
Offset_0x0461A8:
		lea		Offset_0x046374(PC), A1
		jsr		Animate_Raw_Multi_Delay_A1(PC)		   ; Offset_0x042160
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jsr		Run_Object_Hit_Floor_D3_A0(PC)		   ; Offset_0x0423F8
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
Offset_0x0461BE:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.b	#$00, Obj_Map_Id(A0)					 ; $0022
		move.w	Obj_Timer(A0), Obj_Control_Var_0A(A0)	  ; $002E, $003A
		move.w	#$0010, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x04621E, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x0461E0:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.w	#$0020, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x0461FE, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x0461F6:
		bsr.w	Offset_0x0462EE
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x0461FE:
		neg.w	Obj_Speed_X(A0)					 ; $0018
		bchg	#00, Obj_Flags(A0)				 ; $0004
Offset_0x046208:
		move.b	#$02, Obj_Routine(A0)					 ; $0005
		move.w	Obj_Control_Var_0A(A0), Obj_Timer(A0)	  ; $003A, $002E
		move.l	#Offset_0x0461E0, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x04621E:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x046208, Obj_Child(A0)			 ; $0034
		lea		Offset_0x04633C(PC), A2
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
		lea		Offset_0x046344(PC), A2
		jmp		Load_Child_Object_Complex_Adjusted_A2(PC) ; Offset_0x041EE0
;-------------------------------------------------------------------------------
Offset_0x04623C:
		bsr.w	Offset_0x0462EE
		lea		Offset_0x04637E(PC), A1
		jsr		Animate_Raw_Multi_Delay_A1(PC)		   ; Offset_0x042160
		tst.w	D2
		beq.s	Offset_0x04625C
		cmpi.b	#$06, Obj_Ani_Frame(A0)					 ; $0023
		bne.s	Offset_0x04625C
		lea		Offset_0x04635C(PC), A2
		jsr		Load_Child_Object_Complex_Adjusted_A2(PC) ; Offset_0x041EE0
Offset_0x04625C:
		rts
;-------------------------------------------------------------------------------
Offset_0x04625E:
		addi.w	#$FFE0, Obj_Speed_Y(A0)					 ; $001A
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jsr		(Object_HitCeiling).l			   ; Offset_0x009FB4
		tst.w	D1
		bmi.s	Offset_0x046276
		rts
Offset_0x046276:
		add.w	D1, Obj_Y(A0)					 ; $0014
		move.b	#$0C, Obj_Routine(A0)					 ; $0005
		clr.w	Obj_Speed_Y(A0)					 ; $001A
		rts
;-------------------------------------------------------------------------------
Offset_0x046286:
		tst.b	(Boss_Attack_Started).w				 ; $FFFFFAA2
		beq.s	Offset_0x04628E
		rts
Offset_0x04628E:
		move.b	#$0E, Obj_Routine(A0)					 ; $0005
		rts
;-------------------------------------------------------------------------------
Offset_0x046296:
		addi.w	#$0020, Obj_Speed_Y(A0)					 ; $001A
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jsr		(ObjHitFloor).l				   ; Offset_0x009D84
		tst.w	D1
		bmi.s	Offset_0x0462AE
		rts
Offset_0x0462AE:
		add.w	D1, Obj_Y(A0)					 ; $0014
		move.b	Obj_Control_Var_0D(A0), Obj_Routine(A0)	  ; $003D, $0005
		move.w	Obj_Control_Var_0E(A0), Obj_Speed_X(A0)	  ; $003E, $0018
		clr.w	Obj_Speed_Y(A0)					 ; $001A
		rts
;-------------------------------------------------------------------------------
Offset_0x0462C4:
		lea		Blaster_Setup_Data_2(PC), A1		   ; Offset_0x04631E
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.l	#Offset_0x0462DC, (A0)
		move.l	#Go_Delete_Object_A0, Obj_Child(A0) ; Offset_0x042D3E, $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x0462DC:
		jsr		Refresh_Child_Position_Adjusted(PC)	   ; Offset_0x04203C
		lea		Offset_0x046379(PC), A1
		jsr		Animate_Raw_A1(PC)			   ; Offset_0x042092
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Offset_0x0462EE:
		tst.b	Obj_Control_Var_0C(A0)					 ; $003C
		beq.s	Offset_0x046310
		tst.b	(Boss_Attack_Started).w				 ; $FFFFFAA2
		beq.s	Offset_0x046310
		move.b	Obj_Routine(A0), Obj_Control_Var_0D(A0)	  ; $0005, $003D
		move.b	#$0A, Obj_Routine(A0)					 ; $0005
		move.w	Obj_Speed_X(A0), Obj_Control_Var_0E(A0)	  ; $0018, $003E
		clr.w	Obj_Speed_X(A0)					 ; $0018
Offset_0x046310:
		rts
;-------------------------------------------------------------------------------
Blaster_Setup_Data:							   ; Offset_0x046312
		dc.l	Blaster_Mappings			   ; Offset_0x10ED62
		dc.w	$A500, $0280
		dc.b	$18, $10, $00, $0A
;-------------------------------------------------------------------------------
Blaster_Setup_Data_2:						   ; Offset_0x04631E
		dc.w	$0200
		dc.b	$08, $08, $04, $00
;-------------------------------------------------------------------------------
Blaster_Setup_Data_3:						   ; Offset_0x046324
		dc.l	Blaster_Mappings			   ; Offset_0x10ED62
		dc.w	$A500, $0280
		dc.b	$04, $04, $05, $18
;-------------------------------------------------------------------------------
Blaster_Setup_Data_4:						   ; Offset_0x046330
		dc.l	Blaster_Mappings			   ; Offset_0x10ED62
		dc.w	$A500, $0200
		dc.b	$04, $04, $07, $00
;-------------------------------------------------------------------------------
Offset_0x04633C:
		dc.w	$0000
		dc.l	Offset_0x0462C4
		dc.b	$E5, $EA
;-------------------------------------------------------------------------------
Offset_0x046344:
		dc.w	$0000
		dc.l	Object_Settings_Check_X_Y			   ; Offset_0x043B1E
		dc.l	Blaster_Setup_Data_3		   ; Offset_0x046324
		dc.l	Offset_0x046387
		dc.l	ObjectFall_Animate_Raw		   ; Offset_0x042F5C
		dc.b	$E0, $E0
		dc.w	$FE00, $FC00
;-------------------------------------------------------------------------------
Offset_0x04635C:
		dc.w	$0000
		dc.l	Object_Settings_Check_X_Y			   ; Offset_0x043B1E
		dc.l	Blaster_Setup_Data_4		   ; Offset_0x046330
		dc.l	Offset_0x04638B
		dc.l	ObjectFall_Animate_Raw		   ; Offset_0x042F5C
		dc.b	$F4, $FC
		dc.w	$0100, $FE00
;-------------------------------------------------------------------------------
Offset_0x046374:
		dc.b	$00, $17, $01, $02, $FC
;-------------------------------------------------------------------------------
Offset_0x046379:
		dc.b	$00, $04, $04, $05, $F4
;-------------------------------------------------------------------------------
Offset_0x04637E:
		dc.b	$00, $01, $00, $01, $02, $05, $00, $1F
		dc.b	$F4
;-------------------------------------------------------------------------------
Offset_0x046387:
		dc.b	$01, $05, $06, $FC
;-------------------------------------------------------------------------------
Offset_0x04638B:
		dc.b	$02, $07, $08, $09, $0A, $FC, $00
;===============================================================================
; Objeto 0xA7 - Inimigo Blaster na Flying Battery
; <<<-
;===============================================================================