AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_attachment"
ENT.AttachmentName = "EOTech";
ENT.Description = "Standard optic sight with custom reticle";
ENT.Model = Model("models/robotnik_attachments/robotnik_eotech.mdl")
ENT.Image            = "entities/bf4_eotech.png";
ENT.Group            = "Scope";
ENT.Magnification    = 1;

ENT.EquipFnc         = function(wep, self)
	wep:BroadcastClientsideVar("wep.IronSightsPosAdd", wep.IronSightData[self.AttachmentName].pos, "Vector");
	wep:BroadcastClientsideVar("wep.IronSightsAngAdd", wep.IronSightData[self.AttachmentName].ang, "Vector");
end;

ENT.DequipFnc        = function(wep, self)
	wep:BroadcastClientsideVar("wep.IronSightsPosAdd", Vector(0, 0, 0), "Vector");
	wep:BroadcastClientsideVar("wep.IronSightsAngAdd", Vector(0, 0, 0), "Vector");
end;

ENT.AutoSpawnable = true