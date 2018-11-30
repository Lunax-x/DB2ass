;************************************************
;Script Global Settings
;************************************************

;#NoEnv						; Clear All Systemvariables 
#Persistent 				;Keeps a script permanently running until ExitApp execute

#SingleInstance force		;The word FORCE skips the dialog box and replaces the old instance automatically, which is similar in effect to the Reload command.

;************************************************
;Performance PARAMETERS - if you need speed 
;************************************************
;SetBatchLines, -1   		
;Process, Priority, , L  ;A  - Max Speed
;************************************************
; Input PARAMETERS
;************************************************
SendMode Input
SetKeyDelay, 5, 1   ; for speed -1, -1, 

SetMouseDelay, 5		;0 recommend -1 for max speed 
SetDefaultMouseSpeed, 0		;0-100 
;************************************************
;History Protocols 
;Switch setting for more Speed 
;************************************************
;#KeyHistory 1		;  0 - No Keyhistory 
;ListLines  On  		; Off  - for more speed 
;************************************************
;Window detection
;************************************************
;SetTitleMatchMode, 2
SetTitleMatchMode Fast	;slow detect hidden windows

;SetWinDelay, 0  		;0 - for more speed   
;i double the standard settings to be on the save side 


pic_loc = %A_ScriptDir%\res ;search pictures location var
ini_loc = %userprofile%\Documents\.AHKsetting\exec.ini ;ini file location var
window = IBM CIRATS 4.2: Patch advisories


Makeini()
{
IfNotExist, %ini_loc%
	{
	FileCreateDir, %userprofile%\Documents\.AHKsetting
	FileSetAttrib, +H, %userprofile%\Documents\.AHKsetting
	FileAppend, , %ini_loc%
	}
}
Makeini()

Moveres()
{
global pic_loc
IfNotExist, %pic_loc%
FileMoveDir, %userprofile%\Pictures\ahk, %A_ScriptDir%\res, R
IfNotExist, %pic_loc%
msgbox Resources not found, batch close will not work.
}
Moveres()

;Hotkey, IfWinActive, IBM CIRATS 4.2: Patch advisories
;Hotkey, Numpad1, text1
;Hotkey, Numpad2, text2
;Hotkey, Numpad3, text3
;Hotkey, Numpad4, text4
;Hotkey, Numpad5, text5
;Hotkey, Numpad6, text6
;Hotkey, Numpad0, ctrl3
 
Iniread, b_txt1, %ini_loc%, Text, b_text1
Iniread, b_txt2, %ini_loc%, Text, b_text2
Iniread, b_txt3, %ini_loc%, Text, b_text3
Iniread, b_txt4, %ini_loc%, Text, b_text4
Iniread, b_txt5, %ini_loc%, Text, b_text5
Iniread, b_txt6, %ini_loc%, Text, b_text6
Gui, def:+AlwaysOnTop
Gui, def:Font, bold
Gui, def:Add, Text,, DB2 assist
Gui, def:Font, normal
Gui, def:Add, Text, x120 y278, 1.7b
Gui, def:Add, Text, x10 y20, Controls
Gui, def:Add, Text, x82 y12, Autohide?
Gui, def:Add, Checkbox, x135 y12 vhid

Gui, def:Add, Button, gctrl2 x10 y40, Submit
Gui, def:Add, Button, gctrl3 x55 y40, Close
Gui, def:Add, Button, gctrl1 x10 y70, N/A
Gui, def:Add, Button, gctrl4 x55 y70, Batch close
Gui, def:Add, Text,x10 y100, Automated text
Gui, def:Add, Button, vtext1 gtext1 x10 y120 w60, %b_txt1%
Gui, def:Add, Button, vtext2 gtext2 x10 y150 w60, %b_txt2%
Gui, def:Add, Button, vtext3 gtext3 x10 y180 w60, %b_txt3%
Gui, def:Add, Button, vtext4 gtext4 x10 y210 w60, %b_txt4%
Gui, def:Add, Button, vtext5 gtext5 x10 y240 w60, %b_txt5%
Gui, def:Add, Button, vtext6 gtext6 x10 y270 w60, %b_txt6%

