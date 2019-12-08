-- Ammo override base

if (SERVER) then
   util.AddNetworkString("PickupAttachment");
end

AddCSLuaFile()

ENT.Type = "anim"

-- Override these values
ENT.Model            = Model( "models/robotnik_attachments/robotnik_acog.mdl" );
ENT.AttachmentName   = "nil";
ENT.Description      = "Default Attachment Description";
ENT.Image            = "nil";
ENT.Group            = "nil";
ENT.Magnification    = 4;
ENT.Weight           = 1;
ENT.HideModel = false;
ENT.ScopeRadius = 0;
ENT.ScopeOffset = Vector(0, 0, 0);

ENT.EquipFnc         = function() end;
ENT.DequipFnc        = function() end;

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
   local b = 26
   self:SetCollisionBounds(Vector(-b, -b, -b), Vector(b,b,b))

   if SERVER then
      self:SetTrigger(true)
   end

   self.taken = false

   -- this made the ammo get physics'd too early, meaning it would fall
   -- through physics surfaces it was lying on on the client, leading to
   -- inconsistencies
   --	local phys = self:GetPhysicsObject()
   --	if (phys:IsValid()) then
   --		phys:Wake()
   --	end
end

-- Pseudo-clone of SDK's UTIL_ItemCanBeTouchedByPlayer
-- aims to prevent picking stuff up through fences and stuff
function ENT:PlayerCanPickup(ply)
   if ply == self:GetOwner() then return false end

   local result = ply:GetNWInt("Has" ..self.AttachmentName);

   local wepCanUse = false;

   for a,b in pairs(ply:GetWeapons()) do
      if (b != nil && b.RegisteredAttachments != nil) then
         for k,v in pairs(b.RegisteredAttachments) do
            for i, j in pairs(b.RegisteredAttachments[k]) do
               if (i == self.AttachmentName) then
                  wepCanUse = true;
               end
            end
         end
      end
   end

   if (result == 1 || ply:GetActiveWeapon():GetNWInt("Has" ..self.AttachmentName) == 1 || !wepCanUse) then
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
            ent:SetNWInt("Has" ..self.AttachmentName, 1);
            ent:EmitSound("items/ammo_pickup.wav");
            net.Start("PickupAttachment");
               net.WriteString(self.AttachmentName);
            net.Send(ent);
            self:Remove()
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

if (CLIENT) then
   net.Receive("PickupAttachment", function(len)
      local attName = net.ReadString();

      local pickupclr = {
         [ROLE_INNOCENT]  = Color(55, 170, 50, 255),
         [ROLE_TRAITOR]   = Color(180, 50, 40, 255),
         [ROLE_DETECTIVE] = Color(50, 60, 180, 255)
      }

      local GM = baseclass.Get("gamemode_terrortown").BaseClass;

      local pickup = {}
      pickup.time      = CurTime()
      pickup.name      = string.upper(attName)
      pickup.holdtime  = 5
      pickup.font      = "DefaultBold"
      pickup.fadein    = 0.04
      pickup.fadeout   = 0.3

      local role = LocalPlayer().GetRole and LocalPlayer():GetRole() or ROLE_INNOCENT
      pickup.color = pickupclr[role]

      pickup.upper = true

      surface.SetFont( pickup.font )
      local w, h = surface.GetTextSize( pickup.name )
      pickup.height    = h
      pickup.width     = w

      if (GM.PickupHistoryLast >= pickup.time) then
         pickup.time = GM.PickupHistoryLast + 0.05
      end

      table.insert( GM.PickupHistory, pickup )
      GM.PickupHistoryLast = pickup.time
   end)
end