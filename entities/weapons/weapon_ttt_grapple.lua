AddCSLuaFile()

SWEP.HoldType            = "pistol"

if CLIENT then
   SWEP.PrintName        = "Grappling Hook"
   SWEP.Slot             = 6

   SWEP.ViewModelFlip    = false
   SWEP.ViewModelFOV     = 54

   SWEP.EquipMenuData = {
      type  = "item_weapon",
      name  = "Grappling Hook",
      desc  = "Pull yourself to new heights\nwith this grappling gun. Or you could\npull an UnID'd body!"
   };

   SWEP.Icon             = "vgui/ttt/icon_grapple"
   SWEP.IconLetter       = "l"
end

SWEP.Base                = "weapon_tttbase"

SWEP.Kind                = WEAPON_EQUIP
SWEP.CanBuy              = {ROLE_DETECTIVE} -- only traitors can buy
SWEP.WeaponID            = AMMO_GRAPPLING

SWEP.Primary.Damage      = 0
SWEP.Primary.Delay       = 1
SWEP.Primary.Cone        = 0
SWEP.Primary.ClipSize    = -1
SWEP.Primary.ClipMax     = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic   = false
SWEP.Primary.Ammo        = "none"
SWEP.Primary.Recoil      = 1
SWEP.Primary.Sound       = "weapons/alyx_gun/alyx_gun_fire3.wav"

SWEP.AutoSpawnable       = false
SWEP.AmmoEnt             = "none"

SWEP.UseHands            = true
SWEP.ViewModel           = "models/weapons/c_357.mdl"
SWEP.WorldModel          = "models/weapons/w_357.mdl"
SWEP.CrosshairDisappears = false;

SWEP.IronSightsPos       = Vector(-4.705, -3, 0.77)
SWEP.IronSightsAng       = Vector(-0.2, -0.24, 1)

SWEP.DeploySpeed         = 3

SWEP.ViewModelBoneMods = {}

