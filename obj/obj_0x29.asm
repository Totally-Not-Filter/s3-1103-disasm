;===============================================================================
; Objeto 0x29 - Plataformas que desaparecem na Angel Island
; ->>>
;===============================================================================
Offset_0x020EC0:
		dc.w	$0001, $0003, $0007, $000F, $001F, $003F, $007F, $00FF
		dc.w	$01FF, $03FF, $07FF, $0FFF, $1FFF, $3FFF, $7FFF, $FFFF
;-------------------------------------------------------------------------------
Obj_0x29_AIz_Disappearing_Platform:					   ; Offset_0x020EE0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.b	D0, D1
		andi.w	#$000F, D0
		move.w	D0, D2
		add.w	D0, D0
		move.w	Offset_0x020EC0(PC, D0), Obj_Control_Var_02(A0)	 ; $0032
		subq.w	#$03, D2
		bcc.s	Offset_0x020EFA
		moveq	#$00, D2
Offset_0x020EFA:
		lsr.w	#$04, D1
		andi.w	#$000F, D1
		lsl.w	D2, D1
		move.w	D1, Obj_Control_Var_04(A0)				 ; $0034
		move.l	#AIz_Disappearing_Platform_Mappings, Obj_Map(A0) ; Offset_0x021050, $000C
		move.w	#$42F0, Obj_Art_VRAM(A0)				 ; $000A
		move.w	#$4001, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$20, Obj_Width(A0)				 ; $0007
		move.b	#$18, Obj_Height(A0)					 ; $0006
		move.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0280, Obj_Priority(A0)				 ; $0008
		move.w	(Level_Frame_Count).w, D0			 ; $FFFFFE04
		add.w	Obj_Control_Var_04(A0), D0				 ; $0034
		and.w	Obj_Control_Var_02(A0), D0				 ; $0032
		beq.s	Offset_0x020F5E
		subi.w	#$00C8, D0
		bcc.s	Offset_0x020F5E
		neg.w	D0
		move.b	D0, Obj_Ani_Time(A0)					 ; $0024
		move.b	#$00, Obj_Ani_Frame(A0)					 ; $0023
		move.w	#$0202, Obj_Ani_Number(A0)				 ; $0020
		move.b	#$05, Obj_Map_Id(A0)					 ; $0022
Offset_0x020F5E:
		move.l	#Offset_0x020F64, (A0)
Offset_0x020F64:
		move.w	(Level_Frame_Count).w, D0			 ; $FFFFFE04
		add.w	Obj_Control_Var_04(A0), D0				 ; $0034
		and.w	Obj_Control_Var_02(A0), D0				 ; $0032
		bne.w	Offset_0x020F80
		move.w	#$0100, Obj_Ani_Number(A0)				 ; $0020
		move.b	#$00, Obj_Control_Var_06(A0)			 ; $0036
Offset_0x020F80:
		lea		(AIz_Disappearing_Platform_Animate_Data).l, A1 ; Offset_0x021030
		jsr		(AnimateSprite_2).l			   ; Offset_0x0111FE
		cmpi.b	#$05, Obj_Map_Id(A0)					 ; $0022
		bne.s	Offset_0x020FE6
		tst.b	Obj_Control_Var_06(A0)					 ; $0036
		bne.s	Offset_0x020FE6
		move.b	#$01, Obj_Control_Var_06(A0)			 ; $0036
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x020FE6
		move.l	#Offset_0x020FEC, (A1)
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		move.l	#AIz_Disappearing_Platform_Mappings_2, Obj_Map(A1) ; Offset_0x02105C, $000C
		move.w	#$62F0, Obj_Art_VRAM(A1)				 ; $000A
		move.b	#$28, Obj_Width(A1)				 ; $0007
		move.b	#$20, Obj_Height(A1)					 ; $0006
		move.b	#$04, Obj_Flags(A1)				 ; $0004
		move.w	#$0200, Obj_Priority(A1)				 ; $0008
		move.w	A0, Obj_Control_Var_0C(A1)				 ; $003C
Offset_0x020FE6:
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Offset_0x020FEC:
		move.w	Obj_Control_Var_0C(A0), A1				 ; $003C
		cmpi.b	#$03, Obj_Map_Id(A1)					 ; $0022
		bne.s	Offset_0x020FFE
		move.w	#$7FF0, Obj_X(A0)				 ; $0010
Offset_0x020FFE:
		subq.b	#$01, Obj_Ani_Time(A0)					 ; $0024
		bpl.s	Offset_0x021014
		move.b	#$03, Obj_Ani_Time(A0)					 ; $0024
		addq.b	#$01, Obj_Map_Id(A0)					 ; $0022
		andi.b	#$03, Obj_Map_Id(A0)					 ; $0022
Offset_0x021014:
		move.w	#$002B, D1
		move.w	#$0018, D2
		move.w	#$0019, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Solid_Object).l				   ; Offset_0x013556
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
AIz_Disappearing_Platform_Animate_Data:				   ; Offset_0x021030
		dc.w	Offset_0x021036-AIz_Disappearing_Platform_Animate_Data
		dc.w	Offset_0x021039-AIz_Disappearing_Platform_Animate_Data
		dc.w	Offset_0x021045-AIz_Disappearing_Platform_Animate_Data
