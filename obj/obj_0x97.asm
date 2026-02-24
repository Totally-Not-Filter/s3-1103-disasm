;===============================================================================
; Objeto 0x97 - Inimigo Cluckoid na Mushroom Valley
; ->>>
;===============================================================================
; Offset_0x049E50:
		jsr		(Object_Check_Range).l		   ; Offset_0x04326E
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x049E74(PC, D0), D1
		jsr		Offset_0x049E74(PC, D1)
		lea		Cluckoid_PLC_Data(PC), A2			   ; Offset_0x049F96
		jsr		(LoadDynamicPLC).l		  ; Offset_0x042A0A
		jmp		(Delete_Sprite_Clear_Respaw_Flag_Check_X).l ; Offset_0x042B3C
;-------------------------------------------------------------------------------
Offset_0x049E74:
		dc.w	Offset_0x049E7C-Offset_0x049E74
		dc.w	Offset_0x049E90-Offset_0x049E74
		dc.w	Offset_0x049EB4-Offset_0x049E74
		dc.w	Offset_0x049ED8-Offset_0x049E74
;-------------------------------------------------------------------------------
Offset_0x049E7C:
		lea		Cluckoid_Setup_Data(PC), A1			   ; Offset_0x049F70
		jsr		(SetupSlottedObjectAttributes).l		; Offset_0x04298C
		lea		Offset_0x049F8E(PC), A2
		jmp		(SetupChildObject).l		   ; Offset_0x041D9A
;-------------------------------------------------------------------------------
Offset_0x049E90:
		jsr		(Find_Player)				   ; Offset_0x042634
		cmpi.w	#$0080, D2
		bcc.s	Offset_0x049EA2
		cmpi.w	#$0040, D3
		bcs.s	Offset_0x049EA4
Offset_0x049EA2:
		rts
Offset_0x049EA4:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x049ECA, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x049EB4:
		cmpi.b	#$07, Obj_Map_Id(A0)					 ; $0022
		bcs.s	Offset_0x049EC0
		bsr.w	Offset_0x049F12
Offset_0x049EC0:
		lea		Offset_0x049F96(PC), A1
		jmp		(Animate_Raw_Multi_Delay_A1).l		   ; Offset_0x042160
;-------------------------------------------------------------------------------
Offset_0x049ECA:
		move.b	#$06, Obj_Routine(A0)					 ; $0005
		move.w	#$0060, Obj_Timer(A0)					 ; $002E
		rts
;-------------------------------------------------------------------------------
Offset_0x049ED8:
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		bmi.s	Offset_0x049EE0
		rts
Offset_0x049EE0:
		move.b	#$02, Obj_Routine(A0)					 ; $0005
		move.b	#$00, Obj_Map_Id(A0)					 ; $0022
		rts
;-------------------------------------------------------------------------------
Offset_0x049EEE:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x049F02(PC, D0), D1
		jsr		Offset_0x049F02(PC, D1)
		jmp		(Child_Display_Or_Delete).l			   ; Offset_0x04245C
;-------------------------------------------------------------------------------
Offset_0x049F02:
		dc.w	Offset_0x049F06-Offset_0x049F02
		dc.w	Offset_0x049F10-Offset_0x049F02
;-------------------------------------------------------------------------------
Offset_0x049F06:
		lea		Cluckoid_Setup_Data_2(PC), A1		   ; Offset_0x049F82
		jmp		(SetupObjectAttributes).l				 ; Offset_0x041D72
;-------------------------------------------------------------------------------
Offset_0x049F10:
		rts
;-------------------------------------------------------------------------------
Offset_0x049F12:
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		cmpi.b	#$08, Obj_Ani_Number(A1)				 ; $0020
		beq.s	Offset_0x049F22
		bsr.w	Offset_0x049F34
Offset_0x049F22:
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		cmpi.b	#$08, Obj_Ani_Number(A1)				 ; $0020
		beq.s	Offset_0x049F32
		bsr.w	Offset_0x049F34
Offset_0x049F32:
		rts
Offset_0x049F34:
		jsr		(Find_Other_Object).l			   ; Offset_0x04269E
		cmpi.w	#$0100, D2
		bcc.s	Offset_0x049F6E
		cmpi.w	#$0040, D3
		bcc.s	Offset_0x049F6E
		move.w	D0, D4
		btst	#$00, Obj_Flags(A0)				 ; $0004
		bne.s	Offset_0x049F52
		subq.w	#$02, D4
Offset_0x049F52:
		tst.w	D4
		beq.s	Offset_0x049F6E
		lsr.w	#$04, D2
		andi.w	#$000F, D2
		subi.w	#$000F, D2
		neg.w	D2
		addq.w	#$01, D2
		tst.w	D0
		bne.s	Offset_0x049F6A
		neg.w	D2
Offset_0x049F6A:
		add.w	D2, Obj_X(A1)					 ; $0010
Offset_0x049F6E:
		rts
;-------------------------------------------------------------------------------
Cluckoid_Setup_Data:						   ; Offset_0x049F70
		dc.w	$0003, $A580, $0011, $0002
		dc.l	Cluckoid_Mappings			   ; Offset_0x10E052
		dc.w	$0280
		dc.b	$14, $10, $00, $00
;-------------------------------------------------------------------------------
Cluckoid_Setup_Data_2:						   ; Offset_0x049F82
		dc.l	Cluckoid_Arrow_Mappings		   ; Offset_0x10E042
		dc.w	$A57A, $0280
		dc.b	$10, $0C, $00, $00
;-------------------------------------------------------------------------------
Offset_0x049F8E:
		dc.w	$0000
		dc.l	Offset_0x049EEE
		dc.b	$00, $1C
;-------------------------------------------------------------------------------
Cluckoid_PLC_Data:
			  ; dc.l	Art_Cluckoid
			  ; dc.l	Cluckoid_Dyn_Script
;-------------------------------------------------------------------------------
Offset_0x049F96:
		dc.b	$00, $07, $01, $07, $02, $07, $03, $07
		dc.b	$04, $2F, $05, $02, $06, $02, $07, $02
		dc.b	$08, $02, $09, $07, $0A, $07, $0B, $07
		dc.b	$0C, $07, $0D, $1F, $00, $0F, $F4, $00
;===============================================================================
; Objeto 0x97 - Inimigo Cluckoid na Mushroom Valley
; <<<-
;===============================================================================