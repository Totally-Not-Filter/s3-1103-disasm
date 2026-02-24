;===============================================================================
; Objeto 0xBE - Estalactite na Icecap
; ->>>
;===============================================================================
; Offset_0x0477C6:
		jsr		Object_Check_Range(PC)		   ; Offset_0x04326E
		lea		Stalactite_Setup_Data(PC), A1		   ; Offset_0x0478AC
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.l	#Offset_0x0477E0, (A0)
		move.b	#$10, Obj_Height_2(A0)					 ; $001E
		rts
;-------------------------------------------------------------------------------
Offset_0x0477E0:
		bsr.w	Offset_0x04789C
		jsr		Find_Player(PC)				   ; Offset_0x042634
		cmpi.w	#$0070, D2
		bcc.s	Offset_0x047802
		move.l	#Offset_0x047806, (A0)
		move.w	#$000F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x04781E, Obj_Child(A0)			 ; $0034
Offset_0x047802:
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X(PC) ; Offset_0x042B3C
;-------------------------------------------------------------------------------
Offset_0x047806:
		moveq	#$02, D0
		btst	#$00, (Vint_runcount+$03).w		  ; $FFFFFE0F
		beq.s	Offset_0x047812
		neg.w	D0
Offset_0x047812:
		add.w	D0, Obj_X(A0)					 ; $0010
		jsr		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X(PC) ; Offset_0x042B3C
;-------------------------------------------------------------------------------
Offset_0x04781E:
		move.l	#Offset_0x04782C, (A0)
		move.b	#$82, Obj_Col_Flags(A0)					 ; $0028
		rts
;-------------------------------------------------------------------------------
Offset_0x04782C:
		jsr		(ObjectFall).l				   ; Offset_0x0110FE
		jsr		(Object_HitCeiling).l			   ; Offset_0x009FB4
		tst.w	D1
		bpl.s	Offset_0x047856
		move.l	#Offset_0x04785A, (A0)
		clr.b	Obj_Col_Flags(A0)				 ; $0028
		lea		Offset_0x0478C4(PC), A2
		jsr		Load_Child_Object_Simple_A2(PC)		   ; Offset_0x041F5A
		moveq	#Floor_Thump_Sfx, D0					   ; $68
		jsr		(Play_Music).l					 ; Offset_0x001176
Offset_0x047856:
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X(PC) ; Offset_0x042B3C
;-------------------------------------------------------------------------------
Offset_0x04785A:
		bsr.w	Offset_0x04789C
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X(PC) ; Offset_0x042B3C
;-------------------------------------------------------------------------------
Offset_0x047862:
		lea		Offset_0x0478B8(PC), A1
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.l	#Animate_Raw_Delete_Sprite_Check_X_Y, (A0) ; Offset_0x042FB2
		move.l	#Offset_0x047196, Obj_Child_Data(A0)			 ; $0030
		cmpi.b	#$06, Obj_Subtype(A0)					 ; $002C
		bcc.s	Offset_0x047888
		move.l	#Offset_0x04718E, Obj_Child_Data(A0)			 ; $0030
Offset_0x047888:
		jsr		(PseudoRandomNumber).l			 ; Offset_0x001AFA
		andi.b	#$03, D0
		move.b	D0, Obj_Ani_Frame(A0)					 ; $0023
		moveq	#$00, D0
		jmp		Set_Indexed_Velocity(PC)			   ; Offset_0x042D5A
Offset_0x04789C:
		moveq	#$1B, D1
		moveq	#$20, D2
		moveq	#$20, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jmp		(Solid_Object).l				   ; Offset_0x013556
;-------------------------------------------------------------------------------
Stalactite_Setup_Data:						   ; Offset_0x0478AC
		dc.l	Crushing_Column_Mappings			   ; Offset_0x110938
		dc.w	$4001, $0280
		dc.b	$10, $20, $07, $00
;-------------------------------------------------------------------------------
Offset_0x0478B8:
		dc.l	Iz_Platform_Mappings		   ; Offset_0x110BBC
		dc.w	$C3B6, $0280
		dc.b	$04, $04, $0F, $00
;-------------------------------------------------------------------------------
Offset_0x0478C4:
		dc.w	$000B
		dc.l	Offset_0x047862
;-------------------------------------------------------------------------------
; Offset_0x0478CA: ; Left over ???
		dc.b	$00, $27, $0F, $27, $10, $27, $11, $FC
;===============================================================================
; Objeto 0xBE - Estalactite na Icecap
; <<<-
;===============================================================================