AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_attachment"
ENT.AttachmentName = "JGM-4";
ENT.Description = "Enhanced red dot with 4x magnification";
ENT.Model = Model("models/robotnik_attachments/robotnik_jgm4.mdl")
ENT.Image            = "entities/bf4_jgm4.png";
ENT.Group            = "Scope";
ENT.Magnification    = 4;
ENT.ScopeRadius = 8;
ENT.ScopeOffset = Vector(128, 256, 0);

ENT.EquipFnc         = function(wep, self)
	wep:BroadcastClientsideVar("wep.IronSightsPosAdd", wep.IronSightData[self.AttachmentName].pos, "Vector");
	wep:BroadcastClientsideVar("wep.IronSightsAngAdd", wep.IronSightData[self.AttachmentName].ang, "Vector");
end;

ENT.DequipFnc        = function(wep, self)
	wep:BroadcastClientsideVar("wep.IronSightsPosAdd", Vector(0, 0, 0), "Vector");
	wep:BroadcastClientsideVar("wep.IronSightsAngAdd", Vector(0, 0, 0), "Vector");
end;

ENT.AutoSpawnable = true