AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_attachment"
ENT.AttachmentName = "Extended Magazine";
ENT.Description = "Doubles magazine capacity";
ENT.Model = Model("models/weapons/w_defuser.mdl")
ENT.HideModel = true;
ENT.Image            = "vgui/gfx/vgui/cartridge";
ENT.Group            = "Magazine";
ENT.Magnification    = 0;

ENT.EquipFnc         = function(wep)
	wep.Primary.ClipSize = wep.Primary.ClipSize * 2;
	wep:BroadcastClientsideVar("wep.Primary.ClipSize", wep.Primary.ClipSize, "Int");
	if (wep.Owner:GetAmmoCount(wep.Primary.Ammo) >= wep.Primary.ClipSize / 2) then
		--wep:SetClip1(wep.Primary.ClipSize);
		--wep.Owner:RemoveAmmo(wep.Primary.ClipSize / 2, wep.Primary.Ammo, true);
		wep.ReloadOnNotCustomizing = true;
	end

end;
ENT.DequipFnc        = function(wep)
	wep.Primary.ClipSize = wep.Primary.ClipSize / 2;
	wep:BroadcastClientsideVar("wep.Primary.ClipSize", wep.Primary.ClipSize, "Int");
	local ammo = math.Clamp(wep:Clip1() - wep.Primary.ClipSize, 0, 1000000);
	wep.Owner:GiveAmmo(ammo, wep.Primary.Ammo, true);
	wep:SetClip1(wep.Primary.ClipSize );
end;

ENT.AutoSpawnable = true