AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_attachment"
ENT.AttachmentName = "Shotgun Choke";
ENT.Weight		= 0.25;
ENT.Description = "Increases range";
ENT.Model = Model("models/robotnik_attachments/robotnik_muzzlebreak.mdl")
ENT.Image            = "entities/muzzlebreak.png";
ENT.Group            = "Muzzle";
ENT.Magnification    = 0;

ENT.EquipFnc         = function(wep)
	wep.Primary.Cone = wep.Primary.ReducedCone;
	wep:BroadcastClientsideVar("wep.Primary.Cone", wep.Primary.ReducedCone, "Float");
end;

ENT.DequipFnc        = function(wep)
	wep.Primary.Cone = wep.Primary.DefaultCone;
	wep:BroadcastClientsideVar("wep.Primary.Cone", wep.Primary.DefaultCone, "Float");
end;

ENT.AutoSpawnable = true