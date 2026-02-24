;-------------------------------------------------------------------------------
; Splash de água causado pelo jogador entrando e saindo da água
; ->>>
;-------------------------------------------------------------------------------
; Offset_0x02E22E:
		tst.b	Obj_Subtype(A0)					 ; $002C
		beq.s	Offset_0x02E298
		move.l	#Water_Splash_Mappings_2, Obj_Map(A0) ; Offset_0x02E4EA, $000C
		move.w	#$0447, Obj_Art_VRAM(A0)				 ; $000A
		ori.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0300, Obj_Priority(A0)				 ; $0008
		move.b	#$A0, Obj_Width(A0)				 ; $0007
		move.b	#$80, Obj_Height(A0)					 ; $0006
		move.b	#$FF, Obj_Control_Var_01(A0)			 ; $0031
		move.b	#$00, Obj_Status(A0)					 ; $002A
		bset	#$06, Obj_Flags(A0)				 ; $0004
		move.w	#$0002, Obj_Sub_Y(A0)					 ; $0016
		lea		Obj_Speed_X(A0), A2				 ; $0018
		move.w	Obj_X(A0), (A2)+				 ; $0010
		move.w	Obj_Y(A0), (A2)+				 ; $0014
		move.w	#$0005, (A2)+
		move.w	Obj_X(A0), (A2)+				 ; $0010
		move.w	Obj_Y(A0), (A2)+				 ; $0014
		move.w	#$0505, (A2)+
		move.l	#Offset_0x02E318, (A0)
		bra.w	Offset_0x02E318
Offset_0x02E298:
		move.l	#Water_Splash_Mappings, Obj_Map(A0) ; Offset_0x02E4D0, $000C
		move.w	#$43B2, Obj_Art_VRAM(A0)				 ; $000A
		ori.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0300, Obj_Priority(A0)				 ; $0008
		move.b	#$28, Obj_Width(A0)				 ; $0007
		move.b	#$20, Obj_Height(A0)					 ; $0006
		move.b	#$FF, Obj_Control_Var_00(A0)			 ; $0030
		move.l	#Offset_0x02E2CA, (A0)
Offset_0x02E2CA:
		subq.b	#$01, Obj_Ani_Time(A0)					 ; $0024
		bpl.s	Offset_0x02E2E0
		move.b	#$07, Obj_Ani_Time(A0)					 ; $0024
		addq.b	#$01, Obj_Map_Id(A0)					 ; $0022
		andi.b	#$03, Obj_Map_Id(A0)					 ; $0022
Offset_0x02E2E0:
		tst.b	Obj_Flags(A0)					 ; $0004
		bpl.s	Offset_0x02E312
		moveq	#$00, D1
		move.b	Obj_Map_Id(A0), D1				 ; $0022
		cmp.b	Obj_Control_Var_00(A0), D1				 ; $0030
		beq.s	Offset_0x02E312
		move.b	D1, Obj_Control_Var_00(A0)				 ; $0030
		lsl.w	#$08, D1
		move.w	D1, D0
		add.w	D0, D0
		add.w	D0, D1
		addi.l	#Art_Water_Splash_2, D1		   ; Offset_0x131C02
		move.w	#$7640, D2
		move.w	#$0180, D3
		jsr		(QueueDMATransfer).l				; Offset_0x0012FC
Offset_0x02E312:
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
Offset_0x02E318:
		move.w	(Obj_Player_One+Obj_X).w, Obj_X(A0)	  ; $FFFFB010, $0010
		move.w	(Water_Level_Move).w, Obj_Y(A0)		  ; $FFFFF646, $0014
		bsr.s	Offset_0x02E37C
		tst.b	Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x02E34A
		subq.b	#$01, Obj_Ani_Time(A0)					 ; $0024
		bpl.s	Offset_0x02E34A
		move.b	#$02, Obj_Ani_Time(A0)					 ; $0024
		addq.b	#$01, Obj_Control_Var_00(A0)			 ; $0030
		cmpi.b	#$05, Obj_Control_Var_00(A0)			 ; $0030
		bcs.s	Offset_0x02E34A
		move.b	#$00, Obj_Control_Var_00(A0)			 ; $0030
