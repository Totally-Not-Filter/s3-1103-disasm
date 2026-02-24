;===============================================================================
; Objeto de teste de escalonamento das esferas
; ->>>
;===============================================================================
; Offset_0x01B338:
		lea		(Offset_0x01B7F6).l, A6
		move.l	A0, A1
		move.l	#Obj_Sphere_Test_Main, (A1)			   ; Offset_0x01B696
		cmpi.b	#$01, Obj_Subtype(A0)					 ; $002C
		beq.w	Offset_0x01B362
		cmpi.b	#$02, Obj_Subtype(A0)					 ; $002C
		beq.w	Offset_0x01B520
		tst.b	(Control_Ports_Buffer_Data+$02).w			 ; $FFFFF606
		bne.w	Offset_0x01B520
Offset_0x01B362:
		moveq	#$00, D2
		moveq	#$0D, D3
		tst.w	(Art_Scaling_Address).w				 ; $FFFFF75C
		bne.s	Offset_0x01B3A0
		move.w	A0, (Art_Scaling_Address).w			 ; $FFFFF75C
		move.w	#$0000, (Art_Scaling_Data_Buffer+$16).w		 ; $FFFFF756
		move.w	#$0000, (Art_Scaling_Data_Buffer+$18).w		 ; $FFFFF758
		move.w	#$0200, (Art_Scaling_Data_Buffer+$1A).w		 ; $FFFFF75A
		move.w	#$0000, (Art_Scaling_Index_0).w		 ; $FFFFF744
		move.w	#$0000, (Art_Scaling_Index_1).w		 ; $FFFFF746
		move.w	#$0000, (Art_Scaling_Index_2).w		 ; $FFFFF748
		bra.s	Offset_0x01B3A6
;-------------------------------------------------------------------------------
Offset_0x01B396:
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x01B4AA
Offset_0x01B3A0:
		move.l	#Obj_Eosian_Sphere, (A1)			   ; Offset_0x01B75A
Offset_0x01B3A6:
		bsr.w	Offset_0x01B4CA
		bsr.w	Offset_0x01B50A
		move.w	D2, D0
		addi.w	#$0010, D2
		jsr		(CalcSine).l					 ; Offset_0x001B20
		asr.w	#$01, D0
		asr.w	#$01, D1
		move.w	D1, Obj_Control_Var_04(A1)				 ; $0034
		move.w	D0, Obj_Control_Var_06(A1)				 ; $0036
		move.w	#$FFE0, Obj_Control_Var_08(A1)			 ; $0038
		move.l	A6, Obj_Control_Var_0A(A1)				 ; $003A
		adda.w	#$0010, A6
		dbra	D3, Offset_0x01B396
		moveq	#$00, D2
		moveq	#$0D, D3
Offset_0x01B3DC:
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x01B4AA
		move.l	#Obj_Eosian_Sphere, (A1)			   ; Offset_0x01B75A
		bsr.w	Offset_0x01B4CA
		bsr.w	Offset_0x01B50A
		move.w	D2, D0
		addi.w	#$0010, D2
		jsr		(CalcSine).l					 ; Offset_0x001B20
		asr.w	#$01, D0
		asr.w	#$01, D1
		move.w	D1, Obj_Control_Var_04(A1)				 ; $0034
		move.w	D0, Obj_Control_Var_06(A1)				 ; $0036
		move.w	#$0020, Obj_Control_Var_08(A1)			 ; $0038
		move.l	A6, Obj_Control_Var_0A(A1)				 ; $003A
		adda.w	#$0010, A6
		dbra	D3, Offset_0x01B3DC
		moveq	#$00, D2
		moveq	#$0D, D3
Offset_0x01B422:
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x01B4AA
		move.l	#Obj_Eosian_Sphere, (A1)			   ; Offset_0x01B75A
		bsr.w	Offset_0x01B4CA
		bsr.w	Offset_0x01B50A
		move.w	D2, D0
		addi.w	#$0010, D2
		jsr		(CalcSine).l					 ; Offset_0x001B20
		asr.w	#$01, D0
		asr.w	#$01, D1
		move.w	#$0020, Obj_Control_Var_04(A1)			 ; $0034
		move.w	D0, Obj_Control_Var_06(A1)				 ; $0036
		move.w	D1, Obj_Control_Var_08(A1)				 ; $0038
		move.l	A6, Obj_Control_Var_0A(A1)				 ; $003A
		adda.w	#$0010, A6
		dbra	D3, Offset_0x01B422
		moveq	#$00, D2
		moveq	#$0D, D3
