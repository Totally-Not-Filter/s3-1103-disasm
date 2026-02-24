;===============================================================================
; Objeto 0xBD - Plataforma balançando na Icecap
; ->>>
;===============================================================================
; Offset_0x047336:
		lea		Swinging_Platform_Setup_Data(PC), A1   ; Offset_0x04776A
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.l	#Offset_0x047352, (A0)
		lea		Offset_0x047796(PC), A2
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
		move.w	A1, Obj_Child_Ref(A0)					 ; $0046
		rts
;-------------------------------------------------------------------------------
Offset_0x047352:
		btst	#$03, Obj_Control_Var_08(A0)			 ; $0038
		beq.s	Offset_0x04736E
		move.l	#Offset_0x047372, (A0)
		btst	#$00, Obj_Flags(A0)				 ; $0004
		beq.s	Offset_0x04736E
		move.l	#Offset_0x0473FC, (A0)
Offset_0x04736E:
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X_2(PC) ; Offset_0x042B5C
;-------------------------------------------------------------------------------
Offset_0x047372:
		move.w	Obj_Control_Var_0E(A0), D0				 ; $003E
		subi.w	#$0010, D0
		move.w	D0, Obj_Control_Var_0E(A0)				 ; $003E
		move.w	Obj_Control_Var_0C(A0), D1				 ; $003C
		add.w	D0, D1
		scc		D2
		tst.w	D0
		bpl.s	Offset_0x04738E
		tst.b	D2
		bne.s	Offset_0x0473B4
Offset_0x04738E:
		move.w	D1, Obj_Control_Var_0C(A0)				 ; $003C
		tst.b	Obj_Subtype(A0)					 ; $002C
		beq.s	Offset_0x0473A4
		cmpi.w	#$4800, D1
		bcs.s	Offset_0x0473A4
		cmpi.w	#$0200, D0
		bcc.s	Offset_0x0473CE
Offset_0x0473A4:
		cmpi.w	#$6E00, D1
		bcc.s	Offset_0x0473B0
		moveq	#$01, D2
		jsr		Move_Sprite_Circular_Simple(PC)		   ; Offset_0x0426E2
Offset_0x0473B0:
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X_2(PC) ; Offset_0x042B5C
Offset_0x0473B4:
		move.l	#Offset_0x047352, (A0)
		bclr	#$03, Obj_Control_Var_08(A0)			 ; $0038
		clr.w	Obj_Control_Var_0C(A0)					 ; $003C
		moveq	#$01, D2
		jsr		Move_Sprite_Circular_Simple(PC)		   ; Offset_0x0426E2
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X_2(PC) ; Offset_0x042B5C
Offset_0x0473CE:
		move.l	#Offset_0x04743E, (A0)
		bset	#$02, Obj_Control_Var_08(A0)			 ; $0038
		move.b	#$10, Obj_Height_2(A0)					 ; $001E
		move.w	#$0400, D0
		btst	#$00, Obj_Flags(A0)				 ; $0004
		beq.s	Offset_0x0473EE
		neg.w	D0
Offset_0x0473EE:
		move.w	D0, Obj_Speed_X(A0)				 ; $0018
		move.w	#$FA00, Obj_Speed_Y(A0)					 ; $001A
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X_2(PC) ; Offset_0x042B5C
;-------------------------------------------------------------------------------
Offset_0x0473FC:
		move.w	Obj_Control_Var_0E(A0), D0				 ; $003E
		addi.w	#$0010, D0
		move.w	D0, Obj_Control_Var_0E(A0)				 ; $003E
		move.w	Obj_Control_Var_0C(A0), D1				 ; $003C
		add.w	D0, D1
		scs		D2
		tst.w	D0
		bmi.s	Offset_0x047418
		tst.b	D2
		bne.s	Offset_0x0473B4
