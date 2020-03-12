#IfWinActive Path of Exile
#SingleInstance force
#NoEnv  
#Warn  
#Persistent 
#MaxThreadsPerHotkey 2

SetTitleMatchMode 3
SendMode Input  
CoordMode, Mouse, Client
SetWorkingDir %A_ScriptDir%  
Thread, interrupt, 0

I_Icon = PoeC.ico
IfExist, %I_Icon%
  Menu, Tray, Icon, %I_Icon%

; -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
; Global variables
; Default setup for 1920x1080, having wisdom & portal scrolls respectively on the last 2 positions of the first row.  
; DON'T CHANGE them here. If you need to make changes, do change the INI file!
; -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

;General
global CtrlLoopCount=50
global ShiftLoopCount=50
global InventoryColumnsToMove=10
global InventoryRowsToMove=5
global KeyToKeepPress="Q"
global KeyToPressOnTimmer="R"
global KeyToPressOnTimmerDelay=5000
global ForceLogoutOrExitOnQuit=0
; Dont change the speed & the tick unless you know what you are doing
global Speed=1
global Tick=250

;Coordinates
global CellWith=53
global InventoryX=1297
global InventoryY=616
global StashX=41
global StashY=188
global PortalScrollX=1859
global PortalScrollY=616
global WisdomScrollX=1820
global WisdomScrollY=616
global TradeButtonX=628
global TradeButtonY=735	
global TradedItemX=646
global TradedItemY=565
global GuiX=-5
global GuiY=1005

;ItemSwap
global CurrentGemX=1483
global CurrentGemY=372
global AlternateGemX=1379 
global AlternateGemY=171
global AlternateGemOnSecondarySlot=1

;AutoPot Setup
global ChatColor=0x0E6DBF
global ChatX1=10
global ChatY1=875
global ChatX2=24
global ChatY2=890

global HPColor=0x080C18
global HPX1=908
global HPY1=325
global HPX2=1012
global HPY2=329

global HPQuitTreshold=25
global HPLowTreshold=40
global HPAvgTreshold=65
global HPHighTreshold=90
global MainAttackKey="Q"
global SecondaryAttackKey="W"

;The default flask setup/example is based on my setup, but you can use any flask and any trigger combinations by changing the setup in the INI file
global TriggerHPLow=11111
global TriggerHPAvg=10011
global TriggerHPHigh=10001
global TriggerMainAttack=01100
global TriggerSecondaryAttack=01110

; Cooldowns for each of the 5 Flasks
global CoolDownFlask1:=7000
global CoolDownFlask2:=4800
global CoolDownFlask3:=3500
global CoolDownFlask4:=5000
global CoolDownFlask5:=3500

; Trade Spam
global TradeDelay:=30000
global TradeChannelDelay:=2500
global TradeChannelStart:=1
global TradeChannelStop:=20
global TradeMessage:="WTB Ex 1:85c, Alch 4:1c, Jew 13:1c, Alt 15:1c, Chrom 15:1c"

; -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
; Extra vars - Not in INI
; -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
global HPX=HPX2-HPX1
global Trigger=00000
global AutoQuit=0 
global AutoPot=0 
global TradeSpam=0 
global CurrentHP=100
global KeyOn:=False
global KeyOnTimmer:=False
global Flask=1
global OnCoolDown:=[0,0,0,0,0]
global debug=0
; -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

