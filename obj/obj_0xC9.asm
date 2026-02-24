;===============================================================================
; Objeto 0xC9 - Interruptor usado pelo Knuckles em algumas cenas de introdução
; ->>>
;===============================================================================
; Offset_0x035484:
		lea		Knuckles_Switch_Setup_Data(PC), A1	   ; Offset_0x03555A
		jsr		(SetupObjectAttributes).l				 ; Offset_0x041D72
		move.l	#Offset_0x0354AA, (A0)
		addq.w	#$04, Obj_Y(A0)					 ; $0014
		lea		Knuckles_Switch_PLC_Data(PC), A1	   ; Offset_0x0354A2
		jmp		(LoadPLC_Direct).l					 ; Offset_0x001502
;-------------------------------------------------------------------------------
Knuckles_Switch_PLC_Data:					   ; Offset_0x0354A2
		dc.w	$0000
		dc.l	Art_Switch					   ; Offset_0x1067F6
		dc.w	$8AC0
;-------------------------------------------------------------------------------
Offset_0x0354AA:
		move.w	(Obj_Knuckles_Mem_Address).w, D0			 ; $FFFFFAA4
		beq.s	Offset_0x0354FC
		move.w	D0, A1
		lea		Offset_0x035502(PC), A2
		move.w	Obj_X(A0), D0					 ; $0010
		move.w	Obj_X(A1), D1					 ; $0010
		add.w	(A2)+, D0
		cmp.w	D0, D1
		bcs.s	Offset_0x0354FC
		add.w	(A2)+, D0
		cmp.w	D0, D1
		bcc.s	Offset_0x0354FC
		move.w	Obj_Y(A0), D0					 ; $0014
		move.w	Obj_Y(A1), D1					 ; $0014
		add.w	(A2)+, D0
		cmp.w	D0, D1
		bcs.s	Offset_0x0354FC
		add.w	(A2)+, D0
		cmp.w	D0, D1
		bcc.s	Offset_0x0354FC
		move.l	#Offset_0x035510, (A0)
		move.b	#$01, Obj_Map_Id(A0)					 ; $0022
		st		(Knuckles_Control_Lock_Flag).w		 ; $FFFFFAA9
		moveq	#$00, D0
		move.b	Obj_Subtype(A0), D0				 ; $002C
		move.w	Offset_0x03550A(PC, D0), D0
		jsr		Offset_0x03550A(PC, D0)
Offset_0x0354FC:
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Offset_0x035502:
		dc.w	$FFE8, $0030, $FFE8, $0030
;-------------------------------------------------------------------------------
Offset_0x03550A:
		dc.w	Offset_0x035516-Offset_0x03550A
		dc.w	Offset_0x035532-Offset_0x03550A
		dc.w	Offset_0x035536-Offset_0x03550A
;-------------------------------------------------------------------------------
Offset_0x035510:
		jmp		(MarkObjGone).l				   ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Offset_0x035516:
		clr.b	(Control_Locked_Flag_P1).w			 ; $FFFFF7CC
		move.w	#$1000, D0
		move.w	D0, (Target_Camera_Max_Y).w			 ; $FFFFFA98
		move.w	D0, (Level_Limits_Max_Y).w			 ; $FFFFEE12
		lea		(Level_Resize_Max_Y).l, A2			   ; Offset_0x04262E
		jmp		(Load_Child_Object_Simple_A2).l		   ; Offset_0x041F5A
;-------------------------------------------------------------------------------
Offset_0x035532:
		st		(Level_Trigger_Array+$08).w			 ; $FFFFF7E8
Offset_0x035536:
		rts
;-------------------------------------------------------------------------------
Offset_0x035538:
		subq.w	#$01, Obj_Height_3(A0)					 ; $0044
		bne.s	Offset_0x035546
		moveq	#mus_Knuckles, D0					 ; $1F
		jsr		(Play_Music).l					 ; Offset_0x001176
Offset_0x035546:
		rts
;-------------------------------------------------------------------------------
Knuckles_Setup_Data:						   ; Offset_0x035548
		dc.w	$0000
		dc.w	$A500
		dc.w	$002E
		dc.w	$0000
		dc.l	Knuckles_Mappings_2			   ; Offset_0x035678
		dc.w	$0280
		dc.b	$1C, $18, $16, $00
