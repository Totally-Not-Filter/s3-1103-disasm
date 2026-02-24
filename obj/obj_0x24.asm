;===============================================================================
; Objeto 0x24 - Atributos dos túneis transportadores na Launch Base
; ->>>
;===============================================================================
Obj_Automatic_Tunnel_Delayed: ; usado pelo objeto 0x1B		   ; Offset_0x0201B8
		subq.b	#$01, Obj_Ani_Time(A0)					 ; $0024
		bmi.s	Offset_0x0201C0
		rts
Offset_0x0201C0:
		move.b	#$00, Obj_Ani_Time(A0)
;-------------------------------------------------------------------------------
Obj_0x24_Automatic_Tunnel:					   ; Offset_0x0201C6
		ori.b	#$04, Obj_Flags(A0)				 ; $0004
		move.b	#$10, Obj_Width(A0)				 ; $0007
		move.w	#$0280, Obj_Priority(A0)				 ; $0008
		move.l	#Offset_0x0201DE, (A0)
Offset_0x0201DE:
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		lea		Obj_Control_Var_00(A0), A4				 ; $0030
		bsr.s	Offset_0x020204
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		lea		Obj_Control_Var_0A(A0), A4				 ; $003A
		bsr.s	Offset_0x020204
		move.b	Obj_Control_Var_00(A0), D0				 ; $0030
		add.b	Obj_Control_Var_0A(A0), D0				 ; $003A
		beq.s	Offset_0x0201FE
		rts
Offset_0x0201FE:
		jmp		(MarkObjGone_3).l				   ; Offset_0x011B3E
Offset_0x020204:
		moveq	#$00, D0
		move.b	(A4), D0
		move.w	Offset_0x020210(PC, D0), D0
		jmp		Offset_0x020210(PC, D0)
;-------------------------------------------------------------------------------
Offset_0x020210:
		dc.w	Offset_0x020216-Offset_0x020210
		dc.w	Offset_0x02029C-Offset_0x020210
		dc.w	Offset_0x020356-Offset_0x020210
;-------------------------------------------------------------------------------
Offset_0x020216:
		tst.w	(Debug_Mode_Flag_Index).w			 ; $FFFFFE08
		bne.w	Offset_0x02029A
		move.w	Obj_X(A1), D0					 ; $0010
		sub.w	Obj_X(A0), D0					 ; $0010
		addi.w	#$0010, D0
		cmpi.w	#$0020, D0
		bcc.s	Offset_0x02029A
		move.w	Obj_Y(A1), D1					 ; $0014
		sub.w	Obj_Y(A0), D1					 ; $0014
		addi.w	#$0018, D1
		cmpi.w	#$0028, D1
		bcc.s	Offset_0x02029A
		tst.b	Obj_Timer(A1)					 ; $002E
		bne.s	Offset_0x02029A
		addq.b	#$02, (A4)
		move.b	#$81, Obj_Timer(A1)				 ; $002E
		move.b	#$02, Obj_Ani_Number(A1)				 ; $0020
		clr.b	Obj_Control_Var_10(A1)					 ; $0040
		move.w	#$0800, Obj_Inertia(A1)					 ; $001C
		move.w	#$0000, Obj_Speed_X(A1)					 ; $0018
		move.w	#$0000, Obj_Speed_Y(A1)					 ; $001A
		bclr	#$05, Obj_Status(A0)					 ; $002A
		bclr	#$05, Obj_Status(A1)					 ; $002A
		bset	#$01, Obj_Status(A1)					 ; $002A
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		clr.b	$0001(A4)
		bsr.w	Offset_0x02036A
		moveq	#Rolling_Sfx, D0				   ; $3C
		jsr		(PlaySound).l					; Offset_0x001176
Offset_0x02029A:
		rts
;-------------------------------------------------------------------------------
Offset_0x02029C:
		subq.b	#$01, $0002(A4)
		bhi.w	Offset_0x020330
		move.l	$0006(A4), A2
		move.w	(A2)+, D4
		move.w	D4, Obj_X(A1)					 ; $0010
		move.w	(A2)+, D5
		move.w	D5, Obj_Y(A1)					 ; $0014
		tst.b	Obj_Subtype(A0)					 ; $002C
		bpl.s	Offset_0x0202BC
		subq.w	#$08, A2
