local assets =
{
    Asset("ANIM", "anim/blowdart_lava.zip"),
    Asset("ANIM", "anim/swap_blowdart_lava.zip"),
}

local assets_projectile =
{
    Asset("ANIM", "anim/lavaarena_blowdart_attacks.zip"),
}

local prefabs =
{
    "blowdart_lava_projectile",
    "blowdart_lava_projectile_alt",
    "reticulelongmulti",
    "reticulelongmultiping",
}

local prefabs_projectile =
{
    "weaponsparks_piercing",
}

local PROJECTILE_DELAY = 4 * FRAMES

--------------------------------------------------------------------------

local function ReticuleTargetFn()
    return Vector3(ThePlayer.entity:LocalToWorldSpace(6.5, 0, 0))
end

local function ReticuleMouseTargetFn(inst, mousepos)
    if mousepos ~= nil then
        local x, y, z = inst.Transform:GetWorldPosition()
        local dx = mousepos.x - x
        local dz = mousepos.z - z
        local l = dx * dx + dz * dz
        if l <= 0 then
            return inst.components.reticule.targetpos
        end
        l = 6.5 / math.sqrt(l)
        return Vector3(x + dx * l, 0, z + dz * l)
    end
end

local function ReticuleUpdatePositionFn(inst, pos, reticule, ease, smoothing, dt)
    local x, y, z = inst.Transform:GetWorldPosition()
    reticule.Transform:SetPosition(x, 0, z)
    local rot = -math.atan2(pos.z - z, pos.x - x) / DEGREES
    if ease and dt ~= nil then
        local rot0 = reticule.Transform:GetRotation()
        local drot = rot - rot0
        rot = Lerp((drot > 180 and rot0 + 360) or (drot < -180 and rot0 - 360) or rot0, rot, dt * smoothing)
    end
    reticule.Transform:SetRotation(rot)
end

local function onequip(inst, owner) 
	owner.AnimState:OverrideSymbol("swap_object", "swap_blowdart_lava", "swap_blowdart_lava")
	owner.AnimState:Show("ARM_carry") 
	owner.AnimState:Hide("ARM_normal") 
end

local function onunequip(inst, owner) 
	owner.AnimState:ClearOverrideSymbol("swap_object")
	owner.AnimState:Hide("ARM_carry") 
	owner.AnimState:Show("ARM_normal") 
end

local function onattack(inst, attacker, target)
  if target.components.sleeper and target.components.sleeper:IsAsleep() then
      target.components.sleeper:WakeUp()
  end
	
  if target.components.combat then
      target.components.combat:SuggestTarget(attacker)
  end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("blowdart_lava")
    inst.AnimState:SetBuild("blowdart_lava")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("dart")
    inst:AddTag("blowdart")
    inst:AddTag("aoeblowdart_long")
    inst:AddTag("sharp")
    --rechargeable (from rechargeable component) added to pristine state for optimization
    inst:AddTag("rechargeable")

		inst:AddComponent("rechargeable")
		inst.components.rechargeable:SetRechargeTime(30)
		
		inst:DoPeriodicTask(1, function(inst)
			inst.components.rechargeable:Update()
		end)
		
    inst:AddComponent("aoetargeting")
    inst.components.aoetargeting:SetAlwaysValid(true)
    inst.components.aoetargeting.reticule.reticuleprefab = "reticulelongmulti"
    inst.components.aoetargeting.reticule.pingprefab = "reticulelongmultiping"
    inst.components.aoetargeting.reticule.targetfn = ReticuleTargetFn
    inst.components.aoetargeting.reticule.mousetargetfn = ReticuleMouseTargetFn
    inst.components.aoetargeting.reticule.updatepositionfn = ReticuleUpdatePositionFn
    inst.components.aoetargeting.reticule.validcolour = { 1, .75, 0, 1 }
    inst.components.aoetargeting.reticule.invalidcolour = { .5, 0, 0, 1 }
    inst.components.aoetargeting.reticule.ease = true
    inst.components.aoetargeting.reticule.mouseenabled = true

    inst.projectiledelay = PROJECTILE_DELAY
		
		inst:AddComponent("inventoryitem")
		inst.components.inventoryitem.imagename = "blowdart_lava"
		inst.components.inventoryitem.atlasname = "images/inventoryimages/blowdart_lava.xml"
		
		inst:AddComponent("equippable")
		inst.components.equippable:SetOnEquip(onequip)
		inst.components.equippable:SetOnUnequip(onunequip)
		inst.components.equippable.equipstack = false
		
		inst:AddComponent("weapon")
		inst.components.weapon:SetDamage(0)
		inst.components.weapon:SetRange(10, 12)
		inst.components.weapon:SetProjectile("blowdart_lava_projectile")
		inst.components.weapon:SetOnAttack(onattack)
		
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    --event_server_data("lavaarena", "prefabs/blowdart_lava").blowdart_postinit(inst)
		
		MakeHauntableLaunch(inst)
		
    return inst