Offset_0x01B468:
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x01B4AA
		move.l	#Obj_Eosian_Sphere, (A1)			   ; Offset_0x01B75A
		bsr.w	Offset_0x01B4CA
		bsr.w	Offset_0x01B50A
		move.w	D2, D0
		addi.w	#$0010, D2
		jsr		(CalcSine).l					 ; Offset_0x001B20
		asr.w	#$01, D0
		asr.w	#$01, D1
		move.w	#$FFE0, Obj_Control_Var_04(A1)			 ; $0034
		move.w	D0, Obj_Control_Var_06(A1)				 ; $0036
		move.w	D1, Obj_Control_Var_08(A1)				 ; $0038
		move.l	A6, Obj_Control_Var_0A(A1)				 ; $003A
		adda.w	#$0010, A6
		dbra	D3, Offset_0x01B468
Offset_0x01B4AA:
		lea		(Pal_Sphere_Test).l, A1			 ; Offset_0x01B676
		lea		(Palette_Row_1_Offset).w, A2		 ; $FFFFED20
		move.w	#$000F, D0
Offset_0x01B4B8:
		move.w	(A1)+, (A2)+
		dbra	D0, Offset_0x01B4B8
		moveq	#$09, D0
		jsr		(LoadPLC).l				 ; Offset_0x0014D0
		bra.w	Obj_Sphere_Test_Main		   ; Offset_0x01B696
;-------------------------------------------------------------------------------
Offset_0x01B4CA:
		move.b	#$04, Obj_Flags(A1)				 ; $0004
		move.b	#$10, Obj_Width(A1)				 ; $0007
		move.b	#$10, Obj_Height(A1)					 ; $0006
		move.w	#$0200, Obj_Priority(A1)				 ; $0008
		move.l	#Sphere_Test_Mappings, Obj_Map(A1) ; Offset_0x01BB9A, $000C
		move.w	#$24E0, Obj_Art_VRAM(A1)				 ; $000A
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_X(A0), Obj_Control_Var_00(A1)		  ; $0010, $0030
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		move.w	Obj_Y(A0), Obj_Control_Var_02(A1)		  ; $0014, $0032
		rts
Offset_0x01B50A:
		cmpi.w	#$0040, D2
		bne.s	Offset_0x01B514
		addi.w	#$0010, D2
Offset_0x01B514:
		cmpi.w	#$00C0, D2
		bne.s	Offset_0x01B51E
		addi.w	#$0010, D2
Offset_0x01B51E:
		rts
Offset_0x01B520:
		moveq	#$00, D2
		moveq	#$0F, D3
		tst.w	(Art_Scaling_Address).w				 ; $FFFFF75C
		bne.s	Offset_0x01B55E
		move.w	A0, (Art_Scaling_Address).w			 ; $FFFFF75C
		move.w	#$0000, (Art_Scaling_Data_Buffer+$16).w		 ; $FFFFF756
		move.w	#$0000, (Art_Scaling_Data_Buffer+$18).w		 ; $FFFFF758
		move.w	#$0200, (Art_Scaling_Data_Buffer+$1A).w		 ; $FFFFF75A
		move.w	#$0000, (Art_Scaling_Index_0).w		 ; $FFFFF744
		move.w	#$0000, (Art_Scaling_Index_1).w		 ; $FFFFF746
		move.w	#$0000, (Art_Scaling_Index_2).w		 ; $FFFFF748
		bra.s	Offset_0x01B564
;-------------------------------------------------------------------------------
Offset_0x01B554:
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x01B616
Offset_0x01B55E:
		move.l	#Obj_Eosian_Sphere, (A1)			   ; Offset_0x01B75A
Offset_0x01B564:
		bsr.w	Offset_0x01B636
		move.w	D2, D0
		addi.w	#$0010, D2
		jsr		(CalcSine).l					 ; Offset_0x001B20
		asr.w	#$01, D0
		asr.w	#$01, D1
		move.w	D1, Obj_Control_Var_04(A1)				 ; $0034
		move.w	D0, Obj_Control_Var_06(A1)				 ; $0036
		move.w	#$0000, Obj_Control_Var_08(A1)			 ; $0038
		move.l	A6, Obj_Control_Var_0A(A1)				 ; $003A
		adda.w	#$0010, A6
		dbra	D3, Offset_0x01B554
		moveq	#$00, D2
		moveq	#$0F, D3
