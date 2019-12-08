AddCSLuaFile()

SWEP.HoldType              = "grenade"

if CLIENT then
   SWEP.PrintName          = "Pokéball"
   SWEP.Slot               = 6

   SWEP.ViewModelFlip      = true
   SWEP.ViewModelFOV       = 64

   SWEP.Icon               = "vgui/ttt/icon_pokeball"
   SWEP.IconLetter         = "Q"
end

SWEP.EquipMenuData = {
	type = "Weapon",
	desc = "Besides people, it is said that the only\nthing this ball cannot contain is Chip himself...\nbut I wonder what that means?";	
};

SWEP.Base                  = "weapon_tttbase"

SWEP.Kind                  = WEAPON_EQUIP
SWEP.WeaponID              = nil

SWEP.Weight                = 5
SWEP.AutoSpawnable         = false
SWEP.Spawnable             = true
SWEP.CanBuy = { ROLE_TRAITOR }

SWEP.UseHands              = true
SWEP.ViewModel             = "models/weapons/v_pokeballg.mdl"
SWEP.WorldModel            = "models/weapons/w_pokeballg.mdl"

SWEP.primed = false;
SWEP.hasPrimed = false;
SWEP.CapturedEnt = nil;
SWEP.CapturedAngles = Angle(0, 0, 0);
SWEP.CapturedColl = nil;
SWEP.Thrown = false;
SWEP.IdleAnim = false;
SWEP.PrimedTime = 0;

function SWEP:PrimaryAttack()
	if (self.Thrown) then return end;
	if (!self.hasPrimed) then
		self:SendWeaponAnim(ACT_VM_PULLPIN);
		self.hasPrimed = true;
	end
	self.primed = true;
end

function SWEP:Deploy()
	if (self.Thrown) then
		self:SendWeaponAnim(ACT_VM_THROW);
	end
end

function SWEP:Think()

	if (IsValid(self.CapturedEnt) && self.primed) then
		self.PrimedTime = self.PrimedTime + 0.016;

		if (self.PrimedTime > 3) then
			local pokeball = ents.Create("ttt_pokeball_thrown");
			pokeball.CapturedEnt = self.CapturedEnt;
			pokeball.CapturedAng = self.CapturedAngles;
			pokeball.CapturedColl = self.CapturedColl;
			pokeball.PrimedTime = self.PrimedTime;

			pokeball:SetPos(self.Owner:GetPos());
			pokeball:SetAngles(Angle(0, 0, 0));
			pokeball:SetOwner(self.Owner);

			pokeball:SetGravity(1);
			pokeball:SetFriction(100);
			pokeball:SetElasticity(1);

			pokeball:Spawn();

			pokeball:PhysWake();

			local phys = pokeball:GetPhysicsObject();
			if IsValid(phys) then
				phys:SetVelocity(thr);
				phys:AddAngleVelocity(Vector(600, math.random(-1200, 1200), 0));
			end
			self.Thrown = true;
			self.IdleAnim = false;
			self.AllowDrop = false;
		end
	end

	if (self.primed) then
		if (IsValid(self.Owner)) then
			if (!self.Owner:KeyDown(IN_ATTACK) && self.primed) then
				if (SERVER) then
					local ply = self.Owner;
					self:SendWeaponAnim(ACT_VM_THROW);
					local pokeball = nil;
					if (IsValid(self.CapturedEnt)) then
						pokeball = ents.Create("ttt_pokeball_thrown");
						pokeball.CapturedEnt = self.CapturedEnt;
						pokeball.CapturedAng = self.CapturedAngles;
						pokeball.CapturedColl = self.CapturedColl;
						pokeball.PrimedTime = self.PrimedTime;
					else
						pokeball = ents.Create("ttt_pokeball");
						pokeball.bWeapon = self;
					end

				   	if (!IsValid(pokeball)) then return end;

					local ang = ply:EyeAngles();
					local src = ply:GetPos() + (ply:Crouching() and ply:GetViewOffsetDucked() or ply:GetViewOffset())- (ang:Up() * 5) + (ang:Right() * 10) + (ang:Forward() * 5);
					local target = ply:GetEyeTraceNoCursor().HitPos
					local tang = (target-src):Angle();
					if tang.p < 90 then
						tang.p = -10 + tang.p * ((90 + 10) / 90);
					else
						tang.p = 360 - tang.p;
						tang.p = -10 + tang.p * -((90 + 10) / 90);
					end
						tang.p=math.Clamp(tang.p,-90,90);
					local vel = math.min(800, (90 - tang.p) * 6);
					local thr = tang:Forward() * vel + ply:GetVelocity();

					pokeball:SetPos(src);
					pokeball:SetAngles(Angle(0, 0, 0));
					pokeball:SetOwner(self.Owner);

					pokeball:SetGravity(1);
					pokeball:SetFriction(100);
					pokeball:SetElasticity(1);

					pokeball:Spawn();

					pokeball:PhysWake();

					local phys = pokeball:GetPhysicsObject();
					if IsValid(phys) then
						phys:SetVelocity(thr);
						phys:AddAngleVelocity(Vector(600, math.random(-1200, 1200), 0));
					end
					self.Thrown = true;
					self.IdleAnim = false;
					self.Owner:EmitSound("pokeball/throw.wav");
					self.AllowDrop = false;
				end

				self.primed = false;
			end
		end
	end
	if (!self.Thrown && !self.IdleAnim && SERVER) then
		self:SendWeaponAnim(ACT_VM_DRAW);
		self.IdleAnim = true;
		self.hasPrimed = false;
		self.AllowDrop = true;
	end
end