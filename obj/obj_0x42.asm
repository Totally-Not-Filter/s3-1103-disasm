;===============================================================================
; Objeto 0x42 - Canhão na Carnival Night
; ->>>
;===============================================================================
; Offset_0x02794E:
		move.l	#Cannon_Mappings, Obj_Map(A0)	; Offset_0x027C10, $000C
		move.w	#$4374, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0280, Obj_Priority(A0)				 ; $0008
		move.b	#$30, Obj_Width(A0)				 ; $0007
		move.b	#$30, Obj_Height(A0)					 ; $0006
		move.b	#$09, Obj_Map_Id(A0)					 ; $0022
		bset	#$06, Obj_Flags(A0)				 ; $0004
		move.w	#$0001, Obj_Sub_Y(A0)					 ; $0016
		lea		Obj_Speed_X(A0), A2				 ; $0018
		move.w	Obj_X(A0), (A2)+				 ; $0010
		move.w	Obj_Y(A0), (A2)+				 ; $0014
		move.w	#$0004, (A2)
		move.l	#Offset_0x02799C, (A0)
Offset_0x02799C:
		bsr.s	Offset_0x0279CA
		lea		Obj_Control_Var_00(A0), A2				 ; $0030
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		moveq	#$03, D6
		move.w	(Control_Ports_Logical_Data).w, D1			 ; $FFFFF602
		bsr.w	Offset_0x027A92
		addq.w	#$01, A2
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		moveq	#$04, D6
		move.w	(Control_Ports_Logical_Data_2).w, D1		 ; $FFFFF66A
		bsr.w	Offset_0x027A92
		bsr.w	Offset_0x027BB6
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
Offset_0x0279CA:
		move.w	Obj_Control_Var_04(A0), D0				 ; $0034
		bne.s	Offset_0x0279E2
		move.w	#$0010, D1
		move.w	#$0029, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jmp		(Platform_Object).l			   ; Offset_0x013AF6
Offset_0x0279E2:
		subq.w	#$01, D0
		bne.s	Offset_0x027A12
		move.b	Obj_Angle(A0), D0				 ; $0026
		addq.b	#$02, Obj_Angle(A0)				 ; $0026
		jsr		(CalcSine).l					 ; Offset_0x001B20
		addi.w	#$0120, D0
		lsr.w	#$06, D0
		move.b	D0, $001D(A0)
		move.b	(Level_Frame_Count+$01).w, D0		 ; $FFFFFE05
		andi.b	#$1F, D0
		bne.s	Offset_0x027A10
		moveq	#Cannon_Turn_Sfx, D0					  ; -$79
		jsr		(Play_Music).l					 ; Offset_0x001176
Offset_0x027A10:
		rts
Offset_0x027A12:
		subq.w	#$01, D0
		bne.s	Offset_0x027A6C
		subq.w	#$01, Obj_Control_Var_06(A0)			 ; $0036
		bpl.s	Offset_0x027A22
		move.w	#$0003, Obj_Control_Var_04(A0)			 ; $0034
Offset_0x027A22:
		move.b	(Level_Frame_Count+$01).w, D0		 ; $FFFFFE05
		andi.b	#$03, D0
		bne.s	Offset_0x027A6A
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x027A6A
		move.l	#Obj_FireShield_Dissipate, (A1)		  ; Offset_0x013E28
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		subi.w	#$0018, Obj_Y(A1)				 ; $0014
		move.b	$001D(A0), D0
		lsl.b	#$04, D0
		addi.b	#$80, D0
		jsr		(CalcSine).l					 ; Offset_0x001B20
		asl.w	#$03, D1
		asl.w	#$03, D0
		move.w	D1, Obj_Speed_X(A1)				 ; $0018
		move.w	D0, Obj_Speed_Y(A1)				 ; $001A
Offset_0x027A6A:
		rts
Offset_0x027A6C:
		move.b	Obj_Angle(A0), D0				 ; $0026
		addq.b	#$02, Obj_Angle(A0)				 ; $0026
		jsr		(CalcSine).l					 ; Offset_0x001B20
		addi.w	#$0120, D0
		lsr.w	#$06, D0
		move.b	D0, $001D(A0)
		cmpi.b	#$04, D0
		bne.s	Offset_0x027A90
		move.w	#$0000, Obj_Control_Var_04(A0)			 ; $0034
Offset_0x027A90:
		rts
Offset_0x027A92:
		move.b	(A2), D0
		bne.s	Offset_0x027AEA
		bclr	D6, Obj_Status(A0)				 ; $002A
		beq.s	Offset_0x027AE8
		bclr	#$03, Obj_Status(A1)					 ; $002A
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	#$0380, Obj_Priority(A1)				 ; $0008
		move.w	#$0000, Obj_Speed_X(A1)					 ; $0018
		move.w	#$0000, Obj_Speed_Y(A1)					 ; $001A
		move.w	#$0000, Obj_Inertia(A1)					 ; $001C
		move.b	#$81, Obj_Timer(A1)				 ; $002E
		bset	#$02, Obj_Status(A1)					 ; $002A
		bset	#$01, Obj_Status(A1)					 ; $002A
		move.b	#$0E, Obj_Height_2(A1)					 ; $001E
		move.b	#$07, Obj_Width_2(A1)					 ; $001F
		move.b	#$02, Obj_Ani_Number(A1)				 ; $0020
		move.b	#$01, (A2)