;setting buttons
Gui, def:Font, s5 cBlue, Arial
Gui, def:Add, Button, gset1 x77 y120 cPink, set
Gui, def:Add, Button, gset2 x77 y150 cPink, set
Gui, def:Add, Button, gset3 x77 y180 cPink, set
Gui, def:Add, Button, gset4 x77 y210 cPink, set
Gui, def:Add, Button, gset5 x77 y240 cPink, set
Gui, def:Add, Button, gset6 x77 y270 cPink, set
Gui, def:Show, W150

;set timers for checks
SetTimer , CalendarReloc, 1000, -1
SetTimer , ClickCont, 1000, -1
SetTimer , RSAcpy, 500, -1
SetTimer , Autohide, 1000, -1

return


CalendarReloc:
IfWinExist, Calendar - Mozilla,,, 
	{
	WinGetPos, Xpos, Ypos,,, IBM CIRATS 4.2: Patch advisories,,,
	Xpos := Xpos + 500
	Ypos := Ypos + 400
	WinMove, Calendar - Mozilla, , %Xpos%, %Ypos%
	}
return

ClickCont:
ifwinexist, IBM CIRATS 4.2: Patch advisories
	{
	ImageSearch, FoundX, FoundY, 0, 0, 3840, 2160, %pic_loc%\continue.png
	ControlClick, x%FoundX% y%FoundY%, ahk_class MozillaWindowClass,, Left, 1, NA 
		if ErrorLevel = 1 
		{
		ImageSearch, FoundX, FoundY, 0, 0, 3840, 2160, %pic_loc%\continue2.png
		}
		FoundY := FoundY + 5
		FoundX := FoundX + 10
		ControlClick, x%FoundX% y%FoundY%, ahk_class MozillaWindowClass,, Left, 1, NA 
	}
return

RSAcpy:
ifwinactive, 000403039522 - RSA SecurID Token
	{
	ControlClick, x114 y105, ahk_class QWidget,, Left, 1, NA
	Sleep 50
	ControlClick, x101 y72, ahk_class QWidget,, Left, 1, NA 
	Sleep 50
	Controlsend,, 953208{enter}, 000403039522 - RSA SecurID Token
	Sleep 100
	ControlClick, x188 y104, ahk_class QWidget,, Left, 1, NA 
	WinMinimize, 000403039522 - RSA SecurID Token
	}
return


Autohide:
ifwinactive, %A_ScriptName%
goto skip
gui, def:submit, nohide
	if (hid = 1)
	{
		WinGet, win_status, MinMax, %A_ScriptName%
		If (WinActive("IBM CIRATS 4.2: Patch advisories") && (win_status = -1))
		{
		winrestore, %A_ScriptName%
		WinActivate, IBM CIRATS 4.2: Patch advisories
		}
		If (!WinActive("IBM CIRATS 4.2: Patch advisories") && (win_status = 0))
		{
		WinMinimize, %A_ScriptName%
		}	
	}
	skip:
Sleep 500
return

Minput:
	WinSet, AlwaysOnTop, Toggle, %A_ScriptName%
	Iniread, reas, %ini_loc%, Text, reason
	StringReplace, reas, reas, ¥,`n, All, ;recall linebreaks
	Gui,Minput: New,, Edit text
	Gui,Minput:Add, text,,%reas%
	Gui,Minput:Add,Edit,r20 w300 vw_reas
	Gui,Minput:Add,Button,xs+200 gMOK,OK
	Gui,Minput:Add,Button,x+10 gNC,No change
	Gui,Minput:Add,Button,x+10 gMCancel,Cancel
	Gui,Minput:Show
	WinWaitClose,Edit text
return

MCancel:
		Gui, Minput:destroy
		WinSet, AlwaysOnTop, Toggle, %A_ScriptName%
		Cancel = 1
return

NC:
	Gui, Minput:destroy
	WinSet, AlwaysOnTop, Toggle, %A_ScriptName%
return


MOK:
		Gui, submit
		StringReplace, w_reas, w_reas, `n,¥, All, ;linebreak fix
		StringReplace, w_reas, w_reas, %A_Tab%,%A_Space%, All, ;tabbed string fix
		Iniwrite, %w_reas%, %ini_loc%, Text, reason
		WinSet, AlwaysOnTop, Toggle, %A_ScriptName%
