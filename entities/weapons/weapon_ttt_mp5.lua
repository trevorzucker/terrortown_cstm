AddCSLuaFile()

SWEP.HoldType              = "ar2"

if CLIENT then
   SWEP.PrintName          = "MP5"
   SWEP.Slot               = 2

   SWEP.ViewModelFlip      = false
   SWEP.ViewModelFOV       = 64

   SWEP.Icon               = "vgui/ttt/icon_mp5"
   SWEP.IconLetter         = "w"
end

SWEP.Base                  = "weapon_tttbase"

SWEP.Kind                  = WEAPON_HEAVY
SWEP.WeaponID              = AMMO_MAC10

SWEP.Primary.Delay         = 0.08
SWEP.Primary.Recoil        = 1
SWEP.Primary.Automatic     = true
SWEP.Primary.Ammo          = "smg1"
SWEP.Primary.Damage        = 18
SWEP.Primary.Cone          = 0.03
SWEP.Primary.ClipSize      = 30
SWEP.Primary.ClipMax       = 90
SWEP.Primary.DefaultClip   = 30
SWEP.Primary.Sound         = Sound( "Weapon_MP5Navy.Single" )
SWEP.Primary.UnsilencedSound         = SWEP.Primary.Sound;
SWEP.Primary.SilencedSound         = "weapons/sil04.wav";

SWEP.AutoSpawnable         = true
SWEP.Spawnable             = true
SWEP.AmmoEnt               = "item_ammo_smg1_ttt"

SWEP.UseHands              = true
SWEP.ViewModel             = "models/weapons/cstrike/c_smg_mp5.mdl"
SWEP.WorldModel            = "models/weapons/w_smg_mp5.mdl"

SWEP.IronSightsPos         = Vector(-5.303, -10, 1.9)
SWEP.IronSightsAng         = Vector(1, 0, 0)

SWEP.CustomizeData = {pos = Vector(4, -10, -1.2), ang = Angle(0, 15, 50)}

SWEP.CustomizePos = {["Scope"] = Vector(-1, -5, 0), ["Muzzle"] = Vector(-8.5, -9.5, 0), ["Magazine"] = Vector(-7, 1, 0)};

SWEP.IronSightData = {
	["HD-33"] = {pos = Vector(0, 3, 0.3), ang = Vector(-3, 0, 0)},
	["RDS"] = {pos = Vector(-0.015, 3, 0.33), ang = Vector(-3, 0, 0)},
	["EOTech"] = {pos = Vector(0, 3, 0.75), ang = Vector(-4, 0, 0)},
	["Micro Red Dot"] = {pos = Vector(-0.015, 3, 0.53), ang = Vector(-3, 0, 0)},
};

function SWEP:AttachmentRegister()
	self:RegisterAttachment("Micro Red Dot", "v_weapon.mp5_Parent", Vector(0, 0, 0), Angle(0, 180, 0), Vector(0.5, 0.5, 0.5), "Rail",
		"ValveBiped.Bip01_R_Hand", Vector(1.348, 0, 0), Angle(0, 180, 0), Vector(0.5, 0.5, 0.5), "Rail");

	self:RegisterAttachment("HD-33", "v_weapon.mp5_Parent", Vector(-1.5, 0, 0), Angle(0, 180, 0), Vector(0.5, 0.5, 0.5), "Rail",
		"ValveBiped.Bip01_R_Hand", Vector(1.348, 0, 0), Angle(0, 180, 0), Vector(0.5, 0.5, 0.5), "Rail");

	self:RegisterAttachment("EOTech", "v_weapon.mp5_Parent", Vector(-0.5, 0, 0), Angle(0, 0, 0), Vector(0.5, 0.5, 0.5), "Rail",
		"ValveBiped.Bip01_R_Hand", Vector(-0.4, 0, 0), Angle(0, 180, 0), Vector(0.5, 0.5, 0.5), "Rail");

	self:RegisterAttachment("RDS", "v_weapon.mp5_Parent", Vector(-0.5, 0, 0), Angle(0, 180, 0), Vector(0.5, 0.5, 0.5), "Rail",
		"ValveBiped.Bip01_R_Hand", Vector(1.348, 0, 0), Angle(0, 180, 0), Vector(0.5, 0.5, 0.5), "Rail");

	self:RegisterAttachment("SMG Suppressor", "v_weapon.mp5_Parent", Vector(-0.02, -4, -21), Angle(180 + 88.2, 0, 0), Vector(0.5, 0.5, 0.5), "",
		"ValveBiped.Bip01_R_Hand", Vector(28, 1.35, -10), Angle(-10, 0, 0), Vector(0.5, 0.5, 0.5), "");

	self:RegisterAttachment("Extended Magazine", "v_weapon.mp5_Parent", Vector(0, 0, 0), Angle(0, 180, 0), Vector(0, 0, 0), "",
		"ValveBiped.Bip01_R_Hand", Vector(0, 0, 0), Angle(0, 0, 0), Vector(0.5, 0.5, 0.5), "");
end

SWEP.VElements = {
	["Rail"] = { type = "Model", model = "models/robotnik_attachments/robotnik_basicrail.mdl", bone = "v_weapon.mp5_Parent", rel = "", pos = Vector(0.18, -5.6, -1.923), angle = Angle(-90, 0, -90), size = Vector(0.5, 0.45, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
}

SWEP.WElements = {
	["Rail"] = { type = "Model", model = "models/robotnik_attachments/robotnik_basicrail.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3, 0.698, -7.551), angle = Angle(170, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
}