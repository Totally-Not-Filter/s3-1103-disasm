;-------------------------------------------------------------------------------
; Onda causada pelo jogador rolando na superfície da água
; ->>>
;-------------------------------------------------------------------------------
; Offset_0x014926:
		move.l	#Wave_Splash_Mappings, Obj_Map(A0) ; Offset_0x0149F2, $000C
		move.w	#$842E, Obj_Art_VRAM(A0)				 ; $000A
		move.b	#$04, Obj_Flags(A0)				 ; $0004
		move.b	#$80, Obj_Width(A0)				 ; $0007
		move.b	#$08, Obj_Height(A0)					 ; $0006
		bset	#$06, Obj_Flags(A0)				 ; $0004
		move.w	#$0001, Obj_Sub_Y(A0)					 ; $0016
		lea		Obj_Speed_X(A0), A2				 ; $0018
		move.w	Obj_X(A0), (A2)					 ; $0010
		addi.w	#$00C0, (A2)+
		move.w	Obj_Y(A0), (A2)+				 ; $0014
		move.l	#Offset_0x014968, (A0)
Offset_0x014968:
		move.w	(Camera_X).w, D1					 ; $FFFFEE78
		andi.w	#$FFE0, D1
		addi.w	#$0060, D1
		btst	#$00, (Level_Frame_Count+$01).w		 ; $FFFFFE05
		beq.s	Offset_0x014980
		addi.w	#$0020, D1
Offset_0x014980:
		move.w	D1, Obj_X(A0)					 ; $0010
		move.w	(Water_Level_Move).w, D1			 ; $FFFFF646
		move.w	D1, Obj_Y(A0)					 ; $0014
		lea		Obj_Speed_X(A0), A2				 ; $0018
		move.w	Obj_X(A0), (A2)					 ; $0010
		addi.w	#$00C0, (A2)+
		move.w	Obj_Y(A0), (A2)+				 ; $0014
		tst.b	Obj_Control_Var_02(A0)					 ; $0032
		bne.s	Offset_0x0149BA
		tst.b	(Control_Ports_Logical_Data+$01).w			 ; $FFFFF603
		bmi.s	Offset_0x0149AE
		tst.b	(Control_Ports_Logical_Data_2+$01).w		 ; $FFFFF66B
		bpl.s	Offset_0x0149CA
Offset_0x0149AE:
		addq.b	#$03, Obj_Map_Id(A0)					 ; $0022
		move.b	#$01, Obj_Control_Var_02(A0)			 ; $0032
		bra.s	Offset_0x0149E8
Offset_0x0149BA:
		tst.w	(Pause_Status).w					 ; $FFFFF63A
		bne.s	Offset_0x0149E8
		move.b	#$00, Obj_Control_Var_02(A0)			 ; $0032
		subq.b	#$03, Obj_Map_Id(A0)					 ; $0022
Offset_0x0149CA:
		subq.b	#$01, Obj_Ani_Time(A0)					 ; $0024
		bpl.s	Offset_0x0149E8
		move.b	#$09, Obj_Ani_Time(A0)					 ; $0024
		addq.b	#$01, Obj_Map_Id(A0)					 ; $0022
		cmpi.b	#$04, Obj_Map_Id(A0)					 ; $0022
		bcs.s	Offset_0x0149E8
		move.b	#$01, Obj_Map_Id(A0)					 ; $0022
Offset_0x0149E8:
		move.b	Obj_Map_Id(A0), $0001(A2)				 ; $0022
		bra.w	DisplaySprite				   ; Offset_0x011148
;-------------------------------------------------------------------------------
Wave_Splash_Mappings:						   ; Offset_0x0149F2
		dc.w	Offset_0x014A00-Wave_Splash_Mappings
		dc.w	Offset_0x014A00-Wave_Splash_Mappings
		dc.w	Offset_0x014A14-Wave_Splash_Mappings
		dc.w	Offset_0x014A28-Wave_Splash_Mappings
		dc.w	Offset_0x014A3C-Wave_Splash_Mappings
		dc.w	Offset_0x014A62-Wave_Splash_Mappings
		dc.w	Offset_0x014A88-Wave_Splash_Mappings
Offset_0x014A00:
		dc.w	$0003
		dc.w	$FD0D, $0000, $FFA0
		dc.w	$FD0D, $0000, $FFE0
		dc.w	$FD0D, $0000, $0020
Offset_0x014A14:
		dc.w	$0003
		dc.w	$FD0D, $0008, $FFA0
		dc.w	$FD0D, $0008, $FFE0
		dc.w	$FD0D, $0008, $0020
Offset_0x014A28:
		dc.w	$0003
		dc.w	$FD0D, $0800, $FFA0
		dc.w	$FD0D, $0800, $FFE0
		dc.w	$FD0D, $0800, $0020
Offset_0x014A3C:
		dc.w	$0006
		dc.w	$FD0D, $0000, $FFA0
		dc.w	$FD0D, $0000, $FFC0
		dc.w	$FD0D, $0000, $FFE0
		dc.w	$FD0D, $0000, $0000
		dc.w	$FD0D, $0000, $0020
		dc.w	$FD0D, $0000, $0040
Offset_0x014A62:
		dc.w	$0006
		dc.w	$FD0D, $0008, $FFA0
		dc.w	$FD0D, $0008, $FFC0
		dc.w	$FD0D, $0008, $FFE0
		dc.w	$FD0D, $0008, $0000
		dc.w	$FD0D, $0008, $0020
		dc.w	$FD0D, $0008, $0040
Offset_0x014A88:
		dc.w	$0006
		dc.w	$FD0D, $0800, $FFA0
		dc.w	$FD0D, $0800, $FFC0
		dc.w	$FD0D, $0800, $FFE0
		dc.w	$FD0D, $0800, $0000
		dc.w	$FD0D, $0800, $0020
		dc.w	$FD0D, $0800, $0040
;-------------------------------------------------------------------------------
; Onda causada pelo jogador rolando na superfície da água
; <<<-
;-------------------------------------------------------------------------------