if (CLIENT) then

   SWEP.VElements = {
      ["hook"] = { type = "Model", model = "models/props_junk/harpoon002a.mdl", bone = "Python", rel = "", pos = Vector(-0.033, -0.766, 7.952), angle = Angle(90, -0, 0), size = Vector(0.108, 0.384, 0.305), color = Color(255, 255, 255, 255), surpresslightning = false, material = "rubber", skin = 0, bodygroup = {} },
      ["hook++"] = { type = "Model", model = "models/props_junk/harpoon002a.mdl", bone = "Python", rel = "hook", pos = Vector(0.002, 0, 0), angle = Angle(0, -0, 117.587), size = Vector(0.108, 0.384, 0.305), color = Color(255, 255, 255, 255), surpresslightning = false, material = "rubber", skin = 0, bodygroup = {} },
      ["barrel"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "Python", rel = "", pos = Vector(0, -0.168, -1.208), angle = Angle(0, 0, 0), size = Vector(0.079, 0.079, 0.009), color = Color(251, 255, 255, 255), surpresslightning = false, material = "rubber", skin = 0, bodygroup = {} },
      ["barrel++"] = { type = "Model", model = "models/props_wasteland/wheel01a.mdl", bone = "Python", rel = "barrel", pos = Vector(0, -0.018, -0.072), angle = Angle(0, 0, -90), size = Vector(0.032, 0.032, 0.032), color = Color(65, 108, 255, 255), surpresslightning = false, material = "model_color", skin = 0, bodygroup = {} },
      ["hook+++"] = { type = "Model", model = "models/props_junk/harpoon002a.mdl", bone = "Python", rel = "hook", pos = Vector(0.002, 0, 0), angle = Angle(0, -0, -122.154), size = Vector(0.108, 0.384, 0.305), color = Color(255, 255, 255, 255), surpresslightning = false, material = "rubber", skin = 0, bodygroup = {} }
   }

   SWEP.VElementsUnmodified = {
      ["hook"] = { type = "Model", model = "models/props_junk/harpoon002a.mdl", bone = "Python", rel = "", pos = Vector(-0.033, -0.766, 7.952), angle = Angle(90, -0, 0), size = Vector(0.108, 0.384, 0.305), color = Color(255, 255, 255, 255), surpresslightning = false, material = "rubber", skin = 0, bodygroup = {} },
      ["hook++"] = { type = "Model", model = "models/props_junk/harpoon002a.mdl", bone = "Python", rel = "hook", pos = Vector(0.002, 0, 0), angle = Angle(0, -0, 117.587), size = Vector(0.108, 0.384, 0.305), color = Color(255, 255, 255, 255), surpresslightning = false, material = "rubber", skin = 0, bodygroup = {} },
      ["barrel"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "Python", rel = "", pos = Vector(0, -0.168, -1.208), angle = Angle(0, 0, 0), size = Vector(0.079, 0.079, 0.009), color = Color(251, 255, 255, 255), surpresslightning = false, material = "rubber", skin = 0, bodygroup = {} },
      ["barrel++"] = { type = "Model", model = "models/props_wasteland/wheel01a.mdl", bone = "Python", rel = "barrel", pos = Vector(0, -0.018, -0.072), angle = Angle(0, 0, -90), size = Vector(0.032, 0.032, 0.032), color = Color(65, 108, 255, 255), surpresslightning = false, material = "model_color", skin = 0, bodygroup = {} },
      ["hook+++"] = { type = "Model", model = "models/props_junk/harpoon002a.mdl", bone = "Python", rel = "hook", pos = Vector(0.002, 0, 0), angle = Angle(0, -0, -122.154), size = Vector(0.108, 0.384, 0.305), color = Color(255, 255, 255, 255), surpresslightning = false, material = "rubber", skin = 0, bodygroup = {} }
   }

   SWEP.WElements = {
      ["hook"] = { type = "Model", model = "models/props_junk/harpoon002a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(13.659, 0.801, -4.967), angle = Angle(-3.135, 0.833, -85.325), size = Vector(0.108, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "rubber", skin = 0, bodygroup = {} },
      ["hook++"] = { type = "Model", model = "models/props_junk/harpoon002a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "hook", pos = Vector(0, 0, 0), angle = Angle(0, 0, 115.713), size = Vector(0.108, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "rubber", skin = 0, bodygroup = {} },
      ["hook+"] = { type = "Model", model = "models/props_junk/harpoon002a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "hook", pos = Vector(0, 0, 0), angle = Angle(0, 0, -127.403), size = Vector(0.108, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "rubber", skin = 0, bodygroup = {} }
   }

   SWEP.WElementsUnmodified = {
      ["hook"] = { type = "Model", model = "models/props_junk/harpoon002a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(13.659, 0.801, -4.967), angle = Angle(-3.135, 0.833, -85.325), size = Vector(0.108, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "rubber", skin = 0, bodygroup = {} },
      ["hook++"] = { type = "Model", model = "models/props_junk/harpoon002a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "hook", pos = Vector(0, 0, 0), angle = Angle(0, 0, 115.713), size = Vector(0.108, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "rubber", skin = 0, bodygroup = {} },
      ["hook+"] = { type = "Model", model = "models/props_junk/harpoon002a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "hook", pos = Vector(0, 0, 0), angle = Angle(0, 0, -127.403), size = Vector(0.108, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "rubber", skin = 0, bodygroup = {} }
   }

   SWEP.ModelRot = 0;
   SWEP.BreatheBlue = 255;
   SWEP.BreatheDir = false;
   SWEP.HookRot = 0;

end

SWEP.GrappledPlayers = {};

function SWEP:Think()
   self.BaseClass.Think(self);
end

function SWEP:Holster()
   if (!IsValid(self:GetNWEntity("Hook"))) then return true end;
   self:GetNWEntity("Hook"):Remove();
   return true;
end

function SWEP:PrimaryAttack(worldsnd)

   --self:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
   --self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

   if (IsValid(self:GetNWEntity("Hook"))) then return end;

   if not worldsnd then
      self:EmitSound( self.Primary.Sound, self.Primary.FireSoundLevel, 100, self.Primary.SoundLevel)
   elseif SERVER then
      sound.Play(self.Primary.Sound, self:GetPos(), self.Primary.FireSoundLevel, 100, self.Primary.SoundLevel)
   end

   if (!self:GetIronsights()) then
      self:SendWeaponAnim(self.PrimaryAnim)
   end

   if (SERVER) then
      local hook = ents.Create("ttt_hook");

      local src = Vector(0, 0, 0);

      if (!self:GetIronsights()) then
         src = self.Owner:GetPos() + (self.Owner:Crouching() and self.Owner:GetViewOffsetDucked() or self.Owner:GetViewOffset())+ (self.Owner:EyeAngles():Up()) + (self.Owner:EyeAngles():Right() * 2) + (self.Owner:EyeAngles():Forward() * 5);
      else
         src = self.Owner:GetPos() + (self.Owner:Crouching() and self.Owner:GetViewOffsetDucked() or self.Owner:GetViewOffset())+ (self.Owner:EyeAngles():Up()) + (self.Owner:EyeAngles():Forward() * 5);
      end


      hook:SetPos(src);
      hook:SetAngles(Angle(self.Owner:EyeAngles().p, self.Owner:EyeAngles().y, 0));
      hook:SetOwner(self.Owner);

      hook:SetGravity(1);
      hook:SetFriction(100);
      hook:SetElasticity(1);

      hook:Spawn();

      hook:PhysWake();

      self:SetNWEntity("Hook", hook);

      local phys = hook:GetPhysicsObject();
      if IsValid(phys) then
         phys:SetVelocityInstantaneous(self.Owner:EyeAngles():Forward() * 1500);
         phys:AddAngleVelocity(Vector(900, 0, 0));
      end

   end

   self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

   if (CLIENT) then
      if (self.Primary.Automatic) then
         if(self:GetIronsights() && !isEmpty) then
            self.weaponKick.y = math.Clamp(self.Primary.Recoil, 0, 1) * 3;
         end
      else
         if(self:GetIronsights() && !isEmpty) then
            self.weaponKick.y = self.Primary.Recoil * 2 * 3;
            releasedSinceLast = false;
         end
      end
      self.VElements["hook"].pos = Vector(100, 100, 100);
      self.WElements["hook"].pos = Vector(100, 100, 100);
   end

   local owner = self:GetOwner()
   if not IsValid(owner) or owner:IsNPC() or (not owner.ViewPunch) then return end

   owner:ViewPunch( Angle( util.SharedRandom(self:GetClass(),-0.2,-0.1,0) * self.Primary.Recoil * 2, util.SharedRandom(self:GetClass(),-0.1,0.1,1) * self.Primary.Recoil * 2, 0 ) )
end

if (CLIENT) then

   SWEP.LerpR = 65;
   SWEP.LerpG = 108;

   function SWEP:Think()
      if (!IsValid(self:GetNWEntity("Hook"))) then
         self.VElements["hook"].pos = self.VElementsUnmodified["hook"].pos;
         self.WElements["hook"].pos = self.WElementsUnmodified["hook"].pos;
      else
         self.VElements["hook"].pos = Vector(100, 100, 100);
         self.WElements["hook"].pos = Vector(100, 100, 100);
      end

      if (IsValid(self.Owner:GetEyeTrace().Entity)) then
         self.HookRot = self.HookRot - 1;
         self.BreatheDir = true;
      else
         self.BreatheDir = false;
      end

      if (self.BreatheDir) then
         self.BreatheBlue = Lerp(FrameTime() * 5, self.BreatheBlue, 255);
         self.LerpR = Lerp(FrameTime() * 5, self.LerpR, 65);
         self.LerpG = Lerp(FrameTime() * 5, self.LerpG, 108);
      else
         self.BreatheBlue = Lerp(FrameTime() * 5, self.BreatheBlue, 100);
         self.LerpR = Lerp(FrameTime() * 5, self.LerpR, 100);
         self.LerpG = Lerp(FrameTime() * 5, self.LerpG, 100);
      end

      self.ModelRot = self.ModelRot - 0.1;

      self.VElements["hook"].angle = Angle(90, -0, self.HookRot / 8);

      self.VElements["barrel++"].angle = Angle(0, self.ModelRot, -90);
      self.VElements["barrel++"].color = Color(self.LerpR, self.LerpG, self.BreatheBlue, 255);
   end

   local rope = Material("cable/rope");

   hook.Add("PostDrawTranslucentRenderables", "DrawRope", function(drawDepth, drawSkybox)

      for k,v in pairs(player.GetAll()) do
         if (v:GetActiveWeapon().ClassName == "weapon_ttt_grapple") then
            local weapon = v:GetActiveWeapon();
            if (IsValid(weapon:GetNWEntity("Hook"))) then

               local hook = weapon:GetNWEntity("Hook");
               local vm = v:GetViewModel()
               local muzzlePos = {Pos = Vector(0, 0, 0)};
               if (v == LocalPlayer()) then
                  muzzlePos = vm:GetAttachment(vm:LookupAttachment("muzzle"))
               else
                  local pos, ang = v:GetBonePosition(11);
                  muzzlePos.Pos = pos + ang:Forward() * 14 - ang:Up() * 5;
               end

               --[[for i=0, v:GetBoneCount()-1 do
                  print( i, v:GetBoneName( i ) )
               end]]--

               render.SetMaterial(rope)
               render.DrawBeam(muzzlePos.Pos, hook:GetPos() + (hook:GetAngles():Forward() * 45), 1, 0, muzzlePos.Pos:Distance(hook:GetPos() - (hook:GetAngles():Forward() * 5)) / 16, Color(255, 255, 255, 255))
            end
         end
      end

   end)

end