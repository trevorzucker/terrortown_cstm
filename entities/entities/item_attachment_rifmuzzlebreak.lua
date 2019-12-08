AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_attachment"
ENT.AttachmentName = "Rifle Muzzle Brake";
ENT.Description = "Reduces recoil by half";
ENT.Model = Model("models/robotnik_attachments/robotnik_muzzlebreak.mdl")
ENT.Image            = "entities/muzzlebreak.png";
ENT.Group            = "Muzzle";
ENT.Magnification    = 0;

ENT.EquipFnc         = function(wep)
	wep:BroadcastClientsideVar("wep.Primary.Recoil", wep.Primary.Recoil / 2, "Float");
end;

ENT.DequipFnc        = function(wep)
	wep:BroadcastClientsideVar("wep.Primary.Recoil", wep.Primary.Recoil, "Float");
end;

ENT.AutoSpawnable = true