Offset_0x0202BC:
		move.l	A2, $0006(A4)
		subq.w	#$04, $0004(A4)
		beq.s	Offset_0x0202D2
		move.w	(A2)+, D4
		move.w	(A2)+, D5
		move.w	#$1000, D2
		bra.w	Offset_0x0203D0
Offset_0x0202D2:
		addq.b	#$02, (A4)
		move.b	#$02, $0002(A4)
		andi.w	#$0FFF, Obj_Y(A1)				 ; $0014
		btst	#$06, Obj_Subtype(A0)					 ; $002C
		bne.s	Offset_0x0202F4
		move.w	#$0000, Obj_Speed_X(A1)					 ; $0018
		move.w	#$0000, Obj_Speed_Y(A1)					 ; $001A
Offset_0x0202F4:
		moveq	#Tube_Launcher_Sfx, D0					  ; -$6B
		jsr		(PlaySound).l					; Offset_0x001176
		btst	#$05, Obj_Subtype(A0)					 ; $002C
		beq.s	Offset_0x020330
		move.l	A1, A2
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x02032E
		move.l	#Obj_Tunnel_Exhaust_Control, (A1)	   ; Offset_0x02044E
		move.w	Obj_X(A2), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A2), Obj_Y(A1)			  ; $0014, $0014
		move.w	Obj_Speed_X(A2), Obj_Speed_X(A1)		  ; $0018, $0018
		move.w	Obj_Speed_Y(A2), Obj_Speed_Y(A1)		  ; $001A, $001A
Offset_0x02032E:
		move.l	A2, A1
Offset_0x020330:
		move.l	Obj_X(A1), D2					 ; $0010
		move.l	Obj_Y(A1), D3					 ; $0014
		move.w	Obj_Speed_X(A1), D0				 ; $0018
		ext.l	D0
		asl.l	#$08, D0
		add.l	D0, D2
		move.w	Obj_Speed_Y(A1), D0				 ; $001A
		ext.l	D0
		asl.l	#$08, D0
		add.l	D0, D3
		move.l	D2, Obj_X(A1)					 ; $0010
		move.l	D3, Obj_Y(A1)					 ; $0014
		rts
;-------------------------------------------------------------------------------
Offset_0x020356:
		subq.b	#$01, $0002(A4)
		bne.s	Offset_0x020362
		clr.b	Obj_Timer(A1)					 ; $002E
		clr.b	(A4)
Offset_0x020362:
		addi.w	#$0038, Obj_Speed_Y(A1)					 ; $001A
		bra.s	Offset_0x020330
Offset_0x02036A:
		move.b	Obj_Subtype(A0), D0				 ; $002C
		bpl.s	Offset_0x02039E
		andi.w	#$001F, D0
		add.w	D0, D0
		add.w	D0, D0
		lea		(LBz_Automatic_Tunnel_From_To_Data).l, A2 ; Offset_0x1F7258
		move.l	(A2, D0), A2
		move.w	(A2)+, D0
		subq.w	#$04, D0
		move.w	D0, $0004(A4)
		lea		(A2, D0), A2
		move.w	(A2)+, D4
		move.w	D4, Obj_X(A1)					 ; $0010
		move.w	(A2)+, D5
		move.w	D5, Obj_Y(A1)					 ; $0014
		subq.w	#$08, A2
		bra.s	Offset_0x0203C4
Offset_0x02039E:
		andi.w	#$001F, D0
		add.w	D0, D0
		add.w	D0, D0
		lea		(LBz_Automatic_Tunnel_From_To_Data).l, A2 ; Offset_0x1F7258
		move.l	(A2, D0), A2
		move.w	(A2)+, $0004(A4)
		subq.w	#$04, $0004(A4)
		move.w	(A2)+, D4
		move.w	D4, Obj_X(A1)					 ; $0010
		move.w	(A2)+, D5
		move.w	D5, Obj_Y(A1)					 ; $0014
Offset_0x0203C4:
		move.l	A2, $0006(A4)
		move.w	(A2)+, D4
		move.w	(A2)+, D5
		move.w	#$1000, D2
