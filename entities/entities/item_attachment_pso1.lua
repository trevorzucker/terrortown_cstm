AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_attachment"
ENT.AttachmentName = "PSO-1";
ENT.Description = "Enhanced optic for the AK-variants with 4x magnification";
ENT.Model = Model("models/robotnik_attachments/robotnik_pso1.mdl")
ENT.Image            = "entities/pso1side.png";
ENT.Group            = "Scope";
ENT.Magnification    = 4;
ENT.ScopeRadius = 5.4;
ENT.ScopeOffset = Vector(0, 256, 0);

ENT.EquipFnc         = function(wep, self)
	wep:BroadcastClientsideVar("wep.IronSightsPosAdd", wep.IronSightData[self.AttachmentName].pos, "Vector");
	wep:BroadcastClientsideVar("wep.IronSightsAngAdd", wep.IronSightData[self.AttachmentName].ang, "Vector");
end;

ENT.DequipFnc        = function(wep, self)
	wep:BroadcastClientsideVar("wep.IronSightsPosAdd", Vector(0, 0, 0), "Vector");
	wep:BroadcastClientsideVar("wep.IronSightsAngAdd", Vector(0, 0, 0), "Vector");
end;

ENT.AutoSpawnable = true