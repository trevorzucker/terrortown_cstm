AddCSLuaFile()

SWEP.HoldType              = "ar2"

if CLIENT then
   SWEP.PrintName          = "AUG"
   SWEP.Slot               = 2

   SWEP.ViewModelFlip      = false
   SWEP.ViewModelFOV       = 54

   SWEP.Icon               = "vgui/ttt/icon_scout"
   SWEP.IconLetter         = "n"
   SWEP.Crosshair   = false;
end

SWEP.Base                  = "weapon_tttbase"

SWEP.Kind                  = WEAPON_HEAVY
SWEP.WeaponID              = AMMO_M16

SWEP.Primary.Delay         = 0.1
SWEP.Primary.Recoil        = 2
SWEP.Primary.Automatic     = true
SWEP.Primary.Ammo          = "Pistol"
SWEP.Primary.Damage        = 23
SWEP.Primary.Cone          = 0.018
SWEP.Primary.ClipSize      = 20
SWEP.Primary.ClipMax       = 20 -- keep mirrored to ammo
SWEP.Primary.DefaultClip   = 20
SWEP.Primary.Sound         = Sound("Weapon_AUG.Single")
SWEP.Primary.UnsilencedSound         = SWEP.Primary.Sound;
SWEP.Primary.SilencedSound         = Sound( "Weapon_USP.SilencedShot" );
SWEP.Primary.ZoomFOV = 20;

SWEP.Secondary.Sound       = Sound("Default.Zoom")

SWEP.HeadshotMultiplier    = 4

SWEP.AutoSpawnable         = true
SWEP.Spawnable             = true
SWEP.AmmoEnt               = "item_ammo_pistol_ttt"

SWEP.UseHands              = true
SWEP.ViewModel             = Model("models/weapons/cstrike/c_rif_aug.mdl")
SWEP.WorldModel            = Model("models/weapons/w_rif_aug.mdl")

SWEP.IronSightsPos         = Vector( -7.5, -15, 2.1 )
SWEP.IronSightsAng         = Vector( 0, 0, 0 )

SWEP.HasScope = true;

SWEP.CustomizeData = {pos = Vector(8, -10, -2), ang = Angle(0, 15, 50)}

SWEP.CustomizePos = {["Muzzle"] = Vector(-13.2, -8.8, 0), ["Magazine"] = Vector(1000, 550, 0)};

function SWEP:AttachmentRegister()
   self:RegisterAttachment("Rifle Suppressor", "v_weapon.aug_Parent", Vector(-0.25, -3.75, -19), Angle(180 + 88.2, 0, 0), Vector(0.5, 0.5, 0.5), "",
      "ValveBiped.Bip01_R_Hand", Vector(24.652, 1, -7.5), Angle(-10, 0, 0), Vector(0.5, 0.5, 0.5), "");

   self:RegisterAttachment("Rifle Muzzle Brake", "v_weapon.aug_Parent", Vector(-0.17, -3.75, -17.6), Angle(90 + 88.2, 0, -90), Vector(0.5, 0.5, 0.5), "",
      "ValveBiped.Bip01_R_Hand", Vector(23.57, 1, -7.3), Angle(0, 90, 11), Vector(0.5, 0.5, 0.5), "");

   self:RegisterAttachment("Extended Magazine", "v_weapon.aug_Parent", Vector(0, 0, 0), Angle(0, 180, 0), Vector(0, 0, 0), "",
      "ValveBiped.Bip01_R_Hand", Vector(0, 0, 0), Angle(0, 0, 0), Vector(0.5, 0.5, 0.5), "");
end

