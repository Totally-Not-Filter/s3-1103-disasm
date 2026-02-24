;===============================================================================
; Objeto 0x96 - Inimigo Butterdroid na Mushroom Valley
; ->>>
;===============================================================================
; Offset_0x049DCA:
		jsr		(Object_Check_Range).l		   ; Offset_0x04326E
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x049DEE(PC, D0), D1
		jsr		Offset_0x049DEE(PC, D1)
		lea		Butterdroid_PLC_Data(PC), A2		   ; Offset_0x049E46
		jsr		(LoadDynamicPLC).l		  ; Offset_0x042A0A
		jmp		(Delete_Sprite_Clear_Respaw_Flag_Check_X).l ; Offset_0x042B3C
;-------------------------------------------------------------------------------
Offset_0x049DEE:
		dc.w	Offset_0x049DF2-Offset_0x049DEE
		dc.w	Offset_0x049E06-Offset_0x049DEE
;-------------------------------------------------------------------------------
Offset_0x049DF2:
		lea		Butterdroid_Setup_Data(PC), A1		   ; Offset_0x049E34
		jsr		(SetupSlottedObjectAttributes).l		; Offset_0x04298C
		move.l	#Offset_0x049E46, Obj_Child_Data(A0)			 ; $0030
		rts
;-------------------------------------------------------------------------------
Offset_0x049E06:
		jsr		(Find_Player).l				   ; Offset_0x042634
		bclr	#$00, Obj_Flags(A0)				 ; $0004
		tst.w	D0
		beq.s	Offset_0x049E1C
		bset	#$00, Obj_Flags(A0)				 ; $0004
Offset_0x049E1C:
		move.w	#$0100, D0
		move.w	#$0004, D1
		jsr		Chase_Object(PC)			   ; Offset_0x042E6C
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jmp		(AnimateRaw).l				  ; Offset_0x04208E
;-------------------------------------------------------------------------------
Butterdroid_Setup_Data:						   ; Offset_0x049E34
		dc.w	$0003, $A512, $0009, $0000
		dc.l	Butterdroid_Mappings		   ; Offset_0x10E15C
		dc.w	$0280
		dc.b	$0C, $0C, $00, $00
;-------------------------------------------------------------------------------
Butterdroid_PLC_Data:
			  ; dc.l	Art_Butterdroid
			  ; dc.l	Butterdroid_Dyn_Script		   ; Offset_0x10E18E
;-------------------------------------------------------------------------------
Offset_0x049E46:
		dc.b	$07, $00, $01, $02, $03, $04, $03, $02
		dc.b	$01, $FC
;===============================================================================
; Objeto 0x96 - Inimigo Butterdroid na Mushroom Valley
; <<<-
;===============================================================================