AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_attachment"
ENT.AttachmentName = "Elcan";
ENT.Description = "Enhanced optic with 6x magnification";
ENT.Model = Model("models/robotnik_attachments/robotnik_elcan.mdl")
ENT.Image            = "entities/bfh_elcan.png";
ENT.Group            = "Scope";
ENT.Magnification    = 6;
ENT.ScopeRadius = 10;
ENT.ScopeOffset = Vector(128, -512, 0);

ENT.EquipFnc         = function(wep, self)
	wep:BroadcastClientsideVar("wep.IronSightsPosAdd", wep.IronSightData[self.AttachmentName].pos, "Vector");
	wep:BroadcastClientsideVar("wep.IronSightsAngAdd", wep.IronSightData[self.AttachmentName].ang, "Vector");
end;

ENT.DequipFnc        = function(wep, self)
	wep:BroadcastClientsideVar("wep.IronSightsPosAdd", Vector(0, 0, 0), "Vector");
	wep:BroadcastClientsideVar("wep.IronSightsAngAdd", Vector(0, 0, 0), "Vector");
end;

ENT.AutoSpawnable = true