;-------------------------------------------------------------------------------
Knuckles_Switch_Setup_Data:					   ; Offset_0x03555A
		dc.l	Switch_Mappings				   ; Offset_0x023832
		dc.w	$8456, $0200
		dc.b	$10, $08, $00, $00
;-------------------------------------------------------------------------------
Offset_0x035566:
		dc.l	Knuckles_LBz_Bomb_Mappings			   ; Offset_0x03566E
		dc.w	$A4A5, $0080
		dc.b	$08, $08, $00, $00
;-------------------------------------------------------------------------------
Offset_0x035572:
		dc.l	Knuckles_LBz_Pillar_Mappings		   ; Offset_0x10D86A
		dc.w	$4425, $0280
		dc.b	$08, $08, $0E, $00
;-------------------------------------------------------------------------------
Offset_0x03557E:
		dc.w	$0000
		dc.l	Offset_0x035062
		dc.b	$E0, $94
;-------------------------------------------------------------------------------
Offset_0x035586:
		dc.w	$0000
		dc.l	Offset_0x035200
		dc.b	$C0, $00
;-------------------------------------------------------------------------------
Offset_0x03558E:
		dc.w	$0000
		dc.l	Offset_0x035260
		dc.b	$F8, $F0
;-------------------------------------------------------------------------------
Offset_0x035596:
		dc.w	$0003
		dc.l	Offset_0x035288
;-------------------------------------------------------------------------------
Offset_0x03559C:
		dc.w	$0006
		dc.l	Offset_0x0353B8
		dc.b	$02, $1C
;-------------------------------------------------------------------------------
Knuckles_PLC_Data:							   ; Offset_0x0355A4
		dc.l	Art_Knuckles_2				   ; Offset_0x127328
		dc.l	Knuckles_Dyn_Script_2		   ; Offset_0x035970
;-------------------------------------------------------------------------------
Offset_0x0355AC:
		dc.b	$07, $01, $02, $03, $FC
;-------------------------------------------------------------------------------
Offset_0x0355B1:
		dc.b	$05, $0A, $0B, $0C, $0D, $0E, $0F, $10
		dc.b	$11, $FC
;-------------------------------------------------------------------------------
Offset_0x0355BB:
		dc.b	$01, $08, $04, $08, $05, $08, $06, $08
		dc.b	$07, $FC
;-------------------------------------------------------------------------------
Offset_0x0355C5:
		dc.b	$07, $1C, $1C, $1D, $F8, $06
;-------------------------------------------------------------------------------
Offset_0x0355CB:
		dc.b	$07, $1E, $1F, $FC
;-------------------------------------------------------------------------------
Offset_0x0355CF:
		dc.b	$16, $07, $16, $07, $17, $07, $18, $07
		dc.b	$19, $13, $1A, $07, $1B, $00, $F4
;-------------------------------------------------------------------------------
Offset_0x0355DE:
		dc.b	$20, $05, $21, $05, $22, $14, $23, $03
		dc.b	$24, $0F, $21, $05, $20, $05, $F4, $00
;-------------------------------------------------------------------------------
Knuckles_Palette:							   ; Offset_0x0355EE
		dc.w	$0000, $0EEE, $084E, $040C, $0206, $0080, $000E, $0008
		dc.w	$00AE, $008E, $08AE, $046A, $0ECC, $0CAA, $0866, $0222
;-------------------------------------------------------------------------------
Knuckles_Palette_CNz_Lamp:					   ; Offset_0x03560E
		dc.w	$0000, $0EEE, $0222, $0E60, $0C22, $00EE, $0088, $0EC0
		dc.w	$008E, $000A, $0020, $0ECC, $0C88, $0866, $0644, $0044
;-------------------------------------------------------------------------------
Knuckles_Palette_CNz_Boss:					   ; Offset_0x03562E
		dc.w	$0000, $0EEE, $0EC0, $0E60, $0C22, $00EE, $0088, $008E
		dc.w	$004E, $000A, $0000, $0020, $0CAA, $0866, $0644, $0044
;-------------------------------------------------------------------------------
Knuckles_Palette_LBz:						   ; Offset_0x03564E
		dc.w	$0000, $0EEE, $00E0, $0080, $0242, $00EE, $0088, $0000
		dc.w	$068E, $000C, $0008, $0020, $0EAA, $0A64, $0642, $0044
