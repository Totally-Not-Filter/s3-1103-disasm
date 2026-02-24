;===============================================================================
; Objeto 0x0D - Parede quebr�vel nas fases
; ->>>
;===============================================================================
; Offset_0x0170CA:
		move.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0200, Obj_Priority(A0)				 ; $0008
		move.l	#Offset_0x017242, (A0)
		move.b	Obj_Subtype(A0), D0				 ; $002C
		bpl.s	Offset_0x0170EE
		tst.b	(Level_Trigger_Array).w				 ; $FFFFF7E0
		beq.s	Offset_0x0170EE
		jmp		(DeleteObject).l				   ; Offset_0x011138
Offset_0x0170EE:
		andi.b	#$0F, D0
		move.b	D0, Obj_Map_Id(A0)				 ; $0022
		move.l	#Breakable_Wall_Mappings, Obj_Map(A0) ; Offset_0x017732, $000C
		move.w	#$4001, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$10, Obj_Width(A0)				 ; $0007
		move.b	#$28, Obj_Height(A0)					 ; $0006
		move.l	#Offset_0x0175C2, Obj_Control_Var_04(A0)		 ; $0034
		move.l	#Offset_0x0175EA, Obj_Control_Var_08(A0)		 ; $0038
		cmpi.b	#Hz_Id, (Current_Zone).w			; $01, $FFFFFE10
		bne.s	Offset_0x017184
		move.l	#Hz_Breakable_Wall_Mappings, Obj_Map(A0) ; Offset_0x0179B8, $000C
		move.w	#$6001, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$10, Obj_Width(A0)				 ; $0007
		move.b	#$20, Obj_Height(A0)					 ; $0006
		move.l	#Offset_0x017612, Obj_Control_Var_04(A0)		 ; $0034
		move.l	#Offset_0x017632, Obj_Control_Var_08(A0)		 ; $0038
		cmpi.b	#$02, Obj_Map_Id(A0)					 ; $0022
		bne.s	Offset_0x017184
		move.w	#$4350, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$18, Obj_Width(A0)				 ; $0007
		move.b	#$20, Obj_Height(A0)					 ; $0006
		move.l	#Offset_0x017612, Obj_Control_Var_04(A0)		 ; $0034
		move.l	#Offset_0x017632, Obj_Control_Var_08(A0)		 ; $0038
		move.l	#Offset_0x0174CC, (A0)
		rts
Offset_0x017184:
		cmpi.b	#MGz_Id, (Current_Zone).w			; $02, $FFFFFE10
		bne.s	Offset_0x0171C6
		move.l	#MGz_Breakable_Wall_Mappings, Obj_Map(A0) ; Offset_0x0178F8, $000C
		move.w	#$4001, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$20, Obj_Width(A0)				 ; $0007
		move.b	#$28, Obj_Height(A0)					 ; $0006
		move.l	#Offset_0x0176A2, Obj_Control_Var_04(A0)		 ; $0034
		move.l	#Offset_0x017652, Obj_Control_Var_08(A0)		 ; $0038
		cmpi.b	#$02, Obj_Map_Id(A0)					 ; $0022
		bne.s	Offset_0x0171C6
		move.l	#Offset_0x0173E2, (A0)
		rts
Offset_0x0171C6:
		cmpi.b	#CNz_Id, (Current_Zone).w			; $03, $FFFFFE10
		bne.s	Offset_0x017208
		move.l	#CNz_Breakable_Wall_Mappings, Obj_Map(A0) ; Offset_0x017858, $000C
		move.w	#$4420, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$10, Obj_Width(A0)				 ; $0007
		move.b	#$20, Obj_Height(A0)					 ; $0006
		move.l	#Offset_0x0176F2, Obj_Control_Var_04(A0)		 ; $0034
		move.l	#Offset_0x017712, Obj_Control_Var_08(A0)		 ; $0038
		cmpi.b	#$02, Obj_Map_Id(A0)					 ; $0022
		bne.s	Offset_0x017208
		move.l	#Offset_0x0174CC, (A0)
		rts
