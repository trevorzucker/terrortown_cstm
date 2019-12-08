
AddCSLuaFile()

ENT.Type = "anim"
ENT.Model = Model("models/weapons/pokeballg.mdl")
ENT.PrimedTime = 0;

if (SERVER) then

   ENT.CapturedEnt = nil;
   ENT.CapturedAng = Angle(0, 0, 0);
   ENT.CapturedColl = nil;

   function ENT:Initialize()
    
      self:SetModel( self.Model );
      self:PhysicsInit(SOLID_VPHYSICS)
      self:SetMoveType(MOVETYPE_VPHYSICS)
      self:SetSolid(SOLID_VPHYSICS)
      self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
      self:SetRenderMode(RENDERMODE_TRANSALPHA);

      self:SetModelScale( self:GetModelScale() * 3, 0 )
      self:GetPhysicsObject():SetMass(99999);
      self:SetGravity(5);
   end
    
   function ENT:Use( activator, caller )
       return
   end

   ENT.Deploying = true;
   ENT.hasDeployed = false;
   ENT.velProg = 0;
   ENT.shouldRemove = true;

   function ENT:Think()
      if (!IsValid(self.CapturedEnt)) then self:Remove(); return end;
      if (self.Deploying) then
         self.velProg = math.Clamp(self.velProg + 0.05, 0, 1);
         if (self.CapturedEnt.Base != "weapon_tttbasegrenade" && (self:GetPhysicsObject():GetVelocity().x < 0.5 || self:GetPhysicsObject():GetVelocity().x > -0.5) && (self:GetPhysicsObject():GetVelocity().y < 0.5 || self:GetPhysicsObject():GetVelocity().y > 0.5)) then
            self:GetPhysicsObject():SetVelocity(LerpVector(self.velProg, self:GetPhysicsObject():GetVelocity(), Vector(0, 0, self:GetPhysicsObject():GetVelocity().z)));
         end
         if (!self.hasDeployed) then
            self.Owner:StripWeapon("weapon_ttt_pokeball")
            if ((self:GetVelocity().z > 0.2 || self:GetVelocity().z < -0.2) && self.CapturedEnt.Base != "weapon_tttbasegrenade") then return end;
            local time = 0.2;
            if (self.CapturedEnt.Base == "weapon_tttbasegrenade") then time = math.Clamp(3 - self.PrimedTime, 0, 3) end;
            timer.Simple(time, function()
               self:EmitSound("pokeball/out.wav");
               self.CapturedEnt:SetPos(self:GetPos());
               self.CapturedEnt:SetModelScale(1, 0.5);
               self.CapturedEnt:SetColor(Color(255, 255, 255, 255));
               self.CapturedEnt:SetAngles(self.CapturedAng);
               self.CapturedEnt:SetOwner(self.Owner);
               self.CapturedEnt:PhysicsInit(SOLID_VPHYSICS);
               if (IsValid(self.CapturedEnt:GetPhysicsObject())) then
	               self.CapturedEnt:GetPhysicsObject():SetVelocity(Vector(0, 0, -5));
               end

               if (self.CapturedEnt.Base == "weapon_tttbasegrenade") then
                  if (self.CapturedEnt.ClassName == "weapon_ttt_confgrenade") then
                     local effect = EffectData()
                     effect:SetStart(self:GetPos())
                     effect:SetOrigin(self:GetPos())
                     effect:SetScale(250 * 0.3)
                     effect:SetRadius(250)
                     effect:SetMagnitude(140)

                     util.Effect("Explosion", effect, true, true)

                     util.BlastDamage(self, self.Owner, self:GetPos(), 250, 200)
                  else
                     self.CapturedEnt:SetDetTime(CurTime());
                     self.CapturedEnt:CreateGrenade(self.CapturedEnt:GetPos(), Angle(0, 0, 0), Vector(0, 0, 0), Vector(0, 0, 0), self.Owner);
                  end
                  self.CapturedEnt:Remove();
               elseif (!self.CapturedEnt.ClassName) then
                  self:SetModelScale(0, 0);
                  local killEnt = FindNearestPlayerNonTraitor(self:GetPos(), 1000, self);
                  if (killEnt) then
  	               	 if (IsValid(self.CapturedEnt:GetPhysicsObject())) then
	                     self.CapturedEnt:GetPhysicsObject():SetVelocity(Vector(0, 0, 500));
	                 end
                     timer.Simple(0.3, function()
                        self.CapturedEnt:PointAtEntity(killEnt);
                        timer.Simple(0.01, function()
  	               	 	   if (IsValid(self.CapturedEnt:GetPhysicsObject())) then
	                           self.CapturedEnt:GetPhysicsObject():SetVelocityInstantaneous(self.CapturedEnt:GetAngles():Forward() * 5000);
	                       end
                        end)
                        hook.Add("Think", "Pokeball", function()
                           if (!IsValid(self.CapturedEnt)) then hook.Remove("Think", "Pokeball") return end;
                           for k, _ent in pairs(ents.FindInSphere(self.CapturedEnt:GetPos(), 50)) do
                              if (_ent:IsPlayer() && _ent:GetRole() != ROLE_TRAITOR && !self.killed) then _ent:Kill(); hook.Remove("Think", "Pokeball") self.killed = true return end;
                           end
                        end)
                        timer.Simple(0.5, function()
                           if(IsValid(self)) then
                              self:Remove();
                           end
                        end)
                     end)
                  end
                  if (killEnt == nil) then 
                     self.shouldRemove = false;
                  end
               end

               timer.Simple(0.5, function()
                  if (!self.shouldRemove) then return end;
                  self:Remove();
               end)
            end)
            self.hasDeployed = true;
         end
      end
   end

   function FindNearestPlayerNonTraitor( pos, range, _ent )
    local nearestEnt;
    range = range ^ 2
    for _, ent in pairs( player.GetAll() ) do
        local distance = (pos - ent:GetPos()):LengthSqr()
        if( distance <= range && ent:GetRole() == ROLE_INNOCENT && ent != _ent.Owner ) then
            nearestEnt = ent
            range = distance
        end
    end    
    return nearestEnt;
end

elseif (CLIENT) then

   function ENT:Think()
      self:SetAngles(Angle(0, self:GetAngles().y, 0));
   end
end