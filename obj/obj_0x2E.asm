;===============================================================================
; Objeto 0x2E - Tronco com espinhos giratório na Angel Island
; ->>>
;===============================================================================
; Offset_0x022A7E:
		move.l	#Spiked_Rotating_Log_Mappings, Obj_Map(A0) ; Offset_0x022C4E, $000C
		move.w	#$42F0, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$18, Obj_Width(A0)				 ; $0007
		move.b	#$08, Obj_Height(A0)					 ; $0006
		move.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0200, Obj_Priority(A0)				 ; $0008
		move.w	Obj_Y(A0), Obj_Control_Var_00(A0)		  ; $0014, $0030
		move.b	(Water_Entered_Counter).w, Obj_Control_Var_06(A0) ; $FFFFF64D, $0036
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x022AD4
		move.l	#Offset_0x022C14, (A1)
		move.b	#$04, Obj_Flags(A1)				 ; $0004
		move.b	#$9C, Obj_Col_Flags(A1)					 ; $0028
		move.w	A0, Obj_Control_Var_0C(A1)				 ; $003C
		move.w	A1, Obj_Control_Var_0C(A0)				 ; $003C
Offset_0x022AD4:
		move.l	#Offset_0x022ADA, (A0)
Offset_0x022ADA:
		tst.b	Obj_Control_Var_04(A0)					 ; $0034
		bmi.s	Offset_0x022B0E
		move.b	Obj_Control_Var_06(A0), D0				 ; $0036
		cmp.b	(Water_Entered_Counter).w, D0		 ; $FFFFF64D
		beq.s	Offset_0x022AF8
		move.b	(Water_Entered_Counter).w, Obj_Control_Var_06(A0) ; $FFFFF64D, $0036
		move.b	#$81, Obj_Control_Var_04(A0)			 ; $0034
		bra.s	Offset_0x022B0E
Offset_0x022AF8:
		move.b	Obj_Status(A0), D0				 ; $002A
		andi.b	#$18, D0
		bne.s	Offset_0x022B0E
		tst.b	Obj_Control_Var_02(A0)					 ; $0032
		beq.s	Offset_0x022B40
		subq.b	#$04, Obj_Control_Var_02(A0)			 ; $0032
		bra.s	Offset_0x022B40
Offset_0x022B0E:
		tst.b	Obj_Control_Var_04(A0)					 ; $0034
		bne.s	Offset_0x022B2C
		move.b	Obj_Ani_Frame(A0), Obj_Control_Var_05(A0) ; $0023, $0035
		move.b	#$00, Obj_Ani_Frame(A0)					 ; $0023
		move.b	#$00, Obj_Ani_Time(A0)					 ; $0024
		move.b	#$01, Obj_Control_Var_04(A0)			 ; $0034
Offset_0x022B2C:
		cmpi.b	#$40, Obj_Control_Var_02(A0)			 ; $0032
		beq.s	Offset_0x022B3A
		addq.b	#$04, Obj_Control_Var_02(A0)			 ; $0032
		bra.s	Offset_0x022B40
Offset_0x022B3A:
		andi.b	#$7F, Obj_Control_Var_04(A0)			 ; $0034
Offset_0x022B40:
		move.b	Obj_Control_Var_02(A0), D0				 ; $0032
		jsr		(CalcSine).l					 ; Offset_0x001B20
		asr.w	#$05, D0
		add.w	Obj_Control_Var_00(A0), D0				 ; $0030
		move.w	D0, Obj_Y(A0)					 ; $0014
		tst.b	Obj_Control_Var_04(A0)					 ; $0034
		beq.s	Offset_0x022B8A
		subq.b	#$01, Obj_Ani_Time(A0)					 ; $0024
		bpl.s	Offset_0x022BBC
		move.b	#$03, Obj_Ani_Time(A0)					 ; $0024
		subq.b	#$01, Obj_Map_Id(A0)					 ; $0022
		andi.b	#$0F, Obj_Map_Id(A0)					 ; $0022
		addq.b	#$01, Obj_Ani_Frame(A0)					 ; $0023
		cmpi.b	#$10, Obj_Ani_Frame(A0)					 ; $0023
		bcs.s	Offset_0x022BBC
		move.b	Obj_Control_Var_05(A0), Obj_Ani_Frame(A0) ; $0035, $0023
		move.b	#$00, Obj_Control_Var_04(A0)			 ; $0034
		bra.s	Offset_0x022BBC
