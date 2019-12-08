AddCSLuaFile()

SWEP.HoldType              = "ar2"

if CLIENT then
   SWEP.PrintName          = "Vector"
   SWEP.Slot               = 2

   SWEP.ViewModelFlip      = false
   SWEP.ViewModelFOV       = 64

   SWEP.Icon               = "vgui/ttt/icon_vector"
   SWEP.IconLetter         = "w"
end

SWEP.Base                  = "weapon_tttbase"

SWEP.Kind                  = WEAPON_HEAVY
SWEP.WeaponID              = AMMO_MAC10

SWEP.Primary.Delay         = 0.07
SWEP.Primary.Recoil        = 1
SWEP.Primary.Automatic     = true
SWEP.Primary.Ammo          = "smg1"
SWEP.Primary.Damage        = 13
SWEP.Primary.Cone          = 0.03
SWEP.Primary.ClipSize      = 25
SWEP.Primary.ClipMax       = 75
SWEP.Primary.DefaultClip   = 25
SWEP.Primary.Sound         = "weapons/vector/fire1.wav"
SWEP.Primary.UnsilencedSound         = SWEP.Primary.Sound;
SWEP.Primary.SilencedSound         = "weapons/sil04.wav";

SWEP.AutoSpawnable         = true
SWEP.Spawnable             = true
SWEP.AmmoEnt               = "item_ammo_smg1_ttt"

SWEP.UseHands              = true
SWEP.ViewModel             = "models/weapons/v_smg_vector.mdl"
SWEP.WorldModel            = "models/weapons/w_smg_vector.mdl"

SWEP.IronSightsPos         = Vector(-2.142, -2, 0.3)
SWEP.IronSightsAng         = Vector(0, 0, 2)

SWEP.CrotchGun = true;

SWEP.CustomizeData = {pos = Vector(4, -2, -1.2), ang = Angle(0, 15, 50)}

SWEP.CustomizePos = {["Scope"] = Vector(0, -1, 0), ["Muzzle"] = Vector(5.5, -3, 0), ["Magazine"] = Vector(4, 1, 0)};

SWEP.IronSightData = {
   ["HD-33"] = {pos = Vector(0, -1, -0.76), ang = Vector(0, 0, 0)},
   ["RDS"] = {pos = Vector(0, -1, -0.795), ang = Vector(0, 0, 0)},
   ["EOTech"] = {pos = Vector(0, -1, -0.67), ang = Vector(0, 0, 0)},
   ["Micro Red Dot"] = {pos = Vector(0, -1, -0.7), ang = Vector(0, 0, 0)},
};

function SWEP:AttachmentRegister()
   self:RegisterAttachment("Micro Red Dot", "body", Vector(-2, 0, 0), Angle(0, 180, 0), Vector(0.3, 0.3, 0.3), "Rail",
      "ValveBiped.Bip01_R_Hand", Vector(1.348, 0, 0), Angle(0, 180, 0), Vector(0.3, 0.3, 0.3), "Rail");

   self:RegisterAttachment("HD-33", "body", Vector(-1.5 - 1, 0, 0), Angle(0, 180, 0), Vector(0.3, 0.3, 0.3), "Rail",
      "ValveBiped.Bip01_R_Hand", Vector(1.348, 0, 0), Angle(0, 180, 0), Vector(0.3, 0.3, 0.3), "Rail");

   self:RegisterAttachment("EOTech", "body", Vector(-0.5 - 1, 0, 0), Angle(0, 0, 0), Vector(0.3, 0.3, 0.3), "Rail",
      "ValveBiped.Bip01_R_Hand", Vector(-0.4, 0, 0), Angle(0, 180, 0), Vector(0.3, 0.3, 0.3), "Rail");

   self:RegisterAttachment("RDS", "body", Vector(-0.5 - 2, 0, 0), Angle(0, 180, 0), Vector(0.3, 0.3, 0.3), "Rail",
      "ValveBiped.Bip01_R_Hand", Vector(1.348, 0, 0), Angle(0, 180, 0), Vector(0.3, 0.3, 0.3), "Rail");

   self:RegisterAttachment("SMG Suppressor", "body", Vector(0, 0, 10), Angle(90, 0, -90), Vector(0.2, 0.2, 0.2), "",
      "ValveBiped.Bip01_R_Hand", Vector(28, 0, -6.5), Angle(-10, 0, 0), Vector(0.5, 0.5, 0.5), "");

   self:RegisterAttachment("Extended Magazine", "body", Vector(0, 0, 0), Angle(0, 180, 0), Vector(0, 0, 0), "",
      "ValveBiped.Bip01_R_Hand", Vector(0, 0, 0), Angle(0, 0, 0), Vector(0.5, 0.5, 0.5), "");
end

SWEP.VElements = {
   ["Rail"] = { type = "Model", model = "models/robotnik_attachments/robotnik_basicrail.mdl", bone = "body", rel = "", pos = Vector(0, -2, 3.7), angle = Angle(90, 0, -90), size = Vector(0.68, 0.45, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
}

SWEP.WElements = {
   ["Test"] = { type = "Model", model = "models/robotnik_attachments/robotnik_basicrail.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6, 0, -8), angle = Angle(170, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
   ["Rail"] = { type = "Model", model = "models/robotnik_attachments/robotnik_basicrail.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6, 0, -8), angle = Angle(170, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
}

function SWEP:Initialize()
   self.BaseClass.Initialize(self);
   self:RegisterSound("Reload", 0.4, "weapons/vector/magout.wav");
      self:RegisterSound("Reload", 1.6, "weapons/vector/magin.wav");
        self:RegisterSound("Reload", 2.4, "weapons/vector/boltrelease.wav");
end