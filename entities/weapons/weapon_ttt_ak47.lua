AddCSLuaFile()

SWEP.HoldType              = "ar2"

if CLIENT then
   SWEP.PrintName          = "AK-47"
   SWEP.Slot               = 2

   SWEP.ViewModelFlip      = false
   SWEP.ViewModelFOV       = 64

   SWEP.Icon               = "vgui/ttt/icon_ak47"
   SWEP.IconLetter         = "w"
end

SWEP.Base                  = "weapon_tttbase"

SWEP.Kind                  = WEAPON_HEAVY
SWEP.WeaponID              = AMMO_M16

SWEP.Primary.Delay         = 0.08
SWEP.Primary.Recoil        = 1.6
SWEP.Primary.Automatic     = true
SWEP.Primary.Ammo          = "Pistol"
SWEP.Primary.Damage        = 23
SWEP.Primary.Cone          = 0.018
SWEP.Primary.ClipSize      = 20
SWEP.Primary.ClipMax       = 60
SWEP.Primary.DefaultClip   = 20
SWEP.Primary.Sound         = Sound( "Weapon_ak47.Single" )
SWEP.Primary.UnsilencedSound         = SWEP.Primary.Sound;
SWEP.Primary.SilencedSound         = "weapons/sil07.wav";

SWEP.AutoSpawnable         = true
SWEP.Spawnable             = true
SWEP.AmmoEnt               = "item_ammo_pistol_ttt"

SWEP.UseHands              = true
SWEP.ViewModel             = "models/weapons/cstrike/c_rif_ak47.mdl"
SWEP.WorldModel            = "models/weapons/w_rif_ak47.mdl"

SWEP.IronSightsPos         = Vector(-6.6, -10, 2.2)
SWEP.IronSightsAng         = Vector(2.3, 0, 0)

SWEP.CustomizeData = {pos = Vector(8, -10, -2), ang = Angle(0, 15, 50)}

SWEP.CustomizePos = {["Scope"] = Vector(0, 0, 0), ["Muzzle"] = Vector(-13, -10.8, 0), ["Magazine"] = Vector(-9, -1, 0)};

SWEP.IronSightData = {
	["Kobra"] = {pos = Vector(0.05, 0, -0.44), ang = Vector(-1, 0, 0)},
	["PSO-1"] = {pos = Vector(0.0623, -6.2, -0.31), ang = Vector(-1.2, 0, 0)}
};

function SWEP:AttachmentRegister()
	self:RegisterAttachment("Kobra", "v_weapon.AK47_Parent", Vector(0, 0.602, 1.131), Angle(0, 0, 0), Vector(0.5, 0.5, 0.5), "Rail",
		"ValveBiped.Bip01_R_Hand", Vector(-0, 0.583, 1.078), Angle(0, 0, 0), Vector(0.5, 0.5, 0.5), "Rail");

	self:RegisterAttachment("PSO-1", "v_weapon.AK47_Parent", Vector(0, 0.602, 1.131), Angle(0, 0, 0), Vector(0.5, 0.5, 0.5), "Rail",
		"ValveBiped.Bip01_R_Hand", Vector(0.986, 0.541, 1.156), Angle(0, 0, 0), Vector(0.5, 0.5, 0.5), "Rail");

	self:RegisterAttachment("PBS-4", "v_weapon.AK47_Parent", Vector(-0, -3.9, -28.5), Angle(90, 90, 0), Vector(0.34, 0.34, 0.34), "",
		"ValveBiped.Bip01_R_Hand", Vector(34.611, 0.684, -8.671), Angle(171.281, 0, 0), Vector(0.34, 0.34, 0.34), "");

	self:RegisterAttachment("Extended Magazine", "v_weapon.AK47_Parent", Vector(0, 0, 0), Angle(0, 180, 0), Vector(0, 0, 0), "",
		"ValveBiped.Bip01_R_Hand", Vector(0, 0, 0), Angle(0, 0, 0), Vector(0.5, 0.5, 0.5), "");
end

SWEP.VElements = {
	["Rail"] = { type = "Model", model = "models/robotnik_attachments/robotnik_russianrail.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(-0.55, -5.5, -2), angle = Angle(-91, 90, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	--["Test"] = { type = "Model", model = "models/robotnik_attachments/robotnik_coyote.mdl", bone = "v_weapon.AK47_Parent", rel = "Rail", pos = Vector(-0.55, -5.5, -2), angle = Angle(-91, 90, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
}

SWEP.WElements = {
	["Rail"] = { type = "Model", hide = true, model = "models/robotnik_attachments/robotnik_russianrail.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(7.419, 1.269, -5.066), angle = Angle(-171.34, 180, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}