If FileExist("PoeCompanion.ini"){ 
	IniRead, CtrlLoopCount, PoeCompanion.ini, General, CtrlLoopCount
	IniRead, ShiftLoopCount, PoeCompanion.ini, General, ShiftLoopCount
	IniRead, InventoryColumnsToMove, PoeCompanion.ini, General, InventoryColumnsToMove
	IniRead, InventoryRowsToMove, PoeCompanion.ini, General, InventoryRowsToMove	
	IniRead, KeyToKeepPress, PoeCompanion.ini, General, KeyToKeepPress
	IniRead, KeyToPressOnTimmer, PoeCompanion.ini, General, KeyToPressOnTimmer
	IniRead, KeyToPressOnTimmerDelay, PoeCompanion.ini, General, KeyToPressOnTimmerDelay
	IniRead, ForceLogoutOrExitOnQuit, PoeCompanion.ini, General, ForceLogoutOrExitOnQuit
	IniRead, Speed, PoeCompanion.ini, General, Speed
	IniRead, Tick, PoeCompanion.ini, General, Tick
	
	IniRead, CellWith, PoeCompanion.ini, Coordinates, CellWith
	IniRead, InventoryX, PoeCompanion.ini, Coordinates, InventoryX
	IniRead, InventoryY, PoeCompanion.ini, Coordinates, InventoryY
	IniRead, StashX, PoeCompanion.ini, Coordinates, StashX
	IniRead, StashY, PoeCompanion.ini, Coordinates, StashY
	IniRead, PortalScrollX, PoeCompanion.ini, Coordinates, PortalScrollX
	IniRead, PortalScrollY, PoeCompanion.ini, Coordinates, PortalScrollY
	IniRead, WisdomScrollX, PoeCompanion.ini, Coordinates, WisdomScrollX
	IniRead, WisdomScrollY, PoeCompanion.ini, Coordinates, WisdomScrollY
	IniRead, TradeButtonX, PoeCompanion.ini, Coordinates, TradeButtonX
	IniRead, TradeButtonY, PoeCompanion.ini, Coordinates, TradeButtonY
	IniRead, TradedItemX, PoeCompanion.ini, Coordinates, TradedItemX
	IniRead, TradedItemY, PoeCompanion.ini, Coordinates, TradedItemY
	IniRead, GuiX, PoeCompanion.ini, Coordinates, GuiX
	IniRead, GuiY, PoeCompanion.ini, Coordinates, GuiY
		
	IniRead, CurrentGemX, PoeCompanion.ini, ItemSwap, CurrentGemX
	IniRead, CurrentGemY, PoeCompanion.ini, ItemSwap, CurrentGemY
	IniRead, AlternateGemX, PoeCompanion.ini, ItemSwap, AlternateGemX
	IniRead, AlternateGemY, PoeCompanion.ini, ItemSwap, AlternateGemY
	IniRead, AlternateGemOnSecondarySlot, PoeCompanion.ini, ItemSwap, AlternateGemOnSecondarySlot
		
	IniRead, ChatColor, PoeCompanion.ini, AutoPot, ChatColor
	IniRead, ChatX1, PoeCompanion.ini, AutoPot, ChatX1
 	IniRead, ChatY1, PoeCompanion.ini, AutoPot, ChatY1
 	IniRead, ChatX2, PoeCompanion.ini, AutoPot, ChatX2
 	IniRead, ChatY2, PoeCompanion.ini, AutoPot, ChatY2
 	IniRead, HPColor, PoeCompanion.ini, AutoPot, HPColor
	IniRead, HPX1, PoeCompanion.ini, AutoPot, HPX1
	IniRead, HPY1, PoeCompanion.ini, AutoPot, HPY1
	IniRead, HPX2, PoeCompanion.ini, AutoPot, HPX2
	IniRead, HPY2, PoeCompanion.ini, AutoPot, HPY2
	IniRead, HPQuitTreshold, PoeCompanion.ini, AutoPot, HPQuitTreshold
 	IniRead, HPLowTreshold, PoeCompanion.ini, AutoPot, HPLowTreshold
	IniRead, HPAvgTreshold, PoeCompanion.ini, AutoPot, HPAvgTreshold
	IniRead, HPHighTreshold, PoeCompanion.ini, AutoPot, HPHighTreshold
 	IniRead, MainAttackKey, PoeCompanion.ini, AutoPot, MainAttackKey
	IniRead, SecondaryAttackKey, PoeCompanion.ini, AutoPot, SecondaryAttackKey
	IniRead, TriggerHPLow, PoeCompanion.ini, AutoPot, TriggerHPLow
	IniRead, TriggerHPAvg, PoeCompanion.ini, AutoPot, TriggerHPAvg
	IniRead, TriggerHPHigh, PoeCompanion.ini, AutoPot, TriggerHPHigh
	IniRead, TriggerMainAttack, PoeCompanion.ini, AutoPot, TriggerMainAttack
	IniRead, TriggerSecondaryAttack, PoeCompanion.ini, AutoPot, TriggerSecondaryAttack
	IniRead, CoolDownFlask1, PoeCompanion.ini, AutoPot, CoolDownFlask1
	IniRead, CoolDownFlask2, PoeCompanion.ini, AutoPot, CoolDownFlask2
	IniRead, CoolDownFlask3, PoeCompanion.ini, AutoPot, CoolDownFlask3
	IniRead, CoolDownFlask4, PoeCompanion.ini, AutoPot, CoolDownFlask4
	IniRead, CoolDownFlask5, PoeCompanion.ini, AutoPot, CoolDownFlask5
	
	IniRead, TradeDelay, PoeCompanion.ini, Trade, TradeDelay
	IniRead, TradeChannelDelay, PoeCompanion.ini, Trade, TradeChannelDelay
	IniRead, TradeChannelStart, PoeCompanion.ini, Trade, TradeChannelStart
	IniRead, TradeChannelStop, PoeCompanion.ini, Trade, TradeChannelStop
	IniRead, TradeMessage, PoeCompanion.ini, Trade, TradeMessage
 	
} else {
	
	IniWrite, %CtrlLoopCount%, PoeCompanion.ini, General, CtrlLoopCount
	IniWrite, %ShiftLoopCount%, PoeCompanion.ini, General, ShiftLoopCount
	IniWrite, %InventoryColumnsToMove%, PoeCompanion.ini, General, InventoryColumnsToMove
	IniWrite, %InventoryRowsToMove%, PoeCompanion.ini, General, InventoryRowsToMove	
	IniWrite, %KeyToKeepPress%, PoeCompanion.ini, General, KeyToKeepPress
	IniWrite, %KeyToPressOnTimmer%, PoeCompanion.ini, General, KeyToPressOnTimmer
	IniWrite, %KeyToPressOnTimmerDelay%, PoeCompanion.ini, General, KeyToPressOnTimmerDelay
	IniWrite, %ForceLogoutOrExitOnQuit%, PoeCompanion.ini, General, ForceLogoutOrExitOnQuit
	IniWrite, %Speed%, PoeCompanion.ini, General, Speed
	IniWrite, %Tick%, PoeCompanion.ini, General, Tick
	
	IniWrite, %CellWith%, PoeCompanion.ini, Coordinates, CellWith
	IniWrite, %InventoryX%, PoeCompanion.ini, Coordinates, InventoryX
	IniWrite, %InventoryY%, PoeCompanion.ini, Coordinates, InventoryY
	IniWrite, %StashX%, PoeCompanion.ini, Coordinates, StashX
	IniWrite, %StashY%, PoeCompanion.ini, Coordinates, StashY
	IniWrite, %PortalScrollX%, PoeCompanion.ini, Coordinates, PortalScrollX
	IniWrite, %PortalScrollY%, PoeCompanion.ini, Coordinates, PortalScrollY
	IniWrite, %WisdomScrollX%, PoeCompanion.ini, Coordinates, WisdomScrollX
	IniWrite, %WisdomScrollY%, PoeCompanion.ini, Coordinates, WisdomScrollY
	IniWrite, %TradeButtonX%, PoeCompanion.ini, Coordinates, TradeButtonX
	IniWrite, %TradeButtonY%, PoeCompanion.ini, Coordinates, TradeButtonY
	IniWrite, %TradedItemX%, PoeCompanion.ini, Coordinates, TradedItemX
	IniWrite, %TradedItemY%, PoeCompanion.ini, Coordinates, TradedItemY
	IniWrite, %GuiX%, PoeCompanion.ini, Coordinates, GuiX
	IniWrite, %GuiY%, PoeCompanion.ini, Coordinates, GuiY
		
	IniWrite, %CurrentGemX%, PoeCompanion.ini, ItemSwap, CurrentGemX
	IniWrite, %CurrentGemY%, PoeCompanion.ini, ItemSwap, CurrentGemY
	IniWrite, %AlternateGemX%, PoeCompanion.ini, ItemSwap, AlternateGemX
	IniWrite, %AlternateGemY%, PoeCompanion.ini, ItemSwap, AlternateGemY
	IniWrite, %AlternateGemOnSecondarySlot%, PoeCompanion.ini, ItemSwap, AlternateGemOnSecondarySlot
	
	IniWrite, %ChatColor%, PoeCompanion.ini, AutoPot, ChatColor
	IniWrite, %ChatX1%, PoeCompanion.ini, AutoPot, ChatX1
 	IniWrite, %ChatY1%, PoeCompanion.ini, AutoPot, ChatY1
 	IniWrite, %ChatX2%, PoeCompanion.ini, AutoPot, ChatX2
 	IniWrite, %ChatY2%, PoeCompanion.ini, AutoPot, ChatY2
 	IniWrite, %HPColor%, PoeCompanion.ini, AutoPot, HPColor
	IniWrite, %HPX1%, PoeCompanion.ini, AutoPot, HPX1
	IniWrite, %HPY1%, PoeCompanion.ini, AutoPot, HPY1
	IniWrite, %HPX2%, PoeCompanion.ini, AutoPot, HPX2
	IniWrite, %HPY2%, PoeCompanion.ini, AutoPot, HPY2
	IniWrite, %HPQuitTreshold%, PoeCompanion.ini, AutoPot, HPQuitTreshold
 	IniWrite, %HPLowTreshold%, PoeCompanion.ini, AutoPot, HPLowTreshold
	IniWrite, %HPAvgTreshold%, PoeCompanion.ini, AutoPot, HPAvgTreshold
	IniWrite, %HPHighTreshold%, PoeCompanion.ini, AutoPot, HPHighTreshold
 	IniWrite, %MainAttackKey%, PoeCompanion.ini, AutoPot, MainAttackKey
	IniWrite, %SecondaryAttackKey%, PoeCompanion.ini, AutoPot, SecondaryAttackKey
	IniWrite, %TriggerHPLow%, PoeCompanion.ini, AutoPot, TriggerHPLow
	IniWrite, %TriggerHPAvg%, PoeCompanion.ini, AutoPot, TriggerHPAvg
	IniWrite, %TriggerHPHigh%, PoeCompanion.ini, AutoPot, TriggerHPHigh
	IniWrite, %TriggerMainAttack%, PoeCompanion.ini, AutoPot, TriggerMainAttack
	IniWrite, %TriggerSecondaryAttack%, PoeCompanion.ini, AutoPot, TriggerSecondaryAttack
	IniWrite, %CoolDownFlask1%, PoeCompanion.ini, AutoPot, CoolDownFlask1
	IniWrite, %CoolDownFlask2%, PoeCompanion.ini, AutoPot, CoolDownFlask2
	IniWrite, %CoolDownFlask3%, PoeCompanion.ini, AutoPot, CoolDownFlask3
	IniWrite, %CoolDownFlask4%, PoeCompanion.ini, AutoPot, CoolDownFlask4
	IniWrite, %CoolDownFlask5%, PoeCompanion.ini, AutoPot, CoolDownFlask5
	
	IniWrite, %TradeDelay%, PoeCompanion.ini, Trade, TradeDelay
	IniWrite, %TradeChannelDelay%, PoeCompanion.ini, Trade, TradeChannelDelay
	IniWrite, %TradeChannelStart%, PoeCompanion.ini, Trade, TradeChannelStart
	IniWrite, %TradeChannelStop%, PoeCompanion.ini, Trade, TradeChannelStop
	IniWrite, %TradeMessage%, PoeCompanion.ini, Trade, TradeMessage

}