Offset_0x047418:
		move.w	D1, Obj_Control_Var_0C(A0)				 ; $003C
		tst.b	Obj_Subtype(A0)					 ; $002C
		beq.s	Offset_0x04742E
		cmpi.w	#$B800, D1
		bhi.s	Offset_0x04742E
		cmpi.w	#$0200, D0
		bcc.s	Offset_0x0473CE
Offset_0x04742E:
		cmpi.w	#$9200, D1
		bls.s	Offset_0x04743A
		moveq	#$01, D2
		jsr		Move_Sprite_Circular_Simple(PC)		   ; Offset_0x0426E2
Offset_0x04743A:
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X_2(PC) ; Offset_0x042B5C
;-------------------------------------------------------------------------------
Offset_0x04743E:
		jsr		(ObjectFall).l				   ; Offset_0x0110FE
		tst.w	Obj_Speed_Y(A0)					 ; $001A
		bmi.s	Offset_0x047472
		jsr		(ObjHitFloor).l				   ; Offset_0x009D84
		tst.w	D1
		bpl.s	Offset_0x047472
		add.w	D1, Obj_Y(A0)					 ; $0014
		move.w	Obj_Speed_Y(A0), D0				 ; $001A
		cmpi.w	#$0100, D0
		bcs.s	Offset_0x047476
		asr.w	#$02, D0
		neg.w	D0
		move.w	D0, Obj_Speed_Y(A0)				 ; $001A
		lea		Offset_0x0477B0(PC), A2
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
Offset_0x047472:
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X_2(PC) ; Offset_0x042B5C
Offset_0x047476:
		move.l	#Offset_0x047494, (A0)
		move.w	#$0010, D0
		tst.w	Obj_Speed_X(A0)					 ; $0018
		bmi.s	Offset_0x047488
		neg.w	D0
Offset_0x047488:
		move.w	D0, Obj_Control_Var_10(A0)				 ; $0040
		clr.w	Obj_Speed_Y(A0)					 ; $001A
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X_2(PC) ; Offset_0x042B5C
;-------------------------------------------------------------------------------
Offset_0x047494:
		move.w	Obj_Speed_X(A0), D0				 ; $0018
		move.w	D0, D1
		add.w	Obj_Control_Var_10(A0), D0				 ; $0040
		eor.w	D0, D1
		bmi.s	Offset_0x0474C8
		move.w	D0, Obj_Speed_X(A0)				 ; $0018
		move.w	Obj_X(A0), D1					 ; $0010
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		move.w	Obj_X(A0), D0					 ; $0010
		eor.w	D0, D1
		btst	#$03, D1
		beq.s	Offset_0x0474C4
		lea		Offset_0x0477BE(PC), A2
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
Offset_0x0474C4:
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X_2(PC) ; Offset_0x042B5C
Offset_0x0474C8:
		move.l	#Offset_0x0474D2, (A0)
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X_2(PC) ; Offset_0x042B5C
;-------------------------------------------------------------------------------
Offset_0x0474D2:
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X_2(PC) ; Offset_0x042B5C
;-------------------------------------------------------------------------------
Offset_0x0474D6:
		lea		Swinging_Platform_Setup_Data_4(PC), A1 ; Offset_0x04778A
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.l	#Offset_0x0474E4, (A0)
Offset_0x0474E4:
		bsr.w	Offset_0x0476B2
		jmp		Child_Display_Or_Delete_2(PC)		   ; Offset_0x0424A8
;-------------------------------------------------------------------------------
Offset_0x0474EC:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$03, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x0474FE
		move.l	#Offset_0x0474E4, (A0)
Offset_0x0474FE:
		bsr.w	Offset_0x047686
		jmp		Child_Display_Or_Delete_2(PC)		   ; Offset_0x0424A8
;-------------------------------------------------------------------------------
Offset_0x047506:
		lea		Swinging_Platform_Setup_Data_5(PC), A1 ; Offset_0x047790
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.l	#Offset_0x047514, (A0)
Offset_0x047514:
		bsr.w	Offset_0x04769C
		jmp		Child_Display_Or_Delete_2(PC)		   ; Offset_0x0424A8
