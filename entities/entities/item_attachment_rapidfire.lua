AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_attachment"
ENT.AttachmentName = "Rapid-Fire Magazine";
ENT.Description = "Increases rate of fire";
ENT.Weight		= 0.5;
ENT.Model = Model("models/weapons/w_defuser.mdl")
ENT.HideModel = true;
ENT.Image            = "vgui/gfx/vgui/cartridge";
ENT.Group            = "Magazine";
ENT.Magnification    = 0;

ENT.EquipFnc         = function(wep)
	wep.Primary.Delay = wep.Primary.DefaultDelay / 2;
end;
ENT.DequipFnc        = function(wep)
	wep.Primary.Delay = wep.Primary.DefaultDelay;
end;

ENT.AutoSpawnable = true