Offset_0x017208:
		cmpi.b	#LBz_Id, (Current_Zone).w			; $06, $FFFFFE10
		bne.s	Offset_0x017242
		move.l	#LBz_Breakable_Wall_Mappings, Obj_Map(A0) ; Offset_0x017A3E, $000C
		move.w	#$22EA, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$10, Obj_Width(A0)				 ; $0007
		move.b	#$20, Obj_Height(A0)					 ; $0006
		move.l	#Offset_0x017612, Obj_Control_Var_04(A0)		 ; $0034
		move.l	#Offset_0x017632, Obj_Control_Var_08(A0)		 ; $0038
		move.l	#Offset_0x0174CC, (A0)
		rts
Offset_0x017242:
		move.w	(Obj_Player_One+Obj_Speed_X).w, Obj_Control_Var_00(A0) ; $FFFFB018, $0030
		move.w	(Obj_Player_Two+Obj_Speed_X).w, Obj_Control_Var_02(A0) ; $FFFFB062, $0032
		moveq	#$00, D1
		move.b	Obj_Width(A0), D1				 ; $0007
		addi.w	#$000B, D1
		moveq	#$00, D2
		move.b	Obj_Height(A0), D2				 ; $0006
		move.w	D2, D3
		addq.w	#$01, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Solid_Object).l				   ; Offset_0x013556
		tst.b	Obj_Subtype(A0)					 ; $002C
		bpl.s	Offset_0x01727E
		tst.b	(Level_Trigger_Array).w				 ; $FFFFF7E0
		beq.s	Offset_0x017288
		jmp		(DeleteObject).l				   ; Offset_0x011138
Offset_0x01727E:
		move.b	Obj_Status(A0), D0				 ; $002A
		andi.b	#$60, D0
		bne.s	Offset_0x01728E
Offset_0x017288:
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
Offset_0x01728E:
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		move.w	Obj_Control_Var_00(A0), D1				 ; $0030
		btst	#$05, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x0172F0
		cmpi.b	#$02, Obj_Control_Var_08(A1)			 ; $0038
		beq.s	Offset_0x0172BA
		cmpi.b	#$02, Obj_Ani_Number(A1)				 ; $0020
		bne.s	Offset_0x0172F0
		move.w	D1, D0
		bpl.s	Offset_0x0172B4
		neg.w	D0
Offset_0x0172B4:
		cmpi.w	#$0480, D0
		bcs.s	Offset_0x0172F0
Offset_0x0172BA:
		bclr	#$05, Obj_Status(A0)					 ; $002A
		bsr.s	Offset_0x01731C
		btst	#$06, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x017288
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		cmpi.b	#$02, Obj_Ani_Number(A1)				 ; $0020
		bne.s	Offset_0x017288
		move.w	Obj_Control_Var_02(A0), Obj_Speed_X(A1)	  ; $0032, $0018
		move.w	Obj_Speed_X(A1), Obj_Inertia(A1)		  ; $0018, $001C
		bclr	#$06, Obj_Status(A0)					 ; $002A
		bclr	#$05, Obj_Status(A1)					 ; $002A
		bra.s	Offset_0x017288
Offset_0x0172F0:
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		move.w	Obj_Control_Var_02(A0), D1				 ; $0032
		btst	#$06, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x017288
		cmpi.b	#$02, Obj_Ani_Number(A1)				 ; $0020
		bne.s	Offset_0x017288
		move.w	D1, D0
		bpl.s	Offset_0x01730E
		neg.w	D0
Offset_0x01730E:
		cmpi.w	#$0480, D0
		bcs.w	Offset_0x017288
		bclr	#$06, Obj_Status(A0)					 ; $002A
Offset_0x01731C:
		move.w	D1, Obj_Speed_X(A1)				 ; $0018
		addq.w	#$04, Obj_X(A1)					 ; $0010
		move.l	Obj_Control_Var_04(A0), A4				 ; $0034
		move.w	Obj_X(A0), D0					 ; $0010
		cmp.w	Obj_X(A1), D0					 ; $0010
		bcs.s	Offset_0x01733C
		subi.w	#$0008, Obj_X(A1)				 ; $0010
		move.l	Obj_Control_Var_08(A0), A4				 ; $0038
Offset_0x01733C:
		move.w	Obj_Speed_X(A1), Obj_Inertia(A1)		  ; $0018, $001C
		bclr	#$05, Obj_Status(A1)					 ; $002A
		move.l	#Offset_0x017354, (A0)
		addq.b	#$01, Obj_Map_Id(A0)					 ; $0022
		bsr.s	Offset_0x017372
