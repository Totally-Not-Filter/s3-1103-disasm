	ir80 mdmsng82.s
	ir80 chktb1
	lnk  CHKTB1,mdmSNG82,CHKSNG82/N,/P:1600,/H,/S
	ir80 CHKSE1.s
	lnk  CHKSE1,CHKSE1/N,/P:1000,/H,/S