Offset_0x0203D0:
		moveq	#$00, D0
		move.w	D2, D3
		move.w	D4, D0
		sub.w	Obj_X(A1), D0					 ; $0010
		bge.s	Offset_0x0203E0
		neg.w	D0
		neg.w	D2
Offset_0x0203E0:
		moveq	#$00, D1
		move.w	D5, D1
		sub.w	Obj_Y(A1), D1					 ; $0014
		bge.s	Offset_0x0203EE
		neg.w	D1
		neg.w	D3
Offset_0x0203EE:
		cmp.w	D0, D1
		bcs.s	Offset_0x020420
		moveq	#$00, D1
		move.w	D5, D1
		sub.w	Obj_Y(A1), D1					 ; $0014
		swap	D1
		divs.w	D3, D1
		moveq	#$00, D0
		move.w	D4, D0
		sub.w	Obj_X(A1), D0					 ; $0010
		beq.s	Offset_0x02040C
		swap	D0
		divs.w	D1, D0
Offset_0x02040C:
		move.w	D0, Obj_Speed_X(A1)				 ; $0018
		move.w	D3, Obj_Speed_Y(A1)				 ; $001A
		tst.w	D1
		bpl.s	Offset_0x02041A
		neg.w	D1
Offset_0x02041A:
		move.w	D1, $0002(A4)
		rts
Offset_0x020420:
		moveq	#$00, D0
		move.w	D4, D0
		sub.w	Obj_X(A1), D0					 ; $0010
		swap	D0
		divs.w	D2, D0
		moveq	#$00, D1
		move.w	D5, D1
		sub.w	Obj_Y(A1), D1					 ; $0014
		beq.s	Offset_0x02043A
		swap	D1
		divs.w	D0, D1
Offset_0x02043A:
		move.w	D1, Obj_Speed_Y(A1)				 ; $001A
		move.w	D2, Obj_Speed_X(A1)				 ; $0018
		tst.w	D0
		bpl.s	Offset_0x020448
		neg.w	D0
Offset_0x020448:
		move.w	D0, $0002(A4)
		rts
;-------------------------------------------------------------------------------
Obj_Tunnel_Exhaust_Control: ; usado também pelo objeto 0x1B	   ; Offset_0x02044E
		move.l	#Tunnel_Exhaust_Mappings, Obj_Map(A0) ; Offset_0x020842, $000C
		move.w	#$42EA, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$10, Obj_Width(A0)				 ; $0007
		move.b	#$10, Obj_Height(A0)					 ; $0006
		ori.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0180, Obj_Priority(A0)				 ; $0008
		tst.b	Obj_Subtype(A0)					 ; $002C
		beq.s	Offset_0x020484
		move.l	#Obj_Tunnel_Exhaust_Continuous, (A0)   ; Offset_0x02060C
		bra.w	Obj_Tunnel_Exhaust_Continuous		   ; Offset_0x02060C
Offset_0x020484:
		move.w	#$003C, Obj_Control_Var_00(A0)			 ; $0030
		tst.w	Obj_Speed_Y(A0)					 ; $001A
		beq.s	Offset_0x02049A
		bmi.s	Offset_0x0204AC
		move.w	#$0006, Obj_Angle(A0)					 ; $0026
		bra.s	Offset_0x0204AC
Offset_0x02049A:
		move.w	#$000C, Obj_Angle(A0)					 ; $0026
		tst.w	Obj_Speed_X(A0)					 ; $0018
		bmi.s	Offset_0x0204AC
		move.w	#$0012, Obj_Angle(A0)					 ; $0026
Offset_0x0204AC:
		tst.b	(Current_Act).w					  ; $FFFFFE11
		bne.s	Offset_0x0204BC
		move.l	#Obj_Tunnel_Exhaust_Smoke, (A0)		   ; Offset_0x0206B0
		bra.w	Obj_Tunnel_Exhaust_Smoke			   ; Offset_0x0206B0
;-------------------------------------------------------------------------------
Offset_0x0204BC:
		move.l	#Obj_Tunnel_Exhaust_Control_Main, (A0) ; Offset_0x0204C2
