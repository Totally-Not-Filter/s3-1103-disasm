;===============================================================================
; Objeto 0x81 - Inimigo bloominator na Angel Island
; ->>>
;===============================================================================
; Offset_0x043B3E:
		jsr		(Object_Check_Range).l		   ; Offset_0x04326E
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x043B58(PC, D0), D1
		jsr		Offset_0x043B58(PC, D1)
		jmp		(Delete_Sprite_Clear_Respaw_Flag_Check_X).l ; Offset_0x042B3C
;-------------------------------------------------------------------------------
Offset_0x043B58:
		dc.w	Offset_0x043B5E-Offset_0x043B58
		dc.w	Offset_0x043B76-Offset_0x043B58
		dc.w	Offset_0x043B9A-Offset_0x043B58
;-------------------------------------------------------------------------------
Offset_0x043B5E:
		lea		Bloominator_Setup_Data(PC), A1		   ; Offset_0x043BE6
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.w	#$001F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x043B82, Obj_Child(A0)			 ; $0034
Offset_0x043B74:
		rts
;-------------------------------------------------------------------------------
Offset_0x043B76:
		tst.b	Obj_Flags(A0)					 ; $0004
		bpl.w	Offset_0x043B74
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x043B82:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.l	#Offset_0x043C16, Obj_Child_Data(A0)			 ; $0030
		move.l	#Offset_0x043BD0, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x043B9A:
		jsr		Animate_Raw_Multi_Delay(PC)			   ; Offset_0x04215C
		beq.s	Offset_0x043B74
		cmpi.b	#$06, D0
		beq.s	Offset_0x043BAC
		cmpi.b	#$0E, D0
		bne.s	Offset_0x043B74
Offset_0x043BAC:
		moveq	#sfx_Projectile, D0
		jsr		(Play_Music).l					 ; Offset_0x001176
		lea		Offset_0x043BFE(PC), A2
		jsr		SetupChildObject_Complex(PC)	   ; Offset_0x041DEA
		bne.s	Offset_0x043BCE
		addq.b	#$01, Obj_Control_Var_09(A0)			 ; $0039
		btst	#$00, Obj_Control_Var_09(A0)			 ; $0039
		beq.s	Offset_0x043BCE
		neg.w	Obj_Speed_X(A1)					 ; $0018
Offset_0x043BCE:
		rts
;-------------------------------------------------------------------------------
Offset_0x043BD0:
		move.b	#$02, Obj_Routine(A0)					 ; $0005
		move.w	#$0078, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x043B82, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Bloominator_Setup_Data:						   ; Offset_0x043BE6
		dc.l	Bloominator_Mappings		   ; Offset_0x10E660
		dc.w	$252A, $0200
		dc.b	$0C, $18, $00, $23
;-------------------------------------------------------------------------------
Bloominator_Setup_Data_2:					   ; Offset_0x043BF2
		dc.l	Bloominator_Mappings		   ; Offset_0x10E660
		dc.w	$252A, $0280
		dc.b	$08, $08, $04, $98
;-------------------------------------------------------------------------------
Offset_0x043BFE:
		dc.w	$0000
		dc.l	Object_Settings_Check_X_Y			   ; Offset_0x043B1E
		dc.l	Bloominator_Setup_Data_2			   ; Offset_0x043BF2
		dc.l	$00000000
		dc.l	ObjectFall					   ; Offset_0x0110FE
		dc.b	$00, $F0
		dc.w	$0100, $FB00
;-------------------------------------------------------------------------------
Offset_0x043C16:
		dc.b	$00, $07, $01, $09, $02, $04, $03, $04
		dc.b	$00, $09, $01, $09, $02, $04, $03, $04
		dc.b	$00, $00, $F4, $00
;===============================================================================
; Objeto 0x81 - Inimigo bloominator na Angel Island
; <<<-
;===============================================================================