Offset_0x027AE8:
		rts
Offset_0x027AEA:
		subq.b	#$01, D0
		bne.s	Offset_0x027B1A
		move.w	Obj_Speed_Y(A1), D0				 ; $001A
		addi.w	#$0038, Obj_Speed_Y(A1)					 ; $001A
		ext.l	D0
		lsl.l	#$08, D0
		add.l	D0, Obj_Y(A1)					 ; $0014
		move.w	Obj_Y(A0), D0					 ; $0014
		cmp.w	Obj_Y(A1), D0					 ; $0014
		bcc.s	Offset_0x027B18
		move.w	D0, Obj_Y(A1)					 ; $0014
		move.b	#$1C, Obj_Ani_Number(A1)				 ; $0020
		move.b	#$02, (A2)
Offset_0x027B18:
		rts
Offset_0x027B1A:
		subq.b	#$01, D0
		bne.w	Offset_0x027BA4
		cmpi.w	#$0002, Obj_Control_Var_04(A0)			 ; $0034
		beq.s	Offset_0x027B44
		cmpi.w	#$0200, Obj_Control_Var_00(A0)			 ; $0030
		beq.s	Offset_0x027B38
		cmpi.w	#$0202, Obj_Control_Var_00(A0)			 ; $0030
		bne.s	Offset_0x027B3E
Offset_0x027B38:
		move.w	#$0001, Obj_Control_Var_04(A0)			 ; $0034
Offset_0x027B3E:
		andi.w	#$0070, D1
		beq.s	Offset_0x027BA2
Offset_0x027B44:
		move.b	$001D(A0), D0
		lsl.b	#$04, D0
		addi.b	#$80, D0
		jsr		(CalcSine).l					 ; Offset_0x001B20
		asl.w	#$04, D1
		asl.w	#$04, D0
		move.w	D1, Obj_Speed_X(A1)				 ; $0018
		move.w	D0, Obj_Speed_Y(A1)				 ; $001A
		move.w	D1, Obj_Inertia(A1)				 ; $001C
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		subi.w	#$0018, Obj_Y(A1)				 ; $0014
		move.b	#$00, Obj_Timer(A1)				 ; $002E
		bset	#$01, Obj_Status(A1)					 ; $002A
		clr.b	Obj_Control_Var_10(A1)					 ; $0040
		move.b	#$02, Obj_Ani_Number(A1)				 ; $0020
		move.w	#$0002, Obj_Control_Var_04(A0)			 ; $0034
		move.w	#$000F, Obj_Control_Var_06(A0)			 ; $0036
		move.b	#$03, (A2)
		move.b	#$08, $0002(A2)
Offset_0x027BA2:
		rts
Offset_0x027BA4:
		subq.b	#$01, $0002(A2)
		bne.s	Offset_0x027BB4
		move.w	#$0100, Obj_Priority(A1)				 ; $0008
		move.b	#$00, (A2)
Offset_0x027BB4:
		rts
Offset_0x027BB6:
		tst.b	Obj_Flags(A0)					 ; $0004
		bpl.s	Offset_0x027C0E
		moveq	#$00, D0
		move.b	$001D(A0), D0
		cmp.b	Obj_Timer(A0), D0				 ; $002E
		beq.s	Offset_0x027C0E
		move.b	D0, Obj_Timer(A0)				 ; $002E
		lea		(CNz_Cannon_Dyn_Script).l, A2			 ; Offset_0x027D8E
		add.w	D0, D0
		adda.w	(A2, D0), A2
		move.w	(A2)+, D5
		subq.w	#$01, D5
		bmi.s	Offset_0x027C0E
		move.w	#$8900, D4
Offset_0x027BE2:
		moveq	#$00, D1
		move.w	(A2)+, D1
		move.w	D1, D3
		lsr.w	#$08, D3
		andi.w	#$00F0, D3
		addi.w	#$0010, D3
		andi.w	#$0FFF, D1
		lsl.l	#$05, D1
		addi.l	#Art_CNz_Cannon, D1			   ; Offset_0x0859A0
		move.w	D4, D2
		add.w	D3, D4
		add.w	D3, D4
		jsr		(QueueDMATransfer).l				; Offset_0x0012FC
		dbra	D5, Offset_0x027BE2
Offset_0x027C0E:
		rts
;-------------------------------------------------------------------------------
Cannon_Mappings:							   ; Offset_0x027C10
		dc.w	Offset_0x027CDC-Cannon_Mappings
		dc.w	Offset_0x027CB6-Cannon_Mappings
		dc.w	Offset_0x027C90-Cannon_Mappings
		dc.w	Offset_0x027C6A-Cannon_Mappings
		dc.w	Offset_0x027C4A-Cannon_Mappings
		dc.w	Offset_0x027CFC-Cannon_Mappings
		dc.w	Offset_0x027D22-Cannon_Mappings
		dc.w	Offset_0x027D48-Cannon_Mappings
		dc.w	Offset_0x027D6E-Cannon_Mappings
		dc.w	Offset_0x027C24-Cannon_Mappings
