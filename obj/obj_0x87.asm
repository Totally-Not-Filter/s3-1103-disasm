;===============================================================================
; Objeto 0x87 - Inimigo Snale Blaster na Launch Base
; ->>>
;===============================================================================
; Offset_0x048436:
		jsr		(Object_Check_Range).l		   ; Offset_0x04326E
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x04844E(PC, D0), D1
		jsr		Offset_0x04844E(PC, D1)
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X(PC) ; Offset_0x042B3C
;-------------------------------------------------------------------------------
Offset_0x04844E:
		dc.w	Offset_0x04845C-Offset_0x04844E
		dc.w	Offset_0x04847A-Offset_0x04844E
		dc.w	Offset_0x0484AE-Offset_0x04844E
		dc.w	Offset_0x0484DA-Offset_0x04844E
		dc.w	Offset_0x048532-Offset_0x04844E
		dc.w	Offset_0x04855C-Offset_0x04844E
		dc.w	Offset_0x04857C-Offset_0x04844E
;-------------------------------------------------------------------------------
Offset_0x04845C:
		lea		Snale_Blaster_Setup_Data(PC), A1	   ; Offset_0x0486DA
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.w	#$0020, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x048496, Obj_Child(A0)			 ; $0034
		lea		Offset_0x0486FE(PC), A2
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x04847A:
		move.b	#$1A, Obj_Col_Flags(A0)					 ; $0028
		clr.b	Obj_Col_Prop(A0)				 ; $0029
		btst	#$01, Obj_Control_Var_08(A0)			 ; $0038
		bne.s	Offset_0x048492
		move.b	#$7F, Obj_Col_Prop(A0)					 ; $0029
Offset_0x048492:
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x048496:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x04872A, Obj_Child_Data(A0)			 ; $0030
		move.l	#Offset_0x0484B8, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x0484AE:
		move.b	#$1A, Obj_Col_Flags(A0)					 ; $0028
		jmp		AnimateRaw(PC)				  ; Offset_0x04208E
;-------------------------------------------------------------------------------
Offset_0x0484B8:
		move.w	#$FFFE, Obj_Control_Var_10(A0)			 ; $0040
		move.l	#Offset_0x048734, Obj_Child_Data(A0)			 ; $0030
Offset_0x0484C6:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.b	#$02, Obj_Control_Var_09(A0)			 ; $0039
		bclr	#$01, Obj_Control_Var_08(A0)			 ; $0038
		rts
Offset_0x0484DA:
		move.b	#$1A, Obj_Col_Flags(A0)					 ; $0028
		move.b	#$7F, Obj_Col_Prop(A0)					 ; $0029
		bsr.w	Offset_0x0486B0
		jsr		Animate_Raw_Multi_Delay(PC)			   ; Offset_0x04215C
		tst.w	D2
		beq.s	Offset_0x048510
		moveq	#$03, D0
		tst.w	Obj_Control_Var_10(A0)					 ; $0040
		bmi.s	Offset_0x0484FC
		moveq	#$04, D0
Offset_0x0484FC:
		cmp.b	Obj_Map_Id(A0), D0				 ; $0022
		bne.s	Offset_0x048510
		move.w	Obj_Control_Var_10(A0), D0				 ; $0040
		add.w	D0, Obj_Y(A0)					 ; $0014
		subq.b	#$01, Obj_Control_Var_09(A0)			 ; $0039
		bmi.s	Offset_0x048512
Offset_0x048510:
		rts
Offset_0x048512:
		move.b	#$02, Obj_Routine(A0)					 ; $0005
		move.w	#$0090, Obj_Timer(A0)					 ; $002E
		bset	#$01, Obj_Control_Var_08(A0)			 ; $0038
		move.l	#Offset_0x0484C6, Obj_Child(A0)			 ; $0034
		neg.w	Obj_Control_Var_10(A0)					 ; $0040
		rts
;-------------------------------------------------------------------------------
Offset_0x048532:
		move.b	#$7F, Obj_Col_Prop(A0)					 ; $0029
		subq.b	#$01, Obj_Map_Id(A0)					 ; $0022
		beq.s	Offset_0x048540
		rts