Offset_0x01B596:
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x01B616
		move.l	#Obj_Eosian_Sphere, (A1)			   ; Offset_0x01B75A
		bsr.w	Offset_0x01B636
		move.w	D2, D0
		addi.w	#$0010, D2
		jsr		(CalcSine).l					 ; Offset_0x001B20
		asr.w	#$01, D0
		asr.w	#$01, D1
		move.w	#$0000, Obj_Control_Var_04(A1)			 ; $0034
		move.w	D0, Obj_Control_Var_06(A1)				 ; $0036
		move.w	D1, Obj_Control_Var_08(A1)				 ; $0038
		move.l	A6, Obj_Control_Var_0A(A1)				 ; $003A
		adda.w	#$0010, A6
		dbra	D3, Offset_0x01B596
		moveq	#$00, D2
		moveq	#$0F, D3
Offset_0x01B5D8:
		jsr		(AllocateObjectAfterCurrent).l		  ; Offset_0x011DE0
		bne.w	Offset_0x01B616
		move.l	#Obj_Eosian_Sphere, (A1)			   ; Offset_0x01B75A
		bsr.w	Offset_0x01B636
		move.w	D2, D0
		addi.w	#$0010, D2
		jsr		(CalcSine).l					 ; Offset_0x001B20
		asr.w	#$01, D0
		asr.w	#$01, D1
		move.w	D0, Obj_Control_Var_04(A1)				 ; $0034
		move.w	#$0000, Obj_Control_Var_06(A1)			 ; $0036
		move.w	D1, Obj_Control_Var_08(A1)				 ; $0038
		move.l	A6, Obj_Control_Var_0A(A1)				 ; $003A
		adda.w	#$0010, A6
		dbra	D3, Offset_0x01B5D8
Offset_0x01B616:
		lea		(Pal_Sphere_Test).l, A1			 ; Offset_0x01B676
		lea		(Palette_Row_1_Offset).w, A2		 ; $FFFFED20
		move.w	#$000F, D0
Offset_0x01B624:
		move.w	(A1)+, (A2)+
		dbra	D0, Offset_0x01B624
		moveq	#$09, D0
		jsr		(LoadPLC).l				 ; Offset_0x0014D0
		bra.w	Obj_Sphere_Test_Main		   ; Offset_0x01B696
;-------------------------------------------------------------------------------
Offset_0x01B636:
		move.b	#$04, Obj_Flags(A1)				 ; $0004
		move.b	#$10, Obj_Width(A1)				 ; $0007
		move.b	#$10, Obj_Height(A1)					 ; $0006
		move.w	#$0200, Obj_Priority(A1)				 ; $0008
		move.l	#Sphere_Test_Mappings, Obj_Map(A1) ; Offset_0x01BB9A, $000C
		move.w	#$24E0, Obj_Art_VRAM(A1)				 ; $000A
		move.w	Obj_X(A0), Obj_X(A1)			  ; $0010, $0010
		move.w	Obj_X(A0), Obj_Control_Var_00(A1)		  ; $0010, $0030
		move.w	Obj_Y(A0), Obj_Y(A1)			  ; $0014, $0014
		move.w	Obj_Y(A0), Obj_Control_Var_02(A1)		  ; $0014, $0032
		rts
;-------------------------------------------------------------------------------
Pal_Sphere_Test:							   ; Offset_0x01B676
		binclude  "data\ss_test\sphrtest.pal"
;-------------------------------------------------------------------------------
Obj_Sphere_Test_Main:						   ; Offset_0x01B696
		move.b	(Control_Ports_Buffer_Data+$02).w, D1		 ; $FFFFF606
		btst	#$06, D1
		beq.s	Offset_0x01B6AC
		cmpi.w	#$0800, (Art_Scaling_Data_Buffer+$1A).w		 ; $FFFFF75A
		bcc.s	Offset_0x01B6AC
		addq.w	#$08, (Art_Scaling_Data_Buffer+$1A).w		 ; $FFFFF75A
