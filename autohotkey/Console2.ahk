; IMPORTANT INFO ABOUT GETTING STARTED: Lines that start with a
; semicolon, such as this one, are comments.  They are not executed.

; This script has a special filename and path because it is automatically
; launched when you run the program directly.  Also, any text file whose
; name ends in .ahk is associated with the program, which means that it
; can be launched simply by double-clicking it.  You can have as many .ahk
; files as you want, located in any folder.  You can also run more than
; one .ahk file simultaneously and each will get its own tray icon.

; SAMPLE HOTKEYS: Below are two sample hotkeys.  The first is Win+Z and it
; launches a web site in the default browser.  The second is Control+Alt+N
; and it launches a new Notepad window (or activates an existing one).  To
; try out these hotkeys, run AutoHotkey again, which will load this file.


;^!n::

GroupAdd, TargetWindow, ahk_class Console_2_Main

#Space::
    DetectHiddenWindows, on
    IfWinExist ahk_group TargetWindow
    {
        IfWinActive ahk_group TargetWindow
        {
            MouseGetPos,,, MouseWin, MouseControl
            WinHide ahk_group TargetWindow
            WinActivate ahk_id %MouseWin%
            ;ControlFocus %MouseControl%
            ;WinActivate ahk_group Shell_TrayWnd
        }
        else
        {
            WinSet, Style, -0x800000, ahk_group TargetWindow  ; hide thin-line border
            WinSet, Style, -0x400000, ahk_group TargetWindow  ; hide dialog frame
            WinSet, Style, -0x40000, ahk_group TargetWindow  ; hide thickframe/sizebox
            CoordMode, Mouse, Screen
            MouseGetPos, MouseX, MouseY
            CoordMode, Mouse, Relative
            SysGet, mCount, MonitorCount
            Loop %mCount% {
              SysGet, mBounding, Monitor, %A_Index%
              if (MouseX > mBoundingLeft and MouseX < mBoundingRight and MouseY > mBoundingTop && MouseY < mBoundingBottom) {
                Choosen = %A_Index%
                WinMove, ahk_group TargetWindow, , (mBoundingRight-mBoundingLeft)/2 - 1000/2, mBoundingTop, 1000, 300
                Break
              }
            }
            WinSet, AlwaysOnTop, on, ahk_group TargetWindow
            WinShow ahk_group TargetWindow
            WinActivate ahk_group TargetWindow
        }
    }
    else
    {	
      Run C:\Dropbox\Programs\Console2\Console.exe, C:\Dropbox\Programs\Console2\
    }
    DetectHiddenWindows, off
    return

; hide Console on "esc".
#IfWinActive ahk_group TargetWindow
esc::
{
   	WinHide ahk_group TargetWindow
       ;WinActivate ahk_group Shell_TrayWnd
    MouseGetPos,,, MouseWin, MouseControl
    WinActivate ahk_id %MouseWin%
}
return