end

--------------------------------------------------------------------------

local FADE_FRAMES = 5

local function CreateTail()
    local inst = CreateEntity()

    inst:AddTag("FX")
    inst:AddTag("NOCLICK")
    --[[Non-networked entity]]
    inst.entity:SetCanSleep(false)
    inst.persists = false

    inst.entity:AddTransform()
    inst.entity:AddAnimState()

    inst.AnimState:SetBank("lavaarena_blowdart_attacks")
    inst.AnimState:SetBuild("lavaarena_blowdart_attacks")
    inst.AnimState:PlayAnimation("tail_1")
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)

    inst:ListenForEvent("animover", inst.Remove)

    return inst
end

local function OnUpdateProjectileTail(inst)
    local c = (not inst.entity:IsVisible() and 0) or (inst._fade ~= nil and (FADE_FRAMES - inst._fade:value() + 1) / FADE_FRAMES) or 1
    if c > 0 then
        local tail = CreateTail()
        tail.Transform:SetPosition(inst.Transform:GetWorldPosition())
        tail.Transform:SetRotation(inst.Transform:GetRotation())
        if c < 1 then
            tail.AnimState:SetTime(c * tail.AnimState:GetCurrentAnimationLength())
        end
    end
end

local function commonprojectilefn(alt)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
    RemovePhysicsColliders(inst)

    inst.AnimState:SetBank("lavaarena_blowdart_attacks")
    inst.AnimState:SetBuild("lavaarena_blowdart_attacks")
    inst.AnimState:PlayAnimation("attack_3", true)
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetAddColour(1, 1, 0, 0)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")

    --projectile (from projectile component) added to pristine state for optimization
    inst:AddTag("projectile")
		inst:AddComponent("projectile")
		inst.components.projectile:SetSpeed(50)
		inst.components.projectile:SetOnThrownFn(function(inst)
			inst:AddTag("NOCLICK")
		end)
		inst.components.projectile:SetOnHitFn(function(inst, attacker, target)
			target.components.combat:GetAttacked(attacker, 20)
			inst:Remove()
		end)
		inst:ListenForEvent("onthrown", function(inst, data)
			inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
			if inst.Physics ~= nil and not inst:HasTag("nocollisionoverride") then
				inst.Physics:ClearCollisionMask()
				inst.Physics:CollidesWith(COLLISION.GROUND)
				if TUNING.COLLISIONSAREON then
					inst.Physics:CollidesWith(COLLISION.OBSTACLES)
				end
			end
		end)
		
    if not TheNet:IsDedicated() then
        inst:DoPeriodicTask(0, OnUpdateProjectileTail)
    end

    if alt then
        inst._fade = net_tinybyte(inst.GUID, "blowdart_lava_projectile_alt._fade")
    end

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    return inst
end

local function projectilefn()
    return commonprojectilefn(false)
end

local function projectilealtfn()
    return commonprojectilefn(true)
end

return Prefab("blowdart_lava", fn, assets, prefabs),
    Prefab("blowdart_lava_projectile", projectilefn, assets_projectile, prefabs_projectile),
    Prefab("blowdart_lava_projectile_alt", projectilealtfn, assets_projectile, prefabs_projectile)