Offset_0x01B6AC:
		btst	#$05, D1
		beq.s	Offset_0x01B6BE
		cmpi.w	#$0081, (Art_Scaling_Data_Buffer+$1A).w		 ; $FFFFF75A
		bcs.s	Offset_0x01B6BE
		subq.w	#$08, (Art_Scaling_Data_Buffer+$1A).w		 ; $FFFFF75A
Offset_0x01B6BE:
		tst.w	Obj_Control_Var_0E(A0)					 ; $003E
		bne.s	Offset_0x01B6E4
		btst	#$00, D1
		bne.s	Offset_0x01B6CE
		addq.w	#$03, (Art_Scaling_Index_0).w		 ; $FFFFF744
Offset_0x01B6CE:
		btst	#$03, D1
		bne.s	Offset_0x01B6D8
		addq.w	#$02, (Art_Scaling_Index_1).w		 ; $FFFFF746
Offset_0x01B6D8:
		btst	#$04, D1
		bne.s	Offset_0x01B6E2
		addq.w	#$01, (Art_Scaling_Index_2).w		 ; $FFFFF748
Offset_0x01B6E2:
		bra.s	Offset_0x01B702
Offset_0x01B6E4:
		btst	#$00, D1
		beq.s	Offset_0x01B6EE
		subq.w	#$01, (Art_Scaling_Index_0).w		 ; $FFFFF744
Offset_0x01B6EE:
		btst	#$03, D1
		beq.s	Offset_0x01B6F8
		addq.w	#$01, (Art_Scaling_Index_1).w		 ; $FFFFF746
Offset_0x01B6F8:
		btst	#$04, D1
		beq.s	Offset_0x01B702
		addq.w	#$01, (Art_Scaling_Index_2).w		 ; $FFFFF748
Offset_0x01B702:
		btst	#$07, (Control_Ports_Buffer_Data+$03).w		 ; $FFFFF607
		beq.s	Offset_0x01B722
		eori.w	#$FFFF, Obj_Control_Var_0E(A0)			 ; $003E
		move.w	#$0000, (Art_Scaling_Index_0).w		 ; $FFFFF744
		move.w	#$0000, (Art_Scaling_Index_1).w		 ; $FFFFF746
		move.w	#$0000, (Art_Scaling_Index_2).w		 ; $FFFFF748
Offset_0x01B722:
		btst	#$01, D1
		bne.s	Offset_0x01B72C
		addq.w	#$08, (Art_Scaling_Data_Buffer+$18).w		 ; $FFFFF758
Offset_0x01B72C:
		btst	#$02, D1
		bne.s	Offset_0x01B736
		subq.w	#$08, (Art_Scaling_Data_Buffer+$18).w		 ; $FFFFF758
Offset_0x01B736:
		move.w	(Art_Scaling_Index_2).w, D0			 ; $FFFFF748
		lea		(Art_Scaling_Result_2).w, A1		 ; $FFFFF752
		bsr.w	Get_Scalars					   ; Offset_0x01B982
		move.w	(Art_Scaling_Index_1).w, D0			 ; $FFFFF746
		lea		(Art_Scaling_Result_1).w, A1		 ; $FFFFF74E
		bsr.w	Get_Scalars					   ; Offset_0x01B982
		move.w	(Art_Scaling_Index_0).w, D0			 ; $FFFFF744
		lea		(Art_Scaling_Result_0).w, A1		 ; $FFFFF74A
		bsr.w	Get_Scalars					   ; Offset_0x01B982
;-------------------------------------------------------------------------------
Obj_Eosian_Sphere:							   ; Offset_0x01B75A
		move.w	Obj_X(A0), D0					 ; $0010
		andi.w	#$FF80, D0
		sub.w	(Camera_X_Left).w, D0				 ; $FFFFF7DA
		cmpi.w	#$0280, D0
		bhi.w	Offset_0x01B770
		bra.s	Offset_0x01B78E
Offset_0x01B770:
		move.w	Obj_Respaw_Ref(A0), D0					 ; $0048
		beq.s	Offset_0x01B77C
		move.w	D0, A2
		bclr	#$07, (A2)
Offset_0x01B77C:
		cmpa.w	(Art_Scaling_Address).w, A0			 ; $FFFFF75C
		bne.s	Offset_0x01B788
		move.w	#$0000, (Art_Scaling_Address).w		 ; $FFFFF75C
Offset_0x01B788:
		jmp		(DeleteObject).l				   ; Offset_0x011138
