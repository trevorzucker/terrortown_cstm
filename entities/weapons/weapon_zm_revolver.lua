AddCSLuaFile()

SWEP.HoldType              = "pistol"

if CLIENT then
   SWEP.PrintName          = "Deagle"
   SWEP.Slot               = 1

   SWEP.ViewModelFlip      = false
   SWEP.ViewModelFOV       = 54

   SWEP.Icon               = "vgui/ttt/icon_deagle"
end

SWEP.Base                  = "weapon_tttbase"

SWEP.Kind                  = WEAPON_PISTOL
SWEP.WeaponID              = AMMO_DEAGLE

SWEP.Primary.Ammo          = "AlyxGun" -- hijack an ammo type we don't use otherwise
SWEP.Primary.Recoil        = 3
SWEP.Primary.Damage        = 37
SWEP.Primary.Delay         = 0.3
SWEP.Primary.Cone          = 0.02
SWEP.Primary.ClipSize      = 7
SWEP.Primary.ClipMax       = 36
SWEP.Primary.DefaultClip   = 7
SWEP.Primary.Automatic     = false
SWEP.Primary.Sound         = Sound( "Weapon_Deagle.Single" )
SWEP.Primary.UnsilencedSound         = SWEP.Primary.Sound;
SWEP.Primary.SilencedSound         = "weapons/sil02.wav";

SWEP.HeadshotMultiplier    = 4

SWEP.AutoSpawnable         = true
SWEP.Spawnable             = true
SWEP.AmmoEnt               = "item_ammo_revolver_ttt"

SWEP.UseHands              = true
SWEP.ViewModel             = "models/weapons/cstrike/c_pist_deagle.mdl"
SWEP.WorldModel            = "models/weapons/w_pist_deagle.mdl"

SWEP.IronSightsPos         = Vector(-6.361, -3.701, 2.15)
SWEP.IronSightsAng         = Vector(0, 0, 0)

SWEP.CustomizeData = {pos = Vector(12, -10, -3), ang = Angle(0, 15, 50)}

SWEP.CustomizePos = {["Sight"] = Vector(10, -2, 0), ["Muzzle"] = Vector(-10.9, -7, 0), ["Magazine"] = Vector(9, 15, 0)};

SWEP.IronSightData = {
	["Pistol Red Dot"] = {pos = Vector(0.07, -3, -0.45), ang = Vector(0, 0, 0)},
};

function SWEP:AttachmentRegister()
	self:RegisterAttachment("Pistol Red Dot", "v_weapon.Deagle_Slide", Vector(0, -0.6, 1), Angle(-90, 90, 0), Vector(0.5, 0.5, 0.5), "",
		"ValveBiped.Bip01_R_Hand",  Vector(3.536, 1.496, -4.423), Angle(179.134, 175.395, 0), Vector(0.5, 0.5, 0.5), "");

	self:RegisterAttachment("Pistol Suppressor", "v_weapon.Deagle_Parent", Vector(0, -4, -11), Angle(-90, 0, 0), Vector(0.5, 0.5, 0.5), "",
		"ValveBiped.Bip01_R_Hand", Vector(15.96, 2.516, -4.386), Angle(0, -4.901, 0), Vector(0.5, 0.5, 0.5), "");

	self:RegisterAttachment("Extended Magazine", "v_weapon.Deagle_Parent", Vector(0, 0, 0), Angle(0, 180, 0), Vector(0, 0, 0), "",
		"ValveBiped.Bip01_R_Hand", Vector(0, 0, 0), Angle(0, 0, 0), Vector(0.5, 0.5, 0.5), "");
end