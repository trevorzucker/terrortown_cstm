AddCSLuaFile()

SWEP.HoldType              = "ar2"

if CLIENT then
   SWEP.PrintName          = "P90"
   SWEP.Slot               = 2

   SWEP.ViewModelFlip      = false
   SWEP.ViewModelFOV       = 64

   SWEP.Icon               = "vgui/ttt/icon_p90"
   SWEP.IconLetter         = "w"
end

SWEP.Base                  = "weapon_tttbase"

SWEP.Kind                  = WEAPON_HEAVY
SWEP.WeaponID              = AMMO_MAC10

SWEP.Primary.Delay         = 0.07
SWEP.Primary.DefaultDelay  = 0.07
SWEP.Primary.Recoil        = 1
SWEP.Primary.Automatic     = true
SWEP.Primary.Ammo          = "smg1"
SWEP.Primary.Damage        = 9
SWEP.Primary.Cone          = 0.03
SWEP.Primary.ClipSize      = 50
SWEP.Primary.ClipMax       = 150
SWEP.Primary.DefaultClip   = 50
SWEP.Primary.Sound         = Sound( "Weapon_P90.Single" )
SWEP.Primary.UnsilencedSound         = SWEP.Primary.Sound;
SWEP.Primary.SilencedSound         = Sound( "Weapon_USP.SilencedShot" );

SWEP.AutoSpawnable         = true
SWEP.Spawnable             = true
SWEP.AmmoEnt               = "item_ammo_smg1_ttt"

SWEP.UseHands              = true
SWEP.ViewModel             = "models/weapons/cstrike/c_smg_p90.mdl"
SWEP.WorldModel            = "models/weapons/w_smg_p90.mdl"

SWEP.IronSightsPos         = Vector(-3, -10, 1.9)
SWEP.IronSightsAng         = Vector(1, 0, 0)

SWEP.CrosshairDisappears = false;

SWEP.CustomizeData = {pos = Vector(6, -9 -1.2), ang = Angle(0, 15, 50)}

SWEP.CustomizePos = {["Muzzle"] = Vector(-8.5, -7.5, 0), ["Magazine"] = Vector(5, -2, 0)};

function SWEP:AttachmentRegister()

	self:RegisterAttachment("SMG Suppressor", "v_weapon.p90_Parent", Vector(-0.02, -4, -12), Angle(180 + 88.2, 0, 0), Vector(0.5, 0.5, 0.5), "",
		"ValveBiped.Bip01_R_Hand", Vector(21, 1.6, -7), Angle(-10, 0, 0), Vector(0.5, 0.5, 0.5), "");

	self:RegisterAttachment("Rapid-Fire Magazine", "v_weapon.p90_Parent", Vector(0, 0, 0), Angle(0, 180, 0), Vector(0, 0, 0), "",
		"ValveBiped.Bip01_R_Hand", Vector(0, 0, 0), Angle(0, 0, 0), Vector(0.5, 0.5, 0.5), "");

	--[[self:RegisterAttachment("Explosive Rounds", "v_weapon.p90_Parent", Vector(0, 0, 0), Angle(0, 180, 0), Vector(0, 0, 0), "",
		"ValveBiped.Bip01_R_Hand", Vector(0, 0, 0), Angle(0, 0, 0), Vector(0.5, 0.5, 0.5), "");]]--
end