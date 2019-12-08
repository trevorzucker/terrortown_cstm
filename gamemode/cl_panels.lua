local padding = 5;
local defColors = {Color(255, 255, 255, 200), Color(50, 50, 50, 255)};
local matGradL = Material("vgui/gradient-l")

local PANEL_FRAME = {};

PANEL_FRAME.Title = "";
PANEL_FRAME.LabelX = pading;
PANEL_FRAME.LabelY = 0;

surface.CreateFont("none", {font = "DebugFixed", size = 0})

function PANEL_FRAME:Paint()
	local w, h = self:GetWide(), self:GetTall();
    surface.SetDrawColor(GetConVar("interface_r"):GetInt(), GetConVar("interface_g"):GetInt(), GetConVar("interface_b"):GetInt(), GetConVar("interface_a"):GetInt())

    surface.DrawRect(0, 0, w, h);

    surface.SetFont("SH_TTT_HUD2");
    local size = surface.GetTextSize(self.Title);
    surface.SetTextPos(padding, 0);
	draw.SimpleTextOutlined(self.Title, "SH_TTT_HUD2", self.LabelX, self.LabelY, defColors[1], TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 2, defColors[2])

    surface.DrawRect(0, 0, w, 2);
    surface.DrawRect(0, 0, 2, h);
    surface.DrawRect(w - 2, 0, 2, h);
    surface.DrawRect(0, h - 2, w, 2);
end

function PANEL_FRAME:SetTitlePos(x, y)
	self.LabelX = x;
	self.LabelY = y;
end

function PANEL_FRAME:SetTitleHidden(title)
	self:SetTitle("");
	self.Title = title;
end

vgui.Register( "CFrame", PANEL_FRAME, "DFrame" );


local vgui_BUTTON = {};

vgui_BUTTON.Text = "";
vgui_BUTTON.Moused = false;
vgui_BUTTON.MousePressed = false;
vgui_BUTTON.DrawColor = {100, 100, 100, 200};
vgui_BUTTON.TextColor = {200, 200, 200, 255};

function vgui_BUTTON:Init()
	self:SetFont("none");
end

function vgui_BUTTON:Paint()
end

function vgui_BUTTON:Think()
	local ft = FrameTime();
	self.Paint = function()
		local w, h = self:GetWide(), self:GetTall();
		if (self.Moused && !self.MousePressed) then
			if (input.IsMouseDown(MOUSE_LEFT)) then
				self.MousePressed = true;
			else
				self.MousePressed = true;
			end
			self.DrawColor = LerpColorArray(ft * 15, self.DrawColor, {140, 140, 140, 200});
			self.TextColor = LerpColorArray(ft * 15, self.TextColor, {220, 220, 220, 255});
		elseif (self.MousePressed) then
			if (!input.IsMouseDown(MOUSE_LEFT)) then
				self.MousePressed = false;
			end
			self.DrawColor = LerpColorArray(ft * 15, self.DrawColor, {200, 200, 200, 200});
			self.TextColor = LerpColorArray(ft * 15, self.TextColor, {255, 255, 255, 255});
		else
			if (!input.IsMouseDown(MOUSE_LEFT)) then
				self.MousePressed = false;
			end
			self.DrawColor = LerpColorArray(ft * 15, self.DrawColor, {100, 100, 100, 200});
			self.TextColor = LerpColorArray(ft * 15, self.TextColor, {200, 200, 200, 255});
		end
		    surface.SetDrawColor(self.DrawColor[1], self.DrawColor[2], self.DrawColor[3], self.DrawColor[4]);
			surface.SetTextColor( self.TextColor[1], self.TextColor[2], self.TextColor[3], self.TextColor[4] );

	    surface.DrawRect(0, 0, w, h);

	    surface.SetDrawColor(GetConVar("interface_r"):GetInt(), GetConVar("interface_g"):GetInt(), GetConVar("interface_b"):GetInt(), GetConVar("interface_a"):GetInt());

	    surface.SetFont("SH_TTT_HUD" ..(math.floor(h / 14)));
	    local size, sizey = surface.GetTextSize(self.Text);
	    surface.SetTextPos(self:GetWide() / 2 - size / 2, h / 2 - sizey / 2);
	    surface.DrawText(self.Text);

	    surface.DrawRect(2, 0, w - 4, 2);
	    surface.DrawRect(0, 0, 2, h);
	    surface.DrawRect(w - 2, 0, 2, h);
	    surface.DrawRect(2, h - 2, w - 4, 2);
	end
