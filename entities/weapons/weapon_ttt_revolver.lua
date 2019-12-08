AddCSLuaFile()

SWEP.HoldType              = "pistol"

if CLIENT then
   SWEP.PrintName          = "Revolver"
   SWEP.Slot               = 1

   SWEP.ViewModelFlip      = false
   SWEP.ViewModelFOV       = 64

   SWEP.Icon               = "vgui/ttt/icon_revolver"
end

SWEP.Base                  = "weapon_tttbase"

SWEP.Kind                  = WEAPON_PISTOL
SWEP.WeaponID              = AMMO_DEAGLE

SWEP.Primary.Ammo          = "AlyxGun" -- hijack an ammo type we don't use otherwise
SWEP.Primary.Recoil        = 10
SWEP.Primary.Damage        = 64
SWEP.Primary.Delay         = 0.5
SWEP.Primary.Cone          = 0.02
SWEP.Primary.ClipSize      = 6
SWEP.Primary.ClipMax       = 12
SWEP.Primary.DefaultClip   = 6
SWEP.Primary.Automatic     = false
SWEP.Primary.Sound         = "weapons/revolver/revolver-1.wav"
SWEP.Primary.UnsilencedSound         = SWEP.Primary.Sound;
SWEP.Primary.SilencedSound         = "weapons/sil01.wav";

SWEP.HeadshotMultiplier    = 4

SWEP.AutoSpawnable         = true
SWEP.Spawnable             = true
SWEP.AmmoEnt               = "item_ammo_revolver_ttt"

SWEP.UseHands              = true
SWEP.ViewModel             = "models/weapons/v_pist_revolver.mdl"
SWEP.WorldModel            = "models/weapons/w_357.mdl"

SWEP.IronSightsPos         = Vector(-1.64, -1, 0.7)
SWEP.IronSightsAng         = Vector(0, 0, 0)

SWEP.CustomizeData = {pos = Vector(7, -5, -1), ang = Angle(0, 10, 50)}

SWEP.CustomizePos = {["Sight"] = Vector(-15, 6, 0), ["Muzzle"] = Vector(-1, 15, 0), ["Magazine"] = Vector(-1, 3, 0)};

SWEP.IronSightData = {
	["Pistol Red Dot"] = {pos = Vector(0.05, -2, -0.25), ang = Vector(0, 0, 0)},
	["Ballistic Scope"] = {pos = Vector(0.05, -3, -0.5), ang = Vector(0, 0, 0)},
};

function SWEP:AttachmentRegister()
	self:RegisterAttachment("Pistol Red Dot", "357", Vector(0, 0.45, 1.5), Angle(0, -90, 0), Vector(0.3, 0.3, 0.3), "",
		"ValveBiped.Bip01_R_Hand", Vector(6, 0.9, -4.9), Angle(184, 180, 0), Vector(0.5, 0.5, 0.5), "");

	self:RegisterAttachment("Ballistic Scope", "357", Vector(0, 1, 1.5), Angle(0, -90, 0), Vector(0.3, 0.3, 0.3), "",
		"ValveBiped.Bip01_R_Hand", Vector(6, 0.9, -4.9), Angle(184, 180, 0), Vector(0.5, 0.5, 0.5), "");

	self:RegisterAttachment("Pistol Suppressor", "357", Vector(0, 9.7, 1), Angle(0, -90, 0), Vector(0.5, 0.5, 0.5), "",
		"ValveBiped.Bip01_R_Hand", Vector(18, 0.9, -4.9), Angle(-2, 0, 0), Vector(0.5, 0.5, 0.5), "");

	self:RegisterAttachment("Full Metal Jacket", "357", Vector(0, 0, 0), Angle(0, 180, 0), Vector(0, 0, 0), "",
		"ValveBiped.Bip01_R_Hand", Vector(0, 0, 0), Angle(0, 0, 0), Vector(0.5, 0.5, 0.5), "");
end

SWEP.WElements = {
	--["Test"] = { type = "Model", model = "models/robotnik_attachments/robotnik_delta.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6, 0.9, -4.9), angle = Angle(184, 180, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
}

function SWEP:Initialize()
	self.BaseClass.Initialize(self);
	self:RegisterSound("Deploy", 0.01, "weapons/revolver/deploy.wav");
	self:RegisterSound("Reload", 0.17, "weapons/revolver/chamber_out.wav");
	self:RegisterSound("Reload", 0.5, "weapons/revolver/clip_out.wav");
	self:RegisterSound("Reload", 1.1, "weapons/revolver/clip_in.wav");
	self:RegisterSound("Reload", 1.5, "weapons/revolver/chamber_in.wav");
end