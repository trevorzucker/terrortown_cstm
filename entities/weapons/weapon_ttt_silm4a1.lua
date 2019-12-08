AddCSLuaFile()

SWEP.HoldType              = "ar2"

if CLIENT then
   SWEP.PrintName          = "Silenced M16"
   SWEP.Slot               = 6

   SWEP.ViewModelFlip      = false
   SWEP.ViewModelFOV       = 64

   SWEP.Icon               = "vgui/ttt/icon_m16"
   SWEP.IconLetter         = "w"
end

SWEP.Base                  = "weapon_tttbase"

SWEP.Kind                  = WEAPON_HEAVY
SWEP.WeaponID              = AMMO_M16

SWEP.Primary.Delay         = 0.11
SWEP.Primary.Recoil        = 1.6
SWEP.Primary.Automatic     = true
SWEP.Primary.Ammo          = "Pistol"
SWEP.Primary.Damage        = 16
SWEP.Primary.Cone          = 0.018
SWEP.Primary.ClipSize      = 20
SWEP.Primary.ClipMax       = 60
SWEP.Primary.DefaultClip   = 20
SWEP.Primary.Sound = "weapons/m4a1/m4a1-1.wav"

SWEP.AutoSpawnable         = false
SWEP.Spawnable             = true
SWEP.AmmoEnt               = "item_ammo_pistol_ttt"
SWEP.PrimaryAnim = ACT_VM_PRIMARYATTACK;

SWEP.UseHands              = true
SWEP.ViewModel             = "models/weapons/cstrike/c_rif_m4a1.mdl"
SWEP.WorldModel            = "models/weapons/w_rif_m4a1.mdl"

SWEP.IronSightsPos         = Vector(-8.245, -6, -0.45)
SWEP.IronSightsAng         = Vector(3, -2.7, -4.6)

SWEP.SilencerAnim = ACT_VM_ATTACH_SILENCER;
SWEP.PrimaryAnim = ACT_VM_PRIMARYATTACK_SILENCED;
SWEP.Primary.Sound = "weapons/m4a1/m4a1-1.wav"
SWEP.WorldModel = "models/weapons/w_rif_m4a1_silencer.mdl"
SWEP.Primary.FireSoundLevel		 = 35;
SWEP.Primary.SoundLevel = 1;
SWEP.IsSilent = true;
SWEP.ReloadAnim = ACT_VM_RELOAD_SILENCED;
SWEP.CanBuy = { ROLE_TRAITOR }

function SWEP:SecondaryAttack()
	if (self:GetNextPrimaryFire() > CurTime()) then return; end
	self.BaseClass.SecondaryAttack(self);
	if (self:GetSequence() == 10 || self:GetSequence() == 9 || self:GetSequence() == 8 || self:GetSequence() == 2 || self:GetSequence() == 3 || self:GetSequence() == 1) then return; end
    self:SendWeaponAnim(self.PrimaryAnim)
    timer.Create("FireAnimStop", .1, 1, function()
		self:SetNWFloat("AnimSpeed", 1);
	end)
end

if (SERVER) then
	function SWEP:Deploy()
		self.BaseClass.Deploy(self);
		self:SendWeaponAnim(ACT_VM_DRAW_SILENCED);
	end
end