-- Custom weapon base, used to derive from CS one, still very similar

if (SERVER) then
	util.AddNetworkString("RegisterAttachments");
	util.AddNetworkString("CustomizeEvent");
	util.AddNetworkString("EquipAttachment");
	util.AddNetworkString("ClientsideVar");
	util.AddNetworkString("InitClient");
	util.AddNetworkString("InitClientCurrent");
	util.AddNetworkString("InitCClient");
end

AddCSLuaFile()

---- TTT SPECIAL EQUIPMENT FIELDS

-- This must be set to one of the WEAPON_ types in TTT weapons for weapon
-- carrying limits to work properly. See /gamemode/shared.lua for all possible
-- weapon categories.
SWEP.Kind = WEAPON_NONE

-- If CanBuy is a table that contains ROLE_TRAITOR and/or ROLE_DETECTIVE, those
-- players are allowed to purchase it and it will appear in their Equipment Menu
-- for that purpose. If CanBuy is nil this weapon cannot be bought.
--   Example: SWEP.CanBuy = { ROLE_TRAITOR }
-- (just setting to nil here to document its existence, don't make this buyable)
SWEP.CanBuy = nil

if CLIENT then
   -- If this is a buyable weapon (ie. CanBuy is not nil) EquipMenuData must be
   -- a table containing some information to show in the Equipment Menu. See
   -- default equipment weapons for real-world examples.
   SWEP.EquipMenuData = nil

   -- Example data:
   -- SWEP.EquipMenuData = {
   --
   ---- Type tells players if it's a weapon or item
   --     type = "Weapon",
   --
   ---- Desc is the description in the menu. Needs manual linebreaks (via \n).
   --     desc = "Text."
   -- };

   -- This sets the icon shown for the weapon in the DNA sampler, search window,
   -- equipment menu (if buyable), etc.
   SWEP.Icon = "vgui/ttt/icon_nades" -- most generic icon I guess

   -- You can make your own weapon icon using the template in:
   --   /garrysmod/gamemodes/terrortown/template/

   -- Open one of TTT's icons with VTFEdit to see what kind of settings to use
   -- when exporting to VTF. Once you have a VTF and VMT, you can
   -- resource.AddFile("materials/vgui/...") them here. GIVE YOUR ICON A UNIQUE
   -- FILENAME, or it WILL be overwritten by other servers! Gmod does not check
   -- if the files are different, it only looks at the name. I recommend you
   -- create your own directory so that this does not happen,
   -- eg. /materials/vgui/ttt/mycoolserver/mygun.vmt
end

---- MISC TTT-SPECIFIC BEHAVIOUR CONFIGURATION

-- ALL weapons in TTT must have weapon_tttbase as their SWEP.Base. It provides
-- some functions that TTT expects, and you will get errors without them.
-- Of course this is weapon_tttbase itself, so I comment this out here.
--  SWEP.Base = "weapon_tttbase"

-- If true AND SWEP.Kind is not WEAPON_EQUIP, then this gun can be spawned as
-- random weapon by a ttt_random_weapon entity.
SWEP.AutoSpawnable = false

-- Set to true if weapon can be manually dropped by players (with Q)
SWEP.AllowDrop = true

-- Set to true if weapon kills silently (no death scream)
SWEP.IsSilent = false

-- If this weapon should be given to players upon spawning, set a table of the
-- roles this should happen for here
--  SWEP.InLoadoutFor = { ROLE_TRAITOR, ROLE_DETECTIVE, ROLE_INNOCENT }

-- DO NOT set SWEP.WeaponID. Only the standard TTT weapons can have it. Custom
-- SWEPs do not need it for anything.
--  SWEP.WeaponID = nil

---- YE OLDE SWEP STUFF

if CLIENT then
   SWEP.DrawCrosshair   = false
   SWEP.Crosshair       = true;
   SWEP.ViewModelFOV    = 82
   SWEP.ViewModelFlip   = true
   SWEP.CSMuzzleFlashes = true
end

SWEP.Base = "weapon_base"

SWEP.Category           = "TTT"
SWEP.Spawnable          = false

SWEP.IsGrenade = false

SWEP.Weight             = 5
SWEP.AutoSwitchTo       = false
SWEP.AutoSwitchFrom     = false

SWEP.Primary.Sound          = Sound( "Weapon_Pistol.Empty" )
SWEP.Primary.Recoil         = 1.5
SWEP.Primary.Damage         = 1
SWEP.Primary.NumShots       = 1
SWEP.Primary.Cone           = 0.02
SWEP.Primary.Delay          = 0.15
SWEP.Primary.FireSoundLevel = 75;

SWEP.Primary.ClipSize       = -1
SWEP.Primary.DefaultClip    = -1
SWEP.Primary.Automatic      = false
SWEP.Primary.Ammo           = "none"
SWEP.Primary.ClipMax        = -1
SWEP.Primary.ZoomFOV = 20;

SWEP.Secondary.ClipSize     = 1
SWEP.Secondary.DefaultClip  = 1
SWEP.Secondary.Automatic    = false
SWEP.Secondary.Ammo         = "none"
SWEP.Secondary.ClipMax      = -1

SWEP.HeadshotMultiplier = 2.7

SWEP.StoredAmmo = 0
SWEP.IsDropped = false

SWEP.DeploySpeed = 1

SWEP.CrotchGun = false;

SWEP.PrimaryAnim = ACT_VM_PRIMARYATTACK
SWEP.ReloadAnim = ACT_VM_RELOAD
SWEP.EmptyReloadAnim = ACT_VM_RELOAD
SWEP.DeploySound = Sound("Weapon_357.OpenLoader");

SWEP.IronSightsPos         = Vector(0, 0, 0)
SWEP.IronSightsAng         = Vector(0, 0, 0)

SWEP.IronSightsPosAdd      = Vector(0, 0, 0);
SWEP.IronSightsAngAdd      = Vector(0, 0, 0);

SWEP.fingerprints = {}

SWEP.HasScope = false;
SWEP.CrosshairDisappears = true;

SWEP.CustomSounds = {};

SWEP.RegisteredAttachments = {};
SWEP.EquippedAttachments = {};

SWEP.VElements = {};
SWEP.WElements = {};

local sparkle = CLIENT and CreateConVar("ttt_crazy_sparks", "0", FCVAR_ARCHIVE)

local reticle_r = CLIENT and CreateConVar("reticle_r", "255", FCVAR_ARCHIVE);
local reticle_g = CLIENT and CreateConVar("reticle_g", "0", FCVAR_ARCHIVE);
local reticle_b = CLIENT and CreateConVar("reticle_b", "0", FCVAR_ARCHIVE);
local cstmKey = CLIENT and CreateConVar("ttt_customize_key", "v", FCVAR_ARCHIVE);


SWEP.CustomizePos = {};

-- crosshair
if CLIENT then
   local isChatting = false;
   local sights_opacity = CreateConVar("ttt_ironsights_crosshair_opacity", "0.8", FCVAR_ARCHIVE)
   local crosshair_brightness = CreateConVar("ttt_crosshair_brightness", "1.0", FCVAR_ARCHIVE)
   local crosshair_size = CreateConVar("ttt_crosshair_size", "1.0", FCVAR_ARCHIVE)
   local disable_crosshair = CreateConVar("ttt_disable_crosshair", "0", FCVAR_ARCHIVE)

   local alpha = 1;

   function SWEP:DrawHUD()
      if self.HUDHelp then
         self:DrawHelp()
      end

      local client = LocalPlayer()
      if disable_crosshair:GetBool() or (not IsValid(client)) then return end

      local sights = (not self.NoSights) and self:GetIronsights()

      local x = math.floor(ScrW() / 2.0)
      local y = math.floor(ScrH() / 2.0)
      local scale = math.max(0.2,  10 * self:GetPrimaryCone())

      local LastShootTime = self:LastShootTime()
      scale = scale * (2 - math.Clamp( (CurTime() - LastShootTime) * 5, 0.0, 1.0 ))

      --alpha = sights and sights_opacity:GetFloat() or 1


      if (self:GetIronsights() && self.CrosshairDisappears || self.IsCustomizing ) then
         alpha = Lerp(FrameTime() * 10, alpha, 0);
      else
         alpha = Lerp(FrameTime() * 10, alpha, 1);
      end
      local bright = crosshair_brightness:GetFloat() or 1

      -- somehow it seems this can be called before my player metatable
      -- additions have loaded
      if client.IsTraitor and client:IsTraitor() then
         surface.SetDrawColor(255 * bright,
                              50 * bright,
                              50 * bright,
                              255 * alpha)
      else
         surface.SetDrawColor(0,
                              255 * bright,
                              0,
                              255 * alpha)
      end

      local gap = math.floor(20 * 0.4 * (sights and 0.8 or 1))
      local length = math.floor(gap + (25 * crosshair_size:GetFloat()) * 0.4)
      if (self.Crosshair) then
         surface.DrawLine( x - length, y, x - gap, y )
         surface.DrawLine( x + length, y, x + gap, y )
         surface.DrawLine( x, y - length, x, y - gap )
         surface.DrawLine( x, y + length, x, y + gap )
     end

     self:DrawCustomizationMenu();
     self:DrawScopes();
   end

   local matGradR = Material("vgui/gradient-r");

   local cvar_gap = CreateClientConVar("ttt_hud_gap", "50", true, false)

   function SWEP:DrawCustomizationMenu()

      local appliedAttachmentCount = 0;
      for k,v in pairs(self.RegisteredAttachments) do
         for i, j in pairs(v) do
            if (self.EquippedAttachments[k] == j.AttachmentName) then
               appliedAttachmentCount = appliedAttachmentCount + 1;
            end
         end
      end

      if (appliedAttachmentCount > 0) then
         local gap = cvar_gap:GetFloat();
         local padding = 5;
         surface.SetDrawColor(0, 0, 0, 200 * self.CustomizeMul);
         surface.SetFont("SH_TTT_HUD3")
         local attLbl = "Current Attachments";
         local textw, texth = surface.GetTextSize(attLbl)
         local w = textw + padding * 2;
         local h = texth + padding;
         local x = ScrW() - w - gap;
         local y = gap;
         surface.DrawRect(x, y, w, h )
         surface.SetMaterial(matGradR);
         surface.DrawRect(x, y, w, 2);
         surface.DrawRect(x + w - 2, y, 2, h);
         surface.DrawRect(x, y + h - 2, w, 2);

         surface.DrawTexturedRect(x - w / 2, y, w / 2, h );
         surface.DrawTexturedRect(x - w / 2, y, w / 2, 2);
         surface.DrawTexturedRect(x - w / 2, y + h - 2, w / 2, 2);
         draw.SimpleTextOutlined(attLbl, "SH_TTT_HUD3", x + padding, y, Color(255, 255, 255, 200 * self.CustomizeMul), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 2, Color(50, 50, 50, 255 * self.CustomizeMul))

         local yCount = 0;
         for k,v in pairs(self.RegisteredAttachments) do
            for i, j in pairs(v) do
               if (self.EquippedAttachments[k] == j.AttachmentName) then
                  local attName = j.AttachmentName;
                  surface.SetFont("SH_TTT_HUD2")
                  local textw, texth = surface.GetTextSize(attName)
                  surface.SetFont("SH_TTT_HUD1");
                  local descw, desch = surface.GetTextSize(j.Description);

                  descW = w;

                  surface.DrawRect(x - descW + w, y + h + (texth * 2 * yCount) + padding / 2, descW, texth + desch + padding );
                  surface.DrawRect(x - descW + w, y + h + (texth * 2 * yCount) + padding / 2, descW, 2 );
                  surface.DrawRect(x + w - 2, y + h + (texth * 2 * yCount) + padding / 2, 2, texth + desch + padding );
                  surface.DrawRect(x - descW + w, y + h + (texth * 2 * yCount) + padding / 2 + texth + desch + padding - 2, descW, 2 );

                  surface.DrawTexturedRect(x - descW + w / 2, y + h + (texth * 2 * yCount) + padding / 2, descW / 2, texth + desch + padding );
                  surface.DrawTexturedRect(x - descW + w / 2, y + h + (texth * 2 * yCount) + padding / 2, descW / 2, 2);
                  surface.DrawTexturedRect(x - descW + w / 2, y + h + (texth * 2 * yCount) + padding / 2 + texth + desch + padding - 2, descW / 2, 2);

                  draw.SimpleTextOutlined(attName, "SH_TTT_HUD2", x + w - padding, y + h + (texth * 2 * yCount) + 2, Color(255, 255, 255, 200 * self.CustomizeMul), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 2, Color(50, 50, 50, 255 * self.CustomizeMul))
                  draw.SimpleTextOutlined(j.Description, "SH_TTT_HUD1", x + w - padding, y + h + texth + (texth * 2 * yCount) + padding - 2, Color(255, 255, 255, 200 * self.CustomizeMul), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 2, Color(50, 50, 50, 255 * self.CustomizeMul))
                  yCount = yCount + 1;
               end
            end
         end
      end

   		local padding = 5;
   		local boneName = "";

   		for k,v in pairs(self.VElements) do
   			if (v.bone != nil && v.bone != " " && v.bone != "") then
   				boneName = v.bone;
   			end
   		end

		local bone = self.Owner:GetViewModel():LookupBone(boneName);

		if (!bone) then return end

		local pos, ang = Vector(0,0,0), Angle(0,0,0)
		local m = self.Owner:GetViewModel():GetBoneMatrix(bone)
		if (m) then
			pos, ang = m:GetTranslation(), m:GetAngles()
		end

		local ct = 1;
   		for k,v in pairs(self.RegisteredAttachments) do
   			local count = 0;
   			for i, j in pairs(v) do
   				if (self.Owner:GetNWInt("Has" ..j.AttachmentName) == 1 || self:GetNWInt("Has" ..j.AttachmentName) == 1) then
	   				count = count + 1;
   				end
   			end

   			if (count == 0) then continue; end;

   			-- k is cat name
   			local offset = self.CustomizePos[k]

			local _pos = (pos + (offset.x * ang:Forward()) + (offset.y * ang:Right()) ):ToScreen();

			surface.SetDrawColor(0, 0, 0, 200 * self.CustomizeMul);
			surface.SetFont("SH_TTT_HUD2");
			local textw, texth = surface.GetTextSize(k);
         textw = textw + padding * 2.5 + (ScrW() / 32 * (count - 1)) + (padding * (count));
			texth = texth + padding + (ScrW() / 32);
			local x = math.Clamp((_pos.x - textw * 1.8), 0, ScrW());
			local y = math.Clamp((_pos.y / 3), 0, ScrH());
   			surface.DrawRect(x + textw, y, textw, texth);
   			surface.DrawRect(x + textw, y, 2, texth);
   			surface.DrawRect(x + textw, y, textw, 2);
   			surface.DrawRect(x + textw + textw - 2, y, 2, texth);
   			surface.DrawRect(x + textw, y + texth - 2, textw, 2);

   			count = 0;

   			local _ct = 0;

   			for i,j in pairs(v) do
   				if (self.Owner:GetNWInt("Has" ..j.AttachmentName) == 1 || self:GetNWInt("Has" ..j.AttachmentName) == 1) then
   					_ct = _ct + 1;
   				end
   			end

   			for i, j in pairs(v) do
   				if (self.Owner:GetNWInt("Has" ..j.AttachmentName) == 1 || self:GetNWInt("Has" ..j.AttachmentName) == 1) then
	   				surface.SetMaterial(j.Material);
	   				if (self.EquippedAttachments[k] == j.AttachmentName) then
	   					surface.SetDrawColor(255, 255, 255, 255 * self.CustomizeMul);
	   				end
	   				if (_ct >= 2) then
		   				surface.DrawTexturedRect(x + textw + (ScrW() / 32 * (count)) + padding * 2 + (padding * (count)), y + texth - ScrW() / 32 - padding, ScrW() / 32, ScrW() / 32);
	   				else
		   				surface.DrawTexturedRect(x + textw + textw / 2 - ScrW() / 32 / 2, y + texth - ScrW() / 32 - padding, ScrW() / 32, ScrW() / 32);
	   				end
   					surface.SetDrawColor(0, 0, 0, 200 * self.CustomizeMul);
	   				count = count + 1;
   				end
   			end

   			surface.DrawLine(x + textw - 1 + textw, y + texth, _pos.x, _pos.y);
   			surface.DrawLine(x + textw - 2 + textw, y + texth, _pos.x - 1, _pos.y);

			draw.SimpleTextOutlined(k, "SH_TTT_HUD2", x + padding + textw, y, Color(255, 255, 255, 200 * self.CustomizeMul), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 2, Color(50, 50, 50, 255 * self.CustomizeMul))
			draw.SimpleTextOutlined(ct, "SH_TTT_HUD1", x + textw, y - 2, Color(255, 255, 255, 200 * self.CustomizeMul), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 2, Color(50, 50, 50, 255 * self.CustomizeMul))
			ct = ct + 1;
   		end
   end

	local rw, rh = ScrW() / 4, ScrH() / 4;
	local scopeTex = GetRenderTarget("scope", rw, rh, true);
   	local lensdirt = Material("overlays/scope_lens")
	local mat = CreateMaterial("uniquemat"..os.time(), "UnlitGeneric", {
		['$basetexture'] = texture,
	});

	local rDelta = 0;
	local lastR = 0;

	function SWEP:DrawScopes() 
		local r = reticle_r:GetInt();
		local g = reticle_g:GetInt();
		local b = reticle_b:GetInt();
		local shouldDrawRedDot = false;
		local magnification = 0;
		local equippedScopeData = nil;

		for k,v in pairs(self.RegisteredAttachments) do
			local equipped = self.EquippedAttachments[k];
			if (equipped && equipped != "none") then
				local magnif = self.RegisteredAttachments[k][equipped].Magnification;
				if (magnif == 1) then
					shouldDrawRedDot = true;
				end

				if (magnif != 0) then
					magnification = magnif;
					equippedScopeData = self.RegisteredAttachments[k][equipped];
				end
			end
		end

		if (shouldDrawRedDot && self.mul >= 0.9) then
			local bone = self.Owner:GetViewModel():LookupBone(equippedScopeData.Bone);

			if (!bone) then return end

			local pos, ang = Vector(0,0,0), Angle(0,0,0)
			local m = self.Owner:GetViewModel():GetBoneMatrix(bone)
			if (m) then
			pos, ang = m:GetTranslation(), m:GetAngles()
			end

			local boneXPos = pos:ToScreen().x - ScrW() / 2;

			render.SetScissorRect( ScrW() / 3 + boneXPos, ScrH() / 2 - 32, ScrW() / 2 + 512 * self.mul + boneXPos, ScrH() / 2 + 512 * self.mul, true ) -- Enable the rect
            if (equippedScopeData.AttachmentName == "EOTech") then
               surface.SetDrawColor(r, g, b, 230);
               surface.DrawRect(ScrW() / 2, ScrH() / 2, 2, 2 )

               surface.SetDrawColor(r, g, b, 110);
               surface.DrawRect(ScrW() / 2 - 1, ScrH() / 2, 1, 2 )
               surface.DrawRect(ScrW() / 2 + 2, ScrH() / 2, 1, 2 )
               surface.DrawRect(ScrW() / 2, ScrH() / 2 - 1, 2, 1 )
               surface.DrawRect(ScrW() / 2, ScrH() / 2 + 2, 2, 1 )

               surface.DrawCircle(ScrW() / 2 + 1, ScrH() / 2 + 1, ScrH() / 64, r, g, b, 230);

               surface.DrawRect(ScrW() / 2 - ScrH() / 64 - 2, ScrH() / 2, 4, 2 )
               surface.DrawRect(ScrW() / 2, ScrH() / 2 - ScrH() / 64 - 2, 2, 4 )
               surface.DrawRect(ScrW() / 2 + ScrH() / 64 + 1, ScrH() / 2, 4, 2 )
               surface.DrawRect(ScrW() / 2, ScrH() / 2 + ScrH() / 64 + 1, 2, 4 )
            else
            	drawReticle();
            end
			render.SetScissorRect( 0, 0, 0, 0, false ) -- Disable after you are done
		elseif (!shouldDrawRedDot && magnification > 1) then
			local bone = self.Owner:GetViewModel():LookupBone(equippedScopeData.Bone);

			if (!bone) then return end

			local pos, ang = Vector(0,0,0), Angle(0,0,0)
			local m = self.Owner:GetViewModel():GetBoneMatrix(bone)
			if (m) then
			pos, ang = m:GetTranslation(), m:GetAngles()
			end

			local boneXPos = pos:ToScreen().x - ScrW() / 2;

			local w, h = ScrW(), ScrH();

			if (self.mul > 0.9) then
				local OldRT = render.GetRenderTarget()
				render.SetRenderTarget( scopeTex ) -- Change the RenderTarget, so all drawing will be redirected to our new RT

				render.Clear( 0, 0, 0, 255, true ) -- Floodfill with black color

				cam.Start2D()
					render.RenderView( {
						origin = self.Owner:GetPos() + (self.Owner:Crouching() and self.Owner:GetViewOffsetDucked() or self.Owner:GetViewOffset()),
						angles = self.Owner:EyeAngles(),
						x = 0, 0,
						w = rw, h = rh,
						fov = math.floor(60 / magnification),
						drawviewmodel = false
					} )
				cam.End2D()

				render.SetRenderTarget( OldRT )

				surface.SetDrawColor(255, 255, 255, 255);
				surface.SetMaterial(mat);
				rDelta = -(ang.r - lastR) / 5;

				local scopeRadius = ScrH() / equippedScopeData.ScopeRadius;
				local _scopeOffset = equippedScopeData.ScopeOffset;
				local scopeOffset = Vector(0, 0, 0);
				if (_scopeOffset.x != 0) then
					scopeOffset.x = ScrW() / _scopeOffset.x;
				end
				if (_scopeOffset.y != 0) then
					scopeOffset.y = ScrH() / _scopeOffset.y;
				end

				local radii = scopeRadius + self.weaponKick.y * 40


				mat:SetTexture("$basetexture", scopeTex);
				render.SetScissorRect( (ScrW() / 2 - radii - boneXPos - 30) + ScrW() * 2 * (1 - self.mul) - scopeOffset.x,
				(ScrH() / 2 - radii + rDelta * 0.6 - 30) + ScrH() * 2 * (1 - self.mul) - scopeOffset.y,
				(ScrW() / 2 + radii + boneXPos + 30) - ScrW() * 2 * (1 - self.mul) + scopeOffset.x,
				(ScrH() / 2 + radii + rDelta * 0.6 + 30) - ScrH() * 2 * (1 - self.mul) + scopeOffset.y,
				true )

					render.OverrideAlphaWriteEnable(false, true);
					draw.Circle(w / 2 + boneXPos + scopeOffset.x, h / 2 + rDelta * 0.6 + scopeOffset.y, radii, 180);
					surface.SetMaterial(lensdirt);
					draw.Circle(w / 2 + boneXPos + scopeOffset.x, h / 2 + rDelta * 0.6 + scopeOffset.y, radii, 180);

				render.SetScissorRect( 0, 0, 0, 0, false ) -- Disable after you are done

				render.SetScissorRect( ScrW() / 2 + boneXPos - 16, ScrH() / 2 - 16, ScrW() / 2 + 512 * self.mul + boneXPos, ScrH() / 2 + 512 * self.mul, true ) -- Enable the rect
					surface.SetDrawColor(r, g, b, 230);
					surface.DrawRect(ScrW() / 2, ScrH() / 2, 2, 2 )

					surface.SetDrawColor(r, g, b, 110);
					surface.DrawRect(ScrW() / 2 - 1, ScrH() / 2, 1, 2 )
					surface.DrawRect(ScrW() / 2 + 2, ScrH() / 2, 1, 2 )
					surface.DrawRect(ScrW() / 2, ScrH() / 2 - 1, 2, 1 )
					surface.DrawRect(ScrW() / 2, ScrH() / 2 + 2, 2, 1 )
				render.SetScissorRect( 0, 0, 0, 0, false ) -- Disable after you are done

				lastR = Lerp(FrameTime() * 10, lastR, ang.r);
			end
		end
	end

	function drawReticle()
		local reticle = "arrow";
		local r = reticle_r:GetInt();
		local g = reticle_g:GetInt();
		local b = reticle_b:GetInt();

		if (reticle == "dot") then

			surface.SetDrawColor(r, g, b, 230);
			surface.DrawRect(ScrW() / 2, ScrH() / 2, 2, 2 )

			surface.SetDrawColor(r, g, b, 110);
			surface.DrawRect(ScrW() / 2 - 1, ScrH() / 2, 1, 2 )
			surface.DrawRect(ScrW() / 2 + 2, ScrH() / 2, 1, 2 )
			surface.DrawRect(ScrW() / 2, ScrH() / 2 - 1, 2, 1 )
			surface.DrawRect(ScrW() / 2, ScrH() / 2 + 2, 2, 1 )
		elseif (reticle == "arrow") then
			surface.SetDrawColor(r, g, b, 230);
			surface.DrawLine(ScrW() / 2, ScrH() / 2, ScrW() / 2 - 8, ScrH() / 2 + 8);
			surface.DrawLine(ScrW() / 2, ScrH() / 2, ScrW() / 2 + 8, ScrH() / 2 + 8 + 1);
			for i = 1, 3 do
				surface.DrawLine(ScrW() / 2, ScrH() / 2 - 1 + i, ScrW() / 2 - 8, ScrH() / 2 + 8 - 1 + i);
				surface.DrawLine(ScrW() / 2, ScrH() / 2 - 1 + i, ScrW() / 2 + 8, ScrH() / 2 + 8 + i);
			end
		end
	end

   local GetPTranslation = LANG.GetParamTranslation

   -- Many non-gun weapons benefit from some help
   local help_spec = {text = "", font = "TabLarge", xalign = TEXT_ALIGN_CENTER}
   function SWEP:DrawHelp()
      local data = self.HUDHelp

      local translate = data.translatable
      local primary   = data.primary
      local secondary = data.secondary

      if translate then
         primary   = primary   and GetPTranslation(primary,   data.translate_params)
         secondary = secondary and GetPTranslation(secondary, data.translate_params)
      end

      help_spec.pos  = {ScrW() / 2.0, ScrH() - 40}
      help_spec.text = secondary or primary
      draw.TextShadow(help_spec, 2)

      -- if no secondary exists, primary is drawn at the bottom and no top line
      -- is drawn
      if secondary then
         help_spec.pos[2] = ScrH() - 60
         help_spec.text = primary
         draw.TextShadow(help_spec, 2)
      end
   end

   -- mousebuttons are enough for most weapons
   local default_key_params = {
      primaryfire   = Key("+attack",  "LEFT MOUSE"),
      secondaryfire = Key("+attack2", "RIGHT MOUSE"),
      usekey        = Key("+use",     "USE")
   };

   function SWEP:AddHUDHelp(primary_text, secondary_text, translate, extra_params)
      extra_params = extra_params or {}

      self.HUDHelp = {
         primary = primary_text,
         secondary = secondary_text,
         translatable = translate,
         translate_params = table.Merge(extra_params, default_key_params)
      };
   end
end

SWEP.WaitingForScope = false;

function SWEP:SetZoom(state)
   if CLIENT then
      return
   elseif IsValid(self.Owner) and self.Owner:IsPlayer() && self.Owner:GetActiveWeapon() == self then
      if state then
         self.Owner:SetFOV(self.Primary.ZoomFOV, 0.3)
      else
         self.Owner:SetFOV(0, 0.2)
      end
   end
end

SWEP.weaponKick = Vector(0, 0, 0);
local recoilScale = 3;

-- Shooting functions largely copied from weapon_cs_base
function SWEP:PrimaryAttack(worldsnd)
   if (self.IsCustomizing) then return; end;
   if (self:Clip1() <= 0) then
   if not worldsnd then
         self:EmitSound( "weapons/clipempty_rifle.wav", self.Primary.SoundLevel, 100, 1, CHAN_ITEM)
      elseif SERVER then
         sound.Play("weapons/clipempty_rifle.wav", self.Primary.SoundLevel, 100, 1, CHAN_ITEM)
      end
      self:SetNextPrimaryFire( CurTime() + 0.5 )
   return end

   self:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
   self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

   if not self:CanPrimaryAttack() then return end

   if not worldsnd then
      self:EmitSound( self.Primary.Sound, self.Primary.FireSoundLevel, 100, self.Primary.SoundLevel)
   elseif SERVER then
      sound.Play(self.Primary.Sound, self:GetPos(), self.Primary.FireSoundLevel, 100, self.Primary.SoundLevel)
   end

   if (self:GetIronsights()) then
      self:ShootBullet( self.Primary.Damage, self.Primary.Recoil / 2, self.Primary.NumShots, self:GetPrimaryCone() )
   else
      self:ShootBullet( self.Primary.Damage, self.Primary.Recoil, self.Primary.NumShots, self:GetPrimaryCone() )
   end

   if (CLIENT) then
		local magnification = 1;
		for k,v in pairs(self.RegisteredAttachments) do
			local equipped = self.EquippedAttachments[k];
			if (equipped && equipped != "none") then
				local magnif = self.RegisteredAttachments[k][equipped].Magnification;
				if (magnif != 0) then
					magnification = magnif;
				end
			end
		end
      if (self.Primary.Automatic) then
         if(self:GetIronsights() && !isEmpty) then
            self.weaponKick.y = (math.Clamp(self.Primary.Recoil, 0, 1) * recoilScale) / magnification;
         end
      else
         if(self:GetIronsights() && !isEmpty) then
            self.weaponKick.y = (self.Primary.Recoil * 2 * recoilScale) / magnification;
            releasedSinceLast = false;
         end
      end
   end

   self:TakePrimaryAmmo( 1 )

   for k, v in pairs(self.CustomSounds) do
      if (v[1] == "PrimaryAttack") then
         local time = v[2];
         if (self:GetIronsights()) then time = 0.01; end
         timer.Simple(time, function()
         	if (!IsValid(self)) then return end
            if not worldsnd then
               self:EmitSound(v[3], self.Primary.SoundLevel, 100, 1, CHAN_ITEM)
            elseif SERVER then
               sound.Play(v[3], self:GetPos(), self.Primary.SoundLevel, 100, 1, CHAN_ITEM)
            end
         end)
      end
   end

   local owner = self:GetOwner()
   if not IsValid(owner) or owner:IsNPC() or (not owner.ViewPunch) then return end

   owner:ViewPunch( Angle( util.SharedRandom(self:GetClass(),-0.2,-0.1,0) * self.Primary.Recoil * 2, util.SharedRandom(self:GetClass(),-0.1,0.1,1) * self.Primary.Recoil * 2, 0 ) )

   if (self:Clip1() == 0) then self:SetNextPrimaryFire(CurTime() + 1); end

   if (!self.HasScope || self.Primary.Automatic) then return end
   if (self:GetIronsights()) then self.WaitingForScope = true; end
   self:SetZoomed(false);
   self:SetIronsights(false);
   self:SetZoom(false);
   self:SetNextSecondaryFire( CurTime() + 0.1 )
end

SWEP.Zoomed = false;

function SWEP:SetZoomed(condition)
   self.Zoomed = condition;
end

function SWEP:GetZoomed()
   return self.Zoomed;
end


function SWEP:DryFire(setnext)
   if CLIENT and LocalPlayer() == self:GetOwner() then
      --self:EmitSound( "Weapon_Pistol.Empty" )
   end

   setnext(self, CurTime() + 0.2)

   self:Reload(false)
end

function SWEP:CanPrimaryAttack()
   if not IsValid(self:GetOwner()) then return end

   if self:Clip1() <= 0 then
      --self:DryFire(self.SetNextPrimaryFire)
      return false
   end
   return true
end

function SWEP:CanSecondaryAttack()
   if not IsValid(self:GetOwner()) then return end

   if self:Clip2() <= 0 then
      self:DryFire(self.SetNextSecondaryFire)
      return false
   end
   return true
end

local function Sparklies(attacker, tr, dmginfo)
   if tr.HitWorld and tr.MatType == MAT_METAL then
      local eff = EffectData()
      eff:SetOrigin(tr.HitPos)
      eff:SetNormal(tr.HitNormal)
      util.Effect("cball_bounce", eff)
   end
end

local coneAdd = 0;

if (SERVER) then
   SWEP.bulletAtt = nil;
end

function SWEP:ShootBullet( dmg, recoil, numbul, cone )

   if (!self:GetIronsights() || self.HasScope) then
    self:SendWeaponAnim(self.PrimaryAnim)
   end

   if ((self.HasScope && !self:GetIronsights()) || !self.HasScope) then
      self:GetOwner():MuzzleFlash()
      self:GetOwner():SetAnimation( PLAYER_ATTACK1 )
   end

   local sights = self:GetIronsights()

   numbul = numbul or 1
   cone   = cone   or 0.01

   local bullet = {}
   bullet.Num    = numbul
   bullet.Src    = self:GetOwner():GetShootPos()
   bullet.Dir    = self:GetOwner():GetAimVector()
   bullet.Spread = Vector( cone, cone, 0 )
   bullet.Tracer = 4
   bullet.TracerName = self.Tracer or "Tracer"
   bullet.Force  = 10
   bullet.Damage = dmg
   if CLIENT and sparkle:GetBool() then
      bullet.Callback = Sparklies
   end

   coneAdd = coneAdd + self.Primary.Recoil / 75;

   self:GetOwner():FireBullets( bullet )

   if (SERVER) then
      if (self.bulletAtt != nil) then
         self.bulletAtt(self, self.Owner:GetEyeTrace().HitPos)
      end
   end

   -- Owner can die after firebullets
   if (not IsValid(self:GetOwner())) or (not self:GetOwner():Alive()) or self:GetOwner():IsNPC() then return end

   if ((game.SinglePlayer() and SERVER) or
       ((not game.SinglePlayer()) and CLIENT and IsFirstTimePredicted())) then

      -- reduce recoil if ironsighting
      recoil = sights and (recoil * 0.8) or recoil

      local eyeang = self:GetOwner():EyeAngles()
      eyeang.pitch = eyeang.pitch - recoil
      self:GetOwner():SetEyeAngles( eyeang )
   end
end

function SWEP:GetPrimaryCone()
   local cone = self.Primary.Cone or 0.2
   -- 10% accuracy bonus when sighting
   if (self.HasScope) then
      return self:GetIronsights() and (0.001) or cone
   end
   return self:GetIronsights() and (cone * 0.45) or cone
end

function SWEP:GetHeadshotMultiplier(victim, dmginfo)
   return self.HeadshotMultiplier
end

function SWEP:IsEquipment()
   return WEPS.IsEquipment(self)
end

function SWEP:DrawWeaponSelection() end

function SWEP:SecondaryAttack()
   if (self.IsCustomizing) then return; end;
   if (self.HasScope) then
      self.WaitingForScope = false;
      if not self.IronSightsPos then return end
      if self:GetNextSecondaryFire() > CurTime() then return end

      local bIronsights = not self:GetIronsights()

      if (SERVER) then
            if (bIronsights) then
                  timer.Create("ZoomDelay", 0.22, 1, function() self:SetZoom(bIronsights) end);
            else
            self:SetZoom(bIronsights);
            end
      end

      self:SetIronsights( bIronsights )
      self:SetZoomed( !self:GetZoomed() );
      self.AllowDrop = !bIronsights;

       self:EmitSound(self.Secondary.Sound, self.Primary.SoundLevel)

      self:SetNextSecondaryFire(CurTime() + 0.3)
      return
   end

   if self.NoSights or (not self.IronSightsPos) then return end

   self:SetIronsights(not self:GetIronsights())

   self:SetNextSecondaryFire(CurTime() + 0.3)
end

function SWEP:Deploy()
   --[[timer.Simple(0.5, function()
      if (self != nil && self.Owner != nil && IsValid(self.Owner)) then
	      net.Start("InitCClient");
	      net.Send(self.Owner);
      end
   end)]]--

   self:SetIronsights(false)
   self.Owner:SetFOV(0, 0.04)
   if (SERVER and self.Primary.ClipSize > 0) then
      self:EmitSound( self.DeploySound, self.Primary.SoundLevel )
   end

   for k, v in pairs(self.CustomSounds) do
      if (v[1] == "Deploy") then
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

   self.IsCustomizing = false;
   if (SERVER) then
      self:BroadcastClientsideVar("wep.IsCustomizing", false, "Bool");
   end
   return true
end

function SWEP:Reload(bypass)
   if (self.IsCustomizing && !bypass) then return; end;
   if (CLIENT) then
      self.CustomizeMul = 0;
   end
   if ( (self:Clip1() == self.Primary.ClipSize or self:GetOwner():GetAmmoCount( self.Primary.Ammo ) <= 0) && !bypass ) then return end
   if (self:Clip1() == 0) then
    self:DefaultReload(self.EmptyReloadAnim)
    self:SendWeaponAnim(self.EmptyReloadAnim);
   else
    self:DefaultReload(self.ReloadAnim)
    self:SendWeaponAnim(self.ReloadAnim);
   end
   self:SetIronsights( false )

   for k, v in pairs(self.CustomSounds) do
      if (v[1] == "Reload") then
         local time = v[2];
         if (self:GetIronsights()) then time = 0.01; end
         timer.Simple(time, function()
         	if (!IsValid(self)) then return end
            if not worldsnd then
               self:EmitSound(v[3], self.Primary.SoundLevel, 100, 1, CHAN_ITEM)
            elseif SERVER then
               sound.Play(v[3], self:GetPos(), self.Primary.SoundLevel, 100, 1, CHAN_ITEM)
            end
         end)
      end
   end

   if (self.HasScope) then
   self:SetZoom( false )
   end
end


function SWEP:OnRestore()
   self.NextSecondaryAttack = 0
   self:SetIronsights( false )
end

function SWEP:OnRemove()
   self:Holster()
end

function SWEP:Ammo1()
   return IsValid(self:GetOwner()) and self:GetOwner():GetAmmoCount(self.Primary.Ammo) or false
end

function SWEP:Holster()
   if (IsValid(self.Owner) && self.Owner:GetActiveWeapon() == self && self.IsCustomizing && self.RegisteredAttachments != {}) then return false end;
   self.IsCustomizing = false;

   if (CLIENT) then
      self.CustomizeMul = 0;
   end

   if (self.HasScope) then return true; end
   self:SetIronsights(false)
   self:SetZoom(false)
   if(IsValid(self.Owner)) then
      self.Owner:SetFOV(0, 0.2)
   end

   -- SWEP Creator kit
   if CLIENT and IsValid(self.Owner) then
      local vm = self.Owner:GetViewModel()
      if IsValid(vm) then
         self:ResetBonePositions(vm)
      end
   end

   return true
end

-- The OnDrop() hook is useless for this as it happens AFTER the drop. OwnerChange
-- does not occur when a drop happens for some reason. Hence this thing.
function SWEP:PreDrop()

   if (self.HasScope) then
   self:SetZoom(false)
   self:SetZoomed(false)
   self:SetIronsights(false)
   end

   if (IsValid(self.Owner)) then
      self.Owner:SetFOV(0, 0.2);
   end

   if SERVER and IsValid(self:GetOwner()) and self.Primary.Ammo != "none" then
      local ammo = self:Ammo1()

      -- Do not drop ammo if we have another gun that uses this type
      for _, w in pairs(self:GetOwner():GetWeapons()) do
         if IsValid(w) and w != self and w:GetPrimaryAmmoType() == self:GetPrimaryAmmoType() then
            ammo = 0
         end
      end

      self.StoredAmmo = ammo

      if ammo > 0 then
         self:GetOwner():RemoveAmmo(ammo, self.Primary.Ammo)
      end
   end
end

function SWEP:DampenDrop()
   -- For some reason gmod drops guns on death at a speed of 400 units, which
   -- catapults them away from the body. Here we want people to actually be able
   -- to find a given corpse's weapon, so we override the velocity here and call
   -- this when dropping guns on death.
   local phys = self:GetPhysicsObject()
   if IsValid(phys) then
      phys:SetVelocityInstantaneous(Vector(0,0,-75) + phys:GetVelocity() * 0.001)
      phys:AddAngleVelocity(phys:GetAngleVelocity() * -0.99)
   end
end

local SF_WEAPON_START_CONSTRAINED = 1

-- Picked up by player. Transfer of stored ammo and such.

SWEP.HasInitVars = false;

function SWEP:Equip(newowner)

   if (SERVER && !self.HasInitVars) then
      self:AttachmentRegister();

      local attData = self.RegisteredAttachments;

      local actualData = {};

      for k, v in pairs(attData) do
         actualData[k] = {};
         for i, j in pairs(attData[k]) do
            actualData[k][i] = {};
            actualData[k][i].Bone = attData[k][i].Bone;
            actualData[k][i].ModelPos = attData[k][i].ModelPos;
            actualData[k][i].ModelAng = attData[k][i].ModelAng;
            actualData[k][i].ModelSize = attData[k][i].ModelSize;
            actualData[k][i].Parent = attData[k][i].Parent;

            actualData[k][i].WModelBone = attData[k][i].WModelBone;
            actualData[k][i].WModelPos = attData[k][i].WModelPos;
            actualData[k][i].WModelAng = attData[k][i].WModelAng;
            actualData[k][i].WModelSize = attData[k][i].WModelSize;
            actualData[k][i].WModelParent = attData[k][i].WModelParent;


            actualData[k][i].AttachmentName = attData[k][i].AttachmentName;
            actualData[k][i].Model = attData[k][i].Model;
            actualData[k][i].Image = attData[k][i].Image;
            actualData[k][i].Group = attData[k][i].Group;
            actualData[k][i].Magnification = attData[k][i].Magnification;
            if (attData[k][i].Description) then
               actualData[k][i].Description = attData[k][i].Description;
            else
               actualData[k][i].Description = "Default Attachment Description";
            end
            actualData[k][i].Reticle = attData[k][i].Reticle;
            actualData[k][i].ScopeRadius = attData[k][i].ScopeRadius;
            actualData[k][i].HideModel = attData[k][i].HideModel;
            actualData[k][i].ScopeOffset = attData[k][i].ScopeOffset;
         end
      end

      timer.Simple(0.01, function()
         local isDone = false;
         while(IsValid(self) && actualData != nil && actualData != {} && !isDone) do
            net.Start("RegisterAttachments");
               net.WriteTable(actualData);
               net.WriteEntity(self);
            net.Broadcast();
            isDone = true;
         end
      end)

      self.HasInitVars = true;
   end

   if SERVER then
      if self:IsOnFire() then
         self:Extinguish()
      end

      self.fingerprints = self.fingerprints or {}

      if not table.HasValue(self.fingerprints, newowner) then
         table.insert(self.fingerprints, newowner)
      end

      if self:HasSpawnFlags(SF_WEAPON_START_CONSTRAINED) then
         -- If this weapon started constrained, unset that spawnflag, or the
         -- weapon will be re-constrained and float
         local flags = self:GetSpawnFlags()
         local newflags = bit.band(flags, bit.bnot(SF_WEAPON_START_CONSTRAINED))
         self:SetKeyValue("spawnflags", newflags)
      end
   end

   if SERVER and IsValid(newowner) and self.StoredAmmo > 0 and self.Primary.Ammo != "none" then
      local ammo = newowner:GetAmmoCount(self.Primary.Ammo)
      local given = math.min(self.StoredAmmo, self.Primary.ClipMax - ammo)

      newowner:GiveAmmo( given, self.Primary.Ammo)
      self.StoredAmmo = 0
   end
end

-- We were bought as special equipment, some weapons will want to do something
-- extra for their buyer
function SWEP:WasBought(buyer)
end

function SWEP:SetIronsights(b)
   self:SetIronsightsPredicted(b)
   self:SetIronsightsTime(CurTime())
   if CLIENT then
      --self:CalcViewModel()
   end
end
function SWEP:GetIronsights()
   return self:GetIronsightsPredicted()
end

--- Dummy functions that will be replaced when SetupDataTables runs. These are
--- here for when that does not happen (due to e.g. stacking base classes)
function SWEP:GetIronsightsTime() return -1 end
function SWEP:SetIronsightsTime() end
function SWEP:GetIronsightsPredicted() return false end
function SWEP:SetIronsightsPredicted() end

-- Set up ironsights dt bool. Weapons using their own DT vars will have to make
-- sure they call this.
function SWEP:SetupDataTables()
   self:NetworkVar("Bool", 3, "IronsightsPredicted")
   self:NetworkVar("Float", 3, "IronsightsTime")
end

function SWEP:OnRemove()
   if (CLIENT) then
      for k,v in pairs(self.VElements) do
         if (!v.modelEnt) then continue; end;
         v.modelEnt:Remove();
      end

      for k,v in pairs(self.WElements) do
         if (!v.modelEnt) then continue; end;
         v.modelEnt:Remove();
      end
   end
end

function SWEP:AttachmentRegister() end

SWEP.HasReceivedAtt = false;

function SWEP:Initialize()

	if (SERVER) then
		self:AttachmentRegister();

		local attData = self.RegisteredAttachments;

		local actualData = {};

		for k, v in pairs(attData) do
			actualData[k] = {};
			for i, j in pairs(attData[k]) do
				actualData[k][i] = {};
				actualData[k][i].Bone = attData[k][i].Bone;
				actualData[k][i].ModelPos = attData[k][i].ModelPos;
				actualData[k][i].ModelAng = attData[k][i].ModelAng;
				actualData[k][i].ModelSize = attData[k][i].ModelSize;
				actualData[k][i].Parent = attData[k][i].Parent;

				actualData[k][i].WModelBone = attData[k][i].WModelBone;
				actualData[k][i].WModelPos = attData[k][i].WModelPos;
				actualData[k][i].WModelAng = attData[k][i].WModelAng;
				actualData[k][i].WModelSize = attData[k][i].WModelSize;
				actualData[k][i].WModelParent = attData[k][i].WModelParent;


				actualData[k][i].AttachmentName = attData[k][i].AttachmentName;
				actualData[k][i].Model = attData[k][i].Model;
				actualData[k][i].Image = attData[k][i].Image;
				actualData[k][i].Group = attData[k][i].Group;
				actualData[k][i].Magnification = attData[k][i].Magnification;
            if (attData[k][i].Description) then
               actualData[k][i].Description = attData[k][i].Description;
            else
               actualData[k][i].Description = "Default Attachment Description";
            end
            actualData[k][i].Reticle = attData[k][i].Reticle;
				actualData[k][i].ScopeRadius = attData[k][i].ScopeRadius;
				actualData[k][i].HideModel = attData[k][i].HideModel;
				actualData[k][i].ScopeOffset = attData[k][i].ScopeOffset;
			end
		end

      timer.Simple(1, function()
         local isDone = false;
         while(IsValid(self) && actualData != nil && actualData != {} && !isDone) do
            net.Start("RegisterAttachments");
               net.WriteTable(actualData);
               net.WriteEntity(self);
            net.Broadcast();
            isDone = true;
         end
      end)

	end

	for k, v in pairs(self.RegisteredAttachments) do
		for i, j in pairs(self.RegisteredAttachments[k]) do
			self.VElements[j.AttachmentName] = { type = "Model", hide = true, model = j.Model, bone = j.Bone, rel = j.Parent, pos = j.ModelPos, angle = j.ModelAng, size = j.ModelSize, color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} };
			self.WElements[j.AttachmentName] = { type = "Model", hide = true, model = j.Model, bone = j.WModelBone, rel = j.WModelParent, pos = j.WModelPos, angle = j.WModelAng, size = j.WModelSize, color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} };
			if (j.Parent && j.Parent != "" && self.WElements != nil && self.WElements[j.WModelParent] != nil) then
				self.VElements[j.Parent].hide = true;
			end
			if (j.WModelParent && j.WModelParent != "" && self.WElements != nil && self.WElements[j.WModelParent] != nil) then
				self.WElements[j.WModelParent].hide = true;
			end
		end
	end

   if CLIENT and self:Clip1() == -1 then
      self:SetClip1(self.Primary.DefaultClip)
   elseif SERVER then
      self.fingerprints = {}

      self:SetIronsights(false)
   end

   self:SetDeploySpeed(self.DeploySpeed)

   -- compat for gmod update
   if self.SetHoldType then
      self:SetHoldType(self.HoldType or "pistol")
   end

   -- SWEP Creator kit
   if CLIENT then
      // Create a new table for every weapon instance
      self.VElements = table.FullCopy( self.VElements )
      self.WElements = table.FullCopy( self.WElements )
      self.ViewModelBoneMods = table.FullCopy( self.ViewModelBoneMods )

      self:CreateModels(self.VElements) // create viewmodels
      self:CreateModels(self.WElements) // create worldmodels
      
      // init view model bone build function
      if IsValid(self.Owner) then
         local vm = self.Owner:GetViewModel()
         if IsValid(vm) then
            self:ResetBonePositions(vm)
            
            // Init viewmodel visibility
            if (self.ShowViewModel == nil or self.ShowViewModel) then
               vm:SetColor(Color(255,255,255,255))
            else
               // we set the alpha to 1 instead of 0 because else ViewModelDrawn stops being called
               vm:SetColor(Color(255,255,255,1))
               // ^ stopped working in GMod 13 because you have to do Entity:SetRenderMode(1) for translucency to kick in
               // however for some reason the view model resets to render mode 0 every frame so we just apply a debug material to prevent it from drawing
               vm:SetMaterial("Debug/hsv")         
            end
         end
      end
      
   end