return

;set buttons functionality

set1:
		WinSet, AlwaysOnTop, Toggle, %A_ScriptName%
		Iniread, b_txt1, %ini_loc%, Text, b_text1
		Inputbox, w_btxt1, Enter button label, Current: %b_txt1%,,200,150
		if ErrorLevel
		{
		goto skip1
		}
		else
		Iniwrite, %w_btxt1%, %ini_loc%, Text,  b_text1
		Iniread, b_txt1, %ini_loc%, Text, b_text1
		GuiControl,, text1, %b_txt1%
		skip1:
		Iniread, txt1, %ini_loc%, Text, text1
		StringReplace, txt1, txt1, ¥,`n, All, ;recall linebreaks
	Gui, MyGui: New,, Edit text
	Gui,MyGui:Add, text,,%txt1%
	Gui,MyGui:Add,Edit,r5 w300 vw_txt1
	Gui,MyGui:Add,Button,xs+200 gOK1,OK
	Gui,MyGui:Add,Button,x+10 gCancel1,Cancel
	Gui,MyGui:Show
	return
	
		Cancel1:
		Gui, MyGui:destroy
		WinSet, AlwaysOnTop, Toggle, %A_ScriptName%
		return
		
		OK1:
		Gui, submit
		StringReplace, w_txt1, w_txt1, `n,¥, All, ;linebreak fix
		StringReplace, w_txt1, w_txt1, %A_Tab%,%A_Space%, All, ;tabbed string fix
		Iniwrite, %w_txt1%, %ini_loc%, Text, text1
		WinSet, AlwaysOnTop, Toggle, %A_ScriptName%
return

set2:
		WinSet, AlwaysOnTop, Toggle, %A_ScriptName%
		Iniread, b_txt2, %ini_loc%, Text, b_text2
		Inputbox, w_btxt2, Enter button label, Current: %b_txt2%,,200,150
		if ErrorLevel
		{
		goto skip2
		}
		else
		Iniwrite, %w_btxt2%, %ini_loc%, Text,  b_text2
		Iniread, b_txt2, %ini_loc%, Text, b_text2
		GuiControl,, text2, %b_txt2%
		skip2:
		Iniread, txt2, %ini_loc%, Text, text2
		StringReplace, txt2, txt2, ¥,`n, All,
	Gui, MyGui: New,, Edit text
	Gui,MyGui:Add, text,,%txt2%
	Gui,MyGui:Add,Edit,r5 w300 vw_txt2
	Gui,MyGui:Add,Button,xs+200 gOK2,OK
	Gui,MyGui:Add,Button,x+10 gCancel2,Cancel
	Gui,MyGui:Show
	return
	
		Cancel2:
		Gui, MyGui:destroy
		WinSet, AlwaysOnTop, Toggle, %A_ScriptName%
		return
		
		OK2:
		Gui, submit
		StringReplace, w_txt2, w_txt2, `n,¥, All,
		StringReplace, w_txt2, w_txt2, %A_Tab%,%A_Space%, All,
		Iniwrite, %w_txt2%, %ini_loc%, Text, text2
		WinSet, AlwaysOnTop, Toggle, %A_ScriptName%
return

