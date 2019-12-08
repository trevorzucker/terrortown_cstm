AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_attachment"
ENT.AttachmentName = "Ballistic Scope";
ENT.Description = "Enhanced optic with 12x magnification";
ENT.Model = Model("models/robotnik_attachments/robotnik_ballistic.mdl")
ENT.Image            = "entities/bf4_ballistic.png";
ENT.Group            = "Sight";
ENT.Magnification    = 12;
ENT.Weight           = 0.5;
ENT.ScopeRadius = 9;
ENT.ScopeOffset = Vector(512, -128, 0);

ENT.EquipFnc         = function(wep, self)
	wep:BroadcastClientsideVar("wep.IronSightsPosAdd", wep.IronSightData[self.AttachmentName].pos, "Vector");
	wep:BroadcastClientsideVar("wep.IronSightsAngAdd", wep.IronSightData[self.AttachmentName].ang, "Vector");
end;

ENT.DequipFnc        = function(wep, self)
	wep:BroadcastClientsideVar("wep.IronSightsPosAdd", Vector(0, 0, 0), "Vector");
	wep:BroadcastClientsideVar("wep.IronSightsAngAdd", Vector(0, 0, 0), "Vector");
end;

ENT.AutoSpawnable = true