;-------------------------------------------------------------------------------
Knuckles_LBz_Bomb_Mappings:					   ; Offset_0x03566E
		dc.w	Offset_0x035670-Knuckles_LBz_Bomb_Mappings
Offset_0x035670:
		dc.w	$0001
		dc.w	$F805, $0000, $FFF8
;-------------------------------------------------------------------------------
Knuckles_Mappings_2:						   ; Offset_0x035678
		dc.w	Offset_0x0356C2-Knuckles_Mappings_2
		dc.w	Offset_0x0356C4-Knuckles_Mappings_2
		dc.w	Offset_0x0356DE-Knuckles_Mappings_2
		dc.w	Offset_0x0356F8-Knuckles_Mappings_2
		dc.w	Offset_0x035712-Knuckles_Mappings_2
		dc.w	Offset_0x03571A-Knuckles_Mappings_2
		dc.w	Offset_0x035722-Knuckles_Mappings_2
		dc.w	Offset_0x03572A-Knuckles_Mappings_2
		dc.w	Offset_0x035732-Knuckles_Mappings_2
		dc.w	Offset_0x03573A-Knuckles_Mappings_2
		dc.w	Offset_0x035754-Knuckles_Mappings_2
		dc.w	Offset_0x03576E-Knuckles_Mappings_2
		dc.w	Offset_0x035782-Knuckles_Mappings_2
		dc.w	Offset_0x035796-Knuckles_Mappings_2
		dc.w	Offset_0x0357A4-Knuckles_Mappings_2
		dc.w	Offset_0x0357BE-Knuckles_Mappings_2
		dc.w	Offset_0x0357D8-Knuckles_Mappings_2
		dc.w	Offset_0x0357EC-Knuckles_Mappings_2
		dc.w	Offset_0x035806-Knuckles_Mappings_2
		dc.w	Offset_0x035814-Knuckles_Mappings_2
		dc.w	Offset_0x035822-Knuckles_Mappings_2
		dc.w	Offset_0x035830-Knuckles_Mappings_2
		dc.w	Offset_0x03583E-Knuckles_Mappings_2
		dc.w	Offset_0x03584C-Knuckles_Mappings_2
		dc.w	Offset_0x035866-Knuckles_Mappings_2
		dc.w	Offset_0x03587A-Knuckles_Mappings_2
		dc.w	Offset_0x035894-Knuckles_Mappings_2
		dc.w	Offset_0x0358AE-Knuckles_Mappings_2
		dc.w	Offset_0x0358BC-Knuckles_Mappings_2
		dc.w	Offset_0x0358D0-Knuckles_Mappings_2
		dc.w	Offset_0x0358E4-Knuckles_Mappings_2
		dc.w	Offset_0x0358F8-Knuckles_Mappings_2
		dc.w	Offset_0x03590C-Knuckles_Mappings_2
		dc.w	Offset_0x03591A-Knuckles_Mappings_2
		dc.w	Offset_0x035928-Knuckles_Mappings_2
		dc.w	Offset_0x035942-Knuckles_Mappings_2
		dc.w	Offset_0x035956-Knuckles_Mappings_2
Offset_0x0356C2:
		dc.w	$0000
Offset_0x0356C4:
		dc.w	$0004
		dc.w	$EC0F, $0000, $FFF5
		dc.w	$EC01, $0010, $0015
		dc.w	$FC01, $0012, $FFED
		dc.w	$0C04, $0014, $FFF5
Offset_0x0356DE:
		dc.w	$0004
		dc.w	$F405, $0000, $0011
		dc.w	$F40F, $0004, $FFF1
		dc.w	$E409, $0014, $FFF9
		dc.w	$0400, $001A, $FFE9
Offset_0x0356F8:
		dc.w	$0004
		dc.w	$E404, $0000, $0003
		dc.w	$EC0F, $0002, $FFFB
		dc.w	$F406, $0012, $FFEB
		dc.w	$0C04, $0018, $FFFB
Offset_0x035712:
		dc.w	$0001
		dc.w	$F00F, $0000, $FFF0
Offset_0x03571A:
		dc.w	$0001
		dc.w	$F00F, $0000, $FFF0
Offset_0x035722:
		dc.w	$0001
		dc.w	$F00F, $0000, $FFF0
Offset_0x03572A:
		dc.w	$0001
		dc.w	$F00F, $0000, $FFF0
Offset_0x035732:
		dc.w	$0001
		dc.w	$F00F, $0000, $FFF0