Offset_0x048540:
		move.b	#$0A, Obj_Routine(A0)					 ; $0005
		move.b	#$7F, Obj_Col_Prop(A0)					 ; $0029
		move.w	#$003B, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x048566, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x04855C:
		move.b	#$7F, Obj_Col_Prop(A0)					 ; $0029
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x048566:
		move.b	#$0C, Obj_Routine(A0)					 ; $0005
		move.w	#$000F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x048580, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x04857C:
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x048580:
		move.b	#$1A, Obj_Col_Flags(A0)					 ; $0028
		move.b	#$7F, Obj_Col_Prop(A0)					 ; $0029
		move.w	#$0002, Obj_Timer(A0)					 ; $002E
		addq.b	#$01, Obj_Map_Id(A0)					 ; $0022
		cmpi.b	#$03, Obj_Map_Id(A0)					 ; $0022
		bcs.s	Offset_0x0485A4
		move.b	#$06, Obj_Routine(A0)					 ; $0005
Offset_0x0485A4:
		rts
;-------------------------------------------------------------------------------
Offset_0x0485A6:
		jsr		Refresh_Child_Position_Adjusted(PC)	   ; Offset_0x04203C
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x0485BC(PC, D0), D1
		jsr		Offset_0x0485BC(PC, D1)
		jmp		Child_Display_Or_Delete(PC)			   ; Offset_0x04245C
;-------------------------------------------------------------------------------
Offset_0x0485BC:
		dc.w	Offset_0x0485C2-Offset_0x0485BC
		dc.w	Offset_0x0485CA-Offset_0x0485BC
		dc.w	Animate_Raw_Multi_Delay-Offset_0x0485BC ; Offset_0x04215C
;-------------------------------------------------------------------------------
Offset_0x0485C2:
		lea		Snale_Blaster_Setup_Data_2(PC), A1	   ; Offset_0x0486E6
		jmp		SetupObjectAttributes3(PC)			; Offset_0x041D7A
;-------------------------------------------------------------------------------
Offset_0x0485CA:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$01, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x0485D8
		rts
Offset_0x0485D8:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x048739, Obj_Child_Data(A0)			 ; $0030
		move.l	#Offset_0x0485F0, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x0485F0:
		move.b	#$02, Obj_Routine(A0)					 ; $0005
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		bclr	#$01, Obj_Control_Var_08(A1)			 ; $0038
		rts
;-------------------------------------------------------------------------------
Offset_0x048602:
		jsr		Refresh_Child_Position_Adjusted(PC)	   ; Offset_0x04203C
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x048618(PC, D0), D1
		jsr		Offset_0x048618(PC, D1)
		jmp		Child_Display_Touch_Or_Delete(PC)	   ; Offset_0x042472
;-------------------------------------------------------------------------------
Offset_0x048618:
		dc.w	Offset_0x048620-Offset_0x048618
		dc.w	Offset_0x048628-Offset_0x048618
		dc.w	Offset_0x04865C-Offset_0x048618
		dc.w	Offset_0x04869A-Offset_0x048618
;-------------------------------------------------------------------------------
Offset_0x048620:
		lea		Snale_Blaster_Setup_Data_3(PC), A1	   ; Offset_0x0486EC
		jmp		SetupObjectAttributes3(PC)			; Offset_0x041D7A
;-------------------------------------------------------------------------------
Offset_0x048628:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$01, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x048636
		rts
Offset_0x048636:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x048744, Obj_Child_Data(A0)			 ; $0030
		tst.b	Obj_Subtype(A0)					 ; $002C
		beq.s	Offset_0x048652
		move.l	#Offset_0x04874D, Obj_Child_Data(A0)			 ; $0030
Offset_0x048652:
		move.l	#Offset_0x048692, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x04865C:
		jsr		Animate_Raw_Multi_Delay(PC)			   ; Offset_0x04215C
		tst.w	D2
		beq.s	Offset_0x048690
		bmi.s	Offset_0x048690
		cmpi.b	#$04, Obj_Ani_Frame(A0)					 ; $0023
		bne.s	Offset_0x048690
		lea		Offset_0x048712(PC), A2
		jsr		SetupChildObject_Complex(PC)	   ; Offset_0x041DEA
		move.w	Obj_Child_Ref(A0), A2					 ; $0046
		btst	#$00, Obj_Flags(A2)				 ; $0004
		beq.s	Offset_0x048686
		neg.w	Obj_Speed_X(A1)					 ; $0018