;-------------------------------------------------------------------------------
Offset_0x04751C:
		lea		Swinging_Platform_Setup_Data_2(PC), A1 ; Offset_0x047776
		jsr		SetupObjectAttributes2(PC)			; Offset_0x041D76
		move.l	#Offset_0x047564, (A0)
		subi.w	#$0080, Obj_Y(A0)				 ; $0014
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$00, Obj_Flags(A1)				 ; $0004
		beq.s	Offset_0x047542
		bset	#$00, Obj_Flags(A0)				 ; $0004
Offset_0x047542:
		bset	#$06, Obj_Flags(A0)				 ; $0004
		move.w	#$0007, Obj_Sub_Y(A0)					 ; $0016
		lea		Obj_Inertia(A0), A1				 ; $001C
		moveq	#$06, D6
Offset_0x047554:
		move.w	#$0008, (A1)
		addq.w	#$06, A1
		dbra.w	D6, Offset_0x047554
		move.b	#$08, Obj_Map_Id(A0)					 ; $0022
Offset_0x047564:
		bsr.w	Offset_0x047746
		bsr.w	Offset_0x0475D4
		jmp		Child_Display_Or_Delete_2(PC)		   ; Offset_0x0424A8
;-------------------------------------------------------------------------------
Offset_0x047570:
		lea		Swinging_Platform_Setup_Data_3(PC), A1 ; Offset_0x04777E
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.l	#Offset_0x0475D0, (A0)
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.w	Offset_0x0475B8(PC, D0), D1
		neg.w	D1
		move.w	D1, Obj_Speed_Y(A0)				 ; $001A
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$00, Obj_Flags(A1)				 ; $0004
		bne.s	Offset_0x04759C
		neg.w	D1
Offset_0x04759C:
		move.w	D1, Obj_Speed_X(A0)				 ; $0018
		lsr.w	#$01, D0
		move.b	Offset_0x0475C8(PC, D0), D0
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		move.w	$00(A1, D0), Obj_X(A0)					 ; $0010
		move.w	$02(A1, D0), Obj_Y(A0)					 ; $0014
		rts
;-------------------------------------------------------------------------------
Offset_0x0475B8:
		dc.w	$0080, $0100, $0180, $0200, $0280, $0300, $0380, $0400
;-------------------------------------------------------------------------------
Offset_0x0475C8:
		dc.b	$42, $18, $1E, $24, $2A, $30, $36, $3C
;-------------------------------------------------------------------------------
Offset_0x0475D0:
		jmp		ObjectFall_Delete_Sprite_Check_X_Y(PC) ; Offset_0x042FB6
;-------------------------------------------------------------------------------
Offset_0x0475D4:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		lea		Obj_Speed_X(A0), A2				 ; $0018
		move.w	Obj_X(A0), D0					 ; $0010
		move.w	Obj_X(A1), D1					 ; $0010
		sub.w	D0, D1
		swap	D0
		swap	D1
		move.w	Obj_Y(A0), D0					 ; $0014
		move.w	Obj_Y(A1), D1					 ; $0014
		sub.w	D0, D1
		moveq	#$00, D5
		moveq	#$06, D6
Offset_0x0475F8:
		move.l	D1, D2
		move.w	Offset_0x047612(PC, D5), D4
		jsr		Offset_0x047612(PC, D4)
		move.l	D0, (A2)
		swap	D2
		add.l	D2, (A2)+
		addq.w	#$02, A2
		addq.w	#$02, D5
		dbra.w	D6, Offset_0x0475F8
		rts
;-------------------------------------------------------------------------------
Offset_0x047612:
		dc.w	Offset_0x047622-Offset_0x047612
		dc.w	Offset_0x04762A-Offset_0x047612
		dc.w	Offset_0x047632-Offset_0x047612
		dc.w	Offset_0x047646-Offset_0x047612
		dc.w	Offset_0x04764E-Offset_0x047612
		dc.w	Offset_0x047662-Offset_0x047612
		dc.w	Offset_0x047676-Offset_0x047612
		dc.w	Offset_0x047684-Offset_0x047612
