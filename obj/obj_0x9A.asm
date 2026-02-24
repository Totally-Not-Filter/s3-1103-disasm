;===============================================================================
; Objeto 0x9A - Inimigo Blastoid na Hydrocity
; ->>>
;===============================================================================
; Offset_0x0446D0:
		jsr		(Object_Check_Range).l		   ; Offset_0x04326E
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x0446EC(PC, D0), D1
		jsr		Offset_0x0446EC(PC, D1)
		bsr.w	Offset_0x044746
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X(PC) ; Offset_0x042B3C
;-------------------------------------------------------------------------------
Offset_0x0446EC:
		dc.w	Offset_0x0446F2-Offset_0x0446EC
		dc.w	Offset_0x044700-Offset_0x0446EC
		dc.w	Offset_0x044724-Offset_0x0446EC
;-------------------------------------------------------------------------------
Offset_0x0446F2:
		move.b	#$01, Obj_Col_Prop(A0)					 ; $0029
		lea		Blastoid_Setup_Data(PC), A1			   ; Offset_0x044762
		jmp		SetupObjectAttributes(PC)			 ; Offset_0x041D72
;-------------------------------------------------------------------------------
Offset_0x044700:
		jsr		Find_Player(PC)				   ; Offset_0x042634
		cmpi.w	#$0080, D2
		bcs.s	Offset_0x04470C
		rts
Offset_0x04470C:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x044792, Obj_Child_Data(A0)			 ; $0030
		move.l	#Offset_0x04473E, Obj_Child(A0)			 ; $0034
Offset_0x044722:
		rts
;-------------------------------------------------------------------------------
Offset_0x044724:
		jsr		Animate_Raw_Multi_Delay(PC)			   ; Offset_0x04215C
		tst.w	D2
		beq.s	Offset_0x044722
		bmi.s	Offset_0x044722
		cmpi.b	#$01, Obj_Map_Id(A0)					 ; $0022
		bne.s	Offset_0x044722
		lea		Offset_0x04477A(PC), A2
		jmp		Load_Child_Object_Complex_Adjusted_A2(PC) ; Offset_0x041EE0
;-------------------------------------------------------------------------------
Offset_0x04473E:
		move.b	#$02, Obj_Routine(A0)					 ; $0005
		rts
;-------------------------------------------------------------------------------
Offset_0x044746:
		tst.b	Obj_Col_Prop(A0)				 ; $0029
		bne.w	Offset_0x044722
		move.b	Obj_Subtype(A0), D0				 ; $002C
		andi.w	#$000F, D0
		lea		(Level_Trigger_Array).w, A3			 ; $FFFFF7E0
		st		(A3, D0)
		jmp		Enemy_Defeat_Score(PC)		   ; Offset_0x043018
;-------------------------------------------------------------------------------
Blastoid_Setup_Data:						   ; Offset_0x044762
		dc.l	Blastoid_Mappings			   ; Offset_0x10DD6A
		dc.w	$A539, $0280
		dc.b	$14, $0C, $00, $1A
;-------------------------------------------------------------------------------
Blastoid_Setup_Data_2:						   ; Offset_0x04476E
		dc.l	Blastoid_Mappings			   ; Offset_0x10DD6A
		dc.w	$A539, $0280
		dc.b	$04, $04, $02, $98
;-------------------------------------------------------------------------------
Offset_0x04477A:
		dc.w	$0000
		dc.l	Object_Settings_Check_X_Y			   ; Offset_0x043B1E
		dc.l	Blastoid_Setup_Data_2		   ; Offset_0x04476E
		dc.l	Offset_0x0447A1
		dc.l	SpeedToPos_Animate_Raw		   ; Offset_0x042F66
		dc.b	$EC, $F9
		dc.w	$FE00, $FF00
;-------------------------------------------------------------------------------
Offset_0x044792:
		dc.b	$00, $7F, $01, $04, $00, $09, $01, $04
		dc.b	$00, $09, $01, $04, $00, $3F, $F4
;-------------------------------------------------------------------------------
Offset_0x0447A1:
		dc.b	$00, $02, $03, $FC, $00
;===============================================================================
; Objeto 0x9A - Inimigo Blastoid na Hydrocity
; <<<-
;===============================================================================