end

SWEP.punched = false;

SWEP.VReleased = true;
SWEP.IsCustomizing = false;

SWEP.ReloadOnNotCustomizing = false;

-- Note that if you override Think in your SWEP, you should call
-- BaseClass.Think(self) so as not to break ironsights
function SWEP:Think()

   if (self.ReloadOnNotCustomizing && !self.IsCustomizing) then
      timer.Simple(0.2, function()
         self:Reload(true);
      end)
      self.ReloadOnNotCustomizing = false;
   end

   coneAdd = Lerp(FrameTime() * 10, coneAdd, 0);
   if (self.HasScope) then
      if (self:GetNextPrimaryFire() > CurTime() + 0.6) then return end
      if (self:GetNextSecondaryFire() < CurTime() && self.WaitingForScope) then
         self:SecondaryAttack(true);
      end
      return
   end
end

function SWEP:DyingShot()
   local fired = false
   if self:GetIronsights() then
      self:SetIronsights(false)

      if self:GetNextPrimaryFire() > CurTime() then
         return fired
      end

      -- Owner should still be alive here
      if IsValid(self:GetOwner()) then
         local punch = self.Primary.Recoil or 5

         -- Punch view to disorient aim before firing dying shot
         local eyeang = self:GetOwner():EyeAngles()
         eyeang.pitch = eyeang.pitch - math.Rand(-punch, punch)
         eyeang.yaw = eyeang.yaw - math.Rand(-punch, punch)
         self:GetOwner():SetEyeAngles( eyeang )

         MsgN(self:GetOwner():Nick() .. " fired his DYING SHOT")

         self:GetOwner().dying_wep = self

         self:PrimaryAttack(true)

         fired = true
      end
   end

   return fired
