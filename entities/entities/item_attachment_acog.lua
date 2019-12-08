AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_attachment"
ENT.AttachmentName = "ACOG";
ENT.Description = "Enhanced optic with 4x magnification";
ENT.Model = Model("models/robotnik_attachments/robotnik_acog.mdl")
ENT.Image            = "entities/bf4_acog.png";
ENT.Group            = "Scope";
ENT.Magnification    = 4;
ENT.ScopeRadius = 8;
ENT.ScopeOffset = Vector(92, 256, 0);

ENT.EquipFnc         = function(wep, self)
	wep:BroadcastClientsideVar("wep.IronSightsPosAdd", wep.IronSightData[self.AttachmentName].pos, "Vector");
	wep:BroadcastClientsideVar("wep.IronSightsAngAdd", wep.IronSightData[self.AttachmentName].ang, "Vector");
end;

ENT.DequipFnc        = function(wep, self)
	wep:BroadcastClientsideVar("wep.IronSightsPosAdd", Vector(0, 0, 0), "Vector");
	wep:BroadcastClientsideVar("wep.IronSightsAngAdd", Vector(0, 0, 0), "Vector");
end;

ENT.AutoSpawnable = true