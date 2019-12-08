AddCSLuaFile()

SWEP.HoldType              = "pistol"

if CLIENT then
   SWEP.PrintName          = "P228"
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
SWEP.Primary.Damage        = 16
SWEP.Primary.Delay         = 0.16
SWEP.Primary.Cone          = 0.02
SWEP.Primary.ClipSize      = 20
SWEP.Primary.Automatic     = false
SWEP.Primary.DefaultClip   = 20
SWEP.Primary.ClipMax       = 60
SWEP.Primary.Ammo          = "Pistol"
SWEP.Primary.Sound         = Sound( "Weapon_P228.Single" )
SWEP.Primary.UnsilencedSound         = SWEP.Primary.Sound;
SWEP.Primary.SilencedSound         = Sound( "Weapon_USP.SilencedShot" );

SWEP.AutoSpawnable         = true
SWEP.AmmoEnt               = "item_ammo_pistol_ttt"

SWEP.UseHands              = true
SWEP.ViewModel             = "models/weapons/cstrike/c_pist_p228.mdl"
SWEP.WorldModel            = "models/weapons/w_pist_p228.mdl"

SWEP.IronSightsPos         = Vector(-5.985, -4, 2.77)
SWEP.IronSightsAng         = Vector(0, -0.1, 0)

--SWEP.IronSightsPosAdd      = Vector(-0.115, -2, -0.65);
--SWEP.IronSightsAngAdd      = Vector(0, 0, 0);

SWEP.CustomizeData = {pos = Vector(12, -10, -3), ang = Angle(0, 15, 50)}

SWEP.CustomizePos = {["Sight"] = Vector(16, 0, 0), ["Muzzle"] = Vector(-8.5, -6.5, 0), ["Magazine"] = Vector(7, 5, 0)};

SWEP.IronSightData = {
	["Pistol Red Dot"] = {pos = Vector(-0, -2, -0.65), ang = Vector(0, 0, 0)},
};

function SWEP:AttachmentRegister()
	self:RegisterAttachment("Pistol Red Dot", "v_weapon.p228_Slide", Vector(0.085, -0.4, 0.5), Angle(-90, 0, -90), Vector(0.5, 0.5, 0.5), "",
		"ValveBiped.Bip01_R_Hand", Vector(2.6, 1.5, -4), Angle(0, 0, 180), Vector(0.5, 0.5, 0.5), "");

	self:RegisterAttachment("Pistol Suppressor", "v_weapon.p228_Parent", Vector(0.037, -3.8, -8), Angle(-90, 90, 0), Vector(0.5, 0.5, 0.5), "",
		"ValveBiped.Bip01_R_Hand", Vector(12.746, 2.418, -4.24), Angle(-178.446, 175.152, 0), Vector(0.5, 0.5, 0.5), "");

	self:RegisterAttachment("Extended Magazine", "v_weapon.p228_Parent", Vector(0, 0, 0), Angle(0, 180, 0), Vector(0, 0, 0), "",
		"ValveBiped.Bip01_R_Hand", Vector(0, 0, 0), Angle(0, 0, 0), Vector(0.5, 0.5, 0.5), "");
end