Offset_0x022B8A:
		subq.b	#$01, Obj_Ani_Time(A0)					 ; $0024
		bpl.s	Offset_0x022BBC
		move.b	#$17, Obj_Ani_Time(A0)					 ; $0024
		moveq	#$00, D0
		move.b	Obj_Ani_Frame(A0), D0					 ; $0023
		addq.b	#$01, Obj_Ani_Frame(A0)					 ; $0023
		move.b	Offset_0x022BB4(PC, D0), Obj_Map_Id(A0)			 ; $0022
		move.b	Offset_0x022BB4+$01(PC, D0), D0
		bpl.s	Offset_0x022BB2
		move.b	#$00, Obj_Ani_Frame(A0)					 ; $0023
Offset_0x022BB2:
		bra.s	Offset_0x022BBC
;-------------------------------------------------------------------------------
Offset_0x022BB4:
		dc.b	$07, $08, $09, $0A, $09, $08, $FF, $00
;-------------------------------------------------------------------------------
Offset_0x022BBC:
		moveq	#$00, D1
		move.b	Obj_Width(A0), D1				 ; $0007
		addi.w	#$000B, D1
		moveq	#$00, D2
		move.b	Obj_Height(A0), D2				 ; $0006
		move.w	D2, D3
		addq.w	#$01, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Solid_Object).l				   ; Offset_0x013556
		move.w	Obj_X(A0), D0					 ; $0010
		andi.w	#$FF80, D0
		sub.w	(Camera_X_Left).w, D0				 ; $FFFFF7DA
		cmpi.w	#$0280, D0
		bhi.w	Offset_0x022BF4
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x022BF4:
		move.w	Obj_Control_Var_0C(A0), D0				 ; $003C
		beq.s	Offset_0x022C02
		move.w	D0, A1
		jsr		(Delete_A1_Object).l			   ; Offset_0x01113A
Offset_0x022C02:
		move.w	Obj_Respaw_Ref(A0), D0					 ; $0048
		beq.s	Offset_0x022C0E
		move.w	D0, A2
		bclr	#$07, (A2)
Offset_0x022C0E:
		jmp		(DeleteObject).l				   ; Offset_0x011138
;-------------------------------------------------------------------------------
Offset_0x022C14:
		move.w	Obj_Control_Var_0C(A0), A1				 ; $003C
		move.w	Obj_X(A1), Obj_X(A0)			  ; $0010, $0010
		move.w	Obj_Y(A1), Obj_Y(A0)			  ; $0014, $0014
		moveq	#$00, D0
		move.b	Obj_Map_Id(A1), D0				 ; $0022
		move.b	Offset_0x022C3E(PC, D0), D0
		beq.s	Offset_0x022C3C
		ext.w	D0
		add.w	D0, Obj_Y(A0)					 ; $0014
		jmp		(Add_SpriteToCollisionResponseList).l		  ; Offset_0x00A540
Offset_0x022C3C:
		rts
;-------------------------------------------------------------------------------
Offset_0x022C3E:
		dc.b	$F4, $F4, $00, $00, $00, $00, $00, $0C
		dc.b	$0C, $0C, $00, $00, $00, $00, $00, $F4
;-------------------------------------------------------------------------------
Spiked_Rotating_Log_Mappings:				   ; Offset_0x022C4E
		dc.w	Offset_0x022C6E-Spiked_Rotating_Log_Mappings
		dc.w	Offset_0x022C8E-Spiked_Rotating_Log_Mappings
		dc.w	Offset_0x022CAE-Spiked_Rotating_Log_Mappings
		dc.w	Offset_0x022CCE-Spiked_Rotating_Log_Mappings
		dc.w	Offset_0x022CEE-Spiked_Rotating_Log_Mappings
		dc.w	Offset_0x022D0E-Spiked_Rotating_Log_Mappings
		dc.w	Offset_0x022D2E-Spiked_Rotating_Log_Mappings
		dc.w	Offset_0x022D4E-Spiked_Rotating_Log_Mappings
		dc.w	Offset_0x022D6E-Spiked_Rotating_Log_Mappings
		dc.w	Offset_0x022D8E-Spiked_Rotating_Log_Mappings
		dc.w	Offset_0x022DAE-Spiked_Rotating_Log_Mappings
		dc.w	Offset_0x022DC8-Spiked_Rotating_Log_Mappings
		dc.w	Offset_0x022DDC-Spiked_Rotating_Log_Mappings
		dc.w	Offset_0x022DEA-Spiked_Rotating_Log_Mappings
		dc.w	Offset_0x022DFE-Spiked_Rotating_Log_Mappings
		dc.w	Offset_0x022E18-Spiked_Rotating_Log_Mappings