Offset_0x02E34A:
		moveq	#$00, D1
		move.b	Obj_Control_Var_00(A0), D1				 ; $0030
		cmp.b	Obj_Control_Var_01(A0), D1				 ; $0031
		beq.s	Offset_0x02E376
		move.b	D1, Obj_Control_Var_01(A0)				 ; $0031
		lsl.w	#$07, D1
		move.w	D1, D0
		add.w	D0, D0
		add.w	D0, D1
		addi.l	#Art_Water_Splash, D1		   ; Offset_0x131482
		move.w	#$88E0, D2
		move.w	#$00C0, D3
		jsr		(QueueDMATransfer).l				; Offset_0x0012FC
Offset_0x02E376:
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
Offset_0x02E37C:
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		lea		Obj_Speed_X(A0), A2				 ; $0018
		moveq	#$03, D6
		move.w	(Control_Ports_Logical_Data).w, D5			 ; $FFFFF602
		bsr.s	Offset_0x02E3C6
		bclr	#$00, Obj_Flags(A0)				 ; $0004
		btst	#$00, Obj_Status(A1)					 ; $002A
		beq.s	Offset_0x02E3A0
		bset	#$00, Obj_Flags(A0)				 ; $0004
Offset_0x02E3A0:
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		lea		Obj_Height_2(A0), A2					 ; $001E
		moveq	#$04, D6
		move.w	(Control_Ports_Logical_Data_2).w, D5		 ; $FFFFF66A
		bsr.s	Offset_0x02E3C6
		move.b	Obj_Flags(A0), D0				 ; $0004
		add.b	Obj_Status(A1), D0				 ; $002A
		andi.b	#$01, D0
		beq.s	Offset_0x02E3C4
		move.b	#$05, Obj_Routine(A2)					 ; $0005
Offset_0x02E3C4:
		rts
Offset_0x02E3C6:
		btst	D6, Obj_Status(A0)				 ; $002A
		bne.s	Offset_0x02E41A
		tst.w	Obj_Speed_Y(A1)					 ; $001A
		bne.s	Offset_0x02E418
		moveq	#$00, D1
		move.b	Obj_Height_2(A1), D1					 ; $001E
		add.w	Obj_Y(A1), D1					 ; $0014
		addq.w	#$01, D1
		cmp.w	(Water_Level_Move).w, D1			 ; $FFFFF646
		bne.s	Offset_0x02E418
		move.w	Obj_Speed_X(A1), D0				 ; $0018
		bpl.s	Offset_0x02E3EC
		neg.w	D0
Offset_0x02E3EC:
		cmpi.w	#$0700, D0
		bcs.s	Offset_0x02E418
		bset	D6, Obj_Status(A0)				 ; $002A
		move.w	Obj_X(A1), (A2)					 ; $0010
		move.w	(Water_Level_Move).w, $0002(A2)		 ; $FFFFF646
		move.b	#$00, Obj_Routine(A2)					 ; $0005
		bclr	#$00, Obj_Status(A1)					 ; $002A
		tst.w	Obj_Speed_X(A1)					 ; $0018
		bpl.s	Offset_0x02E418
		bset	#$00, Obj_Status(A1)					 ; $002A
Offset_0x02E418:
		rts
Offset_0x02E41A:
		move.w	D5, D0
		andi.w	#$0070, D0
		bne.s	Offset_0x02E49A
		move.w	(Water_Level_Move).w, D0			 ; $FFFFF646
		moveq	#$00, D1
		move.b	Obj_Height_2(A1), D1					 ; $001E
		sub.w	D1, D0
		subq.w	#$01, D0
		cmp.w	Obj_Y(A1), D0					 ; $0014
		bhi.s	Offset_0x02E48E
		move.w	Obj_Speed_X(A1), D1				 ; $0018
		bpl.s	Offset_0x02E43E
		neg.w	D1