;-------------------------------------------------------------------------------
Offset_0x047622:
		asr.w	#$03, D2
		swap	D2
		asr.w	#$03, D2
		rts
;-------------------------------------------------------------------------------
Offset_0x04762A:
		asr.w	#$02, D2
		swap	D2
		asr.w	#$02, D2
		rts
;-------------------------------------------------------------------------------
Offset_0x047632:
		asr.w	#$02, D2
		move.w	D2, D3
		asr.w	#$01, D2
		add.w	D3, D2
		swap	D2
		asr.w	#$02, D2
		move.w	D2, D3
		asr.w	#$01, D2
		add.w	D3, D2
		rts
;-------------------------------------------------------------------------------
Offset_0x047646:
		asr.w	#$01, D2
		swap	D2
		asr.w	#$01, D2
		rts
;-------------------------------------------------------------------------------
Offset_0x04764E:
		asr.w	#$01, D2
		move.w	D2, D3
		asr.w	#$02, D2
		add.w	D3, D2
		swap	D2
		asr.w	#$01, D2
		move.w	D2, D3
		asr.w	#$02, D2
		add.w	D3, D2
		rts
;-------------------------------------------------------------------------------
Offset_0x047662:
		asr.w	#$01, D2
		move.w	D2, D3
		asr.w	#$01, D2
		add.w	D3, D2
		swap	D2
		asr.w	#$01, D2
		move.w	D2, D3
		asr.w	#$01, D2
		add.w	D3, D2
		rts
;-------------------------------------------------------------------------------
Offset_0x047676:
		move.w	D2, D3
		asr.w	#$03, D3
		sub.w	D3, D2
		swap	D2
		move.w	D2, D3
		asr.w	#$03, D3
		sub.w	D3, D2
;-------------------------------------------------------------------------------
Offset_0x047684:
		rts
;-------------------------------------------------------------------------------
Offset_0x047686:
		move.w	Obj_X(A0), -(A7)				 ; $0010
		jsr		Refresh_Child_Position(PC)			   ; Offset_0x042016
		moveq	#$2B, D1
		moveq	#$08, D2
		moveq	#$08, D3
		move.w	(A7)+, D4
		jmp		(Solid_Object).l				   ; Offset_0x013556
;-------------------------------------------------------------------------------
Offset_0x04769C:
		move.w	Obj_X(A0), -(A7)				 ; $0010
		jsr		Refresh_Child_Position_Adjusted(PC)	   ; Offset_0x04203C
		moveq	#$0F, D1
		moveq	#$08, D2
		moveq	#$08, D3
		move.w	(A7)+, D4
		jmp		(Solid_Object).l				   ; Offset_0x013556
;-------------------------------------------------------------------------------
Offset_0x0476B2:
		move.b	Obj_Status(A0), Obj_Control_Var_09(A0)	  ; $002A, $0039
		bsr.s	Offset_0x047686
		move.b	Obj_Control_Var_09(A0), D0				 ; $0039
		move.b	Obj_Status(A0), D1				 ; $002A
		andi.b	#$18, D1
		beq.s	Offset_0x0476E0
		move.w	Obj_Child_Ref(A0), A2					 ; $0046
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		moveq	#$03, D2
		bsr.w	Offset_0x0476E2
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		moveq	#$04, D2
		bsr.w	Offset_0x0476E2
Offset_0x0476E0:
		rts
Offset_0x0476E2:
		btst	D2, D1
		beq.s	Offset_0x0476E0
		move.w	Obj_Speed_X(A1), D3				 ; $0018
		smi		D4
		cmpi.w	#$FE00, D3
		ble.s	Offset_0x0476F8
		cmpi.w	#$0200, D3
		blt.s	Offset_0x0476E0
Offset_0x0476F8:
		btst	D2, D0
		beq.s	Offset_0x0476FE
		asr.w	#$01, D3