Obj_Tunnel_Exhaust_Control_Main:					   ; Offset_0x0204C2
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		bpl.s	Offset_0x020538
		move.w	#$0003, Obj_Timer(A0)					 ; $002E
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x020538
		move.l	#Obj_Tunnel_Exhaust_Up, (A1)		   ; Offset_0x02057E
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		move.l	#Tunnel_Exhaust_Mappings, Obj_Map(A1) ; Offset_0x020842, $000C
		move.w	#$42EA, Obj_Art_VRAM(A1)				 ; $000A
		move.b	#$10, Obj_Width(A1)				 ; $0007
		move.b	#$10, Obj_Height(A1)					 ; $0006
		move.w	#$0380, Obj_Priority(A1)				 ; $0008
		move.w	Obj_Angle(A0), D0				 ; $0026
		cmpi.w	#$0006, D0
		bne.s	Offset_0x02051A
		move.l	#Obj_Tunnel_Exhaust_Down, (A1)		   ; Offset_0x0205AC
Offset_0x02051A:
		lea		Offset_0x02054A(PC, D0), A2
		move.w	(A2)+, Obj_Speed_X(A1)					 ; $0018
		move.w	(A2)+, Obj_Speed_Y(A1)					 ; $001A
		move.b	(A2)+, Obj_Flags(A1)					 ; $0004
		move.b	(A2)+, Obj_Map_Id(A1)					 ; $0022
		bne.s	Offset_0x020538
		move.l	#Obj_Tunnel_Exhaust_Horizontal, (A1)   ; Offset_0x0205DC
		bsr.s	Offset_0x020562
Offset_0x020538:
		subq.w	#$01, Obj_Control_Var_00(A0)			 ; $0030
		bpl.s	Offset_0x020544
		move.w	#$7FF0, Obj_X(A0)				 ; $0010
Offset_0x020544:
		jmp		(MarkObjGone_3).l				   ; Offset_0x011B3E
;-------------------------------------------------------------------------------
Offset_0x02054A:
		dc.w	$0000, $FA00, $8601, $0000, $0400, $8401, $FA00, $0000
		dc.w	$8500, $0600, $0000, $8400
;-------------------------------------------------------------------------------
Offset_0x020562:
		moveq	#$00, D0
		move.w	Obj_Control_Var_00(A0), D0				 ; $0030
		subi.w	#$003C, D0
		neg.w	D0
		lsl.w	#$04, D0
		tst.w	Obj_Speed_X(A1)					 ; $0018
		bmi.s	Offset_0x020578
		neg.w	D0
Offset_0x020578:
		add.w	D0, Obj_Speed_X(A1)				 ; $0018
		rts
;-------------------------------------------------------------------------------
Obj_Tunnel_Exhaust_Up:						   ; Offset_0x02057E
		move.b	(Level_Frame_Count+$01).w, D0		 ; $FFFFFE05
		andi.b	#$01, D0
		bne.s	Offset_0x02058E
		bchg	#00, Obj_Flags(A0)				 ; $0004
Offset_0x02058E:
		jsr		(ObjectFall).l				   ; Offset_0x0110FE
		tst.b	Obj_Flags(A0)					 ; $0004
		bmi.s	Offset_0x0205A6
		tst.w	Obj_Speed_Y(A0)					 ; $001A
		bmi.s	Offset_0x0205A6
		move.w	#$7FF0, Obj_X(A0)				 ; $0010
Offset_0x0205A6:
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Obj_Tunnel_Exhaust_Down:					   ; Offset_0x0205AC
		move.b	(Level_Frame_Count+$01).w, D0		 ; $FFFFFE05
		andi.b	#$01, D0
		bne.s	Offset_0x0205BC
		bchg	#00, Obj_Flags(A0)				 ; $0004
Offset_0x0205BC:
		jsr		(ObjectFall)				   ; Offset_0x0110FE
		tst.b	Obj_Flags(A0)					 ; $0004
		bmi.s	Offset_0x0205D6
		cmpi.w	#$0C00, Obj_Speed_Y(A0)					 ; $001A
		blt.s	Offset_0x0205D6
		move.w	#$7FF0, Obj_X(A0)				 ; $0010
Offset_0x0205D6:
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Obj_Tunnel_Exhaust_Horizontal:				   ; Offset_0x0205DC
		move.b	(Level_Frame_Count+$01).w, D0		 ; $FFFFFE05
		andi.b	#$01, D0
		bne.s	Offset_0x0205EC
		bchg	#01, Obj_Flags(A0)				 ; $0004
