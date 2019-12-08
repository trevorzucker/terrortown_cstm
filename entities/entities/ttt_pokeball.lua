
AddCSLuaFile()

ENT.Type = "anim"
ENT.Model = Model("models/weapons/pokeballg.mdl")

if (SERVER) then

   ENT.Captured = false;
   ENT.CapturedEnt = nil;
   ENT.touchRot = Angle(0, 0, 0);
   ENT.coll = nil;
   ENT.bWeapon = nil;

   function ENT:Initialize()
    
      self:SetModel( self.Model );
      self:PhysicsInit(SOLID_VPHYSICS)
      self:SetMoveType(MOVETYPE_VPHYSICS)
      self:SetSolid(SOLID_VPHYSICS)
      self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
      self:SetRenderMode(RENDERMODE_TRANSALPHA);

      self:SetModelScale( self:GetModelScale() * 3, 0 )
   end
    
   function ENT:Use( activator, caller )
       return
   end

   ENT.posLerp = 0;

   function ENT:Think()
      if (IsValid(self.touched) && !self.Captured) then 

         if(self.touched:GetModelScale() != nil) then
            self:GetPhysicsObject():SetVelocity(LerpVector((1 / self.touched:GetModelScale()) / 2, self:GetPhysicsObject():GetVelocity(), Vector(0, 0, 0)));
            self.touched:SetModelScale(self.touched:GetModelScale() * 0.85, 0.2);
         end

         self.touched:SetRenderMode(RENDERMODE_TRANSALPHA);
         self.touched:SetColor(Color(255, 0, 0, math.Clamp(self.touched:GetColor().a - 25, 0, 255)));
         self:SetColor(Color(255, math.Clamp(self:GetColor().g + 25, 0, 255), math.Clamp(self:GetColor().b + 25, 0, 255), math.Clamp(self:GetColor().a + 25, 0, 255)));

         if (self.touched:GetModelScale() == nil || self.touched:GetModelScale() < 0.2) then
            self.Captured = true;
            self.CapturedEnt = self.touched;
            self.Owner:GetWeapon("weapon_ttt_pokeball").CapturedEnt = self.CapturedEnt;
            self.Owner:GetWeapon("weapon_ttt_pokeball").CapturedAngles = self.touchRot;
            self.Owner:GetWeapon("weapon_ttt_pokeball").CapturedColl = self.coll;
            self:SetNWEntity("Captured", self.touched);
            self:EmitSound("pokeball/caught.wav");
            self.touched:SetOwner(self:GetOwner());
            self.touched:SetPos(Vector(0, 0, -99));
            self:PointAtEntity(self.Owner);
            timer.Simple(2.5, function()
               self.Owner:GetWeapon("weapon_ttt_pokeball").Thrown = false;
               self:Remove();
            end)
         end
      end

      if(!IsValid(self.touched)) then
         timer.Simple(3, function()
            if(!IsValid(self.touched) && IsValid(self) && !self.Captured) then
               self:SetModelScale(0, 0.5);
               timer.Simple(0.5, function()
                  if(!IsValid(self.touched) && IsValid(self) && !self.Captured) then
                     self.Owner:GetWeapon("weapon_ttt_pokeball").Thrown = false;
                     self:Remove();
                  end
               end)
            end
         end)
      end

   end

elseif (CLIENT) then

   ENT.captureTime = 0;

   function ENT:Think()
      local ent = self:GetNWEntity("Touched");

      if(IsValid(ent)) then
         local pos = self:GetNWVector("TouchPos");

         if (self.touchPropPos == Vector(0, 0, 0)) then self.touchPropPos = pos; end

         self.touchPropPos = LerpVector(FrameTime() * 2, self.touchPropPos, self:GetPos());
         ent:SetPos(self.touchPropPos);
      end

      local capturedEnt = self:GetNWEntity("Captured");
      self.captureTime = self.captureTime + 1;
      if (IsValid(capturedEnt) && self.captureTime > 400) then
         self:SetModelScale(self:GetModelScale() * 0.99, 0);
      end

      self:SetAngles(Angle(0, self:GetAngles().y, 0));
   end
end

ENT.touchPos = Vector(0, 0, 0);
ENT.touched = nil;
ENT.touchPropPos = Vector(0, 0, 0);

function ENT:Touch( ent )
   if (ent:IsPlayer()) then return end;
   if (self.touchPos == Vector(0, 0, 0)) then
      if ((!ent.Kind && !ent.AmmoType) || ent.Kind == WEAPON_NADE) then
         print("attempt to capture " ..tostring(ent));
         if(string.find(tostring(ent), "trigger") || string.find(tostring(ent), "ttt") || string.find(tostring(ent), "tracktrain") || string.find(tostring(ent), "monitor") || string.find(tostring(ent), "surf") || string.find(tostring(ent), "button") || string.find(tostring(ent), "door") || string.find(tostring(ent), "brush")) then if (!string.find(tostring(ent), "weapon_ttt")) then return end end;
         print(self.Owner:Nick().. " caught " ..tostring(ent));
         if (SERVER) then
            self:EmitSound("pokeball/capture.wav");
            self:SetColor(Color(255, 0, 0, 50));
         end
         self:SetNWEntity("Touched", ent);
         self:SetNWVector("TouchPos", ent:GetPos());
         self.touchPos = self:GetPos();
         ent:SetHealth(1000);
         self.touchPropPos = ent:GetPos();
         self.touchRot = ent:GetAngles();
         self.coll = ent:GetCollisionGroup();
         ent:SetCollisionGroup(COLLISION_GROUP_DEBRIS);
         self.touched = ent;
         self.Owner:GetWeapon("weapon_ttt_pokeball").CapturedEnt = self.touched;
      end
   end
end