Offset_0x03573A:
		dc.w	$0004
		dc.w	$EB0D, $0000, $FFF2
		dc.w	$EB00, $0008, $0012
		dc.w	$FB0A, $0009, $FFF2
		dc.w	$0305, $0012, $000A
Offset_0x035754:
		dc.w	$0004
		dc.w	$EC08, $0000, $FFF3
		dc.w	$F40E, $0003, $FFF3
		dc.w	$FC02, $000F, $FFEB
		dc.w	$0C04, $0012, $0003
Offset_0x03576E:
		dc.w	$0003
		dc.w	$EC04, $0000, $FFF9
		dc.w	$F40F, $0002, $FFF1
		dc.w	$FC02, $0012, $FFE9
Offset_0x035782:
		dc.w	$0003
		dc.w	$EC09, $0000, $FFF4
		dc.w	$FC0D, $0006, $FFEC
		dc.w	$0C04, $000E, $FFF4
Offset_0x035796:
		dc.w	$0002
		dc.w	$EC09, $0000, $FFF5
		dc.w	$FC0E, $0006, $FFED
Offset_0x0357A4:
		dc.w	$0004
		dc.w	$EC08, $0000, $FFF4
		dc.w	$F40E, $0003, $FFF4
		dc.w	$FC02, $000F, $FFEC
		dc.w	$0C00, $0012, $0004
Offset_0x0357BE:
		dc.w	$0004
		dc.w	$EA04, $0000, $FFFA
		dc.w	$F208, $0002, $FFF2
		dc.w	$FA0E, $0005, $FFF2
		dc.w	$0201, $0011, $FFEA
Offset_0x0357D8:
		dc.w	$0003
		dc.w	$EC04, $0000, $FFF7
		dc.w	$F40E, $0002, $FFEF
		dc.w	$0C08, $000E, $FFEF
Offset_0x0357EC:
		dc.w	$0004
		dc.w	$EC09, $0000, $FFF3
		dc.w	$FC0D, $0006, $FFF3
		dc.w	$FC00, $000E, $FFEB
		dc.w	$0C08, $000F, $FFF3
Offset_0x035806:
		dc.w	$0002
		dc.w	$EC08, $0000, $FFF5
		dc.w	$F40F, $0003, $FFED
Offset_0x035814:
		dc.w	$0002
		dc.w	$ED08, $0000, $FFF5
		dc.w	$F50F, $0003, $FFED
Offset_0x035822:
		dc.w	$0002
		dc.w	$EC08, $0000, $FFF5
		dc.w	$F40F, $0003, $FFED
Offset_0x035830:
		dc.w	$0002
		dc.w	$ED08, $0000, $FFF5
		dc.w	$F50F, $0003, $FFED
Offset_0x03583E:
		dc.w	$0002
		dc.w	$EC09, $0000, $FFF9
		dc.w	$FC0E, $0006, $FFF1
Offset_0x03584C:
		dc.w	$0004
		dc.w	$EC08, $0000, $FFF9
		dc.w	$F40D, $0003, $FFF1
		dc.w	$0408, $000B, $FFF9
		dc.w	$0C0C, $000E, $FFF1
Offset_0x035866:
		dc.w	$0003
		dc.w	$EC08, $0000, $FFEF
		dc.w	$F40D, $0003, $FFEF
		dc.w	$0409, $000B, $FFEF
Offset_0x03587A:
		dc.w	$0004
		dc.w	$EC0D, $0000, $FFF2
		dc.w	$F400, $0008, $FFEA
		dc.w	$FC0D, $0009, $FFEA
		dc.w	$0C08, $0011, $FFEA
Offset_0x035894:
		dc.w	$0004
		dc.w	$EC08, $0000, $FFEF
		dc.w	$F40C, $0003, $FFE7
		dc.w	$FC09, $0007, $FFEF
		dc.w	$0C0C, $000D, $FFE7
Offset_0x0358AE:
		dc.w	$0002
		dc.w	$EC09, $0000, $FFEA
		dc.w	$FC0E, $0006, $FFE2
Offset_0x0358BC:
		dc.w	$0003
		dc.w	$EC0A, $0000, $FFF7
		dc.w	$0404, $0009, $FFF7
		dc.w	$0C0C, $000B, $FFEF
