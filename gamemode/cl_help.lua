---- Help screen

local GetTranslation = LANG.GetTranslation
local GetPTranslation = LANG.GetParamTranslation

CreateConVar("ttt_spectator_mode", "0", FCVAR_ARCHIVE)
CreateConVar("ttt_mute_team_check", "0")

CreateConVar("ttt_customize_key", "V", FCVAR_ARCHIVE);
CreateConVar("interface_r", "0", FCVAR_ARCHIVE)
CreateConVar("interface_g", "0", FCVAR_ARCHIVE)
CreateConVar("interface_b", "0", FCVAR_ARCHIVE)
CreateConVar("interface_a", "200", FCVAR_ARCHIVE)


CreateClientConVar("ttt_avoid_detective", "0", true, true)

HELPSCRN = {}

function HELPSCRN:Show()
   local margin = 15

   local dframe = vgui.Create("CFrame")
   local w, h = 630, 455
   dframe:SetSize(w, h)
   dframe:Center()
   dframe:SetTitlePos(dframe:GetWide() / 1.4, dframe:GetTall() / 100);
   dframe:SetTitleHidden(GetTranslation("help_title"))
   dframe:ShowCloseButton(false);
   dframe:SetDraggable(false);

   local dbut = vgui.Create("CButton", dframe)
   local bw, bh = 50, 25
   dbut:SetSize(bw, bh)
   dbut:SetPos(w - bw - margin, h - bh - margin/2)
   dbut:SetTextHidden(GetTranslation("close"))
   dbut.DoClick = function() dframe:Close() end


   local dtabs = vgui.Create("CPropertySheet", dframe)
   dtabs:SetPos(margin, margin)
   dtabs:SetSize(w - margin*2, h - margin*2 - bh)

   local padding = dtabs:GetPadding()

   padding = padding * 2

   local tutparent = vgui.Create("DPanel", dtabs)
   tutparent:SetPaintBackground(false)
   tutparent:StretchToParent(margin, 0, 0, 0)

   self:CreateTutorial(tutparent)

   dtabs:AddSheet(GetTranslation("help_tut"), tutparent, "icon16/help.png", false, false, GetTranslation("help_tut_tip"))

   local dsettings = vgui.Create("CPanelList", dtabs)
   dsettings:StretchToParent(0,0,padding,0)
   dsettings:EnableVerticalScrollbar(true)
   dsettings:SetPadding(10)
   dsettings:SetSpacing(10)

   dsettings.Paint = function(w, h)
     local bar = dsettings:GetChild(1);

     function bar:Paint(w, h)
       surface.SetDrawColor(100, 100, 100, 100);
       surface.DrawRect(0, 0, w, h);
     end

     function bar.btnGrip:Paint(w, h)
       surface.SetDrawColor(50, 50, 50, 200);
       surface.DrawRect(0, 0, w, h);

       surface.SetDrawColor(50, 50, 50, 200);
       surface.DrawRect(0, 0, w, 2);
       surface.DrawRect(0, 2, 2, h - 2);
       surface.DrawRect(w - 2, 2, 2, h - 2);
       surface.DrawRect(2, h - 2, w - 4, 2);

       surface.DrawLine(w / 3, h / 2 - 2, w / 1.5, h / 2 - 2);
       surface.DrawLine(w / 3, h / 2, w / 1.5, h / 2);
       surface.DrawLine(w / 3, h / 2 + 2, w / 1.5, h / 2 + 2);

     end


     function bar.btnUp:Paint(w, h)

       local up = {
         { x = w / 3, y = h / 1.5 },
         { x = w / 2, y = h / 3 },
         { x = w / 1.5, y = h / 1.5 }
 
       }
       surface.SetDrawColor(50, 50, 50, 200);
       surface.DrawRect(0, 0, w, h);

       surface.SetDrawColor(50, 50, 50, 200);
       surface.DrawRect(0, 0, w, 2);
       surface.DrawRect(0, 2, 2, h - 2);
       surface.DrawRect(w - 2, 2, 2, h - 2);
       surface.DrawRect(2, h - 2, w - 4, 2);

       draw.NoTexture();
       surface.DrawPoly(up);

     end

     function bar.btnDown:Paint(w, h)

       local down = {
         { x = w / 3, y = h / 3 },
         { x = w / 1.5, y = h / 3 },
         { x = w / 2, y = h / 1.5 }
 
       }
       surface.SetDrawColor(50, 50, 50, 200);
       surface.DrawRect(0, 0, w, h);

       surface.SetDrawColor(50, 50, 50, 200);
       surface.DrawRect(0, 0, w, 2);
       surface.DrawRect(0, 2, 2, h - 2);
       surface.DrawRect(w - 2, 2, 2, h - 2);
       surface.DrawRect(2, h - 2, w - 4, 2);

       draw.NoTexture();
       surface.DrawPoly(down);

     end
   end

   --- Interface area

   local dgui = vgui.Create("CForm", dsettings)
   dgui:SetName(GetTranslation("set_title_gui"))
   dgui:SetNameDraw(GetTranslation("set_title_gui"))

   --[[local label = vgui.Create("DLabel");
   label:SetText("UI Color");
   label:SetColor(Color(0, 0, 0));
   dgui:AddItem(label);

   local Mixer = vgui.Create( "DColorMixer", dgui )
   Mixer:SetSize(w / 2, 200)
   Mixer:SetPalette( true )    --Show/hide the palette     DEF:true
   Mixer:SetAlphaBar( true )     --Show/hide the alpha bar   DEF:true
   Mixer:SetWangs( true )      --Show/hide the R G B A indicators  DEF:true
   Mixer:SetColor( Color( GetConVar("interface_r"):GetInt(), GetConVar("interface_g"):GetInt(), GetConVar("interface_b"):GetInt(), GetConVar("interface_a"):GetInt() ) ) --Set the default color

   Mixer.Think = function()
    RunConsoleCommand("interface_r", Mixer:GetColor().r);
    RunConsoleCommand("interface_g", Mixer:GetColor().g);
    RunConsoleCommand("interface_b", Mixer:GetColor().b);
    RunConsoleCommand("interface_a", Mixer:GetColor().a);
   end
   
   dgui:AddItem(Mixer);]]--

   local cb = nil
 
   cb = dgui:NumSlider("HUD gap", "ttt_hud_gap", 0, ScrH() - 50, 0)
   if (cb.Label) then
     cb.Label:SetWrap(true)
   end

   cb:SetTooltip("How far away should the HUD be from the corners of your screen?")
   

   local cb, lbl = nil
 
   cb, lbl = dgui:TextEntry("Customization key", "ttt_customize_key")
   if (lbl) then
     lbl:SetWrap(true)
   end

   cb:SetText(GetConVar("ttt_customize_key"):GetString());
   cb.OnEnter = function(self)
      RunConsoleCommand("ttt_customize_key", self:GetValue());
   end

   cb:SetTooltip("How far away should the HUD be from the corners of your screen?")

   dgui:CheckBox(GetTranslation("set_tips"), "ttt_tips_enable")

   dgui:CheckBox("Show credits on HUD", "ttt_hud_show_cerdits")

   dgui:CheckBox(GetTranslation("set_cross_disable"), "ttt_disable_crosshair")

   dgui:CheckBox(GetTranslation("set_minimal_id"), "ttt_minimal_targetid")

   dgui:CheckBox(GetTranslation("set_healthlabel"), "ttt_health_label")

   cb = dgui:CheckBox(GetTranslation("set_lowsights"), "ttt_ironsights_lowered")
   cb:SetTooltip(GetTranslation("set_lowsights_tip"))

   cb = dgui:CheckBox(GetTranslation("set_fastsw"), "ttt_weaponswitcher_fast")
   cb:SetTooltip(GetTranslation("set_fastsw_tip"))
      
   cb = dgui:CheckBox(GetTranslation("set_fastsw_menu"), "ttt_weaponswitcher_displayfast")
   cb:SetTooltip(GetTranslation("set_fastswmenu_tip"))

   cb = dgui:CheckBox(GetTranslation("set_wswitch"), "ttt_weaponswitcher_stay")
   cb:SetTooltip(GetTranslation("set_wswitch_tip"))

   cb = dgui:CheckBox(GetTranslation("set_cues"), "ttt_cl_soundcues")

   local label = vgui.Create("DLabel");
   label:SetText("");
   dgui:AddItem(label);


   dsettings:AddItem(dgui)

   --- Gameplay area

   local dplay = vgui.Create("CForm", dsettings)
   dplay:SetName(GetTranslation("set_title_play"))
   dplay:SetNameDraw(GetTranslation("set_title_play"))

   cb = dplay:CheckBox(GetTranslation("set_avoid_det"), "ttt_avoid_detective")
   cb:SetTooltip(GetTranslation("set_avoid_det_tip"))

   cb = dplay:CheckBox(GetTranslation("set_specmode"), "ttt_spectator_mode")
   cb:SetTooltip(GetTranslation("set_specmode_tip"))

   -- For some reason this one defaulted to on, unlike other checkboxes, so
   -- force it to the actual value of the cvar (which defaults to off)
   local mute = dplay:CheckBox(GetTranslation("set_mute"), "ttt_mute_team_check")
   mute:SetValue(GetConVar("ttt_mute_team_check"):GetBool())
   mute:SetTooltip(GetTranslation("set_mute_tip"))

   local label = vgui.Create("DLabel");
   label:SetText("");
   dplay:AddItem(label);

   dsettings:AddItem(dplay)

   --- Language area
   local dlanguage = vgui.Create("CForm", dsettings)
   dlanguage:SetName(GetTranslation("set_title_lang"))
   dlanguage:SetNameDraw(GetTranslation("set_title_lang"))

   local dlang = vgui.Create("DComboBox", dlanguage)
   dlang:SetConVar("ttt_language")

   dlang:AddChoice("Server default", "auto")
   for _, lang in pairs(LANG.GetLanguages()) do
      dlang:AddChoice(string.Capitalize(lang), lang)
   end
   -- Why is DComboBox not updating the cvar by default?
   dlang.OnSelect = function(idx, val, data)
                       RunConsoleCommand("ttt_language", data)
                    end
   dlang.Think = dlang.ConVarStringThink

   dlanguage:Help(GetTranslation("set_lang"))
   dlanguage:AddItem(dlang)

   local label = vgui.Create("DLabel");
   label:SetText("");
   dlanguage:AddItem(label);

   dsettings:AddItem(dlanguage)

   dtabs:AddSheet(GetTranslation("help_settings"), dsettings, "icon16/cog.png", false, false, GetTranslation("help_settings_tip"))

   hook.Call("TTTSettingsTabs", GAMEMODE, dtabs)

   dframe:MakePopup()
