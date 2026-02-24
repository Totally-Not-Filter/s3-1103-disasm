;===============================================================================
; Objeto 0xC8 - Suporte de gelo nas extremidades dos trampolins
; ->>>
;===============================================================================
; Offset_0x046A00:
		jsr		(Object_Check_Range).l		   ; Offset_0x04326E
		lea		Trampoline_Support_Setup_Data(PC), A1  ; Offset_0x046AB2
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.l	#Offset_0x046A14, (A0)
Offset_0x046A14:
		moveq	#$1B, D1
		moveq	#$10, D2
		moveq	#$11, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Platform_Object).l			   ; Offset_0x013AF6
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;===============================================================================
; Objeto 0xC8 - Suporte de gelo nas extremidades dos trampolins
; <<<-
;===============================================================================