Offset_0x0358D0:
		dc.w	$0003
		dc.w	$EC0A, $0000, $FFF7
		dc.w	$0404, $0009, $FFF7
		dc.w	$0C0C, $000B, $FFEF
Offset_0x0358E4:
		dc.w	$0003
		dc.w	$EC0A, $0000, $FFF7
		dc.w	$0404, $0009, $FFF7
		dc.w	$0C0C, $000B, $FFEF
Offset_0x0358F8:
		dc.w	$0003
		dc.w	$EC0A, $0000, $FFF7
		dc.w	$0404, $0009, $FFF7
		dc.w	$0C0C, $000B, $FFEF
Offset_0x03590C:
		dc.w	$0002
		dc.w	$EC09, $0800, $FFF3
		dc.w	$FC0E, $0806, $FFF3
Offset_0x03591A:
		dc.w	$0002
		dc.w	$EC09, $0000, $FFF3
		dc.w	$FC0E, $0006, $FFF3
Offset_0x035928:
		dc.w	$0004
		dc.w	$EC08, $0000, $FFF3
		dc.w	$F40D, $0003, $FFF3
		dc.w	$0408, $000B, $FFF3
		dc.w	$0C0C, $000E, $FFF3
Offset_0x035942:
		dc.w	$0003
		dc.w	$EC08, $0000, $FFF5
		dc.w	$F40D, $0003, $FFF5
		dc.w	$0409, $000B, $FFF5
Offset_0x035956:
		dc.w	$0004
		dc.w	$EC0E, $0000, $FFF3
		dc.w	$F401, $000C, $0013
		dc.w	$0408, $000E, $FFF3
		dc.w	$0C0C, $0011, $FFF3
;-------------------------------------------------------------------------------
Knuckles_Dyn_Script_2:						   ; Offset_0x035970
		dc.w	Offset_0x0359BA-Knuckles_Dyn_Script_2
		dc.w	Offset_0x0359BE-Knuckles_Dyn_Script_2
		dc.w	Offset_0x0359C8-Knuckles_Dyn_Script_2
		dc.w	Offset_0x0359D2-Knuckles_Dyn_Script_2
		dc.w	Offset_0x0359DC-Knuckles_Dyn_Script_2
		dc.w	Offset_0x0359E0-Knuckles_Dyn_Script_2
		dc.w	Offset_0x0359E4-Knuckles_Dyn_Script_2
		dc.w	Offset_0x0359E8-Knuckles_Dyn_Script_2
		dc.w	Offset_0x0359EC-Knuckles_Dyn_Script_2
		dc.w	Offset_0x0359F0-Knuckles_Dyn_Script_2
		dc.w	Offset_0x0359FA-Knuckles_Dyn_Script_2
		dc.w	Offset_0x035A04-Knuckles_Dyn_Script_2
		dc.w	Offset_0x035A0C-Knuckles_Dyn_Script_2
		dc.w	Offset_0x035A14-Knuckles_Dyn_Script_2
		dc.w	Offset_0x035A1A-Knuckles_Dyn_Script_2
		dc.w	Offset_0x035A24-Knuckles_Dyn_Script_2
		dc.w	Offset_0x035A2E-Knuckles_Dyn_Script_2
		dc.w	Offset_0x035A36-Knuckles_Dyn_Script_2
		dc.w	Offset_0x035A40-Knuckles_Dyn_Script_2
		dc.w	Offset_0x035A46-Knuckles_Dyn_Script_2
		dc.w	Offset_0x035A4C-Knuckles_Dyn_Script_2
		dc.w	Offset_0x035A52-Knuckles_Dyn_Script_2
		dc.w	Offset_0x035A58-Knuckles_Dyn_Script_2
		dc.w	Offset_0x035A5E-Knuckles_Dyn_Script_2
		dc.w	Offset_0x035A68-Knuckles_Dyn_Script_2
		dc.w	Offset_0x035A70-Knuckles_Dyn_Script_2
		dc.w	Offset_0x035A7A-Knuckles_Dyn_Script_2
		dc.w	Offset_0x035A84-Knuckles_Dyn_Script_2
		dc.w	Offset_0x035A8A-Knuckles_Dyn_Script_2
		dc.w	Offset_0x035A92-Knuckles_Dyn_Script_2
		dc.w	Offset_0x035A9A-Knuckles_Dyn_Script_2
		dc.w	Offset_0x035AA2-Knuckles_Dyn_Script_2
		dc.w	Offset_0x035AAA-Knuckles_Dyn_Script_2
		dc.w	Offset_0x035AB0-Knuckles_Dyn_Script_2
		dc.w	Offset_0x035AB6-Knuckles_Dyn_Script_2
		dc.w	Offset_0x035AC0-Knuckles_Dyn_Script_2
		dc.w	Offset_0x035AC8-Knuckles_Dyn_Script_2
