;-------------------------------------------------------------------------------
; Knuckles
; ->>>
;-------------------------------------------------------------------------------
; Offset_0x018EA0:
		move.l	#Knuckles_Mappings, Obj_Map(A0) ; Offset_0x018FCA, $000C
		move.w	#$0100, Obj_Priority(A0)				 ; $0008
		move.b	#$18, Obj_Width(A0)				 ; $0007
		move.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$26A0, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$FF, Obj_Player_Control(A0)			 ; $002E
		move.l	#Offset_0x018EDE, (A0)
		move.w	#$0001, Obj_Ani_Number(A0)				 ; $0020
		move.b	#$00, Obj_Map_Id(A0)					 ; $0022
		move.b	#$00, Obj_Ani_Frame(A0)					 ; $0023
Offset_0x018EDE:
		move.w	Obj_X(A0), D0					 ; $0010
		sub.w	(Obj_Player_One+Obj_X).w, D0		 ; $FFFFB010
		cmpi.w	#$0070, D0
		bcc.s	Offset_0x018EF8
		move.b	#$01, Obj_Ani_Number(A0)				 ; $0020
		move.l	#Offset_0x018F10, (A0)
Offset_0x018EF8:
		lea		(Knuckles_Animate_Data).l, A1			 ; Offset_0x018F48
		jsr		(AnimateSprite_2).l			   ; Offset_0x0111FE
		jsr		(Load_Knuckles_Dynamic_PLC).l			   ; Offset_0x018F76
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Offset_0x018F10:
		lea		(Knuckles_Animate_Data).l, A1			 ; Offset_0x018F48
		jsr		(AnimateSprite_2).l			   ; Offset_0x0111FE
		tst.b	Obj_Routine(A0)					 ; $0005
		beq.s	Offset_0x018F34
		move.b	#$02, Obj_Ani_Number(A0)				 ; $0020
		move.w	#$0800, Obj_Speed_X(A0)					 ; $0018
		move.l	#Offset_0x018F40, (A0)
Offset_0x018F34:
		jsr		(Load_Knuckles_Dynamic_PLC).l			 ; Offset_0x018F76
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Offset_0x018F40:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		bra.s	Offset_0x018EF8
;-------------------------------------------------------------------------------
Knuckles_Animate_Data:						   ; Offset_0x018F48
		dc.w	Offset_0x018F4E-Knuckles_Animate_Data
		dc.w	Offset_0x018F51-Knuckles_Animate_Data
		dc.w	Offset_0x018F64-Knuckles_Animate_Data
Offset_0x018F4E:
		dc.b	$01, $0F, $FF
Offset_0x018F51:
		dc.b	$01, $7F, $02, $1D, $03, $3B, $04, $04
		dc.b	$05, $04, $06, $3B, $07, $04, $06, $04
		dc.b	$07, $1D, $FC
Offset_0x018F64:
		dc.b	$08, $01, $09, $01, $0A, $01, $0B, $01
		dc.b	$0C, $01, $0D, $01, $0E, $01, $0F, $01
		dc.b	$FF, $00
;-------------------------------------------------------------------------------
Load_Knuckles_Dynamic_PLC:					   ; Offset_0x018F76
		moveq	#$00, D0
		move.b	Obj_Map_Id(A0), D0				 ; $0022
		cmp.b	Obj_Player_Control(A0), D0				 ; $002E
		beq.s	Offset_0x018FC8
		move.b	D0, Obj_Player_Control(A0)				 ; $002E
		lea		(Knuckles_Dyn_Script).l, A2		 ; Offset_0x019166
		add.w	D0, D0
		adda.w	(A2, D0), A2
		move.w	(A2)+, D5
		subq.w	#$01, D5
		bmi.s	Offset_0x018FC8
		move.w	#$D400, D4
Offset_0x018F9C:
		moveq	#$00, D1
		move.w	(A2)+, D1
		move.w	D1, D3
		lsr.w	#$08, D3
		andi.w	#$00F0, D3
		addi.w	#$0010, D3
		andi.w	#$0FFF, D1
		lsl.l	#$05, D1
		addi.l	#Art_Knuckles, D1			   ; Offset_0x072F60
		move.w	D4, D2
		add.w	D3, D4
		add.w	D3, D4
		jsr		(QueueDMATransfer).l				; Offset_0x0012FC
		dbra	D5, Offset_0x018F9C