Offset_0x01B78E:
		move.l	Obj_Control_Var_0A(A0), A6				 ; $003A
		move.w	Obj_Control_Var_04(A0), D1				 ; $0034
		move.w	Obj_Control_Var_06(A0), D2				 ; $0036
		move.w	Obj_Control_Var_08(A0), D0				 ; $0038
		bsr.w	Offset_0x01B958
		bsr.w	Offset_0x01B92E
		add.w	(Art_Scaling_Data_Buffer+$1A).w, D0			 ; $FFFFF75A
		cmpi.w	#$0080, D0
		blt.s	Offset_0x01B7F4
		bsr.w	Offset_0x01B904
		add.w	(Art_Scaling_Data_Buffer+$18).w, D2			 ; $FFFFF758
		bsr.w	Offset_0x01B8F6
		add.w	Obj_Control_Var_00(A0), D1				 ; $0030
		move.w	D1, Obj_X(A0)					 ; $0010
		add.w	Obj_Control_Var_02(A0), D2				 ; $0032
		move.w	D2, Obj_Y(A0)					 ; $0014
		subi.w	#$0080, D0
		lsr.w	#$05, D0
		addi.w	#$0000, D0
		cmpi.w	#$0010, D0
		bcs.s	Offset_0x01B7E0
		move.w	#$000F, D0
Offset_0x01B7E0:
		move.b	D0, Obj_Map_Id(A0)				 ; $0022
		lsl.w	#$06, D0
		andi.w	#$0380, D0
		move.w	D0, Obj_Priority(A0)					 ; $0008
		jsr		(DisplaySprite).l				   ; Offset_0x011148
Offset_0x01B7F4:
		rts
;-------------------------------------------------------------------------------
Offset_0x01B7F6:
		dc.w	$FF90, $8000, $FF90, $8000, $0000, $8000, $0000, $0234
		dc.w	$FFB0, $8000, $FF90, $8000, $0000, $8000, $0000, $0234
		dc.w	$FFD0, $8000, $FF90, $8000, $0000, $8000, $0000, $0234
		dc.w	$FFF0, $8000, $FF90, $8000, $0000, $8000, $0000, $0234
		dc.w	$0010, $8000, $FF90, $8000, $0000, $8000, $0000, $0234
		dc.w	$0030, $8000, $FF90, $8000, $0000, $8000, $0000, $0234
		dc.w	$0050, $8000, $FF90, $8000, $0000, $8000, $0000, $0234
		dc.w	$0070, $8000, $FF90, $8000, $0000, $8000, $0000, $0234
		dc.w	$FF90, $8000, $0070, $8000, $0000, $8000, $0000, $0234
		dc.w	$FFB0, $8000, $0070, $8000, $0000, $8000, $0000, $0234
		dc.w	$FFD0, $8000, $0070, $8000, $0000, $8000, $0000, $0234
		dc.w	$FFF0, $8000, $0070, $8000, $0000, $8000, $0000, $0234
		dc.w	$0010, $8000, $0070, $8000, $0000, $8000, $0000, $0234
		dc.w	$0030, $8000, $0070, $8000, $0000, $8000, $0000, $0234
		dc.w	$0050, $8000, $0070, $8000, $0000, $8000, $0000, $0234
		dc.w	$0070, $8000, $0070, $8000, $0000, $8000, $0000, $0234
;-------------------------------------------------------------------------------
Offset_0x01B8F6:
		ext.l	D1
		lsl.l	#$08, D1
		divs.w	D0, D1
		ext.l	D2
		lsl.l	#$08, D2
		divs.w	D0, D2
		rts
;-------------------------------------------------------------------------------
Offset_0x01B904:
		swap	D0
		move.w	D1, D3
		move.w	D2, D4
		move.w	(Art_Scaling_Result_2).w, D0		 ; $FFFFF752
		muls.w	D0, D3
		muls.w	D0, D4
		move.w	(Art_Scaling_Result_2+$02).w, D0			 ; $FFFFF754
		muls.w	D0, D1
		muls.w	D0, D2
		sub.l	D4, D1
		add.l	D1, D1
		add.l	D1, D1
		swap	D1
		add.l	D3, D2
		add.l	D2, D2
		add.l	D2, D2
		swap	D2
		swap	D0
		rts