set3:
		WinSet, AlwaysOnTop, Toggle, %A_ScriptName%
		Iniread, b_txt3, %ini_loc%, Text, b_text3
		Inputbox, w_btxt3, Enter button label, Current: %b_txt3%,,200,150
		if ErrorLevel
		{
		goto skip3
		}
		else
		Iniwrite, %w_btxt3%, %ini_loc%, Text,  b_text3
		Iniread, b_txt3, %ini_loc%, Text, b_text3
		GuiControl,, text3, %b_txt3%
		skip3:
		Iniread, txt3, %ini_loc%, Text, text3
		StringReplace, txt3, txt3, ¥,`n, All,
	Gui, MyGui: New,, Edit text
	Gui,MyGui:Add, text,,%txt3%
	Gui,MyGui:Add,Edit,r5 w300 vw_txt3
	Gui,MyGui:Add,Button,xs+200 gOK3,OK
	Gui,MyGui:Add,Button,x+10 gCancel3,Cancel
	Gui,MyGui:Show
	return
	
		Cancel3:
		Gui, MyGui:destroy
		WinSet, AlwaysOnTop, Toggle, %A_ScriptName%
		return
		
		OK3:
		Gui, submit
		StringReplace, w_txt3, w_txt3, `n,¥, All,
		StringReplace, w_txt3, w_txt3, %A_Tab%,%A_Space%, All,
		Iniwrite, %w_txt3%, %ini_loc%, Text, text3
		WinSet, AlwaysOnTop, Toggle, %A_ScriptName%
return

set4:
		WinSet, AlwaysOnTop, Toggle, %A_ScriptName%
		Iniread, b_txt4, %ini_loc%, Text, b_text4
		Inputbox, w_btxt4, Enter button label, Current: %b_txt4%,,200,150
		if ErrorLevel
		{
		goto skip4
		}
		else
		Iniwrite, %w_btxt4%, %ini_loc%, Text,  b_text4
		Iniread, b_txt4, %ini_loc%, Text, b_text4
		GuiControl,, text4, %b_txt4%
		skip4:
		Iniread, txt4, %ini_loc%, Text, text4
		StringReplace, txt4, txt4, ¥,`n, All,
	Gui, MyGui: New,, Edit text
	Gui,MyGui:Add, text,,%txt4%
	Gui,MyGui:Add,Edit,r5 w300 vw_txt4
	Gui,MyGui:Add,Button,xs+200 gOK4,OK
	Gui,MyGui:Add,Button,x+10 gCancel4,Cancel
	Gui,MyGui:Show
	return
	
		Cancel4:
		Gui, MyGui:destroy
		WinSet, AlwaysOnTop, Toggle, %A_ScriptName%
		return
		
		OK4:
		Gui, submit
		StringReplace, w_txt4, w_txt4, `n,¥, All,
		StringReplace, w_txt4, w_txt4, %A_Tab%,%A_Space%, All,
		Iniwrite, %w_txt4%, %ini_loc%, Text, text4
		WinSet, AlwaysOnTop, Toggle, %A_ScriptName%
return

set5:
		WinSet, AlwaysOnTop, Toggle, %A_ScriptName%
		Iniread, b_txt5, %ini_loc%, Text, b_text5
		Inputbox, w_btxt5, Enter button label, Current: %b_txt5%,,200,150
		if ErrorLevel
		{
		goto skip5
		}
		else
		Iniwrite, %w_btxt5%, %ini_loc%, Text,  b_text5
		Iniread, b_txt5, %ini_loc%, Text, b_text5
		GuiControl,, text5, %b_txt5%
		skip5:
		Iniread, txt5, %ini_loc%, Text, text5
		StringReplace, txt5, txt5, ¥,`n, All,
	Gui, MyGui: New,, Edit text
	Gui,MyGui:Add, text,,%txt5%
	Gui,MyGui:Add,Edit,r5 w300 vw_txt5
	Gui,MyGui:Add,Button,xs+200 gOK5,OK
	Gui,MyGui:Add,Button,x+10 gCancel5,Cancel
	Gui,MyGui:Show
	return
	
		Cancel5:
		Gui, MyGui:destroy
		WinSet, AlwaysOnTop, Toggle, %A_ScriptName%
		return
		
		OK5:
		Gui, submit
		StringReplace, w_txt5, w_txt5, `n,¥, All,
		StringReplace, w_txt5, w_txt5, %A_Tab%,%A_Space%, All,
		Iniwrite, %w_txt5%, %ini_loc%, Text, text5
		WinSet, AlwaysOnTop, Toggle, %A_ScriptName%
return

