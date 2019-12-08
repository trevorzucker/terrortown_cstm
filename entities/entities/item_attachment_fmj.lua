AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_attachment"
ENT.AttachmentName = "Full Metal Jacket";
ENT.Description = "Increases bullet penetration while also increasing damage";
ENT.Weight		= 0.2;
ENT.Model = Model("models/weapons/w_defuser.mdl")
ENT.HideModel = true;
ENT.Image            = "vgui/gfx/vgui/bullet";
ENT.Group            = "Magazine";
ENT.Magnification    = 0;

ENT.EquipFnc         = function(wep)
	wep.Primary.Damage = wep.Primary.Damage * 1.5;
end;
ENT.DequipFnc        = function(wep)
	wep.Primary.Damage = wep.Primary.Damage / 1.5;
end;

ENT.AutoSpawnable = true