end

local ttt_lowered = CreateConVar("ttt_ironsights_lowered", "1", FCVAR_ARCHIVE)
local host_timescale = GetConVar("host_timescale")

local LOWER_POS = Vector(0, 0, -2)

SWEP.IRONSIGHT_TIME = 0.75

SWEP.CustomizeData = {pos = Vector(7, -5, -3), ang = Angle(0, 15, 50)}
SWEP.CustomizeMul = 0;

if (CLIENT) then

  local fwdSpeed, sideSpeed = 0, 0;
  local xBob, xBobDir, yBob, yBobDir, xBobReal, yBobReal = 0, false, 0, true, 0, 0;
  local bobSpeed, realBobSpeedX, realBobSpeedY = .5, 0, 0;
  local bobAmount = .8;
  local zVelocity = 0;
  SWEP.mul = 0;
  SWEP.IRONSIGHT_TIME = 5;
  local realIronsightTime = 0;
  local swayMult = 1;
  local xRot = 0;

  function SWEP:CalcView(_, pos, ang)
    fwdSpeed = Lerp(FrameTime(), fwdSpeed, Vector(self.Owner:GetVelocity().x, self.Owner:GetVelocity().y, 0):Length());
    sideSpeed = Lerp(FrameTime() * 10, sideSpeed, (self.Owner:GetVelocity() * self.Owner:EyeAngles():Right()):Length() / 40);
    if ((self.Owner:GetVelocity() * self.Owner:EyeAngles():Right()).x > 0) then -- right
      xRot = Lerp(FrameTime() * 10, xRot, sideSpeed);
    else -- left
      xRot = Lerp(FrameTime() * 10, xRot, -sideSpeed);
    end

    if (!self:GetIronsights()) then

      --bobSpeed = fwdSpeed / 30 + 0.5;
      --bobAmount = fwdSpeed / 250 + 0.5;

      if (xBob >= bobAmount - 0.4) then
        realBobSpeedX = Lerp(FrameTime() * bobSpeed * 8, realBobSpeedX, 0);
        if (realBobSpeedX <= 0.1) then
          xBobDir = false;
        end
      elseif (xBob <= -bobAmount + 0.4) then
        realBobSpeedX = Lerp(FrameTime() * bobSpeed * 8, realBobSpeedX, 0);
        if (realBobSpeedX <= 0.1) then
          xBobDir = true;
        end
      end

      if (yBob >= bobAmount * 1.2 - 0.4) then
        realBobSpeedY = Lerp(FrameTime() * bobSpeed * 8, realBobSpeedY, 0);
        if (realBobSpeedY <= 0.1) then
          yBobDir = false;
        end
      elseif (yBob <= -bobAmount * 1.2 + 0.4) then
        realBobSpeedY = Lerp(FrameTime() * bobSpeed * 8, realBobSpeedY, 0);
        if (realBobSpeedY <= 0.1) then
          yBobDir = true;
        end
      end

      if (xBobDir) then
        realBobSpeedX = Lerp(FrameTime() * bobSpeed, realBobSpeedX, bobSpeed);
        xBob = Lerp(FrameTime() * realBobSpeedX, xBob, bobAmount);
        xBobReal = (math.EaseInOut((xBob + 1) / 2, 1, 0.4) - 1) * 2;
      else
        realBobSpeedX = Lerp(FrameTime() * bobSpeed, realBobSpeedX, bobSpeed);
        xBob = Lerp(FrameTime() * realBobSpeedX, xBob, -bobAmount);
        xBobReal = (math.EaseInOut((xBob + 1) / 2, 1, 0.4) - 1) * 2;
      end

      if (yBobDir) then
        realBobSpeedY = Lerp(FrameTime() * bobSpeed, realBobSpeedY, bobSpeed);
        yBob = Lerp(FrameTime() * realBobSpeedY, yBob, bobAmount * 1.2);
        yBobReal = (math.EaseInOut((yBob + 1) / 2, 1, 0.4) - 1) * 2;
      else
        realBobSpeedY = Lerp(FrameTime() * bobSpeed, realBobSpeedY, bobSpeed);
        yBob = Lerp(FrameTime() * realBobSpeedY, yBob, -bobAmount * 1.2);
        yBobReal = (math.EaseInOut((yBob + 1) / 2, 1, 0.4) - 1) * 2;
      end

    else
      xBobReal = Lerp(FrameTime() * self.IRONSIGHT_TIME, xBobReal, 0);
      yBobReal = Lerp(FrameTime() * self.IRONSIGHT_TIME, yBobReal, 0);
    end

    return pos, ang;
  end

  local isEmpty = false;

    SWEP.pressedKeys = {};

    function SWEP:Think()

    	local hasAttachment = false;

    	for k,v in pairs(self.RegisteredAttachments) do
    		for i, j in pairs(self.RegisteredAttachments[k]) do
    			if (self.Owner:GetNWInt("Has" ..i) == 1 || self:GetNWInt("Has" ..i) == 1) then
    				hasAttachment = true;
    			end
    		end
    	end

    	if (!hasAttachment) then
    		self.IsCustomizing = false;
    	end

		if (self.VReleased && input.IsKeyDown(_G["KEY_" ..string.upper(cstmKey:GetString())]) && !isChatting && table.Count(self.RegisteredAttachments) > 0 && hasAttachment && (self.CustomizeMul > 0.98 || self.CustomizeMul < 0.05)) then
			self.VReleased = false;
			self.IsCustomizing = !self.IsCustomizing;
			net.Start( "CustomizeEvent" )
			net.WriteBool(self.IsCustomizing);
			net.SendToServer();
		elseif (!input.IsKeyDown(_G["KEY_" ..string.upper(cstmKey:GetString())])) then
			self.VReleased = true;
		end

		local count = -1;
		for k,v in pairs(self.RegisteredAttachments) do

			local __ct = 0;

			for i,j in pairs(v) do
   				if (self.Owner:GetNWInt("Has" ..j.AttachmentName) == 1 || self:GetNWInt("Has" ..j.AttachmentName) == 1) then
   					__ct = __ct + 1;
   				end
			end

			if (__ct > 0) then
				count = count + 1;
			end

			if (self.pressedKeys["KEY_" ..count + 1] == nil) then self.pressedKeys["KEY_" ..count + 1] = 0; end

			if (self.pressedKeys["KEY_" ..count + 1] == 0 && input.IsKeyDown(_G["KEY_" .. count + 1]) && self.IsCustomizing) then
				local equipNext = false;

				local ___ct = 0;
				for i,j in pairs(v) do
	   				if (self.Owner:GetNWInt("Has" ..j.AttachmentName) == 1 || self:GetNWInt("Has" ..j.AttachmentName) == 1) then
	   					___ct = ___ct + 1;
	   				end
				end

				local selectedCat = k;
				local selectedSubCat = v;

				if (___ct == 0) then
					for a,b in pairs(self.RegisteredAttachments) do
						for c,d in pairs(b) do
			   				if ((self.Owner:GetNWInt("Has" ..d.AttachmentName) == 1 || self:GetNWInt("Has" ..d.AttachmentName) == 1) && selectedSubCat == v) then
			   					selectedCat = a;
			   					selectedSubCat = b;
			   				end
		   				end
					end
				end

				local ct = 0;

				for i,j in pairs(selectedSubCat) do
	   				if (self.Owner:GetNWInt("Has" ..j.AttachmentName) == 1 || self:GetNWInt("Has" ..j.AttachmentName) == 1) then
	   					ct = ct + 1;
	   				end
				end

				local _ct = 0;
				for i,j in pairs(selectedSubCat) do
	   				if (self.Owner:GetNWInt("Has" ..j.AttachmentName) == 1 || self:GetNWInt("Has" ..j.AttachmentName) == 1) then
	   					local equipped = self.EquippedAttachments[selectedCat];
	   					if (equipped == "none" || equipNext) then
	   						if (self.EquippedAttachments[selectedCat] != "none") then
			   					net.Start("EquipAttachment");
			   						net.WriteBool(false);
		   							net.WriteString(selectedCat);
			   						net.WriteString(self.EquippedAttachments[selectedCat]);
			   						net.WriteTable(self.EquippedAttachments);
			   					net.SendToServer();
	   						end
	   						self.EquippedAttachments[selectedCat] = i;

                        net.Start("EquipAttachment");
                           net.WriteBool(true);
                           net.WriteString(selectedCat);
                           net.WriteString(self.EquippedAttachments[selectedCat]);
                           net.WriteTable(self.EquippedAttachments);
                        net.SendToServer();
                        break;
	   					end

	   					if (equipped == i) then
		   					equipNext = true;
		   					if (ct == (_ct + 1)) then
								self.VElements[i].hide = true;
								self.WElements[i].hide = true;
			   					net.Start("EquipAttachment");
			   						net.WriteBool(false);
		   							net.WriteString(selectedCat);
			   						net.WriteString(self.EquippedAttachments[selectedCat]);
			   						net.WriteTable(self.EquippedAttachments);
			   					net.SendToServer();
		   						self.EquippedAttachments[selectedCat] = "none";
		   					end
	   					end

	   					net.Start("EquipAttachment");
	   						net.WriteBool(true);
   							net.WriteString(selectedCat);
	   						net.WriteString(self.EquippedAttachments[selectedCat]);
	   						net.WriteTable(self.EquippedAttachments);
	   					net.SendToServer();
						_ct = _ct + 1;
	   				end
				end
				surface.PlaySound("weapons/weapon_deploy" ..math.random(1, 3).. ".wav");
				self.pressedKeys["KEY_" ..count + 1] = 1;
			elseif (self.pressedKeys["KEY_" ..count + 1] == 1 && !input.IsKeyDown(_G["KEY_" .. count + 1])) then
				self.pressedKeys["KEY_" ..count + 1] = 0;
			end
		end

		self.CustomizeMul = Lerp(FrameTime() * 5, self.CustomizeMul, (self.IsCustomizing and 1) or 0);

		self.weaponKick = LerpVector(FrameTime() * 15, self.weaponKick, Vector(0, 0, 0));

		if (!releasedSinceLast && !input.IsMouseDown(MOUSE_LEFT)) then releasedSinceLast = true; end
		if (self:Clip1() == 0) then isEmpty = true; else isEmpty = false; end
  end


  local oldEyeAngles = Angle(0, 0, 0);
  local SmoothEyeAngles = Angle(0, 0, 0);

  function SWEP:GetViewModelPosition( pos, ang )
    if(!IsValid(self.Owner)) then return pos, ang; end
     self.SwayScale = 0;
    local deltatime = FrameTime();
     local eyeAngleDelta = self.Owner:EyeAngles() - oldEyeAngles;

     oldEyeAngles = self.Owner:EyeAngles();

     SmoothEyeAngles = LerpAngle(deltatime * 4, SmoothEyeAngles, eyeAngleDelta);

     -- falling animation, disabled because of complaints

     --[[if (self.Owner:GetVelocity().z < -100) then
       zVelocity = math.EaseInOut(self.Owner:GetVelocity().z / 500, 0.5, 0.5);
     else
       zVelocity = Lerp(deltatime, zVelocity, 0);
     end]]--

     if (self:GetIronsights()) then
      self.mul = Lerp(deltatime * self.IRONSIGHT_TIME, self.mul, 1);
      swayMult = Lerp(deltatime * self.IRONSIGHT_TIME, swayMult, 0.1);
      self.BobScale = Lerp(deltatime * self.IRONSIGHT_TIME, self.BobScale, 0.2 );
      pos = pos + (-xRot / 40) * ang:Right();
      self.BobScale = .2;
     else
      self.mul = Lerp(deltatime * self.IRONSIGHT_TIME, self.mul, 0);
      swayMult = Lerp(deltatime * self.IRONSIGHT_TIME, swayMult, 1);
      self.BobScale = Lerp(deltatime * self.IRONSIGHT_TIME, self.BobScale, 1 );
      self.BobScale = 1;
     end

     ang:RotateAroundAxis(ang:Forward() + ang:Up(), -SmoothEyeAngles.y * swayMult);
     ang:RotateAroundAxis(ang:Forward() * ang:Right(), SmoothEyeAngles.p * swayMult);
     ang:RotateAroundAxis(ang:Right(), -math.Clamp(zVelocity, -10, 10)); 

	ang:RotateAroundAxis(ang:Right(), self.CustomizeData.ang.y * self.CustomizeMul);
	ang:RotateAroundAxis(ang:Up(), self.CustomizeData.ang.r * self.CustomizeMul);

     pos = pos + Vector(SmoothEyeAngles.y / 8 * swayMult, 0, SmoothEyeAngles.p / 2 * swayMult);
     pos = pos + (self.weaponKick.x + self.IronSightsPos.x + self.IronSightsPosAdd.x) * ang:Right() * self.mul + (self.CustomizeData.pos.x) * ang:Right() * self.CustomizeMul;
     pos = pos + (-self.weaponKick.y + self.IronSightsPos.y + self.IronSightsPosAdd.y) * ang:Forward() * self.mul + (self.CustomizeData.pos.y) * ang:Forward() * self.CustomizeMul;
     pos = pos + (self.weaponKick.z + self.IronSightsPos.z + self.IronSightsPosAdd.z) * ang:Up() * self.mul + (self.CustomizeData.pos.z) * ang:Up() * self.CustomizeMul;
     ang = ang * 1;
     ang:RotateAroundAxis( ang:Right(), (self.IronSightsAng.x + self.IronSightsAngAdd.x) * self.mul)
     ang:RotateAroundAxis( ang:Up(), (self.IronSightsAng.y + self.IronSightsAngAdd.y) * self.mul)
     ang:RotateAroundAxis( ang:Forward(), (self.IronSightsAng.z + self.IronSightsAngAdd.z) * self.mul)

     pos = pos + Vector(0, xBobReal / 4, yBobReal / 4);
     ang:RotateAroundAxis(ang:Forward(), -xBobReal);

     return pos, ang;
  end

