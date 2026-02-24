;===============================================================================
; Objeto 0x39 - Ventiladores gigantes na Hydrocity
; ->>>
;===============================================================================
; Offset_0x026736:
		move.w	(Obj_Player_One+Obj_X).w, D0		 ; $FFFFB010
		subi.w	#$0020, D0
		cmp.w	Obj_X(A0), D0					 ; $0010
		bcs.s	Offset_0x026756
		move.w	(Obj_Player_One+Obj_Y).w, D0		 ; $FFFFB014
		subi.w	#$0020, D0
		sub.w	Obj_Y(A0), D0					 ; $0014
		cmpi.w	#$0040, D0
		bcs.s	Offset_0x026762
Offset_0x026756:
		move.b	#$03, (Wind_Tunnels_Flag).w			 ; $FFFFF7C7
		jmp		(MarkObjGone_3).l				   ; Offset_0x011B3E
Offset_0x026762:
		lea		(Art_Hz_Large_Fan).l, A1		   ; Offset_0x12F9EE
		move.w	#$A000, D2
		jsr		(Queue_Kos_Module).l		 ; Offset_0x0018A8
		move.l	#Offset_0x026778, (A0)
Offset_0x026778:
		tst.b	(Kos_modules_left).w			; $FFFFFF60
		beq.s	Offset_0x026780
		rts
Offset_0x026780:
		ori.b	#$04, Obj_Flags(A0)				 ; $0004
		move.w	#$0200, Obj_Priority(A0)				 ; $0008
		move.l	#Large_Fan_Mappings, Obj_Map(A0) ; Offset_0x02685C, $000C
		move.w	#$2500, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$18, Obj_Width(A0)				 ; $0007
		move.b	#$20, Obj_Height(A0)					 ; $0006
		move.w	#$0008, Obj_Control_Var_00(A0)			 ; $0030
		move.l	#Offset_0x0267B2, (A0)
Offset_0x0267B2:
		tst.w	Obj_Control_Var_00(A0)					 ; $0030
		beq.s	Offset_0x0267C8
		addq.w	#$08, Obj_Y(A0)					 ; $0014
		subq.w	#$01, Obj_Control_Var_00(A0)			 ; $0030
		bne.s	Offset_0x0267C8
		move.b	#$00, (Wind_Tunnels_Flag).w			 ; $FFFFF7C7
Offset_0x0267C8:
		subq.b	#$01, Obj_Ani_Time(A0)					 ; $0024
		bpl.w	Offset_0x0267E8
		move.b	#$00, Obj_Ani_Time(A0)					 ; $0024
		addq.b	#$01, Obj_Map_Id(A0)					 ; $0022
		cmpi.b	#$05, Obj_Map_Id(A0)					 ; $0022
		bcs.s	Offset_0x0267E8
		move.b	#$00, Obj_Map_Id(A0)					 ; $0022
Offset_0x0267E8:
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Fan_Mappings:						   ; Offset_0x0267EE
		dc.w	Offset_0x0267F8-Fan_Mappings
		dc.w	Offset_0x02680C-Fan_Mappings
		dc.w	Offset_0x026820-Fan_Mappings
		dc.w	Offset_0x026834-Fan_Mappings
		dc.w	Offset_0x026848-Fan_Mappings
Offset_0x0267F8:
		dc.w	$0003
		dc.w	$F40C, $0000, $FFF0
		dc.w	$FD0C, $0800, $FFF0
		dc.w	$F406, $000C, $FFF8
Offset_0x02680C:
		dc.w	$0003
		dc.w	$F40C, $1800, $FFF0
		dc.w	$FD0C, $1000, $FFF0
		dc.w	$F406, $000C, $FFF8
Offset_0x026820:
		dc.w	$0003
		dc.w	$F40C, $0004, $FFF0
		dc.w	$FD0C, $0804, $FFF0
		dc.w	$F406, $000C, $FFF8
Offset_0x026834:
		dc.w	$0003
		dc.w	$F40C, $0008, $FFF0
		dc.w	$FD0C, $0808, $FFF0
		dc.w	$F406, $000C, $FFF8
Offset_0x026848:
		dc.w	$0003
		dc.w	$F40C, $1804, $FFF0
		dc.w	$FD0C, $1004, $FFF0
		dc.w	$F406, $000C, $FFF8
;-------------------------------------------------------------------------------
Large_Fan_Mappings:							   ; Offset_0x02685C
		dc.w	Offset_0x026866-Large_Fan_Mappings
		dc.w	Offset_0x026898-Large_Fan_Mappings
		dc.w	Offset_0x0268CA-Large_Fan_Mappings
		dc.w	Offset_0x0268FC-Large_Fan_Mappings
		dc.w	Offset_0x02692E-Large_Fan_Mappings
Offset_0x026866:
		dc.w	$0008
		dc.w	$E706, $0000, $FFE8
		dc.w	$0007, $0006, $FFE8
		dc.w	$E706, $0000, $0008
		dc.w	$0007, $0006, $0008
		dc.w	$E002, $0022, $FFFC
		dc.w	$F805, $0025, $FFF8
		dc.w	$F805, $0029, $FFE8
		dc.w	$F805, $0029, $0008
Offset_0x026898:
		dc.w	$0008
		dc.w	$E007, $1806, $FFE8
		dc.w	$0106, $1800, $FFE8
		dc.w	$E007, $1806, $0008
		dc.w	$0106, $1800, $0008
		dc.w	$E002, $0022, $FFFC
		dc.w	$F805, $0025, $FFF8
		dc.w	$F805, $0029, $FFE8
		dc.w	$F805, $0029, $0008
Offset_0x0268CA:
		dc.w	$0008
		dc.w	$E007, $000E, $FFE8
		dc.w	$0006, $0016, $FFE8
		dc.w	$E007, $000E, $0008
		dc.w	$0006, $0016, $0008
		dc.w	$E002, $0022, $FFFC
		dc.w	$F805, $0025, $FFF8
		dc.w	$F805, $0029, $FFE8
		dc.w	$F805, $0029, $0008
Offset_0x0268FC:
		dc.w	$0008
		dc.w	$E806, $001C, $FFE8
		dc.w	$0006, $181C, $FFE8
		dc.w	$E806, $001C, $0008
		dc.w	$0006, $181C, $0008
		dc.w	$E002, $0022, $FFFC
		dc.w	$F805, $0025, $FFF8
		dc.w	$F805, $0029, $FFE8
		dc.w	$F805, $0029, $0008
Offset_0x02692E:
		dc.w	$0008
		dc.w	$E806, $1816, $FFE8
		dc.w	$0007, $180E, $FFE8
		dc.w	$E806, $1816, $0008
		dc.w	$0007, $180E, $0008
		dc.w	$E002, $0022, $FFFC
		dc.w	$F805, $0025, $FFF8
		dc.w	$F805, $0029, $FFE8
		dc.w	$F805, $0029, $0008
;===============================================================================
; Objeto 0x39 - Ventiladores gigantes na Hydrocity
; <<<-
;===============================================================================