Offset_0x0359BA:
		dc.w	$0000
		dc.w	$000F
Offset_0x0359BE:
		dc.w	$0003
		dc.w	$000F, $0101, $0121, $0141
Offset_0x0359C8:
		dc.w	$0003
		dc.w	$0163, $01AF, $02A5, $0300
Offset_0x0359D2:
		dc.w	$0003
		dc.w	$0311, $033F, $0435, $0491
Offset_0x0359DC:
		dc.w	$0000
		dc.w	$04BF
Offset_0x0359E0:
		dc.w	$0000
		dc.w	$05BF
Offset_0x0359E4:
		dc.w	$0000
		dc.w	$06BF
Offset_0x0359E8:
		dc.w	$0000
		dc.w	$07BF
Offset_0x0359EC:
		dc.w	$0000
		dc.w	$08BF
Offset_0x0359F0:
		dc.w	$0003
		dc.w	$09B7, $0A30, $0A48, $0AD3
Offset_0x0359FA:
		dc.w	$0003
		dc.w	$0B12, $0B4B, $0C02, $0C31
Offset_0x035A04:
		dc.w	$0002
		dc.w	$0C51, $0C7F, $0D72
Offset_0x035A0C:
		dc.w	$0002
		dc.w	$0DA5, $0E07, $0E81
Offset_0x035A14:
		dc.w	$0001
		dc.w	$0EA5, $0F0B
Offset_0x035A1A:
		dc.w	$0003
		dc.w	$0FC2, $0FFB, $10B2, $10E0
Offset_0x035A24:
		dc.w	$0003
		dc.w	$10F1, $1112, $114B, $1201
Offset_0x035A2E:
		dc.w	$0002
		dc.w	$1221, $124B, $1302
Offset_0x035A36:
		dc.w	$0003
		dc.w	$1335, $1397, $1410, $1422
Offset_0x035A40:
		dc.w	$0001
		dc.w	$1452, $148F
Offset_0x035A46:
		dc.w	$0001
		dc.w	$1582, $15BF
Offset_0x035A4C:
		dc.w	$0001
		dc.w	$16B2, $16EF
Offset_0x035A52:
		dc.w	$0001
		dc.w	$17E2, $181F
Offset_0x035A58:
		dc.w	$0001
		dc.w	$1915, $197B
Offset_0x035A5E:
		dc.w	$0003
		dc.w	$1A32, $1A67, $1AE2, $1B13
Offset_0x035A68:
		dc.w	$0002
		dc.w	$1B52, $1B87, $1C05
Offset_0x035A70:
		dc.w	$0003
		dc.w	$1C67, $1CE0, $1CF7, $1D72
Offset_0x035A7A:
		dc.w	$0003
		dc.w	$1DA2, $1DD3, $1E15, $1E73
Offset_0x035A84:
		dc.w	$0001
		dc.w	$1EB5, $1F1B
Offset_0x035A8A:
		dc.w	$0002
		dc.w	$1FD8, $2061, $2083
Offset_0x035A92:
		dc.w	$0002
		dc.w	$20C8, $2151, $2083
Offset_0x035A9A:
		dc.w	$0002
		dc.w	$2178, $2201, $2083
Offset_0x035AA2:
		dc.w	$0002
		dc.w	$2228, $22B1, $2083
Offset_0x035AAA:
		dc.w	$0001
		dc.w	$1915, $197B
Offset_0x035AB0:
		dc.w	$0001
		dc.w	$22D5, $233B
Offset_0x035AB6:
		dc.w	$0003
		dc.w	$23F2, $2427, $24A2, $24D3
Offset_0x035AC0:
		dc.w	$0002
		dc.w	$2512, $2547, $25C5
Offset_0x035AC8:
		dc.w	$0003
		dc.w	$262B, $26E1, $2702, $2733
;===============================================================================
; Objeto 0xC9 - Interruptor usado pelo Knuckles em algumas cenas de introdução
; <<<-
;===============================================================================