end

function SWEP:RegisterSound(event, timing, sound)
   table.insert(self.CustomSounds, {event, timing, sound});
end

-- SWEP Creator kit

if CLIENT then

   SWEP.vRenderOrder = nil
   function SWEP:ViewModelDrawn()
      
      local vm = self.Owner:GetViewModel()
      if !IsValid(vm) then return end
      
      if (!self.VElements) then return end
      
      self:UpdateBonePositions(vm)

      if (!self.vRenderOrder) then
         
         // we build a render order because sprites need to be drawn after models
         self.vRenderOrder = {}

         for k, v in pairs( self.VElements ) do
            if (v.type == "Model") then
               table.insert(self.vRenderOrder, 1, k)
            elseif (v.type == "Sprite" or v.type == "Quad") then
               table.insert(self.vRenderOrder, k)
            end
         end
         
      end

      for k, name in ipairs( self.vRenderOrder ) do
      
         local v = self.VElements[name]
         if (!v) then self.vRenderOrder = nil break end
         if (v.hide) then continue end
         
         local model = v.modelEnt
         local sprite = v.spriteMaterial
         
         if (!v.bone) then continue end
         
         local pos, ang = self:GetBoneOrientation( self.VElements, v, vm )
         
         if (!pos) then continue end
         
         if (v.type == "Model" and IsValid(model)) then

            model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
            ang:RotateAroundAxis(ang:Up(), v.angle.y)
            ang:RotateAroundAxis(ang:Right(), v.angle.p)
            ang:RotateAroundAxis(ang:Forward(), v.angle.r)

            model:SetAngles(ang)
            //model:SetModelScale(v.size)
            local matrix = Matrix()
            matrix:Scale(v.size)
            model:EnableMatrix( "RenderMultiply", matrix )
            
            if (v.material == "") then
               model:SetMaterial("")
            elseif (model:GetMaterial() != v.material) then
               model:SetMaterial( v.material )
            end
            
            if (v.skin and v.skin != model:GetSkin()) then
               model:SetSkin(v.skin)
            end
            
            if (v.bodygroup) then
               for k, v in pairs( v.bodygroup ) do
                  if (model:GetBodygroup(k) != v) then
                     model:SetBodygroup(k, v)
                  end
               end
            end
            
            if (v.surpresslightning) then
               render.SuppressEngineLighting(true)
            end
            
            render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
            render.SetBlend(v.color.a/255)
            model:DrawModel()
            render.SetBlend(1)
            render.SetColorModulation(1, 1, 1)
            
            if (v.surpresslightning) then
               render.SuppressEngineLighting(false)
            end
            
         elseif (v.type == "Sprite" and sprite) then
            
            local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
            render.SetMaterial(sprite)
            render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
            
         elseif (v.type == "Quad" and v.draw_func) then
            
            local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
            ang:RotateAroundAxis(ang:Up(), v.angle.y)
            ang:RotateAroundAxis(ang:Right(), v.angle.p)
            ang:RotateAroundAxis(ang:Forward(), v.angle.r)
            
            cam.Start3D2D(drawpos, ang, v.size)
               v.draw_func( self )
            cam.End3D2D()

         end
         
      end
      
   end

   SWEP.wRenderOrder = nil
   function SWEP:DrawWorldModel()
      if (self.ShowWorldModel == nil or self.ShowWorldModel) then
         if (self.CrotchGun && IsValid(self.Owner) && self.Owner:Alive() && self.Owner:GetAttachment(self.Owner:LookupAttachment("anim_attachment_rh"))) then
            local hand, offset, rotate

               if not IsValid(self.Owner) then
                  self:DrawModel()
                  return
               end

               hand = self.Owner:GetAttachment(self.Owner:LookupAttachment("anim_attachment_rh"))

               offset = hand.Ang:Right() * 1 + hand.Ang:Forward() * 2 + hand.Ang:Up() * 0

               hand.Ang:RotateAroundAxis(hand.Ang:Right(), 10)
               hand.Ang:RotateAroundAxis(hand.Ang:Forward(), 10)
               hand.Ang:RotateAroundAxis(hand.Ang:Up(), 0)

               self:SetRenderOrigin(hand.Pos + offset)
               self:SetRenderAngles(hand.Ang)

               self:DrawModel()

               if (CLIENT) then
                  self:SetModelScale(1,1,1)
               end
         else
            self:DrawModel();
         end
      end
      
      if (!self.WElements) then return end
      
      if (!self.wRenderOrder) then

         self.wRenderOrder = {}

         for k, v in pairs( self.WElements ) do
            if (v.type == "Model") then
               table.insert(self.wRenderOrder, 1, k)
            elseif (v.type == "Sprite" or v.type == "Quad") then
               table.insert(self.wRenderOrder, k)
            end
         end

      end
      
      if (IsValid(self.Owner)) then
         bone_ent = self.Owner
      else
         // when the weapon is dropped
         bone_ent = self
      end
      
      for k, name in pairs( self.wRenderOrder ) do
      
         local v = self.WElements[name]
         if (!v) then self.wRenderOrder = nil break end
         if (v.hide) then continue end
         
         local pos, ang
         
         if (v.bone) then
            pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent )
         else
            pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand" )
         end
         
         if (!pos) then continue end
         
         local model = v.modelEnt
         local sprite = v.spriteMaterial
         
         if (v.type == "Model" and IsValid(model)) then

            model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
            ang:RotateAroundAxis(ang:Up(), v.angle.y)
            ang:RotateAroundAxis(ang:Right(), v.angle.p)
            ang:RotateAroundAxis(ang:Forward(), v.angle.r)

            model:SetAngles(ang)
            //model:SetModelScale(v.size)
            local matrix = Matrix()
            matrix:Scale(v.size)
            model:EnableMatrix( "RenderMultiply", matrix )
            
            if (v.material == "") then
               model:SetMaterial("")
            elseif (model:GetMaterial() != v.material) then
               model:SetMaterial( v.material )
            end
            
            if (v.skin and v.skin != model:GetSkin()) then
               model:SetSkin(v.skin)
            end
            
            if (v.bodygroup) then
               for k, v in pairs( v.bodygroup ) do
                  if (model:GetBodygroup(k) != v) then
                     model:SetBodygroup(k, v)
                  end
               end
            end
            
            if (v.surpresslightning) then
               render.SuppressEngineLighting(true)
            end
            
            render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
            render.SetBlend(v.color.a/255)
            model:DrawModel()
            render.SetBlend(1)
            render.SetColorModulation(1, 1, 1)
            
            if (v.surpresslightning) then
               render.SuppressEngineLighting(false)
            end
            
         elseif (v.type == "Sprite" and sprite) then
            
            local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
            render.SetMaterial(sprite)
            render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
            
         elseif (v.type == "Quad" and v.draw_func) then
            
            local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
            ang:RotateAroundAxis(ang:Up(), v.angle.y)
            ang:RotateAroundAxis(ang:Right(), v.angle.p)
            ang:RotateAroundAxis(ang:Forward(), v.angle.r)
            
            cam.Start3D2D(drawpos, ang, v.size)
               v.draw_func( self )
            cam.End3D2D()

         end
         
      end
      
   end

   function SWEP:GetBoneOrientation( basetab, tab, ent, bone_override )
      
      local bone, pos, ang
      if (tab.rel and tab.rel != "") then
         
         local v = basetab[tab.rel]
         
         if (!v) then return end
         
         // Technically, if there exists an element with the same name as a bone
         // you can get in an infinite loop. Let's just hope nobody's that stupid.
         pos, ang = self:GetBoneOrientation( basetab, v, ent )
         
         if (!pos) then return end
         
         pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
         ang:RotateAroundAxis(ang:Up(), v.angle.y)
         ang:RotateAroundAxis(ang:Right(), v.angle.p)
         ang:RotateAroundAxis(ang:Forward(), v.angle.r)
            
      else
      
         bone = ent:LookupBone(bone_override or tab.bone)

         if (!bone) then return end
         
         pos, ang = Vector(0,0,0), Angle(0,0,0)
         local m = ent:GetBoneMatrix(bone)
         if (m) then
            pos, ang = m:GetTranslation(), m:GetAngles()
         end
         
         if (IsValid(self.Owner) and self.Owner:IsPlayer() and 
            ent == self.Owner:GetViewModel() and self.ViewModelFlip) then
            ang.r = -ang.r // Fixes mirrored models
         end
      
      end
      
      return pos, ang
   end

   function SWEP:CreateModels( tab )

      if (!tab) then return end

      // Create the clientside models here because Garry says we cant do it in the render hook
      for k, v in pairs( tab ) do
         if (v.type == "Model" and v.model and v.model != "" and (!IsValid(v.modelEnt) or v.createdModel != v.model) and 
               string.find(v.model, ".mdl") and file.Exists (v.model, "GAME") ) then
            
            v.modelEnt = ClientsideModel(v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE)
            if (IsValid(v.modelEnt)) then
               v.modelEnt:SetPos(self:GetPos())
               v.modelEnt:SetAngles(self:GetAngles())
               v.modelEnt:SetParent(self)
               v.modelEnt:SetNoDraw(true)
               v.createdModel = v.model
            else
               v.modelEnt = nil
            end
            
         elseif (v.type == "Sprite" and v.sprite and v.sprite != "" and (!v.spriteMaterial or v.createdSprite != v.sprite) 
            and file.Exists ("materials/"..v.sprite..".vmt", "GAME")) then
            
            local name = v.sprite.."-"
            local params = { ["$basetexture"] = v.sprite }
            // make sure we create a unique name based on the selected options
            local tocheck = { "nocull", "additive", "vertexalpha", "vertexcolor", "ignorez" }
            for i, j in pairs( tocheck ) do
               if (v[j]) then
                  params["$"..j] = 1
                  name = name.."1"
               else
                  name = name.."0"
               end
            end

            v.createdSprite = v.sprite
            v.spriteMaterial = CreateMaterial(name,"UnlitGeneric",params)
            
         end
      end
      
   end
   
   local allbones
   local hasGarryFixedBoneScalingYet = false

   function SWEP:UpdateBonePositions(vm)
      
      if self.ViewModelBoneMods then
         
         if (!vm:GetBoneCount()) then return end
         
         // !! WORKAROUND !! //
         // We need to check all model names :/
         local loopthrough = self.ViewModelBoneMods
         if (!hasGarryFixedBoneScalingYet) then
            allbones = {}
            for i=0, vm:GetBoneCount() do
               local bonename = vm:GetBoneName(i)
               if (self.ViewModelBoneMods[bonename]) then 
                  allbones[bonename] = self.ViewModelBoneMods[bonename]
               else
                  allbones[bonename] = { 
                     scale = Vector(1,1,1),
                     pos = Vector(0,0,0),
                     angle = Angle(0,0,0)
                  }
               end
            end
            
            loopthrough = allbones
         end
         // !! ----------- !! //
         
         for k, v in pairs( loopthrough ) do
            local bone = vm:LookupBone(k)
            if (!bone) then continue end
            
            // !! WORKAROUND !! //
            local s = Vector(v.scale.x,v.scale.y,v.scale.z)
            local p = Vector(v.pos.x,v.pos.y,v.pos.z)
            local ms = Vector(1,1,1)
            if (!hasGarryFixedBoneScalingYet) then
               local cur = vm:GetBoneParent(bone)
               while(cur >= 0) do
                  local pscale = loopthrough[vm:GetBoneName(cur)].scale
                  ms = ms * pscale
                  cur = vm:GetBoneParent(cur)
               end
            end
            
            s = s * ms
            // !! ----------- !! //
            
            if vm:GetManipulateBoneScale(bone) != s then
               vm:ManipulateBoneScale( bone, s )
            end
            if vm:GetManipulateBoneAngles(bone) != v.angle then
               vm:ManipulateBoneAngles( bone, v.angle )
            end
            if vm:GetManipulateBonePosition(bone) != p then
               vm:ManipulateBonePosition( bone, p )
            end
         end
      else
         self:ResetBonePositions(vm)
      end
         
   end
    
   function SWEP:ResetBonePositions(vm)
      
      if (!vm:GetBoneCount()) then return end
      for i=0, vm:GetBoneCount() do
         vm:ManipulateBoneScale( i, Vector(1, 1, 1) )
         vm:ManipulateBoneAngles( i, Angle(0, 0, 0) )
         vm:ManipulateBonePosition( i, Vector(0, 0, 0) )
      end
      
   end

   /**************************
      Global utility code
   **************************/

   // Fully copies the table, meaning all tables inside this table are copied too and so on (normal table.Copy copies only their reference).
   // Does not copy entities of course, only copies their reference.
   // WARNING: do not use on tables that contain themselves somewhere down the line or youll get an infinite loop
   function table.FullCopy( tab )

      if (!tab) then return nil end
      
      local res = {}
      for k, v in pairs( tab ) do
         if (type(v) == "table") then
            res[k] = table.FullCopy(v) // recursion ho!
         elseif (type(v) == "Vector") then
            res[k] = Vector(v.x, v.y, v.z)
         elseif (type(v) == "Angle") then
            res[k] = Angle(v.p, v.y, v.r)
         else
            res[k] = v
         end
      end
      
      return res
      
   end
   
