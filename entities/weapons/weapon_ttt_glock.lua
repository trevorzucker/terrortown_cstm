AddCSLuaFile()

SWEP.HoldType              = "pistol"

if CLIENT then
   SWEP.PrintName          = "Glock"
   SWEP.Slot               = 1

   SWEP.ViewModelFlip      = false
   SWEP.ViewModelFOV       = 54

   SWEP.Icon               = "vgui/ttt/icon_glock"
   SWEP.IconLetter         = "c"
end

SWEP.Base                  = "weapon_tttbase"

SWEP.Primary.Recoil        = 0.9
SWEP.Primary.Damage        = 12
SWEP.Primary.Delay         = 0.10
SWEP.Primary.Cone          = 0.028
SWEP.Primary.ClipSize      = 20
SWEP.Primary.Automatic     = true
SWEP.Primary.DefaultClip   = 20
SWEP.Primary.ClipMax       = 60
SWEP.Primary.Ammo          = "Pistol"
SWEP.Primary.Sound         = Sound( "Weapon_Glock.Single" )
SWEP.Primary.UnsilencedSound         = SWEP.Primary.Sound;
SWEP.Primary.SilencedSound         = "weapons/sil04.wav";

SWEP.AutoSpawnable         = true

SWEP.AmmoEnt               = "item_ammo_pistol_ttt"
SWEP.Kind                  = WEAPON_PISTOL
SWEP.WeaponID              = AMMO_GLOCK

SWEP.HeadshotMultiplier    = 1.75

SWEP.UseHands              = true
SWEP.ViewModel             = "models/weapons/cstrike/c_pist_glock18.mdl"
SWEP.WorldModel            = "models/weapons/w_pist_glock18.mdl"

SWEP.IronSightsPos         = Vector( -5.755, -3.9982, 2.8289 )

SWEP.CustomizeData = {pos = Vector(12, -10, -3), ang = Angle(0, 15, 50)}

SWEP.CustomizePos = {["Sight"] = Vector(6.5, -1, 0), ["Muzzle"] = Vector(-14, -5, 0), ["Magazine"] = Vector(5, 6, 0)};

SWEP.IronSightData = {
	["Pistol Red Dot"] = {pos = Vector(0.061, 0, -0.26), ang = Vector(0, 0, 0)},
};

function SWEP:AttachmentRegister()
	self:RegisterAttachment("Pistol Red Dot", "v_weapon.Glock_Slide", Vector(-0.4, 0, -0.1), Angle(0, 0, -103), Vector(0.5, 0.5, 0.5), "",
		"ValveBiped.Bip01_R_Hand", Vector(2.118, 1.368, -4.02), Angle(180, 175, 0), Vector(0.5, 0.5, 0.5), "");

	self:RegisterAttachment("Pistol Suppressor", "v_weapon.Glock_Parent", Vector(-7.2, -5.2, 0.85), Angle(177, -15, -0), Vector(0.5, 0.5, 0.5), "",
		"ValveBiped.Bip01_R_Hand", Vector(13.168, 2.313, -3.961), Angle(180, 175, 0), Vector(0.5, 0.5, 0.5), "");

	self:RegisterAttachment("Extended Magazine", "v_weapon.Glock_Parent", Vector(0, 0, 0), Angle(0, 180, 0), Vector(0, 0, 0), "",
		"ValveBiped.Bip01_R_Hand", Vector(0, 0, 0), Angle(0, 0, 0), Vector(0.5, 0.5, 0.5), "");
end