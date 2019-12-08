AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_attachment"
ENT.AttachmentName = "Explosive Rounds";
ENT.Description = "Bullets explode on impact";
ENT.Weight		= 0;
ENT.Model = Model("models/weapons/w_defuser.mdl")
ENT.HideModel = true;
ENT.Image            = "vgui/gfx/vgui/cartridge";
ENT.Group            = "Magazine";
ENT.Magnification    = 0;

ENT.EquipFnc         = function(wep) end;
ENT.DequipFnc        = function(wep) end;
ENT.ShootBullet		 = function(wep, pos)
	local explode = ents.Create( "env_explosion" )
	explode:SetPos( pos )
	explode:SetOwner( wep.Owner )
	explode:Spawn()
	explode:SetKeyValue( "iMagnitude", "20" )
	explode:Fire( "Explode", 0, 0 )
	--explode:EmitSound( "weapon_AWP.Single", 400, 400 )
end;

ENT.AutoSpawnable = false