end

if (SERVER) then
	function SWEP:RegisterAttachment(name, bone, modelPos, modelAng, modelSize, parent, wmodelBone, wmodelPos, wmodelAng, wmodelSize, wmodelParent, ironsightpos, ironsightang)
		for i,j in pairs(scripted_ents.GetList()) do
			if(j.t.AttachmentName != nil && j.t.AttachmentName == name && j.t.Group != nil) then
				local data = j.t;
				data.IronSightPos = ironsightpos; data.IronSightAng = data.ironsightang;
				data.Bone = bone; data.ModelPos = modelPos; data.ModelAng = modelAng; data.ModelSize = modelSize;
				data.WModelBone = wmodelBone; data.WModelPos = wmodelPos; data.WModelAng = wmodelAng; data.WModelSize = wmodelSize;
				if (parent != "") then
					data.Parent = parent;
				else
					data.Parent = "";
				end

				if (wmodelParent != "") then
					data.WModelParent = wmodelParent;
				else
					data.Parent = "";
				end

				if (self.RegisteredAttachments[data.Group] == nil) then
					self.RegisteredAttachments[data.Group] = {};
				end
				self.RegisteredAttachments[data.Group][data.AttachmentName] = data;
			end
		end
	end

	net.Receive( "CustomizeEvent", function( len, ply )
		local condition = net.ReadBool();
	 	ply:GetActiveWeapon().IsCustomizing = condition;
 		ply:GetActiveWeapon().AllowDrop = !condition;
	 	if (condition) then
         ply:GetActiveWeapon():SetIronsights(false);
         ply:GetActiveWeapon():SetZoom(false)
         if(IsValid(ply)) then
            ply:SetFOV(0, 0.2)
         end
         ply:GetActiveWeapon():SetHoldType("magic");
	 	else
         ply:GetActiveWeapon():SetHoldType(ply:GetActiveWeapon().HoldType);
      end
	end )

	net.Receive("EquipAttachment", function(len, ply)
		local condition = net.ReadBool();
		local cat = net.ReadString();
		local attName = net.ReadString();
		local equippedTbl = net.ReadTable();
		local wep = ply:GetActiveWeapon();
		if (wep.RegisteredAttachments[cat] != nil && wep.RegisteredAttachments[cat][attName] != nil) then
			if (condition && wep.RegisteredAttachments[cat][attName].EquipFnc != nil) then
				local ent = nil;
				for k, v in pairs(scripted_ents.GetList()) do
					if (v.t.AttachmentName != nil && v.t.AttachmentName == attName) then
						ent = v.t;
					end
				end
            if (wep.RegisteredAttachments[cat][attName].ShootBullet != nil) then
               wep.bulletAtt = wep.RegisteredAttachments[cat][attName].ShootBullet;
            elseif (cat == "Magazine") then
               wep.bulletAtt = nil;
            end
				wep.RegisteredAttachments[cat][attName].EquipFnc(wep, ent);
				wep:SetNWInt("Has" ..attName, 1);
				wep.Owner:SetNWInt("Has" ..attName, 0);
			elseif (!condition && wep.RegisteredAttachments[cat][attName].DequipFnc != nil) then
				local ent = nil;
				for k, v in pairs(scripted_ents.GetList()) do
					if (v.t.AttachmentName != nil && v.t.AttachmentName == attName) then
						ent = v.t;
					end
				end
            if (wep.RegisteredAttachments[cat][attName].ShootBullet == nil && cat == "Magazine") then
               wep.bulletAtt = nil;
            end
				wep.RegisteredAttachments[cat][attName].DequipFnc(wep, ent);
				wep:SetNWInt("Has" ..attName, 0);
				wep.Owner:SetNWInt("Has" ..attName, 1);
			end
		end

      if (attName == "none" && cat == "Magazine") then
         wep.bulletAtt = nil;
      end

		net.Start("EquipAttachment");
			net.WriteBool(condition);
			net.WriteString(cat);
			net.WriteString(attName);
			net.WriteString(ply:Nick());
			net.WriteTable(equippedTbl);
		net.Broadcast();
	end)

	function SWEP:BroadcastClientsideVar(var, value, _type)
		net.Start("ClientsideVar")
			net.WriteString(self.Owner:Nick());
			net.WriteString(var);
			net.WriteString(_type);
			for k,v in pairs(net) do
				if (k == ("Write" .._type)) then
               if (_type == "Int") then
                  net[k](value, 32);
               else
   					net[k](value);
               end
				end
			end
		net.Broadcast();
	end