Offset_0x021036:
		dc.b	$00, $1F, $FF
Offset_0x021039:
		dc.b	$01, $01, $02, $01, $03, $01, $04, $01
		dc.b	$05, $7F, $05, $3F
Offset_0x021045:
		dc.b	$04, $03, $03, $02, $02, $01, $01, $01
		dc.b	$FD, $00, $00
;-------------------------------------------------------------------------------
AIz_Disappearing_Platform_Mappings:					   ; Offset_0x021050
		dc.w	Offset_0x021064-AIz_Disappearing_Platform_Mappings
		dc.w	Offset_0x021068-AIz_Disappearing_Platform_Mappings
		dc.w	Offset_0x021076-AIz_Disappearing_Platform_Mappings
		dc.w	Offset_0x021096-AIz_Disappearing_Platform_Mappings
		dc.w	Offset_0x0210B0-AIz_Disappearing_Platform_Mappings
		dc.w	Offset_0x0210DC-AIz_Disappearing_Platform_Mappings
;-------------------------------------------------------------------------------
AIz_Disappearing_Platform_Mappings_2:				   ; Offset_0x02105C
		dc.w	Offset_0x021102-AIz_Disappearing_Platform_Mappings_2
		dc.w	Offset_0x021140-AIz_Disappearing_Platform_Mappings_2
		dc.w	Offset_0x021172-AIz_Disappearing_Platform_Mappings_2
		dc.w	Offset_0x0211A4-AIz_Disappearing_Platform_Mappings_2
Offset_0x021064:
		dc.w	$0000
		dc.w	$0000
Offset_0x021068:
		dc.w	$0002
		dc.w	$E805, $0324, $FFF0
		dc.w	$E805, $0B24, $0000
Offset_0x021076:
		dc.w	$0005
		dc.w	$E805, $0B24, $FFE8
		dc.w	$E805, $0324, $FFF8
		dc.w	$E805, $0324, $0008
		dc.w	$F805, $1324, $FFF0
		dc.w	$F805, $1324, $0000
Offset_0x021096:
		dc.w	$0004
		dc.w	$E807, $0328, $FFE0
		dc.w	$E807, $0B28, $FFF0
		dc.w	$E807, $0328, $0000
		dc.w	$E807, $0B28, $0010
Offset_0x0210B0:
		dc.w	$0007
		dc.w	$E80D, $002A, $FFE0
		dc.w	$E80D, $002A, $0000
		dc.w	$F80D, $0330, $FFE0
		dc.w	$F80D, $0B30, $0000
		dc.w	$0805, $1B24, $FFE8
		dc.w	$0805, $0B24, $FFF8
		dc.w	$0805, $1324, $0008
Offset_0x0210DC:
		dc.w	$0006
		dc.w	$E80D, $002A, $FFE0
		dc.w	$F80D, $1016, $FFE0
		dc.w	$080D, $0032, $FFE0
		dc.w	$E80D, $002A, $0000
		dc.w	$F80D, $1016, $0000
		dc.w	$080D, $0832, $0000
Offset_0x021102:
		dc.w	$000A
		dc.w	$D80A, $0049, $FFD0
		dc.w	$E009, $0052, $FFE8
		dc.w	$E009, $0852, $0000
		dc.w	$D80A, $0849, $0018
		dc.w	$F005, $0058, $FFD0
		dc.w	$F005, $0858, $0020
		dc.w	$0007, $005C, $FFD8
		dc.w	$0007, $085C, $0018
		dc.w	$1009, $0064, $FFE8
		dc.w	$1009, $0864, $0000
Offset_0x021140:
		dc.w	$0008
		dc.w	$E007, $105C, $FFD8
		dc.w	$E009, $0864, $FFE8
		dc.w	$E009, $0064, $0000
		dc.w	$E007, $185C, $0018
		dc.w	$0007, $006A, $FFD8
		dc.w	$0007, $086A, $0018
		dc.w	$1009, $1064, $FFE8
		dc.w	$1009, $1864, $0000
Offset_0x021172:
		dc.w	$0008
		dc.w	$E007, $106A, $FFD8
		dc.w	$E009, $0064, $FFE8
		dc.w	$E009, $0864, $0000
		dc.w	$E007, $186A, $0018
		dc.w	$0007, $005C, $FFD8
		dc.w	$0007, $085C, $0018
		dc.w	$1009, $0052, $FFE8
		dc.w	$1009, $0852, $0000
Offset_0x0211A4:
		dc.w	$0008
		dc.w	$E007, $105C, $FFD8
		dc.w	$E009, $1852, $FFE8
		dc.w	$E009, $1052, $0000
		dc.w	$E007, $185C, $0018
		dc.w	$0007, $006A, $FFD8
		dc.w	$0007, $086A, $0018
		dc.w	$1009, $0852, $FFE8
		dc.w	$1009, $0052, $0000
;===============================================================================
; Objeto 0x29 - Plataformas que desaparecem na Angel Island
; <<<-
;===============================================================================