Offset_0x0476FE:
		btst	#$00, Obj_Flags(A2)				 ; $0004
		beq.s	Offset_0x047708
		not.b	D4
Offset_0x047708:
		tst.b	D4
		bne.s	Offset_0x0476E0
		move.l	#Offset_0x0474EC, (A0)
		bset	#$03, Obj_Control_Var_08(A2)			 ; $0038
		asr.w	#$01, D3
		bmi.s	Offset_0x04772A
		cmpi.w	#$0400, D3
		ble.s	Offset_0x047734
		move.w	#$0400, D3
		bra.w	Offset_0x047734
Offset_0x04772A:
		cmpi.w	#$FC00, D3
		bge.s	Offset_0x047734
		move.w	#$FC00, D3
Offset_0x047734:
		move.w	D3, Obj_Control_Var_0E(A2)				 ; $003E
		asl.w	#$01, D3
		move.w	D3, Obj_Speed_X(A1)				 ; $0018
		move.w	D3, Obj_Inertia(A1)				 ; $001C
		addq.w	#$04, A7
Offset_0x047744:
		rts
Offset_0x047746:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$02, Obj_Control_Var_08(A1)			 ; $0038
		beq.s	Offset_0x047744
		move.w	Obj_X(A0), Obj_Status(A0)		  ; $0010, $002A
		move.w	Obj_Y(A0), Obj_Subtype(A0)		  ; $0014, $002C
		lea		Offset_0x0477AA(PC), A2
		jsr		Load_Child_Object_Simple_A2(PC)		   ; Offset_0x041F5A
		jmp		Go_Delete_Object_A0_2(PC)			   ; Offset_0x042D4C
;-------------------------------------------------------------------------------
Swinging_Platform_Setup_Data:				   ; Offset_0x04776A
		dc.l	Iz_Platform_Mappings		   ; Offset_0x110BBC
		dc.w	$23B6, $0080
		dc.b	$20, $10, $07, $00
;-------------------------------------------------------------------------------
Swinging_Platform_Setup_Data_2:				   ; Offset_0x047776
		dc.w	$43B6, $0280
		dc.b	$80, $80, $08, $00
;-------------------------------------------------------------------------------
Swinging_Platform_Setup_Data_3:				   ; Offset_0x04777E
		dc.l	Iz_Platform_Mappings		   ; Offset_0x110BBC
		dc.w	$43B6, $0280
		dc.b	$08, $08, $08, $00
;-------------------------------------------------------------------------------
Swinging_Platform_Setup_Data_4:				   ; Offset_0x04778A
		dc.w	$0300
		dc.b	$20, $10, $27, $00
;-------------------------------------------------------------------------------
Swinging_Platform_Setup_Data_5:				   ; Offset_0x047790
		dc.w	$0300
		dc.b	$30, $08, $27, $00
;-------------------------------------------------------------------------------
Offset_0x047796:
		dc.w	$0002
		dc.l	Offset_0x0474D6
		dc.b	$00, $08
		dc.l	Offset_0x047506
		dc.b	$1C, $F8
		dc.l	Offset_0x04751C
		dc.b	$00, $00
;-------------------------------------------------------------------------------
Offset_0x0477AA:
		dc.w	$0007
		dc.l	Offset_0x047570
;-------------------------------------------------------------------------------
Offset_0x0477B0:
		dc.w	$0001
		dc.l	Obj_Snow_Dust				   ; Offset_0x0481EC
		dc.b	$1C, $10
		dc.l	Obj_Snow_Dust				   ; Offset_0x0481EC
		dc.b	$14, $10
;-------------------------------------------------------------------------------
Offset_0x0477BE:
		dc.w	$0000
		dc.l	Obj_Snow_Dust				   ; Offset_0x0481EC
		dc.b	$1C, $10
;===============================================================================
; Objeto 0xBD - Plataforma balançando na Icecap
; <<<-
;===============================================================================