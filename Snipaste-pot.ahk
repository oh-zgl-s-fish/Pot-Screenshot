#Persistent
#SingleInstance,force
Menu, Tray, NoStandard
programName:="Snipaste-pot"
Menu, Tray, Click, 1                            ;单击执行默认菜单项open，由OnClick实现。
Menu, Tray, Add, Open, OnClick
Menu, Tray, Add, OpenConfig, OnClickOpen
Menu, Tray, Add, Exit,OnExit
Menu, Tray, Default, Open
Menu,Tray,Tip,%programName%     ;在托盘图标上悬停鼠标，显示
return
OnExit:
        ExitApp
return

OnClickOpen:
        IniRead, Editor, config.ini, settings, Editor
        Run, %Editor% config.ini
return

OnClick:
if !LastClick 
{
        LastClick := 1
        LastTC := A_TickCount
        SetTimer,SingleClickEvent,-300
}
else if (A_TickCount-LastTC<300)
{
        SetTimer,SingleClickEvent,off
        gosub,DoubleClickEvent
}
return
 
 
SingleClickEvent:
IniRead, Snip, config.ini, Screenshot, Snipaste
IniRead, Port, config.ini, Pot, Port
IniRead, Delay, config.ini, Settings, Delay
if FileExist("C:\Users\ZGL\AppData\Local\com.pot-app.desktop\pot_screenshot_cut.png")
{
       FileDelete, C:\Users\ZGL\AppData\Local\com.pot-app.desktop\pot_screenshot_cut.png
}
Run, %Snip% snip -o C:\Users\ZGL\AppData\Local\com.pot-app.desktop\pot_screenshot_cut.png
Delay:=Delay*10
Loop, %Delay%
{
        if FileExist("C:\Users\ZGL\AppData\Local\com.pot-app.desktop\pot_screenshot_cut.png")
        {
                Run, pot-translate.exe %Port%
                Break
        }
        Sleep, 100
}
LastClick := 0
return
 
 
DoubleClickEvent:
LastClick := 0
return