end

if (CLIENT) then
   function draw.Circle( x, y, radius, seg )
      local cir = {}

      table.insert( cir, { x = x, y = y, u = 0.5, v = 0.5 } )
      for i = 0, seg do
         local a = math.rad( ( i / seg ) * -360 )
         table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 / (ScrW() / ScrH()) + 0.5, v = math.cos( a ) / 2 + 0.5 } )
      end

      local a = math.rad( 0 ) -- This is needed for non absolute segment counts
      table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )

      surface.DrawPoly( cir )
   end
end

if (CLIENT) then
   hook.Add( "StartChat", "HasStartedTyping", function( isTeamChat )
      isChatting = true;
   end )
   hook.Add( "FinishChat", "ClientFinishTyping", function()
      isChatting = false;
   end )
end

if (CLIENT) then
	--[[hook.Add("FinishMove", "reqModels", function()
		if (!IsValid(LocalPlayer())) then return false; end;
		timer.Simple(1, function()
			net.Start("InitClient");
			net.SendToServer();
		end)
   		hook.Remove ("FinishMove", "reqModels");
		return false;
	end)]]--

	hook.Add("Think", "fixModels", function()
		timer.Simple(6, function()
			net.Start("InitClient");
			net.SendToServer();
		end)
   		hook.Remove ("Think", "fixModels");
	end)

	--[[hook.Add("TTTPrepareRound", "fixModelsA", function()
		timer.Simple(5, function()
			net.Start("InitClient");
			net.SendToServer();
		end)
	end)]]--
