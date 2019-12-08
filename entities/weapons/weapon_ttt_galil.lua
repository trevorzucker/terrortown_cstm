AddCSLuaFile()

SWEP.HoldType              = "ar2"

if CLIENT then
   SWEP.PrintName          = "Galil"
   SWEP.Slot               = 2

   SWEP.ViewModelFlip      = false
   SWEP.ViewModelFOV       = 64

   SWEP.Icon               = "vgui/ttt/icon_galil"
   SWEP.IconLetter         = "w"
end

SWEP.Base                  = "weapon_tttbase"

SWEP.Kind                  = WEAPON_HEAVY
SWEP.WeaponID              = AMMO_M16

SWEP.Primary.Delay         = 0.08
SWEP.Primary.Recoil        = 1.6
SWEP.Primary.Automatic     = true
SWEP.Primary.Ammo          = "Pistol"
SWEP.Primary.Damage        = 12
SWEP.Primary.Cone          = 0.018
SWEP.Primary.ClipSize      = 35
SWEP.Primary.ClipMax       = 105
SWEP.Primary.DefaultClip   = 35
SWEP.Primary.Sound         = Sound( "Weapon_Galil.Single" )
SWEP.Primary.UnsilencedSound         = SWEP.Primary.Sound;
SWEP.Primary.SilencedSound         = "weapons/sil05.wav";

SWEP.AutoSpawnable         = true
SWEP.Spawnable             = true
SWEP.AmmoEnt               = "item_ammo_pistol_ttt"

SWEP.UseHands              = true
SWEP.ViewModel             = "models/weapons/cstrike/c_rif_galil.mdl"
SWEP.WorldModel            = "models/weapons/w_rif_galil.mdl"

SWEP.IronSightsPos         = Vector(-6.355, -10, 2.695)
SWEP.IronSightsAng         = Vector(-0.2, 0, 0)

SWEP.CustomizeData = {pos = Vector(8, -10, -2), ang = Angle(0, 15, 50)}

SWEP.CustomizePos = {["Scope"] = Vector(0, 0, 0), ["Muzzle"] = Vector(13.2, -6.2, 0), ["Magazine"] = Vector(8, 3, 0)};

SWEP.IronSightData = {
	["Kobra"] = {pos = Vector(0, 0, -1.45), ang = Vector(0, 0, 0)},
	["PSO-1"] = {pos = Vector(-0.03, -2, -0.82), ang = Vector(-2.5, 0, 0)}
};

function SWEP:AttachmentRegister()
	self:RegisterAttachment("Kobra", "v_weapon.galil", Vector(0, 0.602, 1.131), Angle(0, 0, 0), Vector(0.5, 0.5, 0.5), "Rail",
		"ValveBiped.Bip01_R_Hand", Vector(-0, 0.583, 1.078), Angle(0, 0, 0), Vector(0.5, 0.5, 0.5), "Rail");

	self:RegisterAttachment("PSO-1", "v_weapon.galil", Vector(0, 0.602, 1.131), Angle(0, 0, 0), Vector(0.5, 0.5, 0.5), "Rail",
		"ValveBiped.Bip01_R_Hand", Vector(0.986, 0.541, 1.156), Angle(0, 0, 0), Vector(0.5, 0.5, 0.5), "Rail");

	self:RegisterAttachment("PBS-4", "v_weapon.galil", Vector(0.101, -0.091, 32.257), Angle(-90, 0, 0), Vector(0.5, 0.5, 0.5), "",
		"ValveBiped.Bip01_R_Hand", Vector(34.25, 0.991, -8.959), Angle(173.24, 0, 0), Vector(0.5, 0.5, 0.5), "");

	self:RegisterAttachment("Extended Magazine", "v_weapon.galil", Vector(0, 0, 0), Angle(0, 180, 0), Vector(0, 0, 0), "",
		"ValveBiped.Bip01_R_Hand", Vector(0, 0, 0), Angle(0, 0, 0), Vector(0.5, 0.5, 0.5), "");
end

SWEP.VElements = {
	["Rail"] = { type = "Model", model = "models/robotnik_attachments/robotnik_russianrail.mdl", bone = "v_weapon.galil", rel = "", pos = Vector(0.617, -1.7, 1.25), angle = Angle(90, -90, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
}

SWEP.WElements = {
	["Rail"] = { type = "Model", hide = true, model = "models/robotnik_attachments/robotnik_russianrail.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.197, 1.521, -5.604), angle = Angle(-9.372, 0, 180), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
}