Offset_0x018FC8:
		rts
;-------------------------------------------------------------------------------
Knuckles_Mappings:							   ; Offset_0x018FCA
		dc.w	Offset_0x018FEA-Knuckles_Mappings
		dc.w	Offset_0x018FEC-Knuckles_Mappings
		dc.w	Offset_0x019006-Knuckles_Mappings
		dc.w	Offset_0x019020-Knuckles_Mappings
		dc.w	Offset_0x01903A-Knuckles_Mappings
		dc.w	Offset_0x019054-Knuckles_Mappings
		dc.w	Offset_0x019068-Knuckles_Mappings
		dc.w	Offset_0x019082-Knuckles_Mappings
		dc.w	Offset_0x01909C-Knuckles_Mappings
		dc.w	Offset_0x0190B6-Knuckles_Mappings
		dc.w	Offset_0x0190D0-Knuckles_Mappings
		dc.w	Offset_0x0190DE-Knuckles_Mappings
		dc.w	Offset_0x0190F2-Knuckles_Mappings
		dc.w	Offset_0x019112-Knuckles_Mappings
		dc.w	Offset_0x019132-Knuckles_Mappings
		dc.w	Offset_0x01914C-Knuckles_Mappings
Offset_0x018FEA:
		dc.w	$0000
Offset_0x018FEC:
		dc.w	$0004
		dc.w	$EC0E, $0000, $FFF4
		dc.w	$F401, $000C, $FFEC
		dc.w	$0404, $000E, $FFFC
		dc.w	$0C0C, $0010, $FFF4
Offset_0x019006:
		dc.w	$0004
		dc.w	$EC0E, $0000, $FFF4
		dc.w	$FC00, $000C, $FFEC
		dc.w	$0404, $000D, $FFFC
		dc.w	$0C0C, $000F, $FFF4
Offset_0x019020:
		dc.w	$0004
		dc.w	$EC0E, $0000, $FFF4
		dc.w	$FC00, $000C, $FFEC
		dc.w	$0408, $000D, $FFFC
		dc.w	$0C0C, $0010, $FFF4
Offset_0x01903A:
		dc.w	$0004
		dc.w	$EC0E, $0000, $FFF4
		dc.w	$F401, $000C, $FFEC
		dc.w	$0408, $000E, $FFFC
		dc.w	$0C0C, $0011, $FFF4
Offset_0x019054:
		dc.w	$0003
		dc.w	$EC0F, $0000, $FFF4
		dc.w	$FC01, $0010, $FFEC
		dc.w	$0C0C, $0012, $FFF4
Offset_0x019068:
		dc.w	$0004
		dc.w	$EC0E, $0000, $FFF4
		dc.w	$F401, $000C, $FFEC
		dc.w	$0408, $000E, $FFFC
		dc.w	$0C0C, $0011, $FFF4
Offset_0x019082:
		dc.w	$0004
		dc.w	$EC0E, $0000, $FFF4
		dc.w	$F401, $000C, $FFEC
		dc.w	$0408, $000E, $FFFC
		dc.w	$0C0C, $0011, $FFF4
Offset_0x01909C:
		dc.w	$0004
		dc.w	$EC08, $0000, $FFF4
		dc.w	$F407, $0003, $FFEC
		dc.w	$F40A, $000B, $FFFC
		dc.w	$0C04, $0014, $0004
Offset_0x0190B6:
		dc.w	$0004
		dc.w	$EC0D, $0000, $FFF4
		dc.w	$FC06, $0008, $FFEC
		dc.w	$FC09, $000E, $FFFC
		dc.w	$0C04, $0014, $0004
Offset_0x0190D0:
		dc.w	$0002
		dc.w	$EC0F, $0000, $FFF0
		dc.w	$0C08, $0010, $FFF0
Offset_0x0190DE:
		dc.w	$0003
		dc.w	$EC09, $0000, $FFF4
		dc.w	$F401, $0006, $000C
		dc.w	$FC0E, $0008, $FFEC
