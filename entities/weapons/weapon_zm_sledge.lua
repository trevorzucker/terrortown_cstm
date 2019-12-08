AddCSLuaFile()

SWEP.HoldType              = "crossbow"

if CLIENT then
   SWEP.PrintName          = "H.U.G.E-249"
   SWEP.Slot               = 2

   SWEP.ViewModelFlip      = false
   SWEP.ViewModelFOV       = 54

   SWEP.Icon               = "vgui/ttt/icon_m249"
   SWEP.IconLetter         = "z"
end

SWEP.Base                  = "weapon_tttbase"

SWEP.Spawnable             = true
SWEP.AutoSpawnable         = true

SWEP.Kind                  = WEAPON_HEAVY
SWEP.WeaponID              = AMMO_M249

SWEP.Primary.Damage        = 7
SWEP.Primary.Delay         = 0.06
SWEP.Primary.Cone          = 0.09
SWEP.Primary.ClipSize      = 150
SWEP.Primary.ClipMax       = 150
SWEP.Primary.DefaultClip   = 150
SWEP.Primary.Automatic     = true
SWEP.Primary.Ammo          = "AirboatGun"
SWEP.Primary.Recoil        = 1.5
SWEP.Primary.Sound         = Sound("Weapon_m249.Single")

SWEP.UseHands              = true
SWEP.ViewModel             = "models/weapons/cstrike/c_mach_m249para.mdl"
SWEP.WorldModel            = "models/weapons/w_mach_m249para.mdl"

SWEP.HeadshotMultiplier    = 2.2

SWEP.IronSightsPos         = Vector(-5.96, -5.119, 2.349)
SWEP.IronSightsAng         = Vector(0, 0, 0)

SWEP.CustomizeData = {pos = Vector(10, -6, -4), ang = Angle(0, 15, 50)}

SWEP.CustomizePos = {["Scope"] = Vector(-1, -8, 0), ["Muzzle"] = Vector(0, 0, 0), ["Magazine"] = Vector(-7, 1, 0)};

SWEP.IronSightData = {
	["Micro Red Dot"] = {pos = Vector(0.219, -3, -1.05), ang = Vector(-1.5, 1, 0)},
	["HD-33"] = {pos = Vector(0.219, -3, -1.2), ang = Vector(-1.5, 1, 0)},
	["EOTech"] = {pos = Vector(0.219, -3, -1.05), ang = Vector(-1.5, 1, 0)},
	["RDS"] = {pos = Vector(0.219, -3, -1.23), ang = Vector(-1.5, 1, 0)},
	["JGM-4"] = {pos = Vector(0.3, -3, -1.1), ang = Vector(-1.5, 1.2, 0)},
	["Elcan"] = {pos = Vector(0.3, -3, -1.1), ang = Vector(-1.5, 1.2, 0)},
	["ACOG"] = {pos = Vector(-0.02, -3, -1.1), ang = Vector(-1.5, 0, 0)}
};

function SWEP:AttachmentRegister()
	--[[self:RegisterAttachment("Micro Red Dot", "v_weapon.m4_Parent", Vector(0, 0, 0), Angle(0, 180, 0), Vector(0.5, 0.5, 0.5), "Rail",
		"ValveBiped.Bip01_R_Hand", Vector(1.348, 0, 0), Angle(0, 180, 0), Vector(0.5, 0.5, 0.5), "Rail");

	self:RegisterAttachment("HD-33", "v_weapon.m4_Parent", Vector(-1.5, 0, 0), Angle(0, 180, 0), Vector(0.5, 0.5, 0.5), "Rail",
		"ValveBiped.Bip01_R_Hand", Vector(1.348, 0, 0), Angle(0, 180, 0), Vector(0.5, 0.5, 0.5), "Rail");

	self:RegisterAttachment("EOTech", "v_weapon.m4_Parent", Vector(-0.5, 0, 0), Angle(0, 0, 0), Vector(0.5, 0.5, 0.5), "Rail",
		"ValveBiped.Bip01_R_Hand", Vector(-0.4, 0, 0), Angle(0, 180, 0), Vector(0.5, 0.5, 0.5), "Rail");

	self:RegisterAttachment("RDS", "v_weapon.m4_Parent", Vector(-0.5, 0, 0), Angle(0, 180, 0), Vector(0.5, 0.5, 0.5), "Rail",
		"ValveBiped.Bip01_R_Hand", Vector(1.348, 0, 0), Angle(0, 180, 0), Vector(0.5, 0.5, 0.5), "Rail");

	self:RegisterAttachment("JGM-4", "v_weapon.m4_Parent", Vector(-0.5, 0, 0), Angle(0, 180, 0), Vector(0.5, 0.5, 0.5), "Rail",
		"ValveBiped.Bip01_R_Hand", Vector(0.9, 0, 0), Angle(0, 0, 0), Vector(0.5, 0.5, 0.5), "Rail");

	self:RegisterAttachment("Elcan", "v_weapon.m4_Parent", Vector(-0.5, 0, 0), Angle(0, 0, 0), Vector(0.5, 0.5, 0.5), "Rail",
		"ValveBiped.Bip01_R_Hand", Vector(0.9, 0, 0), Angle(0, 0, 0), Vector(0.5, 0.5, 0.5), "Rail");

	self:RegisterAttachment("ACOG", "v_weapon.m4_Parent", Vector(0, -0.64, 0.25), Angle(0, 91.5, 0), Vector(0.5, 0.5, 0.5), "Rail",
		"ValveBiped.Bip01_R_Hand", Vector(-0.652, 0.565, 0.296), Angle(0, -90, 0), Vector(0.5, 0.5, 0.5), "Rail");]]--

	--[[self:RegisterAttachment("Rifle Suppressor", "v_weapon.m249", Vector(0.08, -4.65, -21), Angle(180 + 88.2, 0, 0), Vector(0.5, 0.5, 0.5), "",
		"ValveBiped.Bip01_R_Hand", Vector(29.652, 0.776, -8.37), Angle(-10, 0, 0), Vector(0.5, 0.5, 0.5), "");]]--

	--[[self:RegisterAttachment("Rifle Muzzle Brake", "v_weapon.m4_Parent", Vector(0.2, -4.65, -19.6), Angle(90 + 88.2, 0, -90), Vector(0.5, 0.5, 0.5), "",
		"ValveBiped.Bip01_R_Hand", Vector(28.57, 0.672, -8.171), Angle(0, 90, 12.121), Vector(0.5, 0.5, 0.5), "");

	self:RegisterAttachment("Extended Magazine", "v_weapon.m4_Parent", Vector(0, 0, 0), Angle(0, 180, 0), Vector(0, 0, 0), "",
		"ValveBiped.Bip01_R_Hand", Vector(0, 0, 0), Angle(0, 0, 0), Vector(0.5, 0.5, 0.5), "");]]--
end

--[[SWEP.VElements = {
	["Rail"] = { type = "Model", model = "models/robotnik_attachments/robotnik_basicrail.mdl", bone = "v_weapon.m4_Parent", rel = "", pos = Vector(1.126, -7.355, -1.923), angle = Angle(-90, -7.404, -90), size = Vector(0.5, 0.45, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
}

SWEP.WElements = {
	["Rail"] = { type = "Model", hide = true, model = "models/robotnik_attachments/robotnik_basicrail.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.556, 0.698, -7.551), angle = Angle(177.026, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
}]]--