Offset_0x048686:
		tst.b	Obj_Subtype(A0)					 ; $002C
		beq.s	Offset_0x048690
		neg.w	Obj_Speed_Y(A1)					 ; $001A
Offset_0x048690:
		rts
;-------------------------------------------------------------------------------
Offset_0x048692:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		rts
;-------------------------------------------------------------------------------
Offset_0x04869A:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$01, Obj_Control_Var_08(A1)			 ; $0038
		beq.s	Offset_0x0486A8
		rts
Offset_0x0486A8:
		move.b	#$02, Obj_Routine(A0)					 ; $0005
		rts
;-------------------------------------------------------------------------------
Offset_0x0486B0:
		jsr		Find_Player(PC)				   ; Offset_0x042634
		cmpi.w	#$0030, D2
		bcc.s	Offset_0x0486C8
		cmpi.w	#$0030, D3
		bcc.s	Offset_0x0486C8
		cmpi.b	#$02, Obj_Ani_Number(A1)				 ; $0020
		beq.s	Offset_0x0486CA
Offset_0x0486C8:
		rts
Offset_0x0486CA:
		move.b	#$08, Obj_Routine(A0)					 ; $0005
		move.b	#$03, Obj_Map_Id(A0)					 ; $0022
		addq.w	#$04, A7
		rts
;-------------------------------------------------------------------------------
Snale_Blaster_Setup_Data:					   ; Offset_0x0486DA
		dc.l	Snale_Blaster_Mappings		   ; Offset_0x10D3C8
		dc.w	$2524, $0200
		dc.b	$10, $10, $00, $0B
;-------------------------------------------------------------------------------
Snale_Blaster_Setup_Data_2:					   ; Offset_0x0486E6
		dc.w	$0180
		dc.b	$04, $0C, $05, $00
;-------------------------------------------------------------------------------
Snale_Blaster_Setup_Data_3:					   ; Offset_0x0486EC
		dc.w	$0200
		dc.b	$04, $04, $07, $00
;-------------------------------------------------------------------------------
Snale_Blaster_Setup_Data_4:					   ; Offset_0x0486F2
		dc.l	Snale_Blaster_Mappings		   ; Offset_0x10D3C8
		dc.w	$8524, $0200
		dc.b	$04, $04, $09, $98
;-------------------------------------------------------------------------------
Offset_0x0486FE:
		dc.w	$0002
		dc.l	Offset_0x048602
		dc.b	$F8, $00
		dc.l	Offset_0x048602
		dc.b	$F8, $07
		dc.l	Offset_0x0485A6
		dc.b	$F8, $04
;-------------------------------------------------------------------------------
Offset_0x048712:
		dc.w	$0000
		dc.l	Object_Settings_Check_X_Y			   ; Offset_0x043B1E
		dc.l	Snale_Blaster_Setup_Data_4			   ; Offset_0x0486F2
		dc.l	$00000000
		dc.l	SpeedToPos					   ; Offset_0x01111E
		dc.b	$00, $00
		dc.w	$FE00, $FF00
;-------------------------------------------------------------------------------
Offset_0x04872A:
		dc.b	$05, $00, $01, $02, $03, $04, $04, $04
		dc.b	$04, $F4
;-------------------------------------------------------------------------------
Offset_0x048734:
		dc.b	$04, $0F, $03, $0F, $FC
;-------------------------------------------------------------------------------
Offset_0x048739:
		dc.b	$05, $02, $06, $02, $0A, $5F, $06, $02
		dc.b	$05, $02, $F4
;-------------------------------------------------------------------------------
Offset_0x048744:
		dc.b	$07, $02, $07, $1F, $08, $03, $07, $00
		dc.b	$F4
;-------------------------------------------------------------------------------
Offset_0x04874D:
		dc.b	$07, $02, $07, $2F, $08, $03, $07, $00
		dc.b	$F4
;===============================================================================
; Objeto 0x87 - Inimigo Snale Blaster na Launch Base
; <<<-
;===============================================================================