set6:
		WinSet, AlwaysOnTop, Toggle, %A_ScriptName%
		Iniread, b_txt6, %ini_loc%, Text, b_text6
		Inputbox, w_btxt6, Enter button label, Current: %b_txt6%,,200,150
		if ErrorLevel
		{
		goto skip6
		}
		else
		Iniwrite, %w_btxt6%, %ini_loc%, Text,  b_text6
		Iniread, b_txt6, %ini_loc%, Text, b_text6
		GuiControl,, text6, %b_txt6%
		skip6:
		Iniread, txt6, %ini_loc%, Text, text6
		StringReplace, txt6, txt6, ¥,`n, All,
	Gui, MyGui: New,, Edit text
	Gui,MyGui:Add, text,,%txt6%
	Gui,MyGui:Add,Edit,r5 w300 vw_txt6
	Gui,MyGui:Add,Button,xs+200 gOK6,OK
	Gui,MyGui:Add,Button,x+10 gCancel6,Cancel
	Gui,MyGui:Show
	return
	
		Cancel6:
		Gui, MyGui:destroy
		WinSet, AlwaysOnTop, Toggle, %A_ScriptName%
		return
		
		OK6:
		Gui, submit
		StringReplace, w_txt6, w_txt6, `n,¥, All,
		StringReplace, w_txt6, w_txt6, %A_Tab%,%A_Space%, All,
		Iniwrite, %w_txt6%, %ini_loc%, Text, text6
		WinSet, AlwaysOnTop, Toggle, %A_ScriptName%
return


ctrl1:
	WinActivate, IBM CIRATS 4.2
	ImageSearch, FoundX, FoundY, 0, 0, 3840, 2160, %pic_loc%\na.png

		if ErrorLevel = 1 
		Sleep 100
		loop 3
		{
		WinActivate, IBM CIRATS 4.2: Patch advisories
		Sendinput {Down}{Down}{Down}
		sleep 500
		ImageSearch, FoundX, FoundY, 0, 0, 2000, 1100, *10 %pic_loc%\na.png
		if ErrorLevel = 0
		break
		if ErrorLevel = 1
		ImageSearch, FoundX, FoundY, 0, 0, 2000, 1100, *10 %pic_loc%\na2.png
		if ErrorLevel = 0
		break
		}
		if ErrorLevel = 1
		{
		SplashImage,, b fs12 ctRed, ERROR: NOT FOUND
		Sleep 3000
		SplashImage, Off
		return
		}
		else
	FoundY := FoundY + 10
	FoundX := FoundX + 10
	ControlClick, x%FoundX% y%FoundY%, ahk_class MozillaWindowClass,, Left, 1, NA 
return

ctrl2:
	WinActivate, IBM CIRATS 4.2
	ImageSearch, FoundX, FoundY, 0, 0, 3840, 2160, %pic_loc%\submit.png 
	FoundY := FoundY + 5
	FoundX := FoundX + 5
	ControlClick, x%FoundX% y%FoundY%, ahk_class MozillaWindowClass,, Left, 1, NA
return



ctrl3:
	WinActivate, IBM CIRATS 4.2
	ImageSearch, FoundX, FoundY, 0, 0, 3840, 2160, %pic_loc%\close.png
	FoundY := FoundY + 6
	FoundX := FoundX + 6
	ControlClick, x%FoundX% y%FoundY%, ahk_class MozillaWindowClass,, Left, 1, NA
return