end


local function ShowTTTHelp(ply, cmd, args)
   HELPSCRN:Show()
end
concommand.Add("ttt_helpscreen", ShowTTTHelp)

-- Some spectator mode bookkeeping

local function SpectateCallback(cv, old, new)
   local num = tonumber(new)
   if num and (num == 0 or num == 1) then
      RunConsoleCommand("ttt_spectate", num)
   end
end
cvars.AddChangeCallback("ttt_spectator_mode", SpectateCallback)

local function MuteTeamCallback(cv, old, new)
   local num = tonumber(new)
   if num and (num == 0 or num == 1) then
      RunConsoleCommand("ttt_mute_team", num)
   end
end
cvars.AddChangeCallback("ttt_mute_team_check", MuteTeamCallback)

--- Tutorial

local imgpath = "vgui/ttt/help/tut0%d"
local tutorial_pages = 6
function HELPSCRN:CreateTutorial(parent)
   local w, h = parent:GetSize()
   local m = 5

   local bg = vgui.Create("ColoredBox", parent)
   bg:StretchToParent(0,0,0,0)
   bg:SetTall(330)
   bg:SetColor(COLOR_BLACK)

   local tut = vgui.Create("DImage", parent)
   tut:StretchToParent(0, 0, 0, 0)
   tut:SetVerticalScrollbarEnabled(false)

   tut:SetImage(Format(imgpath, 1))
   tut:SetWide(1024)
   tut:SetTall(512)

   tut.current = 1


   local bw, bh = 100, 30

   local bar = vgui.Create("TTTProgressBar", parent)
   bar:SetSize(200, bh)
   bar:MoveBelow(bg)
   bar:CenterHorizontal()
   bar:SetMin(1)
   bar:SetMax(tutorial_pages)
   bar:SetValue(1)
   bar:SetColor(Color(0,200,0))

   -- fixing your panels...
   bar.UpdateText = function(s)
                       s.Label:SetText(Format("%i / %i", s.m_iValue, s.m_iMax))
                    end

   bar:UpdateText()
   local xpos, ypos = bar:GetPos();
   bar:SetPos(xpos, ypos + 2)


   local bnext = vgui.Create("CButton", parent)
   bnext:SetFont("Trebuchet22")
   bnext:SetSize(bw, bh)
   bnext:SetTextHidden(GetTranslation("next"))
   bnext:CopyPos(bar)
   bnext:AlignRight(1)
   local xpos, ypos = bnext:GetPos();
   bnext:SetPos(xpos, ypos + 2)

   local bprev = vgui.Create("CButton", parent)
   bprev:SetFont("Trebuchet22")
   bprev:SetSize(bw, bh)
   bprev:SetTextHidden(GetTranslation("prev"))
   bprev:CopyPos(bar)
   bprev:AlignLeft()
   local xpos, ypos = bprev:GetPos();
   bprev:SetPos(xpos, ypos + 2)

   bnext.DoClick = function()
                      if tut.current < tutorial_pages then
                         tut.current = tut.current + 1
                         tut:SetImage(Format(imgpath, tut.current))
                         bar:SetValue(tut.current)
                      end
                   end

   bprev.DoClick = function()
                      if tut.current > 1 then
                         tut.current = tut.current - 1
                         tut:SetImage(Format(imgpath, tut.current))
                         bar:SetValue(tut.current)
                      end
                   end
end
