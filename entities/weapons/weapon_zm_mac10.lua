AddCSLuaFile()

SWEP.HoldType            = "ar2"

if CLIENT then
   SWEP.PrintName        = "MAC10"
   SWEP.Slot             = 2

   SWEP.ViewModelFlip    = false
   SWEP.ViewModelFOV     = 54

   SWEP.Icon             = "vgui/ttt/icon_mac"
   SWEP.IconLetter       = "l"
end

SWEP.Base                = "weapon_tttbase"

SWEP.Kind                = WEAPON_HEAVY
SWEP.WeaponID            = AMMO_MAC10

SWEP.Primary.Damage      = 8
SWEP.Primary.Delay       = 0.065
SWEP.Primary.DefaultDelay  = 0.065;
SWEP.Primary.Cone        = 0.03
SWEP.Primary.ClipSize    = 30
SWEP.Primary.ClipMax     = 60
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic   = true
SWEP.Primary.Ammo        = "smg1"
SWEP.Primary.Recoil      = 1.15
SWEP.Primary.Sound       = Sound( "Weapon_mac10.Single" )
SWEP.Primary.UnsilencedSound         = SWEP.Primary.Sound;
SWEP.Primary.SilencedSound         = "weapons/sil02.wav";

SWEP.AutoSpawnable       = true
SWEP.AmmoEnt             = "item_ammo_smg1_ttt"

SWEP.UseHands            = true
SWEP.ViewModel           = "models/weapons/cstrike/c_smg_mac10.mdl"
SWEP.WorldModel          = "models/weapons/w_smg_mac10.mdl"

SWEP.IronSightsPos       = Vector(-10.08, -5, 1.65)
SWEP.IronSightsAng       = Vector(0.699, -5.4, -7)

SWEP.DeploySpeed         = 3

SWEP.CustomizeData = {pos = Vector(6, -9 -1.2), ang = Angle(0, 15, 50)}

SWEP.CustomizePos = {["Muzzle"] = Vector(-8.5, -7.5, 0), ["Magazine"] = Vector(5, -2, 0)};

function SWEP:AttachmentRegister()

   self:RegisterAttachment("SMG Suppressor", "v_weapon.mac10_Parent", Vector(-0.2, -4, -8), Angle(180 + 88.2, 0, 0), Vector(0.5, 0.5, 0.5), "",
      "ValveBiped.Bip01_R_Hand", Vector(14, 2, -4), Angle(0, -4, 0), Vector(0.5, 0.5, 0.5), "");

   self:RegisterAttachment("Rapid-Fire Magazine", "v_weapon.mac10_Parent", Vector(0, 0, 0), Angle(0, 180, 0), Vector(0, 0, 0), "",
      "ValveBiped.Bip01_R_Hand", Vector(0, 0, 0), Angle(0, 0, 0), Vector(0.5, 0.5, 0.5), "");

   --[[self:RegisterAttachment("Explosive Rounds", "v_weapon.p90_Parent", Vector(0, 0, 0), Angle(0, 180, 0), Vector(0, 0, 0), "",
      "ValveBiped.Bip01_R_Hand", Vector(0, 0, 0), Angle(0, 0, 0), Vector(0.5, 0.5, 0.5), "");]]--
end

function SWEP:GetHeadshotMultiplier(victim, dmginfo)
   local att = dmginfo:GetAttacker()
   if not IsValid(att) then return 2 end

   local dist = victim:GetPos():Distance(att:GetPos())
   local d = math.max(0, dist - 150)

   -- decay from 3.2 to 1.7
   return 1.7 + math.max(0, (1.5 - 0.002 * (d ^ 1.25)))
end
