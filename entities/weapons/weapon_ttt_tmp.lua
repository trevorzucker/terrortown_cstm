AddCSLuaFile()

SWEP.HoldType            = "ar2"

if CLIENT then
   SWEP.PrintName        = "MP9"
   SWEP.Slot             = 1

   SWEP.ViewModelFlip    = false
   SWEP.ViewModelFOV     = 54

   SWEP.Icon             = "vgui/ttt/icon_mac"
   SWEP.IconLetter       = "l"
end

SWEP.Base                = "weapon_tttbase"

SWEP.Kind                = WEAPON_PISTOL
SWEP.CanBuy              = {ROLE_TRAITOR}
SWEP.WeaponID            = AMMO_MAC10

SWEP.Primary.Damage      = 22
SWEP.Primary.Delay       = 0.065
SWEP.Primary.Cone        = 0.01
SWEP.Primary.ClipSize    = 30
SWEP.Primary.ClipMax     = 60
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic   = true
SWEP.Primary.Ammo        = "smg1"
SWEP.Primary.Recoil      = 0.5
SWEP.Primary.Sound       = Sound( "Weapon_TMP.Single" )

SWEP.AutoSpawnable       = false
SWEP.AmmoEnt             = "item_ammo_smg1_ttt"

SWEP.UseHands            = true
SWEP.ViewModel           = "models/weapons/cstrike/c_smg_tmp.mdl"
SWEP.WorldModel          = "models/weapons/w_smg_tmp.mdl"

SWEP.IronSightsPos       = Vector(-2, -5, 2)
SWEP.IronSightsAng       = Vector(0, 0, 6)
SWEP.CrosshairDisappears = false;
SWEP.IsSilent = true;

function SWEP:GetHeadshotMultiplier(victim, dmginfo)
   local att = dmginfo:GetAttacker()
   if not IsValid(att) then return 2 end

   local dist = victim:GetPos():Distance(att:GetPos())
   local d = math.max(0, dist - 150)

   -- decay from 3.2 to 1.7
   return 1.7 + math.max(0, (1.5 - 0.002 * (d ^ 1.25)))
end