;===============================================================================
; Objeto 0xA8 - Inimigo Techno Squeek na Flying Battery
; ->>>
;===============================================================================
; Offset_0x046392:
		jsr		(Object_Check_Range).l		   ; Offset_0x04326E
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x0463AA(PC, D0), D1
		jsr		Offset_0x0463AA(PC, D1)
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X(PC) ; Offset_0x042B3C
;-------------------------------------------------------------------------------
Offset_0x0463AA:
		dc.w	Offset_0x0463B4-Offset_0x0463AA
		dc.w	Offset_0x04644E-Offset_0x0463AA
		dc.w	Offset_0x0464A0-Offset_0x0463AA
		dc.w	Offset_0x0464CE-Offset_0x0463AA
		dc.w	Offset_0x046512-Offset_0x0463AA
;-------------------------------------------------------------------------------
Offset_0x0463B4:
		move.w	#$0800, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x046498, Obj_Child(A0)			 ; $0034
		cmpi.b	#$04, Obj_Subtype(A0)					 ; $002C
		beq.s	Offset_0x046410
		lea		Techno_Squeek_Setup_Data(PC), A1	   ; Offset_0x0465CC
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.l	#Offset_0x0465F2, Obj_Child_Data(A0)			 ; $0030
		bset	#$00, Obj_Flags(A0)				 ; $0004
		cmpi.b	#$02, Obj_Subtype(A0)					 ; $002C
		bne.s	Offset_0x0463EE
		bset	#$01, Obj_Flags(A0)				 ; $0004
Offset_0x0463EE:
		lea		Offset_0x0465EA(PC), A2
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
		move.w	#$0400, D0
		move.w	D0, Obj_Control_Var_0A(A0)				 ; $003A
		move.w	D0, Obj_Speed_X(A0)				 ; $0018
		move.w	#$0020, Obj_Control_Var_0C(A0)			 ; $003C
		bclr	#$03, Obj_Control_Var_08(A0)			 ; $0038
		rts
Offset_0x046410:
		lea		Techno_Squeek_Setup_Data_2(PC), A1	   ; Offset_0x0465D8
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x046618, Obj_Child_Data(A0)			 ; $0030
		bset	#$01, Obj_Flags(A0)				 ; $0004
		lea		Offset_0x0465EA(PC), A2
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
		move.w	#$0400, D0
		move.w	D0, Obj_Control_Var_0E(A0)				 ; $003E
		move.w	D0, Obj_Speed_Y(A0)				 ; $001A
		move.w	#$0020, Obj_Control_Var_10(A0)			 ; $0040
		bclr	#$00, Obj_Control_Var_08(A0)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x04644E:
		jsr		Animate_Raw_Multi_Delay_Flip_X(PC)	   ; Offset_0x0421CE
		tst.w	D2
		beq.s	Offset_0x046464
		cmpi.b	#$06, Obj_Ani_Frame(A0)					 ; $0023
		bne.s	Offset_0x046464
		bset	#$01, Obj_Control_Var_08(A0)			 ; $0038
Offset_0x046464:
		jsr		Swing_Left_And_Right(PC)			   ; Offset_0x042372
		tst.w	Obj_Speed_X(A0)					 ; $0018
		beq.s	Offset_0x046478
		jsr		(SpeedToPos)				   ; Offset_0x01111E
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
Offset_0x046478:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x046608, Obj_Child_Data(A0)			 ; $0030
		move.l	#Offset_0x0464A4, Obj_Child(A0)			 ; $0034
Offset_0x04648E:
		clr.b	Obj_Ani_Frame(A0)				 ; $0023
		clr.b	Obj_Ani_Time(A0)				 ; $0024
		rts
;-------------------------------------------------------------------------------
Offset_0x046498:
		bclr	#$05, Obj_Control_Var_08(A0)			 ; $0038
Offset_0x04649E:
		rts
;-------------------------------------------------------------------------------
Offset_0x0464A0:
		jmp		Animate_Raw_Adjust_Flip_X(PC)		   ; Offset_0x0420F2
;-------------------------------------------------------------------------------
Offset_0x0464A4:
		move.b	#$02, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x0465FD, Obj_Child_Data(A0)			 ; $0030
Offset_0x0464B2:
		bclr	#$01, Obj_Control_Var_08(A0)			 ; $0038
		bset	#$05, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$0010, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x046498, Obj_Child(A0)			 ; $0034
		bra.s	Offset_0x04648E
;-------------------------------------------------------------------------------
Offset_0x0464CE:
		jsr		Animate_Raw_Multi_Delay_Flip_Y(PC)	   ; Offset_0x04220A
		tst.w	D2
		beq.s	Offset_0x0464E4
		cmpi.b	#$06, Obj_Ani_Frame(A0)					 ; $0023
		bne.s	Offset_0x0464E4
		bset	#$01, Obj_Control_Var_08(A0)			 ; $0038
Offset_0x0464E4:
		jsr		Swing_Up_And_Down(PC)		   ; Offset_0x04232E
		tst.w	Obj_Speed_Y(A0)					 ; $001A
		beq.s	Offset_0x0464F8
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
Offset_0x0464F8:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x04662E, Obj_Child_Data(A0)			 ; $0030
		move.l	#Offset_0x046516, Obj_Child(A0)			 ; $0034
		bra.w	Offset_0x04648E
;-------------------------------------------------------------------------------
Offset_0x046512:
		jmp		Animate_Raw_Adjust_Flip_Y(PC)		   ; Offset_0x042126
