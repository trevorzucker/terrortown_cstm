AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_attachment"
ENT.AttachmentName = "Pistol Muzzle Brake";
ENT.Description = "Reduces recoil by half";
ENT.Model = Model("models/robotnik_attachments/robotnik_muzzlebreakpist.mdl")
ENT.Image            = "entities/muzzlebreakpist.png";
ENT.Group            = "Muzzle";
ENT.Magnification    = 0;

ENT.EquipFnc         = function(wep)
	wep.Primary.Recoil = wep.Primary.Recoil / 2;
end;

ENT.DequipFnc        = function(wep)
	wep.Primary.Recoil = wep.Primary.Recoil * 2;
end;

ENT.AutoSpawnable = true