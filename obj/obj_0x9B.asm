;===============================================================================
; Objeto 0x9B - Inimigo Buggernaut na Hydrocity
; ->>>
;===============================================================================
; Offset_0x0447A6:
		jsr		(Object_Check_Range).l		   ; Offset_0x04326E
Offset_0x0447AC:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x0447BE(PC, D0), D1
		jsr		Offset_0x0447BE(PC, D1)
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X(PC) ; Offset_0x042B3C
;-------------------------------------------------------------------------------
Offset_0x0447BE:
		dc.w	Offset_0x0447C4-Offset_0x0447BE
		dc.w	Offset_0x0447F6-Offset_0x0447BE
		dc.w	Offset_0x044814-Offset_0x0447BE
;-------------------------------------------------------------------------------
Offset_0x0447C4:
		lea		Buggernaut_Setup_Data(PC), A1		   ; Offset_0x044922
		jsr		SetupObjectAttributes(PC)			 ; Offset_0x041D72
		move.l	#Offset_0x04493C, Obj_Child_Data(A0)			 ; $0030
		lea		Offset_0x044934(PC), A2
		jsr		SetupChildObject(PC)			   ; Offset_0x041D9A
		addq.b	#$01, Obj_Control_Var_09(A0)			 ; $0039
Offset_0x0447E0:
		move.b	#$02, Obj_Routine(A0)					 ; $0005
		move.w	#$003F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x0447FE, Obj_Child(A0)			 ; $0034
		rts
;-------------------------------------------------------------------------------
Offset_0x0447F6:
		jsr		AnimateRaw(PC)				  ; Offset_0x04208E
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x0447FE:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.w	#$007F, Obj_Timer(A0)					 ; $002E
		move.l	#Offset_0x0447E0, Obj_Child(A0)			 ; $0034
Offset_0x044812:
		rts
;-------------------------------------------------------------------------------
Offset_0x044814:
		tst.b	Obj_Flags(A0)					 ; $0004
		bpl.s	Offset_0x044812
		jsr		Find_Player(PC)				   ; Offset_0x042634
		jsr		Change_Flip_X(PC)			   ; Offset_0x042678
		move.w	#$0200, D0
		moveq	#$10, D1
		jsr		Chase_Object(PC)			   ; Offset_0x042E6C
		bsr.w	Offset_0x04490A
		jsr		(SpeedToPos).l				   ; Offset_0x01111E
		jsr		AnimateRaw(PC)				  ; Offset_0x04208E
		jmp		Run_Object_Wait_Timer_A0(PC)		   ; Offset_0x0423D2
;-------------------------------------------------------------------------------
Offset_0x04483E:
		moveq	#$00, D0
		move.b	Obj_Routine(A0), D0				 ; $0005
		move.w	Offset_0x044850(PC, D0), D1
		jsr		Offset_0x044850(PC, D1)
		jmp		Delete_Sprite_Clear_Respaw_Flag_Check_X_Y(PC) ; Offset_0x042B96
;-------------------------------------------------------------------------------
Offset_0x044850:
		dc.w	Offset_0x044856-Offset_0x044850
		dc.w	Offset_0x044868-Offset_0x044850
		dc.w	Offset_0x0448CE-Offset_0x044850
;-------------------------------------------------------------------------------
Offset_0x044856:
		lea		Buggernaut_Setup_Data_2(PC), A1		   ; Offset_0x04492E
		jsr		SetupObjectAttributes3(PC)			; Offset_0x041D7A
		move.l	#Offset_0x044941, Obj_Child_Data(A0)			 ; $0030
		rts
;-------------------------------------------------------------------------------
Offset_0x044868:
		jsr		AnimateRaw(PC)				  ; Offset_0x04208E
		move.w	Obj_Child_Ref(A0), A1					 ; $0046
		cmpi.l	#Offset_0x0447AC, (A1)
		beq.s	Offset_0x04487E
		bsr.w	Offset_0x0448D8
		beq.s	Offset_0x0448A6
Offset_0x04487E:
		bclr	#$00, Obj_Flags(A0)				 ; $0004
		btst	#$00, Obj_Flags(A1)				 ; $0004
		beq.s	Offset_0x044892
		bset	#$00, Obj_Flags(A0)				 ; $0004
Offset_0x044892:
		move.w	#$0200, D0
		moveq	#$20, D1
		jsr		Chase_Object(PC)			   ; Offset_0x042E6C
		bsr.w	Offset_0x04490A
		jmp		(SpeedToPos).l				   ; Offset_0x01111E
Offset_0x0448A6:
		move.b	#$04, Obj_Routine(A0)					 ; $0005
		move.w	Obj_X(A0), D0					 ; $0010
		move.w	#$0200, D1
		bset	#$00, Obj_Flags(A0)				 ; $0004
		cmp.w	(Obj_Player_One+Obj_X).w, D0		 ; $FFFFB010
		bcc.s	Offset_0x0448C8
		neg.w	D1
		bclr	#$00, Obj_Flags(A0)				 ; $0004
Offset_0x0448C8:
		move.w	D1, Obj_Speed_X(A0)				 ; $0018
		rts
;-------------------------------------------------------------------------------
Offset_0x0448CE:
		jsr		AnimateRaw(PC)				  ; Offset_0x04208E
		jmp		(SpeedToPos).l				   ; Offset_0x01111E
Offset_0x0448D8:
		lea		(Obj_04_Mem_Address).w, A2			 ; $FFFFB128
		move.w	#$0059, D0
Offset_0x0448E0:
		cmpi.l	#Offset_0x0447AC, (A2)
		beq.s	Offset_0x0448F4
Offset_0x0448E8:
		lea		Obj_Size(A2), A2				 ; $004A
		dbra	D0, Offset_0x0448E0
		moveq	#$00, D0
		rts
Offset_0x0448F4:
		move.b	Obj_Control_Var_09(A2), D1				 ; $0039
		addq.b	#$01, D1
		cmpi.b	#$04, D1
		bhi.s	Offset_0x0448E8
		move.b	D1, Obj_Control_Var_09(A2)				 ; $0039
		move.w	A2, Obj_Child_Ref(A0)					 ; $0046
		rts
;-------------------------------------------------------------------------------
Offset_0x04490A:
		move.w	Obj_Y(A0), D0					 ; $0014
		move.w	(Water_Level_Move).w, D1			 ; $FFFFF646
		subi.w	#$0008, D1
		cmp.w	D1, D0
		bcs.s	Offset_0x044920
		move.w	#$FE00, Obj_Speed_Y(A0)					 ; $001A
Offset_0x044920:
		rts
;-------------------------------------------------------------------------------
Buggernaut_Setup_Data:						   ; Offset_0x044922
		dc.l	Buggernaut_Mappings			   ; Offset_0x10DE4E
		dc.w	$A453, $0280
		dc.b	$10, $0C, $00, $17
;-------------------------------------------------------------------------------
Buggernaut_Setup_Data_2:					   ; Offset_0x04492E
		dc.w	$0280
		dc.b	$0C, $0C, $03, $00
;-------------------------------------------------------------------------------
Offset_0x044934:
		dc.w	$0000
		dc.l	Offset_0x04483E
		dc.b	$20, $00
;-------------------------------------------------------------------------------
Offset_0x04493C:
		dc.b	$00, $00, $01, $02, $FC
;-------------------------------------------------------------------------------
Offset_0x044941:
		dc.b	$00, $03, $04, $05, $FC
;===============================================================================
; Objeto 0x9B - Inimigo Buggernaut na Hydrocity
; <<<-
;===============================================================================