Offset_0x017354:
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		addi.w	#$0070, Obj_Speed_Y(A0)					 ; $001A
		tst.b	Obj_Flags(A0)					 ; $0004
		bpl.s	Offset_0x01736C
		jmp		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x01736C:
		jmp		(DeleteObject).l				   ; Offset_0x011138
Offset_0x017372:
		moveq	#$00, D0
		move.b	Obj_Map_Id(A0), D0				 ; $0022
		add.w	D0, D0
		move.l	Obj_Map(A0), A3					 ; $000C
		adda.w	(A3, D0), A3
		move.w	(A3)+, D1
		subq.w	#$01, D1
		bset	#$05, Obj_Flags(A0)				 ; $0004
		move.l	(A0), D4
		move.b	Obj_Flags(A0), D5				 ; $0004
		move.l	A0, A1
		bra.s	Offset_0x0173A0
;-------------------------------------------------------------------------------
Offset_0x017396:
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.s	Offset_0x0173DA
		addq.w	#$06, A3
Offset_0x0173A0:
		move.l	D4, (A1)
		move.l	A3, Obj_Map(A1)					 ; $000C
		move.b	D5, Obj_Flags(A1)				 ; $0004
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		move.w	Obj_Art_VRAM(A0), Obj_Art_VRAM(A1)		  ; $000A, $000A
		ori.w	#$8000, Obj_Art_VRAM(A1)				 ; $000A
		move.b	Obj_Priority(A0), Obj_Priority(A1)		  ; $0008, $0008
		move.b	Obj_Width(A0), Obj_Width(A1)			  ; $0007, $0007
		move.w	(A4)+, Obj_Speed_X(A1)					 ; $0018
		move.w	(A4)+, Obj_Speed_Y(A1)					 ; $001A
		dbra	D1, Offset_0x017396
Offset_0x0173DA:
		moveq	#Smash_Sfx, D0					   ; $62
		jmp		(Play_Music).l					 ; Offset_0x001176
;-------------------------------------------------------------------------------
Offset_0x0173E2:
		move.w	(Obj_Player_One+Obj_Speed_X).w, Obj_Control_Var_00(A0) ; $FFFFB018, $0030
		move.w	(Obj_Player_Two+Obj_Speed_X).w, Obj_Control_Var_02(A0) ; $FFFFB062, $0032
		moveq	#$00, D1
		move.b	Obj_Width(A0), D1				 ; $0007
		addi.w	#$000B, D1
		moveq	#$00, D2
		move.b	Obj_Height(A0), D2				 ; $0006
		move.w	D2, D3
		addq.w	#$01, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Solid_Object)				   ; Offset_0x013556
		swap	D6
		andi.b	#$03, D6
		beq.w	Offset_0x01749C
		move.b	D6, D0
		andi.b	#$01, D0
		beq.s	Offset_0x017470
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		bclr	#$06, Obj_Player_Hit_Flag(A1)			 ; $0037
		beq.s	Offset_0x017470
		move.w	Obj_Control_Var_00(A0), Obj_Speed_X(A1)	  ; $0030, $0018
		move.w	Obj_Speed_X(A1), Obj_Inertia(A1)		  ; $0018, $001C
		bclr	#$05, Obj_Status(A1)					 ; $002A
		bclr	#$05, Obj_Status(A0)					 ; $002A
		bsr.s	Offset_0x0174A2
		andi.b	#$02, D6
		beq.s	Offset_0x01749C
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		bclr	#$06, Obj_Player_Hit_Flag(A1)			 ; $0037
		beq.s	Offset_0x01749C
		move.w	Obj_Control_Var_02(A0), Obj_Speed_X(A1)	  ; $0032, $0018
		move.w	Obj_Speed_X(A1), Obj_Inertia(A1)		  ; $0018, $001C
		bclr	#$05, Obj_Status(A1)					 ; $002A
		bclr	#$06, Obj_Status(A0)					 ; $002A
		bra.s	Offset_0x01749C
