AddCSLuaFile()

ENT.Type = "anim"
ENT.Model = Model("models/props_junk/harpoon002a.mdl")
ENT.Size = Vector(0.1, 1, 1);

if (SERVER) then

   ENT.Captured = false;
   ENT.CapturedEnt = nil;
   ENT.touchRot = Angle(0, 0, 0);
   ENT.coll = nil;

   function ENT:Initialize()
    
      self:SetModel( self.Model );
      self:PhysicsInit(SOLID_VPHYSICS)
      self:SetMoveType(MOVETYPE_VPHYSICS)
      self:SetSolid(SOLID_VPHYSICS)
      self:SetCollisionGroup( COLLISION_GROUP_NONE )
      self:SetRenderMode(RENDERMODE_TRANSALPHA);

      self:SetModelScale(0.1);

      local t_Attachments = {
         ["harpoon0"] = {
            Model = self.Model,
            Position = Vector( 0, 0, 0 ),
            Angle = Angle( 0, 0, 120 ),
            Size = self.Size
         },
         ["harpoon1"] = {
            Model = self.Model,
            Position = Vector( 0, 0, 0 ),
            Angle = Angle( 0, 0, -120 ),
            Size = self.Size
         },
         ["harpoon2"] = {
            Model = self.Model,
            Position = Vector( 0, 0, 0 ),
            Angle = Angle( 0, 0, 0 ),
            Size = self.Size
         }
      };
      
      for t_Name, t_Table in pairs( t_Attachments ) do
      
         t_Table.Parent = self;
         AttachModel( t_Table );
         
      end

   end

   function AttachModel( t_Table )
      
      local t_Parent = t_Table.Parent;
      
      local t_Child = ents.Create( "prop_dynamic" );
         t_Child:SetModel( t_Table.Model or "models/stalker.mdl" );
         t_Child:SetPos( t_Parent:GetPos() + t_Table.Position );
         t_Child:SetAngles( t_Parent:GetAngles() + t_Table.Angle );
         t_Child:SetCollisionGroup( COLLISION_GROUP_DEBRIS );
         t_Child:SetParent( t_Parent );
         t_Table.Parent:DeleteOnRemove( t_Child );
      t_Child:Spawn();

   end

   function ENT:Touch(touchEnt)

   end

   ENT.RetractEnt = nil;
   ENT.Retract = false;
   ENT.ShouldCollide = true;

   function ENT:PhysicsCollide( data, phys )
      if (!self.ShouldCollide) then return end;
      self.ShouldCollide = false;
      local ent = data.HitEntity;
      if (tostring(ent) == "Entity [62][prop_dynamic]" || string.find(tostring(ent), "worldspawn") || string.find(tostring(ent), "breakable") || string.find(tostring(ent), "trigger") || string.find(tostring(ent), "tracktrain") || string.find(tostring(ent), "monitor") || string.find(tostring(ent), "surf") || string.find(tostring(ent), "button") || string.find(tostring(ent), "door") || string.find(tostring(ent), "brush")) then
         self:GetPhysicsObject():EnableMotion(false);
         self.Owner:SetNWBool("NegateFallDamage", true);
         timer.Simple(1, function()
            if (!IsValid(self)) then return end;
            self.Owner:SetPos(self.Owner:GetPos() + Vector(0, 0, 10));
            self.Owner:SetVelocity((self:GetPos() - self.Owner:GetPos()):GetNormalized() * (self.Owner:GetPos():Distance(self:GetPos()) * 1.5));

            timer.Simple(1, function() self.Retract = true; end)

            timer.Simple(2, function()
               if (!IsValid(self)) then return end;
               self.Owner:GetActiveWeapon():SetNWEntity("Hook", nil);
               self:Remove();

               hook.Add("EntityTakeDamage", "noFDamage" ..self.Owner:GetName(), function(ent, dmginfo)
                  if (ent:GetNWBool("NegateFallDamage") && dmginfo:IsFallDamage()) then
                     ent:SetNWBool("NegateFallDamage", false);
                     return true;
                  end
               end)
            end)
         end)
         return;
      else
         if (ent:IsPlayer()) then
            local foundPlayer = false;
            for k, v in pairs(self.Owner:GetActiveWeapon().GrappledPlayers) do
               if (v.ID == ent:SteamID64()) then
                  if (CurTime() - v.Time <= 60) then
                     foundPlayer = true;
                  end
               end
            end

            local hitPos = Vector(0, 0, 0);

            if (foundPlayer) then
               hitPos = ent:GetPos();
               ent:SetVelocity(Vector(0, 0, 0));
               timer.Simple(0.3, function()
                  ent:SetVelocity(Vector(0, 0, 0));
                  ent:SetPos(hitPos);
               end)

               timer.Simple(0.5, function()
                  ent:SetVelocity(Vector(0, 0, 0));
                  ent:SetPos(hitPos);
                  self:Remove()
               end)
               return end;
            self.Owner:EmitSound( "grapple/getoverhere.wav");
            table.insert(self.Owner:GetActiveWeapon().GrappledPlayers, {ID = ent:SteamID64(), Time = CurTime()});
         end
         self:GetPhysicsObject():EnableMotion(false);
         if(!string.find(tostring(self.RetractEnt), "ragdoll")) then
            data.HitEntity:GetPhysicsObject():EnableMotion(false);
            self.SolidType = data.HitEntity:GetSolid();
         end

         timer.Simple(1, function()
            if (!IsValid(self)) then return end;

            self.RetractEnt = data.HitEntity;
            self:SetNWEntity("RetractEnt", self.RetractEnt);
         end)

      end
   end

   ENT.Progress = 0;
   ENT.SolidType = 0;

   function ENT:Think()
      if (IsValid(self.RetractEnt)) then
         local vm = self.Owner:GetViewModel()
         local muzzlePos = vm:GetAttachment(vm:LookupAttachment("muzzle"))

         local src = self.Owner:GetPos() + (self.Owner:Crouching() and self.Owner:GetViewOffsetDucked() or self.Owner:GetViewOffset()) - (self.Owner:EyeAngles():Up() * 6) - (self.Owner:EyeAngles():Forward() * 8) + (self.Owner:EyeAngles():Right() * 14);

         self:SetPos(LerpVector(self.Progress, self:GetPos(), src));
         if (string.find(tostring(self.RetractEnt), "ragdoll")) then
            self.RetractEnt:SetPos(self:GetPos() + (self:GetAngles():Forward() * 80));

            for i=0, self.RetractEnt:GetPhysicsObjectCount()-1 do
               local bone = self.RetractEnt:GetPhysicsObjectNum(i)
               if IsValid(bone) then
                  bone:SetPos(self:GetPos() + (self:GetAngles():Forward() * 80))
               end
            end
         else
            self.RetractEnt:SetPos(self:GetPos() + (self:GetAngles():Forward() * 80));
         end
         self:SetAngles(self.Owner:EyeAngles());
         self.Progress = math.Clamp(self.Progress + 0.1, 0, 1);

         if (self.Progress >= 0.8) then
            self.Owner:GetActiveWeapon():SetNWEntity("Hook", nil);
            if (!string.find(tostring(self.RetractEnt), "ragdoll") && !self.RetractEnt:IsPlayer()) then
               self.RetractEnt:PhysicsInit(self.SolidType);
               self.RetractEnt:PhysWake()
            end
            self.RetractEnt:GetPhysicsObject():EnableMotion(true);
            self.RetractEnt:GetPhysicsObject():SetVelocityInstantaneous(Vector(0, 0, 0));
            self.RetractEnt:PhysWake()
            self:Remove();
            self.RetractEnt = nil;
         end
      elseif (self.Retract) then
         local src = self.Owner:GetPos() + (self.Owner:Crouching() and self.Owner:GetViewOffsetDucked() or self.Owner:GetViewOffset()) - (self.Owner:EyeAngles():Up() * 6) - (self.Owner:EyeAngles():Forward() * 8) + (self.Owner:EyeAngles():Right() * 14);
         self:SetAngles(self.Owner:EyeAngles());
         self:SetPos(LerpVector(self.Progress, self:GetPos(), src));
         self.Progress = math.Clamp(self.Progress + 0.4, 0, 1);
      end
   end

elseif (CLIENT) then
   function ENT:Initialize()
      local matrix = Matrix();
      matrix:Scale(self.Size);
      self:EnableMatrix( "RenderMultiply", matrix );

      for k,v in pairs(self:GetChildren()) do
         local matrix = Matrix();
         matrix:Scale(self.Size);
         matrix:SetTranslation(Vector(50, 0, 0));
         v:EnableMatrix( "RenderMultiply", matrix );
      end
   end

   function ENT:Think()
      if (IsValid(self:GetNWEntity("RetractEnt"))) then
         self:GetNWEntity("RetractEnt"):SetupBones();
      end
   end
end