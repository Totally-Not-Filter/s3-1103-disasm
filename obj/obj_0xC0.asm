;===============================================================================
; Objeto 0xC0 - Espinhos de gelo na Icecap
; ->>>
;===============================================================================
; Offset_0x0478D2:
		jsr		Object_Check_Range(PC)		   ; Offset_0x04326E
		lea		Ice_Spikes_Setup_Data(PC), A1		   ; Offset_0x04796E
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		tst.b	Obj_Subtype(A0)					 ; $002C
		bne.s	Offset_0x0478FE
		move.l	#Offset_0x04790C, (A0)
		lea		Offset_0x04797A(PC), A2
		btst	#$01, Obj_Flags(A0)				 ; $0004
		beq.s	Offset_0x0478FA
		lea		Offset_0x047982(PC), A2
Offset_0x0478FA:
		jmp		SetupChildObject(PC)			   ; Offset_0x041D9A
Offset_0x0478FE:
		move.l	#Offset_0x047920, (A0)
		move.b	#$92, Obj_Col_Flags(A0)					 ; $0028
		rts
;-------------------------------------------------------------------------------
Offset_0x04790C:
		moveq	#$17, D1
		moveq	#$08, D2
		moveq	#$08, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Solid_Object).l				   ; Offset_0x013556
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X(PC) ; Offset_0x042B3C
;-------------------------------------------------------------------------------
Offset_0x047920:
		jsr		Find_Player(PC)				   ; Offset_0x042634
		cmpi.w	#$0040, D2
		bcc.s	Offset_0x04793E
		move.l	#Offset_0x047942, (A0)
		move.w	#$000F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x04795A, Obj_Child(A0)			 ; $0034
Offset_0x04793E:
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X(PC) ; Offset_0x042B3C
;-------------------------------------------------------------------------------
Offset_0x047942:
		moveq	#$02, D0
		btst	#$00, (Vint_runcount+$03).w		  ; $FFFFFE0F
		beq.s	Offset_0x04794E
		neg.w	D0
Offset_0x04794E:
		add.w	D0, Obj_X(A0)					 ; $0010
		jsr		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X(PC) ; Offset_0x042B3C
;-------------------------------------------------------------------------------
Offset_0x04795A:
		move.l	#ObjectFall_Delete_Sprite_Check_X_Y_2, (A0) ; Offset_0x042FC4
		rts
;-------------------------------------------------------------------------------
Offset_0x047962:
		move.b	#$98, Obj_Col_Flags(A0)					 ; $0028
		jmp		(Add_SpriteToCollisionResponseList).l		  ; Offset_0x00A540
;-------------------------------------------------------------------------------
Ice_Spikes_Setup_Data:						   ; Offset_0x04796E
		dc.l	Crushing_Column_Mappings			   ; Offset_0x110938
		dc.w	$4001, $0280
		dc.b	$0C, $10, $05, $00
;-------------------------------------------------------------------------------
Offset_0x04797A:
		dc.w	$0000
		dc.l	Offset_0x047962
		dc.b	$00, $0C
;-------------------------------------------------------------------------------
Offset_0x047982:
		dc.w	$0000
		dc.l	Offset_0x047962
		dc.b	$00, $F4
;===============================================================================
; Objeto 0xC0 - Espinhos de gelo na Icecap
; <<<-
;===============================================================================