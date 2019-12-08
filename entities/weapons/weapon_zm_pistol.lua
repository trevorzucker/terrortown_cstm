AddCSLuaFile()

SWEP.HoldType              = "pistol"

if CLIENT then
   SWEP.PrintName          = "pistol_name"
   SWEP.Slot               = 1

   SWEP.ViewModelFlip      = false
   SWEP.ViewModelFOV       = 54

   SWEP.Icon               = "vgui/ttt/icon_pistol"
   SWEP.IconLetter         = "u"
end

SWEP.Base                  = "weapon_tttbase"

SWEP.Kind                  = WEAPON_PISTOL
SWEP.WeaponID              = AMMO_PISTOL

SWEP.Primary.Recoil        = 1.5
SWEP.Primary.Damage        = 25
SWEP.Primary.Delay         = 0.28
SWEP.Primary.Cone          = 0.02
SWEP.Primary.ClipSize      = 20
SWEP.Primary.Automatic     = false
SWEP.Primary.DefaultClip   = 20
SWEP.Primary.ClipMax       = 60
SWEP.Primary.Ammo          = "Pistol"
SWEP.Primary.Sound         = Sound( "Weapon_FiveSeven.Single" )
SWEP.Primary.UnsilencedSound         = SWEP.Primary.Sound;
SWEP.Primary.SilencedSound         = "weapons/sil04.wav";

SWEP.AutoSpawnable         = true
SWEP.AmmoEnt               = "item_ammo_pistol_ttt"

SWEP.UseHands              = true
SWEP.ViewModel             = "models/weapons/cstrike/c_pist_fiveseven.mdl"
SWEP.WorldModel            = "models/weapons/w_pist_fiveseven.mdl"

SWEP.IronSightsPos         = Vector(-5.95, -4, 2.799)
SWEP.IronSightsAng         = Vector(0, 0, 0)

SWEP.CustomizeData = {pos = Vector(10, -10, -3), ang = Angle(0, 15, 50)}

SWEP.CustomizePos = {["Sight"] = Vector(6, 0, 0), ["Muzzle"] = Vector(-10.6, -6.75, 0), ["Magazine"] = Vector(1, 9, 0)};

SWEP.IronSightData = {
	["Pistol Red Dot"] = {pos = Vector(0.05, 0, -0.84), ang = Vector(0, 0, 0)},
};

function SWEP:AttachmentRegister()
	self:RegisterAttachment("Pistol Red Dot", "v_weapon.FIVESEVEN_SLIDE", Vector(-0.403, 0, 0), Angle(0, 0, 0), Vector(0.5, 0.5, 0.5), "Rail",
		"ValveBiped.Bip01_R_Hand", Vector(0.497, 0, -0), Angle(0, 180, 0), Vector(0.5, 0.5, 0.5), "Rail");

	self:RegisterAttachment("Pistol Suppressor", "v_weapon.FIVESEVEN_PARENT", Vector(0, -3, -12.2), Angle(-90, 0, 0), Vector(0.5, 0.5, 0.5), "",
		"ValveBiped.Bip01_R_Hand", Vector(13.654, 2.371, -4.025), Angle(-1.295, -4.981, 0), Vector(0.5, 0.5, 0.5), "");

	self:RegisterAttachment("Extended Magazine", "v_weapon.FIVESEVEN_PARENT", Vector(0, 0, 0), Angle(0, 180, 0), Vector(0, 0, 0), "",
		"ValveBiped.Bip01_R_Hand", Vector(0, 0, 0), Angle(0, 0, 0), Vector(0.5, 0.5, 0.5), "");

	self:RegisterAttachment("Snowball Rounds", "v_weapon.FIVESEVEN_PARENT", Vector(0, 0, 0), Angle(0, 180, 0), Vector(0, 0, 0), "",
		"ValveBiped.Bip01_R_Hand", Vector(0, 0, 0), Angle(0, 0, 0), Vector(0.5, 0.5, 0.5), "");
end

SWEP.VElements = {
	["Rail"] = { type = "Model", model = "models/robotnik_attachments/robotnik_basicrail.mdl", bone = "v_weapon.FIVESEVEN_SLIDE", rel = "", pos = Vector(-0.022, 0.03, -0.7), angle = Angle(180, 90, 0), size = Vector(0.2, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
}

SWEP.WElements = {
	["Rail"] = { type = "Model", hide = true, model = "models/robotnik_attachments/robotnik_basicrail.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.042, 1.425, -4.29), angle = Angle(176.96, -5.186, 0), size = Vector(0.2, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}