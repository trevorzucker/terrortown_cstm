-- Ammo override base

AddCSLuaFile()

ENT.Type = "anim"
-- Override these values
ENT.Model            = Model( "models/items/cs_gift.mdl" );

ENT.Contents = {};

function ENT:RealInit() end -- bw compat

-- Some subclasses want to do stuff before/after initing (eg. setting color)
-- Using self.BaseClass gave weird problems, so stuff has been moved into a fn
-- Subclasses can easily call this whenever they want to
function ENT:Initialize()
   self:SetModel( self.Model )

   self:PhysicsInit( SOLID_VPHYSICS )
   self:SetMoveType( MOVETYPE_VPHYSICS )
   self:SetSolid( SOLID_BBOX )

   self:SetCollisionGroup( COLLISION_GROUP_WEAPON)

   if SERVER then
      self:SetTrigger(true)
   end

   self.taken = false
end

-- Pseudo-clone of SDK's UTIL_ItemCanBeTouchedByPlayer
-- aims to prevent picking stuff up through fences and stuff
function ENT:PlayerCanPickup(ply)
   if ply == self:GetOwner() then return false end

   local missingAny = false;

   for k,v in pairs(scripted_ents.GetList()) do
      for a,b in pairs(self.Contents) do
         if (v.t.AttachmentName != nil && v.t.AttachmentName == b) then
            if (ply:GetNWInt("Has" ..v.t.AttachmentName) == 0 && ply:GetActiveWeapon():GetNWInt("Has" ..v.t.AttachmentName) == 0) then
               missingAny = true;
            end
         end
      end
   end

   if (missingAny == false) then
      return false
   end

   local ent = self
   local phys = ent:GetPhysicsObject()
   local spos = phys:IsValid() and phys:GetPos() or ent:OBBCenter()
   local epos = ply:GetShootPos() -- equiv to EyePos in SDK

   local tr = util.TraceLine({start=spos, endpos=epos, filter={ply, ent}, mask=MASK_SOLID})

   -- can pickup if trace was not stopped
   return tr.Fraction == 1.0
end

function ENT:Touch(ent)
   if SERVER and self.taken != true then
      if (ent:IsValid() and ent:IsPlayer() and self:PlayerCanPickup(ent)) then
         for k,v in pairs(self.Contents) do
            if (ent:GetNWInt("Has" ..v) == 0 && ent:GetActiveWeapon():GetNWInt("Has" ..v) == 0) then
               ent:SetNWInt("Has" ..v, 1);
               net.Start("PickupAttachment");
                  net.WriteString(v);
               net.Send(ent);
               table.remove(self.Contents, k);

               ent:EmitSound("items/ammo_pickup.wav");
               if (table.Count(self.Contents) == 0) then
                  self:Remove()
               end
            end
         end
      end
   end
end

-- Hack to force ammo to physwake
if SERVER then
   function ENT:Think()
      if not self.first_think then
         self:PhysWake()
         self.first_think = true

         -- Immediately unhook the Think, save cycles. The first_think thing is
         -- just there in case it still Thinks somehow in the future.
         self.Think = nil
      end
   end
end