Offset_0x022C6E:
		dc.w	$0005
		dc.w	$F000, $000B, $FFEC
		dc.w	$F001, $000C, $FFFC
		dc.w	$F301, $000E, $000C
		dc.w	$F809, $0015, $FFE8
		dc.w	$F809, $001B, $0000
Offset_0x022C8E:
		dc.w	$0005
		dc.w	$F001, $000C, $FFEC
		dc.w	$F301, $000E, $FFFC
		dc.w	$F601, $0010, $000C
		dc.w	$F809, $0815, $0000
		dc.w	$F809, $081B, $FFE8
Offset_0x022CAE:
		dc.w	$0005
		dc.w	$F301, $000E, $FFEC
		dc.w	$F601, $0010, $FFFC
		dc.w	$F901, $0012, $000C
		dc.w	$F809, $0015, $FFE8
		dc.w	$F809, $001B, $0000
Offset_0x022CCE:
		dc.w	$0005
		dc.w	$F601, $0010, $FFEC
		dc.w	$F901, $0012, $FFFC
		dc.w	$FC00, $0014, $000C
		dc.w	$F809, $0815, $0000
		dc.w	$F809, $081B, $FFE8
Offset_0x022CEE:
		dc.w	$0005
		dc.w	$F901, $0012, $FFEC
		dc.w	$FC00, $0014, $FFFC
		dc.w	$F701, $1012, $000C
		dc.w	$F809, $0015, $FFE8
		dc.w	$F809, $001B, $0000
Offset_0x022D0E:
		dc.w	$0005
		dc.w	$FC00, $0014, $FFEC
		dc.w	$F701, $1012, $FFFC
		dc.w	$FA01, $1010, $000C
		dc.w	$F809, $0815, $0000
		dc.w	$F809, $081B, $FFE8
Offset_0x022D2E:
		dc.w	$0005
		dc.w	$F701, $1012, $FFEC
		dc.w	$FA01, $1010, $FFFC
		dc.w	$FD01, $100E, $000C
		dc.w	$F809, $0015, $FFE8
		dc.w	$F809, $001B, $0000
Offset_0x022D4E:
		dc.w	$0005
		dc.w	$FA01, $1010, $FFEC
		dc.w	$FD01, $100E, $FFFC
		dc.w	$0001, $100C, $000C
		dc.w	$F809, $0815, $0000
		dc.w	$F809, $081B, $FFE8
Offset_0x022D6E:
		dc.w	$0005
		dc.w	$FD01, $100E, $FFEC
		dc.w	$0001, $100C, $FFFC
		dc.w	$0800, $100B, $000C
		dc.w	$F809, $0015, $FFE8
		dc.w	$F809, $001B, $0000
Offset_0x022D8E:
		dc.w	$0005
		dc.w	$0001, $100C, $FFEC
		dc.w	$0800, $100B, $FFFC
		dc.w	$0800, $100A, $000C
		dc.w	$F809, $0815, $0000
		dc.w	$F809, $081B, $FFE8
Offset_0x022DAE:
		dc.w	$0004
		dc.w	$0800, $100B, $FFEC
		dc.w	$0800, $100A, $FFFC
		dc.w	$F809, $0015, $FFE8
		dc.w	$F809, $001B, $0000
Offset_0x022DC8:
		dc.w	$0003
		dc.w	$0800, $100A, $FFEC
		dc.w	$F809, $0815, $0000
		dc.w	$F809, $081B, $FFE8
Offset_0x022DDC:
		dc.w	$0002
		dc.w	$F809, $0015, $FFE8
		dc.w	$F809, $001B, $0000
Offset_0x022DEA:
		dc.w	$0003
		dc.w	$F000, $000A, $000C
		dc.w	$F809, $0815, $0000
		dc.w	$F809, $081B, $FFE8
Offset_0x022DFE:
		dc.w	$0004
		dc.w	$F000, $000A, $FFFC
		dc.w	$F000, $000B, $000C
		dc.w	$F809, $0015, $FFE8
		dc.w	$F809, $001B, $0000
Offset_0x022E18:
		dc.w	$0005
		dc.w	$F000, $000A, $FFEC
		dc.w	$F000, $000B, $FFFC
		dc.w	$F001, $000C, $000C
		dc.w	$F809, $0815, $0000
		dc.w	$F809, $081B, $FFE8
;===============================================================================
; Objeto 0x2E - Tronco com espinhos giratório na Angel Island
; <<<-
;===============================================================================