Offset_0x0205EC:
		jsr		(ObjectFall).l				   ; Offset_0x0110FE
		tst.b	Obj_Flags(A0)					 ; $0004
		bmi.s	Offset_0x020606
		cmpi.w	#$0600, Obj_Speed_Y(A0)					 ; $001A
		blt.s	Offset_0x020606
		move.w	#$7FF0, Obj_X(A0)				 ; $0010
Offset_0x020606:
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Obj_Tunnel_Exhaust_Continuous:				   ; Offset_0x02060C
		move.b	(Level_Frame_Count+$01).w, D0		 ; $FFFFFE05
		andi.b	#$03, D0
		bne.s	Offset_0x020670
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x020670
		move.l	#Obj_Tunnel_Exhaust_Timed, (A1)		   ; Offset_0x020676
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		move.l	#Tunnel_Exhaust_Mappings, Obj_Map(A1) ; Offset_0x020842, $000C
		move.w	#$42EA, Obj_Art_VRAM(A1)				 ; $000A
		move.b	#$10, Obj_Width(A1)				 ; $0007
		move.b	#$10, Obj_Height(A1)					 ; $0006
		move.w	#$0380, Obj_Priority(A1)				 ; $0008
		move.w	#$0000, Obj_Speed_X(A1)					 ; $0018
		move.w	#$0400, Obj_Speed_Y(A1)					 ; $001A
		move.b	#$84, Obj_Flags(A1)				 ; $0004
		move.b	#$01, Obj_Map_Id(A1)					 ; $0022
		move.w	#$000B, Obj_Timer(A1)					 ; $002E
Offset_0x020670:
		jmp		(MarkObjGone_3).l				   ; Offset_0x011B3E
;-------------------------------------------------------------------------------
Obj_Tunnel_Exhaust_Timed:					   ; Offset_0x020676
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		bpl.s	Offset_0x020688
		move.w	#$000B, Obj_Timer(A0)					 ; $002E
		move.w	#$7FF0, Obj_X(A0)				 ; $0010
Offset_0x020688:
		move.b	(Level_Frame_Count+$01).w, D0		 ; $FFFFFE05
		andi.b	#$01, D0
		bne.s	Offset_0x020698
		bchg	#00, Obj_Flags(A0)				 ; $0004
Offset_0x020698:
		jsr		(ObjectFall)				   ; Offset_0x0110FE
		tst.b	Obj_Flags(A0)					 ; $0004
		bmi.s	Offset_0x0206AA
		move.w	#$7FF0, Obj_X(A0)				 ; $0010
Offset_0x0206AA:
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Obj_Tunnel_Exhaust_Smoke:					   ; Offset_0x0206B0
		move.b	(Level_Frame_Count+$01).w, D0		 ; $FFFFFE05
		andi.b	#$03, D0
		bne.s	Offset_0x0206E2
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x0206E2
		move.l	#Obj_FireShield_Dissipate, (A1)		  ; Offset_0x013E28
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		move.w	Obj_Speed_X(A0), Obj_Speed_X(A1)		  ; $0018, $0018
		move.w	Obj_Speed_Y(A0), Obj_Speed_Y(A1)		  ; $001A, $001A
Offset_0x0206E2:
		subq.w	#$01, Obj_Control_Var_00(A0)			 ; $0030
		bpl.s	Offset_0x0206EE
		move.w	#$7FF0, Obj_X(A0)				 ; $0010
Offset_0x0206EE:
		jmp		(MarkObjGone_3).l				   ; Offset_0x011B3E
;-------------------------------------------------------------------------------
; Offset_0x0206F4: ; Left over ??? Não usado.
		move.l	#Tunnel_Exhaust_Mappings, Obj_Map(A0)  ; Offset_0x020842, $000C
		move.w	#$42EA, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$10, Obj_Width(A0)				 ; $0007
		move.b	#$10, Obj_Height(A0)					 ; $0006
		ori.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0180, Obj_Priority(A0)				 ; $0008
		move.w	#$0078, Obj_Control_Var_00(A0)			 ; $0030
		move.l	#Offset_0x020726, (A0)
