;===============================================================================
; Objeto 0xBC - Coluna segmentada na Icecap
; ->>>
;===============================================================================
; Offset_0x04719E:
		lea		Segmented_Column_Setup_Data(PC), A1	   ; Offset_0x047314
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.l	#Delete_Sprite_Check_X_2, (A0)		   ; Offset_0x042A8A
		lea		Offset_0x047326(PC), A2
		tst.b	Obj_Subtype(A0)					 ; $002C
		beq.s	Offset_0x0471BA
		lea		Offset_0x04732E(PC), A2
Offset_0x0471BA:
		jmp		Load_Child_Object_Tree_List_Repeated_A2(PC) ; Offset_0x041FD6
;-------------------------------------------------------------------------------
Offset_0x0471BE:
		lea		Offset_0x047320(PC), A1
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.l	#Offset_0x0471E8, (A0)
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		cmpi.b	#$06, D0
		bne.s	Offset_0x0471DE
		move.b	#$03, Obj_Map_Id(A0)					 ; $0022
Offset_0x0471DE:
		lsl.w	#$04, D0
		sub.w	D0, Obj_Y(A0)					 ; $0014
		bra.w	Offset_0x047300
;-------------------------------------------------------------------------------
Offset_0x0471E8:
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		btst	#$00, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x04722A
		move.w	(Obj_Player_One+Obj_Speed_X).w, -(A7)		 ; $FFFFB018
		move.w	(Obj_Player_Two+Obj_Speed_X).w, -(A7)		 ; $FFFFB062
		bsr.w	Offset_0x0472A2
		move.l	(A7)+, D0
		moveq	#$05, D1
		cmpi.b	#$03, Obj_Map_Id(A0)					 ; $0022
		beq.s	Offset_0x047226
		tst.b	Obj_Subtype(A0)					 ; $002C
		bne.s	Offset_0x047226
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		bsr.w	Offset_0x0472B2
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		swap	D0
		addq.b	#$01, D1
		bsr.w	Offset_0x0472B2
Offset_0x047226:
		bra.w	Offset_0x047300
Offset_0x04722A:
		move.l	#Offset_0x047250, (A0)
		bset	#$00, Obj_Control_Var_08(A0)			 ; $0038
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		lsl.w	#$02, D0
		addi.w	#$000F, D0
		move.w	D0, Obj_Timer(A0)				 ; $002E
		move.l	#Offset_0x04725C, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x047250:
		bsr.w	Offset_0x0472A2
		jsr		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
		bra.w	Offset_0x047300
;-------------------------------------------------------------------------------
Offset_0x04725C:
		move.l	#Offset_0x047276, (A0)
		move.w	#$0007, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x047286, Obj_Child(A0)			 ; $0034
		subq.b	#$02, Obj_Subtype(A0)					 ; $002C
		rts
;-------------------------------------------------------------------------------
Offset_0x047276:
		bsr.w	Offset_0x0472A2
		addq.w	#$04, Obj_Y(A0)					 ; $0014
		jsr		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
		bra.w	Offset_0x047300
;-------------------------------------------------------------------------------
Offset_0x047286:
		move.l	#Offset_0x0471E8, (A0)
		bclr	#$00, Obj_Control_Var_08(A0)			 ; $0038
		move.w	#$0010, (Earthquake_Flag).w			 ; $FFFFEECC
		moveq	#Slide_Thunk_Sfx, D0					  ; -$50
		jsr		(Play_Music).l					 ; Offset_0x001176
		rts
;-------------------------------------------------------------------------------
Offset_0x0472A2:
		moveq	#$2B, D1
		moveq	#$10, D2
		moveq	#$10, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jmp		(Solid_Object).l				   ; Offset_0x013556
Offset_0x0472B2:
		btst	D1, Obj_Status(A0)				 ; $002A
		beq.s	Offset_0x0472FE
		move.w	D0, D3
		tst.w	D3
		bpl.s	Offset_0x0472C0
		neg.w	D3
Offset_0x0472C0:
		cmpi.b	#$02, Obj_Ani_Number(A1)				 ; $0020
		bne.s	Offset_0x0472FE
		cmpi.w	#$0600, D3
		bcs.s	Offset_0x0472FE
		move.w	D0, Obj_Speed_X(A1)				 ; $0018
		move.w	D0, Obj_Inertia(A1)				 ; $001C
		bclr	D1, Obj_Status(A0)				 ; $002A
		bclr	D1, Obj_Status(A1)				 ; $002A
		bset	#$00, Obj_Control_Var_08(A0)			 ; $0038
		lea		Offset_0x04713A(PC), A2
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
		jsr		Displace_Player_Offset(PC)			   ; Offset_0x04315A
		jsr		Go_Delete_Object_A0(PC)		   ; Offset_0x042D3E
		moveq	#Smash_Sfx, D0					   ; $62
		jsr		(Play_Music).l					 ; Offset_0x001176
		addq.w	#$04, A7
Offset_0x0472FE:
		rts
;-------------------------------------------------------------------------------
Offset_0x047300:
		move.w	Obj_Height_3(A0), A1					 ; $0044
		btst	#$04, Obj_Control_Var_08(A1)			 ; $0038
		bne.w	Go_Delete_Object_A0_2		   ; Offset_0x042D4C
		jmp		(DisplaySprite).l				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Segmented_Column_Setup_Data:				   ; Offset_0x047314
		dc.l	Crushing_Column_Mappings			   ; Offset_0x110938
		dc.w	$4001, $0280
		dc.b	$20, $10, $0B, $00
;-------------------------------------------------------------------------------
Offset_0x047320:
		dc.w	$0280
		dc.b	$20, $10, $0A, $00
;-------------------------------------------------------------------------------
Offset_0x047326:
		dc.w	$0002
		dc.l	Offset_0x0471BE
		dc.b	$00, $00
;-------------------------------------------------------------------------------
Offset_0x04732E:
		dc.w	$0003
		dc.l	Offset_0x0471BE
		dc.b	$00, $00
;===============================================================================
; Objeto 0xBC - Coluna segmentada na Icecap
; <<<-
;===============================================================================