if CLIENT then
   local scope = surface.GetTextureID("sprites/scope")
   local drawAlpha = 0;
   function SWEP:DrawHUD()
      if (!self.HasScope) then return self.BaseClass.DrawHUD(self) end
      if (self:GetIronsights()) then
         if (self.mul < 0.95) then return;  end
         if (self.mul > 0.95) then
            surface.SetDrawColor( 0, 0, 0, drawAlpha );
            local scrW = ScrW();
            local scrH = ScrH();
            surface.DrawRect(0, 0, scrW, scrH);

            if (self.mul < 0.9985) then
               drawAlpha = math.Clamp(Lerp(FrameTime() * 10, drawAlpha, 300), 0, 255);
               if (drawAlpha >= 255) then -- black screen, hide model
                  self.Owner:DrawViewModel(false);
               end
               return;
            else
               drawAlpha = math.Clamp(Lerp(FrameTime() * 5, drawAlpha, -45), 0, 255);

            end
         end
         self.Owner:DrawViewModel(false);
         surface.SetDrawColor( 0, 0, 0, 255 )
         
         local scrW = ScrW()
         local scrH = ScrH()

         local x = scrW / 2.0
         local y = scrH / 2.0
         local scope_size = scrH

         -- crosshair
         local gap = 0
         local length = scope_size
         local scope_radius, scope_radiusY = scrW / 4, scrH / 10.5;
         surface.DrawLine( x - length, y, x - gap, y )
         surface.DrawLine( x + length, y, x + gap, y )
         surface.DrawLine( x, y - length, x, y - gap )
         surface.DrawLine( x, y + length, x, y + gap )

         for x = 1, 5 do
            surface.DrawLine( scope_radius + x * scrW / 24, y - y / 64, scope_radius + x * scrW / 24, y + y / 64 );
         end

         for x = 1, 5 do
            surface.DrawLine( scrW / 4 + scope_radius + x * scrW / 24, y - y / 64, scrW / 4 + scope_radius + x * scrW / 24, y + y / 64 );
         end

            surface.DrawRect(scope_radius / 1.2, y - scrH / 1024, scrW / 16, scrH / 256);
            surface.DrawRect(scrW / 2 + scope_radius / 1.1, y - scrH / 1024, scrW / 16, scrH / 256);

         for x = 1, 5 do
            surface.DrawLine( scrW / 2 - scrW / 2 / 64, scope_radiusY + x * scrW / 24, scrW / 2 + scrW / 2 / 64, scope_radiusY + x * scrW / 24 );
         end

            surface.DrawRect(x - scrW / 2048, scope_radiusY / 2.5, scrW / 384, scrH / 11);

         for x = 1, 5 do
            surface.DrawLine( scrW / 2 - scrW / 2 / 64 - x ^ (scrW / 512), scrH / 1.11 - x * scrW / 24, scrW / 2 + scrW / 2 / 64 + x ^ (scrW / 512), scrH / 1.11 - x * scrW / 24 );
         end

            surface.DrawRect(x - scrW / 2048, scrH / 1.1 - scope_radiusY / 2.5, scrW / 384, scrH / 11);


         -- cover edges
         local sh = scope_size / 2
         local w = (x - sh) + 2
         surface.DrawRect(0, 0, w, scope_size)
         surface.DrawRect(x + sh - 2, 0, w, scope_size)
         
         -- cover gaps on top and bottom of screen
         surface.DrawLine( 0, 0, scrW, 0 )
         surface.DrawLine( 0, scrH - 1, scrW, scrH - 1 )

         surface.SetDrawColor(255, 0, 0, 255)
         surface.DrawRect(x - 1, y - 1, 3, 3)

         -- scope
         surface.SetTexture(scope)
         surface.SetDrawColor(255, 255, 255, 255)

         surface.DrawTexturedRectRotated(x, y, scope_size, scope_size, 0)
      else
         drawAlpha = 0;
         self.Owner:DrawViewModel(true);

         return self.BaseClass.DrawHUD(self)
      end
   end

   function SWEP:AdjustMouseSensitivity()
        if(!self.HasScope) then return; end
      if (self.mul > 0.99) then
         return (true and 0.2);
      end
      return nil
   end
end