;-------------------------------------------------------------------------------
Offset_0x01B92E:
		swap	D2
		move.w	D0, D3
		move.w	D1, D4
		move.w	(Art_Scaling_Result_1).w, D2		 ; $FFFFF74E
		muls.w	D2, D3
		muls.w	D2, D4
		move.w	(Art_Scaling_Result_1+$02).w, D2			 ; $FFFFF750
		muls.w	D2, D0
		muls.w	D2, D1
		sub.l	D4, D0
		add.l	D0, D0
		add.l	D0, D0
		swap	D0
		add.l	D3, D1
		add.l	D1, D1
		add.l	D1, D1
		swap	D1
		swap	D2
		rts
;-------------------------------------------------------------------------------
Offset_0x01B958:
		swap	D1
		move.w	D0, D3
		move.w	D2, D4
		move.w	(Art_Scaling_Result_0).w, D1		 ; $FFFFF74A
		muls.w	D1, D3
		muls.w	D1, D4
		move.w	(Art_Scaling_Result_0+$02).w, D1			 ; $FFFFF74C
		muls.w	D1, D0
		muls.w	D1, D2
		sub.l	D4, D0
		add.l	D0, D0
		add.l	D0, D0
		swap	D0
		add.l	D3, D2
		add.l	D2, D2
		add.l	D2, D2
		swap	D2
		swap	D1
		rts
;-------------------------------------------------------------------------------
Get_Scalars:						   ; Offset_0x01B982
		add.w	D0, D0
		andi.w	#$01FE, D0
		move.w	Scalar_Table(PC, D0), (A1)+			   ; Offset_0x01B99A
		addi.w	#$0080, D0
		andi.w	#$01FE, D0
		move.w	Scalar_Table(PC, D0), (A1)+			   ; Offset_0x01B99A
		rts
;-------------------------------------------------------------------------------
Scalar_Table:						   ; Offset_0x01B99A
		dc.w	$0000, $0192, $0324, $04B5, $0646, $07D6, $0964, $0AF1
		dc.w	$0C7C, $0E06, $0F8D, $1112, $1294, $1413, $1590, $1709
		dc.w	$187E, $19EF, $1B5D, $1CC6, $1E2B, $1F8C, $20E7, $223D
		dc.w	$238E, $24DA, $2620, $2760, $289A, $29CE, $2AFB, $2C21
		dc.w	$2D41, $2E5A, $2F6C, $3076, $3179, $3274, $3368, $3453
		dc.w	$3537, $3612, $36E5, $37B0, $3871, $392B, $39DB, $3A82
		dc.w	$3B21, $3BB6, $3C42, $3CC5, $3D3F, $3DAF, $3E15, $3E72
		dc.w	$3EC5, $3F0F, $3F4F, $3F85, $3FB1, $3FD4, $3FEC, $3FFB
		dc.w	$4000, $3FFB, $3FEC, $3FD4, $3FB1, $3F85, $3F4F, $3F0F
		dc.w	$3EC5, $3E72, $3E15, $3DAF, $3D3F, $3CC5, $3C42, $3BB6
		dc.w	$3B21, $3A82, $39DB, $392B, $3871, $37B0, $36E5, $3612
		dc.w	$3537, $3453, $3368, $3274, $3179, $3076, $2F6C, $2E5A
		dc.w	$2D41, $2C21, $2AFB, $29CE, $289A, $2760, $2620, $24DA
		dc.w	$238E, $223D, $20E7, $1F8C, $1E2B, $1CC6, $1B5D, $19EF
		dc.w	$187E, $1709, $1590, $1413, $1294, $1112, $0F8D, $0E06
		dc.w	$0C7C, $0AF1, $0964, $07D6, $0646, $04B5, $0324, $0192
		dc.w	$0000, $FE6E, $FCDC, $FB4B, $F9BA, $F82A, $F69C, $F50F
		dc.w	$F384, $F1FA, $F073, $EEEE, $ED6C, $EBED, $EA70, $E8F7
		dc.w	$E782, $E611, $E4A3, $E33A, $E1D5, $E074, $DF19, $DDC3
		dc.w	$DC72, $DB26, $D9E0, $D8A0, $D766, $D632, $D505, $D3DF
		dc.w	$D2BF, $D1A6, $D094, $CF8A, $CE87, $CD8C, $CC98, $CBAD
		dc.w	$CAC9, $C9EE, $C91B, $C850, $C78F, $C6D5, $C625, $C57E
		dc.w	$C4DF, $C44A, $C3BE, $C33B, $C2C1, $C251, $C1EB, $C18E
		dc.w	$C13B, $C0F1, $C0B1, $C07B, $C04F, $C02C, $C014, $C005
		dc.w	$C000, $C005, $C014, $C02C, $C04F, $C07B, $C0B1, $C0F1
		dc.w	$C13B, $C18E, $C1EB, $C251, $C2C1, $C33B, $C3BE, $C44A
		dc.w	$C4DF, $C57E, $C625, $C6D5, $C78F, $C850, $C91B, $C9EE
		dc.w	$CAC9, $CBAD, $CC98, $CD8C, $CE87, $CF8A, $D094, $D1A6
		dc.w	$D2BF, $D3DF, $D505, $D632, $D766, $D8A0, $D9E0, $DB26
		dc.w	$DC72, $DDC3, $DF19, $E074, $E1D5, $E33A, $E4A3, $E611
		dc.w	$E782, $E8F7, $EA70, $EBED, $ED6C, $EEEE, $F073, $F1FA
		dc.w	$F384, $F50F, $F69C, $F82A, $F9BA, $FB4B, $FCDC, $FE6E
