AddCSLuaFile()

DEFINE_BASECLASS "weapon_tttbase"

SWEP.HoldType              = "shotgun"

if CLIENT then
   SWEP.PrintName          = "Sawed-Off Shotgun"
   SWEP.Slot               = 2

   SWEP.ViewModelFlip      = false
   SWEP.ViewModelFOV       = 54

   SWEP.Icon               = "vgui/ttt/icon_sawedoff"
   SWEP.IconLetter         = "B"
end

SWEP.Base                  = "weapon_tttbase"

SWEP.Kind                  = WEAPON_HEAVY
SWEP.WeaponID              = AMMO_SHOTGUN

SWEP.Primary.Ammo          = "Buckshot"
SWEP.Primary.Damage        = 13
SWEP.Primary.Cone          = 0.2
SWEP.Primary.DefaultCone   = SWEP.Primary.Cone;
SWEP.Primary.ReducedCone          = 0.1;
SWEP.Primary.Delay         = 1
SWEP.Primary.ClipSize      = 8
SWEP.Primary.ClipMax       = 24
SWEP.Primary.DefaultClip   = 8
SWEP.Primary.Automatic     = false
SWEP.Primary.NumShots      = 8
SWEP.Primary.Sound         = "weapons/37/fire.wav"
SWEP.Primary.UnsilencedSound         = Sound( "Weapon_M3.Single" )
SWEP.Primary.SilencedSound = "weapons/sil02.wav"
SWEP.Primary.Recoil        = 8

SWEP.CrotchGun = true;

SWEP.AutoSpawnable         = true
SWEP.Spawnable             = true
SWEP.AmmoEnt               = "item_box_buckshot_ttt"

SWEP.UseHands              = true
SWEP.ViewModel             = "models/weapons/v_shot_sawedoff.mdl"
SWEP.WorldModel            = "models/weapons/w_shot_sawedoff.mdl"

SWEP.IronSightsPos         = Vector(-1.8, 2, 0.9)
SWEP.IronSightsAng         = Vector(0, 0, 0)

SWEP.CustomizeData = {pos = Vector(7, -3, -2), ang = Angle(0, 15, 50)}

SWEP.CustomizePos = {["Muzzle"] = Vector(-60, 0, 0), ["Magazine"] = Vector(-9, -1, 0)};

SWEP.IronSightData = {
};

function SWEP:AttachmentRegister()
   --[[self:RegisterAttachment("Shotgun Suppressor", "body", Vector(-13.5, 0, 1.15), Angle(180, 0, 180), Vector(0.75, 0.75, 0.75), "",
      "ValveBiped.Bip01_R_Hand", Vector(28, 0, -9), Angle(-171.34, 180, 0), Vector(0.8, 0.8, 0.8), "");]]--

   --[[self:RegisterAttachment("Shotgun Choke", "body", Vector(-13.5, 0, 1.15), Angle(270, 0, 180), Vector(0.75, 0.75, 0.75), "",
      "ValveBiped.Bip01_R_Hand", Vector(28, 0, -9), Angle(-171.34, 180, 0), Vector(0.8, 0.8, 0.8), "");]]--
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

   for k, v in pairs(self.CustomSounds) do
      if (v[1] == "PerformReload") then
         timer.Simple(v[2], function()
            if (!IsValid(self)) then return end
            if not worldsnd then
               self:EmitSound(v[3], self.Primary.SoundLevel, 100, 1, CHAN_ITEM)
            elseif SERVER then
               sound.Play(v[3], self:GetPos(), self.Primary.SoundLevel, 100, 1, CHAN_ITEM)
            end
         end)
      end
   end
end

function SWEP:FinishReload()
   self:SetReloading(false)
   self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)

   for k, v in pairs(self.CustomSounds) do
      if (v[1] == "FinishReload") then
         timer.Simple(v[2], function()
            if (!IsValid(self)) then return end
            if not worldsnd then
               self:EmitSound(v[3], self.Primary.SoundLevel, 100, 1, CHAN_ITEM)
            elseif SERVER then
               sound.Play(v[3], self:GetPos(), self.Primary.SoundLevel, 100, 1, CHAN_ITEM)
            end
         end)
      end
   end

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

function SWEP:Initialize()
   self.BaseClass.Initialize(self);
   self:RegisterSound("Deploy", 0.01, "weapons/37/pump.wav");
   self:RegisterSound("PerformReload", 0.01, "weapons/37/insert1.wav");
   self:RegisterSound("FinishReload", 0.01, "weapons/37/pump.wav");
   self:RegisterSound("PrimaryAttack", 0.2, "weapons/37/pump.wav");
end