Offset_0x017470:
		andi.b	#$02, D6
		beq.s	Offset_0x01749C
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		bclr	#$06, Obj_Player_Hit_Flag(A1)			 ; $0037
		beq.s	Offset_0x01749C
		move.w	Obj_Control_Var_02(A0), Obj_Speed_X(A1)	  ; $0032, $0018
		move.w	Obj_Speed_X(A1), Obj_Inertia(A1)		  ; $0018, $001C
		bclr	#$05, Obj_Status(A1)					 ; $002A
		bclr	#$06, Obj_Status(A0)					 ; $002A
		bsr.s	Offset_0x0174A2
Offset_0x01749C:
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
Offset_0x0174A2:
		move.l	Obj_Control_Var_04(A0), A4				 ; $0034
		move.w	Obj_X(A0), D0					 ; $0010
		cmp.w	Obj_X(A1), D0					 ; $0010
		bcs.s	Offset_0x0174BA
		subi.w	#$0008, Obj_X(A1)				 ; $0010
		move.l	Obj_Control_Var_08(A0), A4				 ; $0038
Offset_0x0174BA:
		move.l	#Offset_0x017354, (A0)
		addq.b	#$01, Obj_Map_Id(A0)					 ; $0022
		bsr.w	Offset_0x017372
		bra.w	Offset_0x017354
;-------------------------------------------------------------------------------
Offset_0x0174CC:
		move.w	(Obj_Player_One+Obj_Speed_X).w, Obj_Control_Var_00(A0) ; $FFFFB018, $0030
		move.w	(Obj_Player_Two+Obj_Speed_X).w, Obj_Control_Var_02(A0) ; $FFFFB062, $0032
		moveq	#$00, D1
		move.b	Obj_Width(A0), D1				 ; $0007
		addi.w	#$000B, D1
		moveq	#$00, D2
		move.b	Obj_Height(A0), D2				 ; $0006
		move.w	D2, D3
		addq.w	#$01, D3
		move.w	Obj_X(A0), D4					 ; $0010
		jsr		(Solid_Object).l				   ; Offset_0x013556
		tst.b	Obj_Subtype(A0)					 ; $002C
		bpl.s	Offset_0x017508
		tst.b	(Level_Trigger_Array).w				 ; $FFFFF7E0
		beq.s	Offset_0x017512
		jmp		(DeleteObject).l				   ; Offset_0x011138
Offset_0x017508:
		move.b	Obj_Status(A0), D0				 ; $002A
		andi.b	#$60, D0
		bne.s	Offset_0x017518
Offset_0x017512:
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
Offset_0x017518:
		lea		(Obj_Player_One).w, A1				 ; $FFFFB000
		move.w	Obj_Control_Var_00(A0), D1				 ; $0030
		btst	#$05, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x017566
		cmpi.b	#$02, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x017566
		bclr	#$05, Obj_Status(A0)					 ; $002A
		bsr.s	Offset_0x017584
		btst	#$06, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x017512
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		cmpi.b	#$02, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x017512
		move.w	Obj_Control_Var_02(A0), Obj_Speed_X(A1)	  ; $0032, $0018
		move.w	Obj_Speed_X(A1), Obj_Inertia(A1)		  ; $0018, $001C
		bclr	#$06, Obj_Status(A0)					 ; $002A
		bclr	#$05, Obj_Status(A1)					 ; $002A
		bra.s	Offset_0x017512
Offset_0x017566:
		lea		(Obj_Player_Two).w, A1				 ; $FFFFB04A
		move.w	Obj_Control_Var_02(A0), D1				 ; $0032
		btst	#$06, Obj_Status(A0)					 ; $002A
		beq.s	Offset_0x017512
		cmpi.b	#$02, Obj_Control_Var_08(A1)			 ; $0038
		bne.s	Offset_0x017512
		bclr	#$06, Obj_Status(A0)					 ; $002A
Offset_0x017584:
		move.w	D1, Obj_Speed_X(A1)				 ; $0018
		addq.w	#$04, Obj_X(A1)					 ; $0010
		move.l	Obj_Control_Var_04(A0), A4				 ; $0034
		move.w	Obj_X(A0), D0					 ; $0010
		cmp.w	Obj_X(A1), D0					 ; $0010
		bcs.s	Offset_0x0175A4
		subi.w	#$0008, Obj_X(A1)				 ; $0010
		move.l	Obj_Control_Var_08(A0), A4				 ; $0038