; -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
; KEY Binding
; Legend:   ! = Alt      ^ = Ctrl     + = Shift 
; -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
; !WheelDown::Send {Right} ; ALT+WheelDown: Stash scroll 
; !WheelUp::Send {Left} ; ALT+WheelUp: Stash scroll
;; ^WheelDown::AutoClicks() ; CTRL+WheelDown -> Spam CTRL+CLICK
+WheelDown::AutoClicks() ; SHIFT+WheelDown -> Spam SHIFT+CLICK
!WheelDown::AutoCtrlClicks() ; CTRL+WheelDown -> Spam CTRL+CLICK
!MButton::RepeatCtrlClicks() ;
^WheelDown::Send {Right} ;
^WheelUp::Send {Left} ;

F4::Send {Enter} /kick Katoone{Enter}
F5::Send {Enter} /hideout{Enter}

$!1::GetNumber(1)
$!2::GetNumber(2)
$!3::GetNumber(3)
$!4::GetNumber(4)
$!5::GetNumber(5)
$!6::GetNumber(6)
$!7::GetNumber(7)
$!8::GetNumber(8)
$!9::GetNumber(9)


GetNumber(num) {
    BlockInput on
    Send {Shift down}
    Send {Lbutton}
    Send {Shift up}
    FileAppend, Repeat times %num% `n, output.log
    num := num - 1
    FileAppend, Repeat times2 %num% `n, output.log
    Loop %num%
    {
       Sleep 1
       Send {Right}
    }
    Send {Enter}
    BlockInput off
}

