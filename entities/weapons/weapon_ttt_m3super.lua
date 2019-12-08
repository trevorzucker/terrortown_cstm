AddCSLuaFile()

DEFINE_BASECLASS "weapon_tttbase"

SWEP.HoldType              = "shotgun"

if CLIENT then
   SWEP.PrintName          = "M3 Super"
   SWEP.Slot               = 2

   SWEP.ViewModelFlip      = false
   SWEP.ViewModelFOV       = 54

   SWEP.Icon               = "vgui/ttt/icon_m3"
   SWEP.IconLetter         = "B"
end

SWEP.Base                  = "weapon_tttbase"

SWEP.Kind                  = WEAPON_HEAVY
SWEP.WeaponID              = AMMO_SHOTGUN

SWEP.Primary.Ammo          = "Buckshot"
SWEP.Primary.Damage        = 18
SWEP.Primary.Cone          = 0.15
SWEP.Primary.DefaultCone   = SWEP.Primary.Cone;
SWEP.Primary.ReducedCone          = 0.085;
SWEP.Primary.Delay         = 1
SWEP.Primary.ClipSize      = 8
SWEP.Primary.ClipMax       = 24
SWEP.Primary.DefaultClip   = 8
SWEP.Primary.Automatic     = false
SWEP.Primary.NumShots      = 8
SWEP.Primary.Sound         = Sound( "Weapon_M3.Single" )
SWEP.Primary.UnsilencedSound         = Sound( "Weapon_M3.Single" )
SWEP.Primary.SilencedSound = Sound( "Weapon_USP.SilencedShot" );
SWEP.Primary.Recoil        = 8

SWEP.AutoSpawnable         = true
SWEP.Spawnable             = true
SWEP.AmmoEnt               = "item_box_buckshot_ttt"

SWEP.UseHands              = true
SWEP.ViewModel             = "models/weapons/cstrike/c_shot_m3super90.mdl"
SWEP.WorldModel            = "models/weapons/w_shot_m3super90.mdl"

SWEP.IronSightsPos         = Vector(-7.65, -7, 3.5)
SWEP.IronSightsAng         = Vector(0, 0, 0)

SWEP.CustomizeData = {pos = Vector(8, -10, -2), ang = Angle(0, 15, 50)}

SWEP.CustomizePos = {["Muzzle"] = Vector(-14.8, -10.5, 0), ["Magazine"] = Vector(-9, -1, 0)};

SWEP.IronSightData = {
};

function SWEP:AttachmentRegister()
   self:RegisterAttachment("Shotgun Suppressor", "v_weapon.M3_PARENT", Vector(0, -4.5, -23), Angle(-90, 90, 0), Vector(0.8, 0.8, 0.8), "",
      "ValveBiped.Bip01_R_Hand", Vector(28, 1, -8.1), Angle(-171.34, 180, 0), Vector(0.8, 0.8, 0.8), "");

   self:RegisterAttachment("Shotgun Choke", "v_weapon.M3_PARENT", Vector(0, -4.5, -25), Angle(0, 90, 90), Vector(0.5, 0.5, 0.5), "",
      "ValveBiped.Bip01_R_Hand", Vector(29.5, 0.8, -8.5), Angle(0, 90, 10), Vector(0.5, 0.5, 0.5), "");
end

function SWEP:SetupDataTables()
   self:NetworkVar("Bool", 0, "Reloading")
   self:NetworkVar("Float", 0, "ReloadTimer")

   return BaseClass.SetupDataTables(self)
end

function SWEP:Reload()

   --if self:GetNWBool( "reloading", false ) then return end
   if self:GetReloading() || self.IsCustomizing then return end

   if self:Clip1() < self.Primary.ClipSize and self:GetOwner():GetAmmoCount( self.Primary.Ammo ) > 0 then

      if self:StartReload() then
         return
      end
   end

end

function SWEP:StartReload()
   --if self:GetNWBool( "reloading", false ) then
   if self:GetReloading() then
      return false
   end

   self:SetIronsights( false )

   self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

   local ply = self:GetOwner()

   if not ply or ply:GetAmmoCount(self.Primary.Ammo) <= 0 then
      return false
   end

   local wep = self

   if wep:Clip1() >= self.Primary.ClipSize then
      return false
   end

   wep:SendWeaponAnim(ACT_SHOTGUN_RELOAD_START)

   self:SetReloadTimer(CurTime() + wep:SequenceDuration())

   --wep:SetNWBool("reloading", true)
   self:SetReloading(true)

   return true
end

function SWEP:PerformReload()
   local ply = self:GetOwner()

   -- prevent normal shooting in between reloads
   self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

   if not ply or ply:GetAmmoCount(self.Primary.Ammo) <= 0 then return end

   if self:Clip1() >= self.Primary.ClipSize then return end

   self:GetOwner():RemoveAmmo( 1, self.Primary.Ammo, false )
   self:SetClip1( self:Clip1() + 1 )

   self:SendWeaponAnim(ACT_VM_RELOAD)

   self:SetReloadTimer(CurTime() + self:SequenceDuration())
end

function SWEP:FinishReload()
   self:SetReloading(false)
   self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)

   self:SetReloadTimer(CurTime() + self:SequenceDuration())
end

function SWEP:Think()
   BaseClass.Think(self)
   if self:GetReloading() then
      if self:GetOwner():KeyDown(IN_ATTACK) then
         self:FinishReload()
         return
      end

      if self:GetReloadTimer() <= CurTime() then

         if self:GetOwner():GetAmmoCount(self.Primary.Ammo) <= 0 then
            self:FinishReload()
         elseif self:Clip1() < self.Primary.ClipSize then
            self:PerformReload()
         else
            self:FinishReload()
         end
         return
      end
   end
end

function SWEP:Deploy()
   self:SetReloading(false)
   self:SetReloadTimer(0)
   return BaseClass.Deploy(self)
end

-- The shotgun's headshot damage multiplier is based on distance. The closer it
-- is, the more damage it does. This reinforces the shotgun's role as short
-- range weapon by reducing effectiveness at mid-range, where one could score
-- lucky headshots relatively easily due to the spread.
function SWEP:GetHeadshotMultiplier(victim, dmginfo)
   local att = dmginfo:GetAttacker()
   if not IsValid(att) then return 3 end

   local dist = victim:GetPos():Distance(att:GetPos())
   local d = math.max(0, dist - 140)

   -- decay from 3.1 to 1 slowly as distance increases
   return 1 + math.max(0, (2.1 - 0.002 * (d ^ 1.25)))
end

function SWEP:SecondaryAttack()
   if self.NoSights or (not self.IronSightsPos) or self:GetReloading() then return end
   --if self:GetNextSecondaryFire() > CurTime() then return end

   self:SetIronsights(not self:GetIronsights())

   self:SetNextSecondaryFire(CurTime() + 0.3)
end