Offset_0x0175A4:
		move.w	Obj_Speed_X(A1), Obj_Inertia(A1)		  ; $0018, $001C
		bclr	#$05, Obj_Status(A1)					 ; $002A
		move.l	#Offset_0x017354, (A0)
		addq.b	#$01, Obj_Map_Id(A0)					 ; $0022
		bsr.w	Offset_0x017372
		bra.w	Offset_0x017354
;-------------------------------------------------------------------------------
Offset_0x0175C2:
		dc.w	$0400, $FB00, $0600, $FA00, $0600, $FF00, $0800, $FE00
		dc.w	$0680, $0000, $0880, $0000, $0600, $0100, $0800, $0200
		dc.w	$0400, $0500, $0600, $0600
;-------------------------------------------------------------------------------
Offset_0x0175EA:
		dc.w	$FA00, $FA00, $FC00, $FB00, $F800, $FE00, $FA00, $FF00
		dc.w	$F780, $0000, $F980, $0000, $F800, $0200, $FA00, $0100
		dc.w	$FA00, $0600, $FC00, $0500
;-------------------------------------------------------------------------------
Offset_0x017612:
		dc.w	$0400, $FB00, $0600, $FA00, $0600, $FF00, $0800, $FE00
		dc.w	$0600, $0100, $0800, $0200, $0400, $0500, $0600, $0600
;-------------------------------------------------------------------------------
Offset_0x017632:
		dc.w	$FA00, $FA00, $FC00, $FB00, $F800, $FE00, $FA00, $FF00
		dc.w	$F800, $0200, $FA00, $0100, $FA00, $0600, $FC00, $0500
;-------------------------------------------------------------------------------
Offset_0x017652
		dc.w	$0400, $FB00, $0500, $FA80, $0600, $FA00, $0700, $F980
		dc.w	$0600, $FF00, $0700, $FE80, $0800, $FE00, $0900, $FD80
		dc.w	$0680, $0000, $0780, $0000, $0880, $0000, $0980, $0000
		dc.w	$0600, $0100, $0700, $0180, $0800, $0200, $0900, $0280
		dc.w	$0400, $0500, $0500, $0580, $0600, $0600, $0700, $0680
;-------------------------------------------------------------------------------
Offset_0x0176A2:
		dc.w	$F900, $F980, $FA00, $FA00, $FB00, $FA80, $FC00, $FB00
		dc.w	$F700, $FD80, $F800, $FE00, $F900, $FE80, $FA00, $FF00
		dc.w	$F680, $0000, $F780, $0000, $F880, $0000, $F980, $0000
		dc.w	$F700, $0280, $F800, $0200, $F900, $0180, $FA00, $0100
		dc.w	$F900, $0680, $FA00, $0600, $FB00, $0580, $FC00, $0500
;-------------------------------------------------------------------------------
Offset_0x0176F2:
		dc.w	$0400, $FB00, $0600, $FA00, $0600, $FF00, $0800, $FE00
		dc.w	$0600, $0100, $0800, $0200, $0400, $0500, $0600, $0600
;-------------------------------------------------------------------------------
Offset_0x017712:
		dc.w	$FA00, $FA00, $FC00, $FB00, $F800, $FE00, $FA00, $FF00
		dc.w	$F800, $0200, $FA00, $0100, $FA00, $0600, $FC00, $0500
;-------------------------------------------------------------------------------
Breakable_Wall_Mappings:					   ; Offset_0x017732
		dc.w	Offset_0x01773E-Breakable_Wall_Mappings
		dc.w	Offset_0x01779E-Breakable_Wall_Mappings
		dc.w	Offset_0x01775E-Breakable_Wall_Mappings
		dc.w	Offset_0x0177DC-Breakable_Wall_Mappings
		dc.w	Offset_0x01777E-Breakable_Wall_Mappings
		dc.w	Offset_0x01781A-Breakable_Wall_Mappings
Offset_0x01773E:
		dc.w	$0005
		dc.w	$D80D, $0016, $FFF0
		dc.w	$E80D, $1816, $FFF0
		dc.w	$F80D, $0016, $FFF0
		dc.w	$080D, $1816, $FFF0
		dc.w	$180D, $0016, $FFF0
Offset_0x01775E:
		dc.w	$0005
		dc.w	$D80D, $1016, $FFF0
		dc.w	$E80D, $0816, $FFF0
		dc.w	$F80D, $1016, $FFF0
		dc.w	$080D, $0816, $FFF0
		dc.w	$180D, $1816, $FFF0
