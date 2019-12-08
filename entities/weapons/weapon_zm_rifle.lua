AddCSLuaFile()

SWEP.HoldType              = "ar2"

if CLIENT then
   SWEP.PrintName          = "rifle_name"
   SWEP.Slot               = 2

   SWEP.ViewModelFlip      = false
   SWEP.ViewModelFOV       = 54

   SWEP.Icon               = "vgui/ttt/icon_scout"
   SWEP.IconLetter         = "n"
   SWEP.Crosshair   = false
end

SWEP.Base                  = "weapon_tttbase"

SWEP.Kind                  = WEAPON_HEAVY
SWEP.WeaponID              = AMMO_RIFLE

SWEP.Primary.Delay         = 1.5
SWEP.Primary.Recoil        = 7
SWEP.Primary.Automatic     = false
SWEP.Primary.Ammo          = "357"
SWEP.Primary.Damage        = 50
SWEP.Primary.Cone          = 0.005
SWEP.Primary.ClipSize      = 10
SWEP.Primary.ClipMax       = 20 -- keep mirrored to ammo
SWEP.Primary.DefaultClip   = 10
SWEP.Primary.Sound         = Sound("Weapon_Scout.Single")

SWEP.Secondary.Sound       = Sound("Default.Zoom")

SWEP.HeadshotMultiplier    = 4

SWEP.AutoSpawnable         = true
SWEP.Spawnable             = true
SWEP.AmmoEnt               = "item_ammo_357_ttt"

SWEP.UseHands              = true
SWEP.ViewModel             = Model("models/weapons/cstrike/c_snip_scout.mdl")
SWEP.WorldModel            = Model("models/weapons/w_snip_scout.mdl")

SWEP.IronSightsPos         = Vector( -6.69, -20, 3.35 )
SWEP.IronSightsAng         = Vector( 0, 0, 0 )

SWEP.HasScope = true;

SWEP.CustomizeData = {pos = Vector(6, -9 -1.2), ang = Angle(0, 15, 50)}

SWEP.CustomizePos = {["Muzzle"] = Vector(-8.5, -7.5, 0), ["Magazine"] = Vector(5, -2, 0)};

function SWEP:AttachmentRegister()
   self:RegisterAttachment("Explosive Rounds", "v_weapon.scout_Parent", Vector(0, 0, 0), Angle(0, 180, 0), Vector(0, 0, 0), "",
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