Unblock(){
    ;; BlockInput on
    Send {Enter} /hideout {Enter}
    BlockInput off
}
;;;;;  ; -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;;;;;  $!G::Send {Enter} /global 820 {Enter} ; ALT+G
;;;;;  $!T::Send {Enter} /trade 820 {Enter} ; ALT+T
;;;;;  $!H::Send {Enter} /hideout {Enter} ; ALT+H
;;;;;  $!R::Send {Enter} /remaining {Enter} ; ALT+R
;;;;;  $!B::Send {Enter} /abandon_daily {Enter} ; ALT+B
;;;;;  $!L::Send {Enter} /itemlevel {Enter} ; ALT+L
;;;;;  $!P::Send {Enter} /passives {Enter} ; ALT+P
;;;;;  $!E::Send {Enter} /exit {Enter} ; ALT+E: Exit to char selection
;;;;;  $!Y::Send ^{Enter}{Home}{Delete}/invite {Enter} ;ALT+Y: Invite the last char who whispered you to party
;;;;;  $+Y::Send ^{Enter}{Home}{Delete}/tradewith {Enter} ; Invite the last char who whispered you to trade
;;;;;  ^!Y:: ; Link the current item to the last person that whispered you
;;;;;      Send ^{Enter}
;;;;;      Sleep 111
;;;;;      Send ^!{Click}{Space}
;;;;;  Return
;;;;;  ; -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;;;;;  $!F1::ExitApp  ; Alt+F1: Exit the script
;;;;;  $!Q::Logout() ; ALT+Q: Fast logout  
;;;;;  $!O::CheckPos() ; ALT+O Get the cursor position. Use it to change the position setup for Identify, OpenPortal, SwitchGem etc
;;;;;  $!S::POTSpam() ; Alt+S for 5 times will press 1,2,3,4,4 in fast seqvence 
;;;;;  ; -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;;;;;  ; The following macros are NOT ALLOWED by GGG (EULA), as we send multiple server actions with one button pressed
;;;;;  ; This can't be identified as we randomize all timmings, but dont use it if you want to stick with the EULA 
;;;;;  ; -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;;;;;  $!Space::OpenPortal() ; ALT+Space: Open a portal using a portal scroll from the top right inv slot; use CheckPos to change portal scroll position if needed
;;;;;  $`::POT12345() ; `: Pressing ` once will press 1,2,3,4,5 in fast seqvence 
;;;;;  $!I::Identify(InventoryX,InventoryY,InventoryRowsToMove,InventoryColumnsToMove) ; ALT+I: Id all the items from Inventory 
;;;;;  $+I::Identify(StashX,StashY,12,12) ; SHIFT:I: Id all Items from the opened stash tab
;;;;;  $!C::CtrlClick(InventoryX,InventoryY,InventoryRowsToMove,InventoryColumnsToMove) ; ALT+C: CtrlClick full inventory excepting the last 2 columns
;;;;;  $+C::CtrlClick(StashX,StashY,12,4) ; SHIFT+C: CtrlClick the opened stash tab to move 12 X 4 rows x columns to the Inventory
;;;;;  $!X::CtrlClick(-1,-1,12,4) ; ALT+X: CtrClick the opened tab from the MousePointer (needs to be a top cell)
;;;;;  $!Z::CtrlClickLoop(CtrlLoopCount) ; ALT + Z : 50 X CtrlClick at the current mouse location (ex: buys currency from vendors)
;;;;;  $!F::ShiftClick(ShiftLoopCount) ; ShiftClick 50 times (Use it for Fusings/Jewler 6s/6l crafting) 
;;;;;  $!M::SwitchGem() ;Alt+M to switch 2 gems (eg conc effect with area). Use CheckPos to change the positions in the function! 
;;;;;  $!V::DivTrade() ;Alt+V trade all your divinations ; use CheckPos to change position if needed
;;;;;  $!U::KeepKeyPressed()
;;;;;  $!K::KeyOnTimmer()
;;;;;  $!D::SwitchDebug()

;;;; SwitchDebug(){
;;;; debug=!debug
;;;; if Debug {
;;;; 	msgbox "Debug mode enabled!"
;;;; } else
;;;; 	msgbox "Debug mode disabled!"
;;;; }

; Functions
LeaveParty(){

}
RandomSleep(min,max){
	Random, r, %min%, %max%
	r:=floor(r/Speed)
	Sleep %r%
	return
}

AutoClicks(){
BlockInput On 
Send {blind}{Lbutton down}{Lbutton up} 
BlockInput Off
}

AutoCtrlClicks(){
    BlockInput On
    Send {Ctrl down}{Lbutton down}{Lbutton up}{Ctrl up}
    Sleep 15
    BlockInput Off
}

RepeatCtrlClicks(){
    BlockInput On
    try {
      Send {Ctrl down}
      While GetKeyState("MButton", "P")
      {
          Send {Lbutton down}{Lbutton up}
          ;; MouseGetPos, MouseX, MouseY
          ;; PixelGetColor, color, %MouseX%, %MouseY%, Alt
          ;; FileAppend, Color is %color%`n, output.log
          RandomSleep(50,79)
      }
    } finally {
      Send {Ctrl up}
      BlockInput Off
    }
}

