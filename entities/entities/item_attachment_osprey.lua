AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_attachment"
ENT.AttachmentName = "Shotgun Suppressor";
ENT.Weight		= 0.125;
ENT.Description = "Enables you to silently kill your target";
ENT.Model = Model("models/robotnik_attachments/robotnik_ospreysil.mdl")
ENT.Image            = "entities/osprey.png";
ENT.Group            = "Muzzle";
ENT.Magnification    = 0;

ENT.EquipFnc         = function(wep)
	wep.Primary.Sound = wep.Primary.SilencedSound;
	wep.IsSilent = true;
	wep.Primary.FireSoundLevel = 65;
	wep:BroadcastClientsideVar("wep.Primary.Sound", wep.Primary.SilencedSound, "String");
end;

ENT.DequipFnc        = function(wep)
	wep.Primary.Sound = wep.Primary.UnsilencedSound;
	wep.IsSilent = false;
	wep.Primary.FireSoundLevel = 75;
	wep:BroadcastClientsideVar("wep.Primary.Sound", wep.Primary.UnsilencedSound, "String");
end;

ENT.AutoSpawnable = true