Offset_0x01777E:
		dc.w	$0005
		dc.w	$D80D, $0816, $FFF0
		dc.w	$E80D, $1016, $FFF0
		dc.w	$F80D, $0816, $FFF0
		dc.w	$080D, $1016, $FFF0
		dc.w	$180D, $0816, $FFF0
Offset_0x01779E:
		dc.w	$000A
		dc.w	$D805, $0016, $FFF0
		dc.w	$D805, $001A, $0000
		dc.w	$E805, $181A, $FFF0
		dc.w	$E805, $1816, $0000
		dc.w	$F805, $0016, $FFF0
		dc.w	$F805, $001A, $0000
		dc.w	$0805, $181A, $FFF0
		dc.w	$0805, $1816, $0000
		dc.w	$1805, $0016, $FFF0
		dc.w	$1805, $001A, $0000
Offset_0x0177DC:
		dc.w	$000A
		dc.w	$D805, $1016, $FFF0
		dc.w	$D805, $101A, $0000
		dc.w	$E805, $081A, $FFF0
		dc.w	$E805, $0816, $0000
		dc.w	$F805, $1016, $FFF0
		dc.w	$F805, $101A, $0000
		dc.w	$0805, $081A, $FFF0
		dc.w	$0805, $0816, $0000
		dc.w	$1805, $181A, $FFF0
		dc.w	$1805, $1816, $0000
Offset_0x01781A:
		dc.w	$000A
		dc.w	$D805, $081A, $FFF0
		dc.w	$D805, $0816, $0000
		dc.w	$E805, $1016, $FFF0
		dc.w	$E805, $101A, $0000
		dc.w	$F805, $081A, $FFF0
		dc.w	$F805, $0816, $0000
		dc.w	$0805, $1016, $FFF0
		dc.w	$0805, $101A, $0000
		dc.w	$1805, $081A, $FFF0
		dc.w	$1805, $0816, $0000
;-------------------------------------------------------------------------------
CNz_Breakable_Wall_Mappings:				   ; Offset_0x017858
		dc.w	Offset_0x017860-CNz_Breakable_Wall_Mappings
		dc.w	Offset_0x01787A-CNz_Breakable_Wall_Mappings
		dc.w	Offset_0x0178AC-CNz_Breakable_Wall_Mappings
		dc.w	Offset_0x0178C6-CNz_Breakable_Wall_Mappings
Offset_0x017860:
		dc.w	$0004
		dc.w	$E00D, $0000, $FFF0
		dc.w	$F00D, $0000, $FFF0
		dc.w	$000D, $0000, $FFF0
		dc.w	$100D, $0000, $FFF0
Offset_0x01787A:
		dc.w	$0008
		dc.w	$E005, $0000, $FFF0
		dc.w	$E005, $0004, $0000
		dc.w	$F005, $0000, $FFF0
		dc.w	$F005, $0004, $0000
		dc.w	$0005, $0000, $FFF0
		dc.w	$0005, $0004, $0000
		dc.w	$1005, $0000, $FFF0
		dc.w	$1005, $0004, $0000
Offset_0x0178AC:
		dc.w	$0004
		dc.w	$E00D, $0008, $FFF0
		dc.w	$F00D, $0008, $FFF0
		dc.w	$000D, $0008, $FFF0
		dc.w	$100D, $0008, $FFF0
Offset_0x0178C6:
		dc.w	$0008
		dc.w	$E005, $0008, $FFF0
		dc.w	$E005, $000C, $0000
		dc.w	$F005, $0008, $FFF0
		dc.w	$F005, $000C, $0000
		dc.w	$0005, $0008, $FFF0
		dc.w	$0005, $000C, $0000
		dc.w	$1005, $0008, $FFF0
		dc.w	$1005, $000C, $0000
;-------------------------------------------------------------------------------
MGz_Breakable_Wall_Mappings:				   ; Offset_0x0178F8
		dc.w	Offset_0x017900-MGz_Breakable_Wall_Mappings
		dc.w	Offset_0x01793E-MGz_Breakable_Wall_Mappings
		dc.w	Offset_0x017900-MGz_Breakable_Wall_Mappings
		dc.w	Offset_0x01793E-MGz_Breakable_Wall_Mappings