;;;;;  OpenPortal(){
;;;;;  	BlockInput On
;;;;;  	RandomSleep(113,138)
;;;;;  	
;;;;;  	MouseGetPos xx, yy
;;;;;  	Send {i}
;;;;;  	RandomSleep(56,68)
;;;;;  	
;;;;;  	MouseMove, PortalScrollX, PortalScrollY, 0 ; portal scroll location, top right
;;;;;  	RandomSleep(56,68)
;;;;;  	
;;;;;  	Click Right
;;;;;  	RandomSleep(56,68)
;;;;;  	
;;;;;  	Send {i}
;;;;;  	MouseMove, xx, yy, 0
;;;;;  	BlockInput Off
;;;;;  	return
;;;;;  }
;;;;;  KeepKeyPressed(){
;;;;;  If (KeyOn = False)
;;;;;  	{
;;;;;  		Send {%KeyToKeepPress% Down}
;;;;;  		} Else 
;;;;;  			Send {%KeyToKeepPress% Up}
;;;;;  	KeyOn := not(KeyOn)
;;;;;  	Return
;;;;;  }
;;;;;  KeyOnTimmer(){
;;;;;     KeyOnTimmer := !KeyOnTimmer
;;;;;     if (KeyOnTimmer=True) {
;;;;;          SetTimer TKeyPress, %KeyToPressOnTimmerDelay%
;;;;;      } else {
;;;;;          SetTimer TKeyPress, Off	
;;;;;      }
;;;;;  	Return
;;;;;  }
;;;;;  CheckPos(){
;;;;;      MouseGetPos, xpos, ypos
;;;;;  	PixelGetColor, xycolor , xpos, ypos
;;;;;      msgbox, X=%xpos% Y=%ypos% XYColor=%xycolor%
;;;;;  	return
;;;;;  }