end

function vgui_BUTTON:OnCursorEntered()
	surface.PlaySound("garrysmod/ui_hover.wav");
	self.Moused = true;
end

function vgui_BUTTON:OnCursorExited()
	self.Moused = false;
end

function vgui_BUTTON:SetTextHidden(text)
	self:SetText("");
	self.Text = text;
end

vgui.Register( "CButton", vgui_BUTTON, "DButton" );



local PANEL_PROPERTYSHEET = {};

PANEL_PROPERTYSHEET.Title = "";

surface.CreateFont("none", {font = "DebugFixed", size = 0})

function PANEL_PROPERTYSHEET:Paint()
	local w, h = self:GetWide(), self:GetTall();
	local y = 20;
    surface.SetDrawColor(206, 206, 206, 255)

    surface.DrawRect(0, y, w, h - y);

    surface.SetDrawColor(255, 255, 255, 255)
    surface.SetMaterial(matGradL);

    surface.DrawTexturedRect(0, y, w, 2);
    surface.DrawRect(0, y, 2, h - y);
    surface.DrawTexturedRect(0, h - 2, w, 2);
end

function PANEL_PROPERTYSHEET:Think()
	self.animFade:Run()
	local y = 6;

    for k, v in pairs(self.Items) do
		if (!v.Tab) then continue end
		v.Tab.Paint = function(self,w,h)
		    surface.SetDrawColor(120, 120, 120, 200)

		    surface.DrawRect(2, 0, w - 4, h);

		    surface.SetDrawColor(140, 140, 140, 200)

		    surface.DrawRect(2, 0, w - 4, 2);
		    surface.DrawRect(2, 0, 2, h);
		    surface.DrawRect(w - 4, 0, 2, h);
		end
		if (self:GetActiveTab():GetPanel() == v.Tab:GetPanel()) then
			v.Tab.Paint = function(self,w,h)
			    surface.SetDrawColor(206, 206, 206, 200)

			    surface.DrawRect(2, 0, w - 4, h);

			    surface.SetDrawColor(255, 255, 255, 200)
			    surface.DrawRect(2, 0, w - 4, 2);
			    surface.DrawRect(2, 0, 2, h - y);
			    surface.DrawRect(w - 4, 0, 2, h - y);
			end
		end

	end
end

vgui.Register( "CPropertySheet", PANEL_PROPERTYSHEET, "DPropertySheet" );

local PANEL_FORM = {};

PANEL_FORM.NAME = name;

function PANEL_FORM:SetNameDraw(name)
	self.NAME = name;
end

function PANEL_FORM:Paint()
	local w, h = self:GetWide(), self:GetTall();
	local y = 20;
	local padding = 12;
    surface.SetDrawColor(206, 206, 206, 255)

    surface.SetDrawColor(20, 20, 20, 200)
    surface.SetFont("DermaDefaultBold");
    local textx = surface.GetTextSize(self.NAME) + padding;
    surface.DrawRect(0, 1, textx, y - 3);

    surface.SetMaterial(matGradL);

    surface.DrawRect(0, y, 2, h - y * 2 - 2);

    surface.DrawTexturedRect(0, y - 2, w, 2);

    surface.DrawTexturedRect(0, h - 2 - y, w, 2);

end

vgui.Register( "CForm", PANEL_FORM, "DForm" );

local PANEL_PANELLIST = {};

function PANEL_PANELLIST:Paint()
	local w, h = self:GetWide(), self:GetTall();
	local y = 20;
    surface.SetDrawColor(206, 206, 206, 255)

    surface.DrawRect(0, y, w, h - y);

    surface.SetDrawColor(255, 255, 255, 255)

    surface.DrawRect(0, y, w, 2);
    surface.DrawRect(0, y, 2, h - y);
    surface.DrawRect(w - 2, y, 2, h - y);
    surface.DrawRect(0, h - 2, w, 2);

end

vgui.Register( "CPanelList", PANEL_PANELLIST, "DPanelList" );

function LerpColorArray(time, arr, values)
	local newarr = {0, 0, 0, 0};
	newarr[1] = Lerp(time, arr[1], values[1]);
	newarr[2] = Lerp(time, arr[2], values[2]);
	newarr[3] = Lerp(time, arr[3], values[3]);
	newarr[4] = Lerp(time, arr[4], values[4]);
	return newarr;
end