ctrl4:
	Runwait C:\Windows\Notepad.exe "%userprofile%\Documents\.AHKsetting\APAR list.txt"	;settings
	
	GoSub Minput																		;multiline entry
	Sleep 150
	if (Cancel = 1 or ErrorLevel = 1)
		return

	;line count
	WinGetPos, Xpos, Ypos,,, IBM CIRATS 4.2: Patch advisories,,,
	Xpos := Xpos + 7
	Ypos := Ypos + 7
	XposP := Xpos
	YposP := Ypos + 37
	FileRead File, %userprofile%\Documents\.AHKsetting\APAR list.txt
	StringReplace File, File, `n, `n, All UseErrorLevel
	line_count := ErrorLevel + 1
	timeleft := ((line_count) * 36)/60
	timeleft := round(timeleft)
	WinActivate, IBM CIRATS 4.2
	ImageSearch, FoundX, FoundY, 0, 0, 3840, 2160, %pic_loc%\no.png ;excluding closed records checks
		if ErrorLevel = 1 
		{
		msgbox You cannot search including closed records. Please click no and try again.
		return
		}
	progr = 0
	Loop, read, %userprofile%\Documents\.AHKsetting\APAR list.txt
	{
		progr := progr + 1
		progrbar := 100*(progr/line_count)
		
	back:
	WinActivate, IBM CIRATS 4.2
	SplashImage,, x%xpos% y%ypos% b fs10, Processing %progr%/%line_count% #%A_LoopReadLine% `n Time remaining %timeleft% min.
	Progress, b ZH10 w300 CT000000 x%xposP% y%YposP%
	Progress, %progrbar%,, working...
	ImageSearch, FoundX, FoundY, 0, 0, 3840, 2160, %pic_loc%\no.png 
		if ErrorLevel = 1 
		loop
		{
		Sleep 1500
		ImageSearch, FoundX, FoundY, 0, 0, 3840, 2160, %pic_loc%\no.png
		if ErrorLevel = 0
		break
		}
	FoundY := FoundY + 30
	FoundX := FoundX + 60
	ControlClick, x%FoundX% y%FoundY%, ahk_class MozillaWindowClass,, Left, 2, NA 
	Sendinput, %A_LoopReadLine%{enter}
	Sleep, 1500
	ImageSearch, FoundX, FoundY, 0, 0, 3840, 2160, %pic_loc%\recnbr.png
	if ErrorLevel = 1 
	loop 5
	{
		Sleep 1500
		ImageSearch, FoundX, FoundY, 0, 0, 3840, 2160, %pic_loc%\recnbr.png
		if ErrorLevel = 0
		{
		break
		}
		if ErrorLevel = 1
		{
		ImageSearch, FoundX, FoundY, 0, 0, 3840, 2160, %pic_loc%\notfound.png
		}
		if ErrorLevel = 0
		{
		SplashImage,, x%xpos% y%ypos% b fs12, Seems closed, skipping...
		Sleep 1500
		goto end
		}
	}
		
		if ErrorLevel = 1
		{
		SplashImage,, x%xpos% y%ypos% b fs12, Error, retrying..
		Sleep 3840
		goto back
		}
	FoundY := FoundY + 55
	FoundX := FoundX + 20
	ControlClick, x%FoundX% y%FoundY%, ahk_class MozillaWindowClass,, Left, 1, NA
	Sleep 3840
	
	gosub ctrl1		;click not applicable
	if ErrorLevel = 1 
	{
	SplashImage,, x%xpos% y%ypos% b ctRed fs12, Skip to close
	Sleep 3000
	goto close
	}
	Sleep, 1500
	ImageSearch, FoundX, FoundY, 0, 0, 3840, 2160, %pic_loc%\char.png
	if ErrorLevel = 1 
		loop 5
		{
		Sleep 1500
		ImageSearch, FoundX, FoundY, 0, 0, 3840, 2160, %pic_loc%\char.png
		if ErrorLevel = 0
		break
		}
	else
	Sleep 100
	FoundY := FoundY - 50
	FoundX := FoundX + 50
	ControlClick, x%FoundX% y%FoundY%, ahk_class MozillaWindowClass,, Left, 1, NA
	Iniread, reas, %ini_loc%, Text, reason
	StringReplace, reas, reas, ¥,`n, All, ;recall linebreaks
	SendInput, %reas%
	Sleep 150
	gosub ctrl2		;click submit
		if ErrorLevel = 1 
		{
		SplashImage,, x%xpos% y%ypos% b ctRed fs12, Error, terminating..
		Sleep, 5000
		error=1
		goto final
		return
		}
		else
	Sleep 500
	
	gosub ClickCont		;click continue
	
		if ErrorLevel = 1
		loop 3
		{
		Sleep 3000
		gosub ClickCont
		if ErrorLevel = 0
		break
		}
		if ErrorLevel = 1
		{
		SplashImage,, x%xpos% y%ypos% b ctRed fs12, Error, terminating..
		Sleep, 5000
		error=1
		goto final
		return
		}
	
	
	Sleep 1000
	close:
	gosub ctrl3		;click close
	if ErrorLevel = 1 
	loop 3
		{
		Sleep 3300
		gosub ctrl3
		if ErrorLevel = 0
		break
		}
		if ErrorLevel = 1 
		{
		SplashImage,, x%xpos% y%ypos% b ctRed fs12, Error, terminating..
		Sleep, 5000
		error=1
		goto final
		return
		}
		else
	FoundY := FoundY + 6
	FoundX := FoundX + 6
	ControlClick, x%FoundX% y%FoundY%, ahk_class MozillaWindowClass,, Left, 1, NA
	Sleep 2500

	end:
	MouseMove, 1, 0 , , R
	ImageSearch, FoundX, FoundY, 0, 0, 3840, 2160, *64 %pic_loc%\padv.png
	SplashImage,, x%xpos% y%ypos% b fs10 ZH30, Returning to search
	if ErrorLevel = 1
		{
		ControlSend,, {pgup}, IBM CIRATS 4.2: Patch advisories
		Sleep, 500
		goto end
		}
	if ErrorLevel = 0
	{
	FoundY := FoundY + 8
	FoundX := FoundX + 6
	ControlClick, x%FoundX% y%FoundY%, ahk_class MozillaWindowClass,, Left, 1, NA
	}
	timeleft := ((line_count - A_index) * 36)/60
	Iniread, closed_r, %ini_loc%, Stats, closed_count, 0
	closed := closed_r + 1
	Iniwrite, %closed%, %ini_loc%, Stats, closed_count
	Sleep 8000
	}
	SplashImage, Off
	Progress, Off
	final:
	if error = 1
	msgbox Processing failed at record #%A_LoopReadLine%
	else
	msgbox Processing complete
return
		
text1:

	Iniread, txt1, %ini_loc%, Text, text1
	StringReplace, txt1, txt1, ¥,`n, All,
	WinActivate, IBM CIRATS 4.2: Patch advisories
	Sendinput, %txt1%
	Sleep, 150
	
gosub, ctrl2

return

text2:

	Iniread, txt2, %ini_loc%, Text, text2
	StringReplace, txt2, txt2, ¥,`n, All,
	WinActivate, IBM CIRATS 4.2: Patch advisories
	Sendinput, %txt2%
	Sleep, 150
	
gosub, ctrl2

return

text3:

	Iniread, txt3, %ini_loc%, Text, text3
	StringReplace, txt3, txt3, ¥,`n, All,
	WinActivate, IBM CIRATS 4.2: Patch advisories
	Sendinput, %txt3%
	Sleep, 150
	
gosub, ctrl2

return

text4:

	Iniread, txt4, %ini_loc%, Text, text4
	StringReplace, txt4, txt4, ¥,`n, All,
	WinActivate, IBM CIRATS 4.2: Patch advisories
	Sendinput, %txt4%
	Sleep, 150
	
gosub, ctrl2

return

text5:

	Iniread, txt5, %ini_loc%, Text, text5
	StringReplace, txt5, txt5, ¥,`n, All,
	WinActivate, IBM CIRATS 4.2: Patch advisories
	Sendinput, %txt5%
	Sleep, 150
	
gosub, ctrl2

return

text6:

	Iniread, txt6, %ini_loc%, Text, text6
	StringReplace, txt6, txt6, ¥,`n, All,
	WinActivate, IBM CIRATS 4.2: Patch advisories
	Sendinput, %txt6%
	Sleep, 150
	
gosub, ctrl2

return



defGuiClose:
ExitApp

MinputGuiClose:
Gui, Minput:destroy
Cancel = 1
WinSet, AlwaysOnTop, Toggle, %A_ScriptName%
return

F12::reload  ; to reload the script after making changes (don't forget to save)