;-------------------------------------------------------------------------------
Offset_0x046516:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x046623, Obj_Child_Data(A0)			 ; $0030
		bra.s	Offset_0x0464B2
;-------------------------------------------------------------------------------
Offset_0x046526:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x046538(PC, D0), D1
		jsr		Offset_0x046538(PC, D1)
		jmp		Child_Display_Or_Delete(PC)			   ; Offset_0x04245C
;-------------------------------------------------------------------------------
Offset_0x046538:
		dc.w	Offset_0x04653E-Offset_0x046538
		dc.w	Offset_0x04655A-Offset_0x046538
		dc.w	Offset_0x046592-Offset_0x046538
;-------------------------------------------------------------------------------
Offset_0x04653E:
		lea		Techno_Squeek_Setup_Data_3(PC), A1	   ; Offset_0x0465E4
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		cmpi.b	#$04, Obj_Subtype(A1)					 ; $002C
		bne.s	Offset_0x046558
		move.b	#$04, Obj_Routine(A0)					 ; $0005
Offset_0x046558:
		rts
;-------------------------------------------------------------------------------
Offset_0x04655A:
		lea		Offset_0x046613(PC), A1
		jsr		Animate_Raw_A1(PC)			   ; Offset_0x042092
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		moveq	#$00, D0
		move.b	Obj_Map_Id(A1), D0				 ; $0022
		btst	#$01, Obj_Control_Var_08(A1)			 ; $0038
		beq.s	Offset_0x046576
		moveq	#$02, D0
Offset_0x046576:
		add.w	D0, D0
		move.w	Offset_0x04658C(PC, D0), Obj_Control_Var_12(A0)	 ; $0042
		btst	#$05, Obj_Control_Var_08(A1)			 ; $0038
		bne.w	Offset_0x04649E
		jmp		Refresh_Child_Position_Adjusted(PC)	   ; Offset_0x04203C
;-------------------------------------------------------------------------------
Offset_0x04658C:
		dc.b	$14, $04, $0C, $04, $00, $04
;-------------------------------------------------------------------------------
Offset_0x046592:
		lea		Offset_0x046639(PC), A1
		jsr		Animate_Raw_A1(PC)			   ; Offset_0x042092
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		moveq	#$00, D0
		move.b	Obj_Map_Id(A1), D0				 ; $0022
		subq.w	#$05, D0
		btst	#$01, Obj_Control_Var_08(A1)			 ; $0038
		beq.s	Offset_0x0465B0
		moveq	#$02, D0
Offset_0x0465B0:
		add.w	D0, D0
		move.w	Offset_0x0465C6(PC, D0), Obj_Control_Var_12(A0)	 ; $0042
		btst	#$05, Obj_Control_Var_08(A1)			 ; $0038
		bne.w	Offset_0x04649E
		jmp		Refresh_Child_Position_Adjusted(PC)	   ; Offset_0x04203C
;-------------------------------------------------------------------------------
Offset_0x0465C6:
		dc.w	$FC14, $FC0C, $FC00
;-------------------------------------------------------------------------------
Techno_Squeek_Setup_Data:					   ; Offset_0x0465CC
		dc.l	Techno_Squeek_Mappings		   ; Offset_0x10EF02
		dc.w	$A528, $0280
		dc.b	$0C, $08, $00, $0B
;-------------------------------------------------------------------------------
Techno_Squeek_Setup_Data_2:					   ; Offset_0x0465D8
		dc.l	Techno_Squeek_Mappings		   ; Offset_0x10EF02
		dc.w	$A528, $0280
		dc.b	$08, $0C, $05, $0B
;-------------------------------------------------------------------------------
Techno_Squeek_Setup_Data_3:					   ; Offset_0x0465E4
		dc.w	$0280
		dc.b	$08, $04, $02, $00
;-------------------------------------------------------------------------------
Offset_0x0465EA:
		dc.w	$0000
		dc.l	Offset_0x046526
		dc.b	$14, $04
;-------------------------------------------------------------------------------
Offset_0x0465F2:
		dc.b	$00, $00, $00, $17, $01, $01, $41, $01
		dc.b	$00, $1F, $F4
;-------------------------------------------------------------------------------
Offset_0x0465FD:
		dc.b	$00, $00, $00, $37, $01, $01, $41, $01
		dc.b	$00, $1F, $F4
;-------------------------------------------------------------------------------
Offset_0x046608:
		dc.b	$03, $00, $00, $01, $41, $00, $00, $01
		dc.b	$41, $00, $F4
;-------------------------------------------------------------------------------
Offset_0x046613:
		dc.b	$03, $02, $03, $04, $FC
;-------------------------------------------------------------------------------
Offset_0x046618:
		dc.b	$05, $00, $05, $17, $06, $01, $26, $01
		dc.b	$00, $1F, $F4
;-------------------------------------------------------------------------------
Offset_0x046623:
		dc.b	$05, $00, $05, $37, $06, $01, $26, $01
		dc.b	$05, $1F, $F4
;-------------------------------------------------------------------------------
Offset_0x04662E:
		dc.b	$03, $05, $05, $06, $26, $05, $05, $06
		dc.b	$26, $05, $F4
;-------------------------------------------------------------------------------
Offset_0x046639:
		dc.b	$03, $07, $08, $09, $FC
;===============================================================================
; Objeto 0xA8 - Inimigo Techno Squeek na Flying Battery
; <<<-
;===============================================================================