Offset_0x027C24:
		dc.w	$0006
		dc.w	$E001, $0012, $FFF8
		dc.w	$E001, $0812, $0000
		dc.w	$F003, $0014, $FFF8
		dc.w	$F003, $0814, $0000
		dc.w	$1004, $0018, $FFF0
		dc.w	$1004, $0818, $0000
Offset_0x027C4A:
		dc.w	$0005
		dc.w	$D80E, $00D4, $FFF0
		dc.w	$E80A, $0000, $FFE8
		dc.w	$E80A, $0800, $0000
		dc.w	$000A, $0009, $FFE8
		dc.w	$000A, $0809, $0000
Offset_0x027C6A:
		dc.w	$0006
		dc.w	$D807, $00D4, $FFEC
		dc.w	$D30A, $00DC, $FFFC
		dc.w	$E60A, $0000, $FFF3
		dc.w	$E60A, $0800, $000B
		dc.w	$FE0A, $0009, $FFF3
		dc.w	$FE0A, $0809, $000B
Offset_0x027C90:
		dc.w	$0006
		dc.w	$D807, $00D4, $FFEA
		dc.w	$D00B, $00DC, $FFF9
		dc.w	$E10A, $0000, $FFF9
		dc.w	$E10A, $0800, $0011
		dc.w	$F90A, $0009, $FFF9
		dc.w	$F90A, $0809, $0011
Offset_0x027CB6:
		dc.w	$0006
		dc.w	$D30D, $00D4, $FFEF
		dc.w	$E30A, $00DC, $FFEC
		dc.w	$DB0A, $0000, $FFFF
		dc.w	$DB0A, $0800, $0017
		dc.w	$F30A, $0009, $FFFF
		dc.w	$F30A, $0809, $0017
Offset_0x027CDC:
		dc.w	$0005
		dc.w	$D80B, $00D4, $FFF0
		dc.w	$D00A, $0000, $0000
		dc.w	$D00A, $0800, $0018
		dc.w	$E80A, $0009, $0000
		dc.w	$E80A, $0809, $0018
Offset_0x027CFC:
		dc.w	$0006
		dc.w	$D807, $08D4, $0004
		dc.w	$D30A, $08DC, $FFEC
		dc.w	$E60A, $0800, $FFF5
		dc.w	$E60A, $0000, $FFDD
		dc.w	$FE0A, $0809, $FFF5
		dc.w	$FE0A, $0009, $FFDD
Offset_0x027D22:
		dc.w	$0006
		dc.w	$D807, $08D4, $0007
		dc.w	$D00B, $08DC, $FFEF
		dc.w	$E10A, $0800, $FFEF
		dc.w	$E10A, $0000, $FFD7
		dc.w	$F90A, $0809, $FFEF
		dc.w	$F90A, $0009, $FFD7
Offset_0x027D48:
		dc.w	$0006
		dc.w	$D30D, $08D4, $FFF1
		dc.w	$E30A, $08DC, $FFFC
		dc.w	$DB0A, $0800, $FFE9
		dc.w	$DB0A, $0000, $FFD1
		dc.w	$F30A, $0809, $FFE9
		dc.w	$F30A, $0009, $FFD1
Offset_0x027D6E:
		dc.w	$0005
		dc.w	$D80B, $08D4, $FFF8
		dc.w	$D00A, $0800, $FFE8
		dc.w	$D00A, $0000, $FFD0
		dc.w	$E80A, $0809, $FFE8
		dc.w	$E80A, $0009, $FFD0
;-------------------------------------------------------------------------------
CNz_Cannon_Dyn_Script:						   ; Offset_0x027D8E
		dc.w	Offset_0x027DB6-CNz_Cannon_Dyn_Script
		dc.w	Offset_0x027DB0-CNz_Cannon_Dyn_Script
		dc.w	Offset_0x027DAA-CNz_Cannon_Dyn_Script
		dc.w	Offset_0x027DA4-CNz_Cannon_Dyn_Script
		dc.w	Offset_0x027DA0-CNz_Cannon_Dyn_Script
		dc.w	Offset_0x027DA4-CNz_Cannon_Dyn_Script
		dc.w	Offset_0x027DAA-CNz_Cannon_Dyn_Script
		dc.w	Offset_0x027DB0-CNz_Cannon_Dyn_Script
		dc.w	Offset_0x027DB6-CNz_Cannon_Dyn_Script
Offset_0x027DA0:
		dc.w	$0001
		dc.w	$B000
Offset_0x027DA4:
		dc.w	$0002
		dc.w	$700C, $8014
Offset_0x027DAA:
		dc.w	$0002
		dc.w	$701D, $B025
Offset_0x027DB0:
		dc.w	$0002
		dc.w	$7031, $8039
Offset_0x027DB6:
		dc.w	$0001
		dc.w	$B042
;===============================================================================
; Objeto 0x42 - Canhão na Carnival Night
; <<<-
;===============================================================================