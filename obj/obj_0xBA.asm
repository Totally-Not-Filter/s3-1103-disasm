;===============================================================================
; Objeto 0xBA - Parede quebrável na Icecap
; ->>>
;===============================================================================
Offset_0x0468EC:
		lea		Breakable_Wall_Setup_Data_2(PC), A1	   ; Offset_0x046AE2
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.l	#Offset_0x046938, (A0)
		move.l	#Offset_0x046B08, Obj_Child_Data(A0)			 ; $0030
		move.l	#Go_Delete_Object_A0, Obj_Child(A0) ; Offset_0x042D3E, $0034
		move.w	#$005F, Obj_Timer(A0)					 ; $002E
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.w	Offset_0x046926(PC, D0), Obj_Control_Var_12(A0)	 ; $0042
		jsr		Refresh_Child_Position(PC)			   ; Offset_0x042016
		moveq	#$00, D0
		jmp		Set_Indexed_Velocity(PC)			   ; Offset_0x042D5A
;-------------------------------------------------------------------------------
Offset_0x046926:
		dc.b	$EC, $D0, $08, $CC, $F4, $EC, $10, $E0
		dc.b	$0A, $FC, $EC, $0C, $08, $18, $F0, $28
		dc.b	$0C, $34
;-------------------------------------------------------------------------------
Offset_0x046938:
		jsr		AnimateRaw(PC)				  ; Offset_0x04208E
		jsr		(ObjectFall).l				   ; Offset_0x0110FE
		jsr		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Obj_0xBA_Iz_Breakable_Wall:					   ; Offset_0x04694C
		lea		Breakable_Wall_Setup_Data(PC), A1	   ; Offset_0x046ACA
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.l	#Offset_0x046960, (A0)
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Offset_0x046960:
		moveq	#$2B, D1
		moveq	#$40, D2
		moveq	#$70, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Solid_Object).l				   ; Offset_0x013556
		move.w	(Obj_Knuckles_Mem_Address).w, A1			 ; $FFFFFAA4
		cmpi.l	#Obj_0xB9_Iz_Platform_2, (A1)		   ; Offset_0x046644
		bne.s	Offset_0x0469AC
		move.w	Obj_X(A1), D0					 ; $0010
		move.w	Obj_Y(A1), D1					 ; $0014
		and.w	(Screen_Wrap_Y).w, D1				 ; $FFFFEEAA
		move.w	Obj_X(A0), D2					 ; $0010
		move.w	Obj_Y(A0), D3					 ; $0014
		lea		Offset_0x0469CC(PC), A2
		add.w	(A2)+, D2
		cmp.w	D2, D0
		bcs.s	Offset_0x0469AC
		add.w	(A2)+, D2
		cmp.w	D2, D0
		bcc.s	Offset_0x0469AC
		add.w	(A2)+, D3
		cmp.w	D3, D1
		bcs.s	Offset_0x0469AC
		add.w	(A2)+, D3
		cmp.w	D3, D1
		bcs.s	Offset_0x0469B2
Offset_0x0469AC:
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
Offset_0x0469B2:
		lea		Offset_0x046AF4(PC), A2
		jsr		Load_Child_Object_Simple_A2(PC)		   ; Offset_0x041F5A
		jsr		Go_Delete_Object_A0(PC)		   ; Offset_0x042D3E
		moveq	#Smash_Sfx, D0					   ; $62
		jsr		(Play_Music).l					 ; Offset_0x001176
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Offset_0x0469CC:
		dc.w	$FFD0, $0060, $FFC0, $0080
;===============================================================================
; Objeto 0xBA - Parede quebrável na Icecap
; <<<-
;===============================================================================