end

if (SERVER) then
	net.Receive("InitClient", function(len, ply)
		for k,v in pairs(ents.GetAll()) do
			if (v.RegisteredAttachments != nil) then
				local attData = v.RegisteredAttachments;

				local actualData = {};

				for k, v in pairs(attData) do
					actualData[k] = {};
					for i, j in pairs(attData[k]) do
						actualData[k][i] = {};
						actualData[k][i].Bone = attData[k][i].Bone;
						actualData[k][i].ModelPos = attData[k][i].ModelPos;
						actualData[k][i].ModelAng = attData[k][i].ModelAng;
						actualData[k][i].ModelSize = attData[k][i].ModelSize;
						actualData[k][i].Parent = attData[k][i].Parent;

						actualData[k][i].WModelBone = attData[k][i].WModelBone;
						actualData[k][i].WModelPos = attData[k][i].WModelPos;
						actualData[k][i].WModelAng = attData[k][i].WModelAng;
						actualData[k][i].WModelSize = attData[k][i].WModelSize;
						actualData[k][i].WModelParent = attData[k][i].WModelParent;


						actualData[k][i].AttachmentName = attData[k][i].AttachmentName;
						actualData[k][i].Model = attData[k][i].Model;
						actualData[k][i].Image = attData[k][i].Image;
						actualData[k][i].Group = attData[k][i].Group;
						actualData[k][i].Magnification = attData[k][i].Magnification;
		            if (attData[k][i].Description) then
		               actualData[k][i].Description = attData[k][i].Description;
		            else
		               actualData[k][i].Description = "Default Attachment Description";
		            end
		            actualData[k][i].Reticle = attData[k][i].Reticle;
						actualData[k][i].ScopeRadius = attData[k][i].ScopeRadius;
						actualData[k][i].HideModel = attData[k][i].HideModel;
						actualData[k][i].ScopeOffset = attData[k][i].ScopeOffset;
					end
				end

				local isDone = false;
				while(IsValid(v) && actualData != nil && !isDone) do
				 net.Start("RegisterAttachments");
					net.WriteTable(actualData);
					net.WriteEntity(v);
				 net.Send(ply);
				 isDone = true;
				end
			end
		end
	end)

	net.Receive("InitClientCurrent", function(len, ply)
		local wep = ply:GetActiveWeapon();
		if (wep.RegisteredAttachments != nil) then
			local attData = wep.RegisteredAttachments;

			local actualData = {};

			for k, v in pairs(attData) do
				actualData[k] = {};
				for i, j in pairs(attData[k]) do
					actualData[k][i] = {};
					actualData[k][i].Bone = attData[k][i].Bone;
					actualData[k][i].ModelPos = attData[k][i].ModelPos;
					actualData[k][i].ModelAng = attData[k][i].ModelAng;
					actualData[k][i].ModelSize = attData[k][i].ModelSize;
					actualData[k][i].Parent = attData[k][i].Parent;

					actualData[k][i].WModelBone = attData[k][i].WModelBone;
					actualData[k][i].WModelPos = attData[k][i].WModelPos;
					actualData[k][i].WModelAng = attData[k][i].WModelAng;
					actualData[k][i].WModelSize = attData[k][i].WModelSize;
					actualData[k][i].WModelParent = attData[k][i].WModelParent;


					actualData[k][i].AttachmentName = attData[k][i].AttachmentName;
					actualData[k][i].Model = attData[k][i].Model;
					actualData[k][i].Image = attData[k][i].Image;
					actualData[k][i].Group = attData[k][i].Group;
					actualData[k][i].Magnification = attData[k][i].Magnification;
	            if (attData[k][i].Description) then
	               actualData[k][i].Description = attData[k][i].Description;
	            else
	               actualData[k][i].Description = "Default Attachment Description";
	            end
	            actualData[k][i].Reticle = attData[k][i].Reticle;
					actualData[k][i].ScopeRadius = attData[k][i].ScopeRadius;
					actualData[k][i].HideModel = attData[k][i].HideModel;
					actualData[k][i].ScopeOffset = attData[k][i].ScopeOffset;
				end
			end

			local isDone = false;
			while(IsValid(wep) && actualData != nil && !isDone) do
			 net.Start("RegisterAttachments");
				net.WriteTable(actualData);
				net.WriteEntity(wep);
			 net.Send(ply);
			 isDone = true;
			end
		end
	end)

end