Offset_0x020726:
		tst.b	Obj_Control_Var_02(A0)					 ; $0032
		bne.s	Offset_0x0207A0
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		bpl.s	Offset_0x0207A0
		move.w	#$0003, Obj_Timer(A0)					 ; $002E
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x0207A0
		move.l	#Offset_0x0207B8, (A1)
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		move.l	#Tunnel_Exhaust_Mappings, Obj_Map(A1) ; Offset_0x020842, $000C
		move.w	#$42EA, Obj_Art_VRAM(A1)				 ; $000A
		move.b	#$10, Obj_Width(A1)				 ; $0007
		move.b	#$10, Obj_Height(A1)					 ; $0006
		move.w	#$0380, Obj_Priority(A1)				 ; $0008
		ori.b	#$04, Obj_Flags(A1)				 ; $0004
		bset	#$00, Obj_Flags(A1)				 ; $0004
		move.w	#$F800, Obj_Speed_X(A1)					 ; $0018
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		addq.w	#$01, D0
		add.w	D0, D0
		move.w	D0, Obj_Timer(A1)				 ; $002E
		addi.w	#$0010, Obj_X(A1)				 ; $0010
		move.b	#$C6, Obj_Col_Flags(A1)					 ; $0028
Offset_0x0207A0:
		subq.w	#$01, Obj_Control_Var_00(A0)			 ; $0030
		bpl.s	Offset_0x0207B2
		move.w	#$0078, Obj_Control_Var_00(A0)			 ; $0030
		eori.b	#$FF, Obj_Control_Var_02(A0)			 ; $0032
Offset_0x0207B2:
		jmp		(MarkObjGone_3).l				   ; Offset_0x011B3E
;-------------------------------------------------------------------------------
Offset_0x0207B8:
		move.b	(Level_Frame_Count+$01).w, D0		 ; $FFFFFE05
		andi.b	#$01, D0
		bne.s	Offset_0x0207C8
		bchg	#01, Obj_Flags(A0)				 ; $0004
Offset_0x0207C8:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		subq.w	#$01, Obj_Timer(A0)				 ; $002E
		bpl.s	Offset_0x0207DA
		move.w	#$7FF0, Obj_X(A0)				 ; $0010
Offset_0x0207DA:
		move.b	Obj_Col_Prop(A0), D0					 ; $0029
		beq.w	Offset_0x0207FE
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		bclr	#$00, Obj_Col_Prop(A0)					 ; $0029
		beq.s	Offset_0x0207F0
		bsr.s	Offset_0x020804
Offset_0x0207F0:
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		bclr	#$01, Obj_Col_Prop(A0)					 ; $0029
		beq.s	Offset_0x0207FE
		bsr.s	Offset_0x020804
Offset_0x0207FE:
		jmp		(MarkObjGone_5).l				   ; Offset_0x011BCC
Offset_0x020804:
		tst.b	Obj_Timer(A1)					 ; $002E
		bne.s	Offset_0x020840
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		cmpi.w	#$F000, Obj_Speed_X(A1)					 ; $0018
		beq.s	Offset_0x020840
		move.b	#$1A, Obj_Ani_Number(A1)				 ; $0020
		clr.b	Obj_Control_Var_10(A1)					 ; $0040
		move.w	#$0000, Obj_Inertia(A1)					 ; $001C
		move.w	#$F000, Obj_Speed_X(A1)					 ; $0018
		move.w	#$0000, Obj_Speed_Y(A1)					 ; $001A
		bclr	#$05, Obj_Status(A1)					 ; $002A
		bset	#$01, Obj_Status(A1)					 ; $002A
Offset_0x020840:
		rts
;-------------------------------------------------------------------------------
Tunnel_Exhaust_Mappings:					   ; Offset_0x020842
		dc.w	Offset_0x020846-Tunnel_Exhaust_Mappings
		dc.w	Offset_0x02084E-Tunnel_Exhaust_Mappings
Offset_0x020846:
		dc.w	$0001
		dc.w	$F40E, $002A, $FFF0
Offset_0x02084E:
		dc.w	$0001
		dc.w	$F00B, $002A, $FFF4
;===============================================================================
; Objeto 0x24 - Atributos dos túneis transportadores na Launch Base
; <<<-
;===============================================================================