Offset_0x0190F2:
		dc.w	$0005
		dc.w	$EC0D, $0000, $FFF0
		dc.w	$FC06, $0008, $FFE8
		dc.w	$FC09, $000E, $FFF8
		dc.w	$F401, $0014, $0010
		dc.w	$0C04, $0016, $0000
Offset_0x019112:
		dc.w	$0005
		dc.w	$EC09, $0000, $FFF4
		dc.w	$FC06, $0006, $FFEC
		dc.w	$FC09, $000C, $FFFC
		dc.w	$F400, $0012, $000C
		dc.w	$0C04, $0013, $0004
Offset_0x019132:
		dc.w	$0004
		dc.w	$EC0B, $0000, $FFF4
		dc.w	$F401, $000C, $FFEC
		dc.w	$F400, $000E, $000C
		dc.w	$0C04, $000F, $FFF4
Offset_0x01914C:
		dc.w	$0004
		dc.w	$EC0B, $0000, $FFF4
		dc.w	$FC00, $000C, $FFEC
		dc.w	$F402, $000D, $000C
		dc.w	$0C08, $0010, $FFF4
;-------------------------------------------------------------------------------
Knuckles_Dyn_Script:						   ; Offset_0x019166
		dc.w	Offset_0x019186-Knuckles_Dyn_Script
		dc.w	Offset_0x019188-Knuckles_Dyn_Script
		dc.w	Offset_0x019192-Knuckles_Dyn_Script
		dc.w	Offset_0x01919C-Knuckles_Dyn_Script
		dc.w	Offset_0x0191A6-Knuckles_Dyn_Script
		dc.w	Offset_0x0191B0-Knuckles_Dyn_Script
		dc.w	Offset_0x0191B8-Knuckles_Dyn_Script
		dc.w	Offset_0x0191C2-Knuckles_Dyn_Script
		dc.w	Offset_0x0191CC-Knuckles_Dyn_Script
		dc.w	Offset_0x0191D6-Knuckles_Dyn_Script
		dc.w	Offset_0x0191E0-Knuckles_Dyn_Script
		dc.w	Offset_0x0191E6-Knuckles_Dyn_Script
		dc.w	Offset_0x0191EE-Knuckles_Dyn_Script
		dc.w	Offset_0x0191FA-Knuckles_Dyn_Script
		dc.w	Offset_0x019206-Knuckles_Dyn_Script
		dc.w	Offset_0x019210-Knuckles_Dyn_Script
Offset_0x019186:
		dc.w	$0000
Offset_0x019188:
		dc.w	$0004
		dc.w	$B000, $100C, $100E, $3010
Offset_0x019192:
		dc.w	$0004
		dc.w	$B014, $0020, $100E, $3010
Offset_0x01919C:
		dc.w	$0004
		dc.w	$B021, $002D, $202E, $3031
Offset_0x0191A6:
		dc.w	$0004
		dc.w	$B035, $1041, $202E, $3031
Offset_0x0191B0:
		dc.w	$0003
		dc.w	$F043, $1053, $3031
Offset_0x0191B8:
		dc.w	$0004
		dc.w	$B055, $1061, $202E, $3031
Offset_0x0191C2:
		dc.w	$0004
		dc.w	$B063, $106F, $202E, $3031
Offset_0x0191CC:
		dc.w	$0004
		dc.w	$2071, $7074, $807C, $1085
Offset_0x0191D6:
		dc.w	$0004
		dc.w	$7087, $508F, $5095, $109B
Offset_0x0191E0:
		dc.w	$0002
		dc.w	$F09D, $20AD
Offset_0x0191E6:
		dc.w	$0003
		dc.w	$50B0, $10B6, $B0B8
Offset_0x0191EE:
		dc.w	$0005
		dc.w	$70C4, $50CC, $50D2, $10D8, $10DA
Offset_0x0191FA:
		dc.w	$0005
		dc.w	$50DC, $50E2, $50E8, $00EE, $10EF
Offset_0x019206:
		dc.w	$0004
		dc.w	$B0F1, $10FD, $00FF, $1100
Offset_0x019210:
		dc.w	$0004
		dc.w	$B102, $010E, $210F, $2112
;-------------------------------------------------------------------------------
; Knuckles
; <<<-
;-------------------------------------------------------------------------------