Offset_0x017900:
		dc.w	$000A
		dc.w	$D80D, $0066, $FFE0
		dc.w	$D80D, $0866, $0000
		dc.w	$E80D, $0066, $FFE0
		dc.w	$E80D, $0866, $0000
		dc.w	$F80D, $0066, $FFE0
		dc.w	$F80D, $0866, $0000
		dc.w	$080D, $0066, $FFE0
		dc.w	$080D, $0866, $0000
		dc.w	$180D, $006E, $FFE0
		dc.w	$180D, $086E, $0000
Offset_0x01793E:
		dc.w	$0014
		dc.w	$D805, $0066, $FFE0
		dc.w	$D805, $006A, $FFF0
		dc.w	$D805, $086A, $0000
		dc.w	$D805, $0866, $0010
		dc.w	$E805, $0066, $FFE0
		dc.w	$E805, $006A, $FFF0
		dc.w	$E805, $086A, $0000
		dc.w	$E805, $0866, $0010
		dc.w	$F805, $0066, $FFE0
		dc.w	$F805, $006A, $FFF0
		dc.w	$F805, $086A, $0000
		dc.w	$F805, $0866, $0010
		dc.w	$0805, $0066, $FFE0
		dc.w	$0805, $006A, $FFF0
		dc.w	$0805, $086A, $0000
		dc.w	$0805, $0866, $0010
		dc.w	$1805, $006E, $FFE0
		dc.w	$1805, $0072, $FFF0
		dc.w	$1805, $0872, $0000
		dc.w	$1805, $086E, $0010
;-------------------------------------------------------------------------------
Hz_Breakable_Wall_Mappings:					   ; Offset_0x0179B8
		dc.w	Offset_0x0179C0-Hz_Breakable_Wall_Mappings
		dc.w	Offset_0x0179DA-Hz_Breakable_Wall_Mappings
		dc.w	Offset_0x017A0C-Hz_Breakable_Wall_Mappings
		dc.w	Offset_0x017A0C-Hz_Breakable_Wall_Mappings
Offset_0x0179C0:
		dc.w	$0004
		dc.w	$E00D, $0060, $FFF0
		dc.w	$F00D, $0068, $FFF0
		dc.w	$000D, $0060, $FFF0
		dc.w	$100D, $0068, $FFF0
Offset_0x0179DA:
		dc.w	$0008
		dc.w	$E005, $0060, $FFF0
		dc.w	$E005, $0064, $0000
		dc.w	$F005, $0068, $FFF0
		dc.w	$F005, $006C, $0000
		dc.w	$0005, $0060, $FFF0
		dc.w	$0005, $0064, $0000
		dc.w	$1005, $0068, $FFF0
		dc.w	$1005, $006C, $0000
Offset_0x017A0C:
		dc.w	$0008
		dc.w	$E009, $0000, $FFE8
		dc.w	$E009, $0800, $0000
		dc.w	$F009, $0006, $FFE8
		dc.w	$F009, $0806, $0000
		dc.w	$0009, $0000, $FFE8
		dc.w	$0009, $0800, $0000
		dc.w	$1009, $0006, $FFE8
		dc.w	$1009, $0806, $0000
;-------------------------------------------------------------------------------
LBz_Breakable_Wall_Mappings:				   ; Offset_0x017A3E
		dc.w	Offset_0x017A42-LBz_Breakable_Wall_Mappings
		dc.w	Offset_0x017A5C-LBz_Breakable_Wall_Mappings
Offset_0x017A42:
		dc.w	$0004
		dc.w	$E00D, $003E, $FFF0
		dc.w	$F00D, $0046, $FFF0
		dc.w	$000D, $003E, $FFF0
		dc.w	$100D, $0046, $FFF0
Offset_0x017A5C:
		dc.w	$0008
		dc.w	$E005, $003E, $FFF0
		dc.w	$E005, $0042, $0000
		dc.w	$F005, $0046, $FFF0
		dc.w	$F005, $004A, $0000
		dc.w	$0005, $003E, $FFF0
		dc.w	$0005, $0042, $0000
		dc.w	$1005, $0046, $FFF0
		dc.w	$1005, $004A, $0000
;===============================================================================
; Objeto 0x0D - Parede quebr�vel nas fases
; <<<-
;===============================================================================