Offset_0x02E43E:
		cmpi.w	#$0700, D1
		bcs.s	Offset_0x02E48E
		move.w	D0, Obj_Y(A1)					 ; $0014
		move.w	#$0000, Obj_Speed_Y(A1)					 ; $001A
		move.w	Obj_X(A1), (A2)					 ; $0010
		move.w	(Water_Level_Move).w, $0002(A2)		 ; $FFFFF646
		btst	#$01, Obj_Status(A1)					 ; $002A
		beq.s	Offset_0x02E498
		andi.w	#$0C00, D5
		bne.s	Offset_0x02E498
		move.w	#$000C, D1
		move.w	Obj_Speed_X(A1), D0				 ; $0018
		beq.s	Offset_0x02E48E
		bmi.s	Offset_0x02E480
		sub.w	D1, D0
		bcc.s	Offset_0x02E47A
		move.w	#$0000, D0
Offset_0x02E47A:
		move.w	D0, Obj_Speed_X(A1)				 ; $0018
		bra.s	Offset_0x02E498
Offset_0x02E480:
		add.w	D1, D0
		bcc.s	Offset_0x02E488
		move.w	#$0000, D0
Offset_0x02E488:
		move.w	D0, Obj_Speed_X(A1)				 ; $0018
		bra.s	Offset_0x02E498
Offset_0x02E48E:
		bclr	D6, Obj_Status(A0)				 ; $002A
		move.b	#$05, Obj_Routine(A2)					 ; $0005
Offset_0x02E498:
		rts
Offset_0x02E49A:
		bclr	D6, Obj_Status(A0)				 ; $002A
		move.b	#$05, Obj_Routine(A2)					 ; $0005
		move.w	#$F980, Obj_Speed_Y(A1)					 ; $001A
		bset	#$01, Obj_Status(A1)					 ; $002A
		move.b	#$01, Obj_Control_Var_10(A1)			 ; $0040
		move.b	#$0E, Obj_Height_2(A1)					 ; $001E
		move.b	#$07, Obj_Width_2(A1)					 ; $001F
		move.b	#$02, Obj_Ani_Number(A1)				 ; $0020
		bset	#$02, Obj_Status(A1)					 ; $002A
		rts
;-------------------------------------------------------------------------------
Water_Splash_Mappings:						   ; Offset_0x02E4D0
		dc.w	Offset_0x02E4DA-Water_Splash_Mappings
		dc.w	Offset_0x02E4DA-Water_Splash_Mappings
		dc.w	Offset_0x02E4DA-Water_Splash_Mappings
		dc.w	Offset_0x02E4DA-Water_Splash_Mappings
		dc.w	Offset_0x02E4F6-Water_Splash_Mappings
Offset_0x02E4DA:
		dc.w	$0002
		dc.w	$F00B, $0000, $FFE8
		dc.w	$F00B, $000C, $0000
Offset_0x02E4E8:
		dc.w	$0000
Water_Splash_Mappings_2:					   ; Offset_0x02E4EA
		dc.w	Offset_0x02E4F6-Water_Splash_Mappings_2
		dc.w	Offset_0x02E4F6-Water_Splash_Mappings_2
		dc.w	Offset_0x02E4F6-Water_Splash_Mappings_2
		dc.w	Offset_0x02E4F6-Water_Splash_Mappings_2
		dc.w	Offset_0x02E4F6-Water_Splash_Mappings_2
		dc.w	Offset_0x02E4E8-Water_Splash_Mappings_2
Offset_0x02E4F6:
		dc.w	$0002
		dc.w	$F00D, $0000, $FFC8
		dc.w	$F005, $0008, $FFE8
;-------------------------------------------------------------------------------
; Splash de água causado pelo jogador entrando e saindo da água
; <<<-
;-------------------------------------------------------------------------------