:
:
:
ECHO OFF
IF "%1"=="" GOTO USAGE
IF "%1"=="ALL" GOTO all
IF "%1"=="all" GOTO all
IF "%1"=="A" GOTO ASM
IF "%1"=="a" GOTO ASM
IF "%1"=="Z" GOTO ZICE
IF "%1"=="z" GOTO ZICE
IF "%1"=="B" GOTO BANK
IF "%1"=="b" GOTO BANK
IF "%1"=="HHH" GOTO HHH
IF "%1"=="hhh" GOTO HHH
GOTO USAGE
:ASM
	COMMAND /C MAKE -f m513.MKF song

:ZICE
REM	ZICE m5Z13.BAT -C A:\SYS\Z80\ZICEZ80
	ECHO --------------------------　　終了　　--------------------------
	GOTO END

:all
	touch -c 010200000089 m5sng*.rel
:BANK
	COMMAND /C MAKE -f m513.MKF bank
	goto ZICE
:HHH
	cf -D m5CNT13.HEX m5CNT13.HHH
	cf -D m5BNK13.HEX m5BNK13.HHH
	cf -D m5SE13.HEX m5SE13.HHH
	COPY *.HHH B:
	ECHO --------------------------　　終了　　--------------------------
	GOTO END
:USAGE
	echo 	USAGE: %0 [COMMAND]
	echo 	Z: ZICE
	echo	A: ASEMBLE & LINK 1 song  -- zice
	echo	ALL: asemmble & link all songs --- zice
	ech	B: bank data making ( .hhh ) & copy b: drive
:END