;-------------------------------------------------------------------------------
Sphere_Test_Mappings:						   ; Offset_0x01BB9A
		dc.w	Offset_0x01BBBA-Sphere_Test_Mappings
		dc.w	Offset_0x01BBC2-Sphere_Test_Mappings
		dc.w	Offset_0x01BBCA-Sphere_Test_Mappings
		dc.w	Offset_0x01BBD2-Sphere_Test_Mappings
		dc.w	Offset_0x01BBDA-Sphere_Test_Mappings
		dc.w	Offset_0x01BBE2-Sphere_Test_Mappings
		dc.w	Offset_0x01BBEA-Sphere_Test_Mappings
		dc.w	Offset_0x01BBF2-Sphere_Test_Mappings
		dc.w	Offset_0x01BBFA-Sphere_Test_Mappings
		dc.w	Offset_0x01BC02-Sphere_Test_Mappings
		dc.w	Offset_0x01BC0A-Sphere_Test_Mappings
		dc.w	Offset_0x01BC12-Sphere_Test_Mappings
		dc.w	Offset_0x01BC1A-Sphere_Test_Mappings
		dc.w	Offset_0x01BC22-Sphere_Test_Mappings
		dc.w	Offset_0x01BC2A-Sphere_Test_Mappings
		dc.w	Offset_0x01BC32-Sphere_Test_Mappings
Offset_0x01BBBA:
		dc.w	$0001
		dc.w	$F00F, $0000, $FFF0
Offset_0x01BBC2:
		dc.w	$0001
		dc.w	$F00F, $0010, $FFF0
Offset_0x01BBCA:
		dc.w	$0001
		dc.w	$F00F, $0020, $FFF0
Offset_0x01BBD2:
		dc.w	$0001
		dc.w	$F00F, $0030, $FFF0
Offset_0x01BBDA:
		dc.w	$0001
		dc.w	$F00F, $0040, $FFF0
Offset_0x01BBE2:
		dc.w	$0001
		dc.w	$F00F, $0050, $FFF0
Offset_0x01BBEA:
		dc.w	$0001
		dc.w	$F00F, $0060, $FFF0
Offset_0x01BBF2:
		dc.w	$0001
		dc.w	$F00F, $0070, $FFF0
Offset_0x01BBFA:
		dc.w	$0001
		dc.w	$F805, $0080, $FFF8
Offset_0x01BC02:
		dc.w	$0001
		dc.w	$F805, $0084, $FFF8
Offset_0x01BC0A:
		dc.w	$0001
		dc.w	$F805, $0088, $FFF8
Offset_0x01BC12:
		dc.w	$0001
		dc.w	$F805, $008C, $FFF8
Offset_0x01BC1A:
		dc.w	$0001
		dc.w	$F805, $0090, $FFF8
Offset_0x01BC22:
		dc.w	$0001
		dc.w	$F805, $0094, $FFF8
Offset_0x01BC2A:
		dc.w	$0001
		dc.w	$F805, $0098, $FFF8
Offset_0x01BC32:
		dc.w	$0001
		dc.w	$F805, $009C, $FFF8
;===============================================================================
; Objeto de teste de escalonamento das esferas
; <<<-
;===============================================================================