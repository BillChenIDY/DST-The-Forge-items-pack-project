local assets =
{
    Asset("ANIM", "anim/spear_lance.zip"),
    Asset("ANIM", "anim/swap_spear_lance.zip"),
}

local prefabs =
{
    "reticuleaoesmall",
    "reticuleaoesmallping",
    "reticuleaoesmallhostiletarget",
    "weaponsparks",
    "weaponsparks_thrusting",
    "firehit",
    "superjump_fx",
}

local function ReticuleTargetFn()
    local player = ThePlayer
    local ground = TheWorld.Map
    local pos = Vector3()
    --Cast range is 8, leave room for error
    --2 is the aoe range
    for r = 5, 0, -.25 do
        pos.x, pos.y, pos.z = player.entity:LocalToWorldSpace(r, 0, 0)
        if ground:IsPassableAtPoint(pos:Get()) and not ground:IsGroundTargetBlocked(pos) then
            return pos
        end
    end
    return pos
end

local function onequip(inst, owner) 
	owner.AnimState:OverrideSymbol("swap_object", "swap_spear_lance", "swap_spear_lance")
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

    inst.AnimState:SetBank("spear_lance")
    inst.AnimState:SetBuild("spear_lance")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("melee")
    inst:AddTag("sharp")
    inst:AddTag("pointy")
    inst:AddTag("superjump")
    --aoeweapon_leap (from aoeweapon_leap component) added to pristine state for optimization
    inst:AddTag("aoeweapon_leap")
    --rechargeable (from rechargeable component) added to pristine state for optimization
    inst:AddTag("rechargeable")
		
		inst:AddComponent("rechargeable")
		inst.components.rechargeable:SetRechargeTime(30)
		
		inst:DoPeriodicTask(1, function(inst)
			inst.components.rechargeable:Update()
		end)
		
    inst:AddComponent("aoetargeting")
    inst.components.aoetargeting:SetRange(16)
    inst.components.aoetargeting.reticule.reticuleprefab = "reticuleaoesmall"
    inst.components.aoetargeting.reticule.pingprefab = "reticuleaoesmallping"
    inst.components.aoetargeting.reticule.targetfn = ReticuleTargetFn
    inst.components.aoetargeting.reticule.validcolour = { 1, .75, 0, 1 }
    inst.components.aoetargeting.reticule.invalidcolour = { .5, 0, 0, 1 }
    inst.components.aoetargeting.reticule.ease = true
    inst.components.aoetargeting.reticule.mouseenabled = true
		
		inst:AddComponent("inventoryitem")
		inst.components.inventoryitem.imagename = "spear_lance"
		inst.components.inventoryitem.atlasname = "images/inventoryimages/spear_lance.xml"
		
		inst:AddComponent("equippable")
		inst.components.equippable:SetOnEquip(onequip)
		inst.components.equippable:SetOnUnequip(onunequip)
		inst.components.equippable.equipstack = false
		
		inst:AddComponent("weapon")
		inst.components.weapon:SetDamage(30)
		inst.components.weapon:SetOnAttack(onattack)
		
		
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    --event_server_data("lavaarena", "prefabs/spear_lance").master_postinit(inst)
		
		MakeHauntableLaunch(inst)
		
    return inst
end

return Prefab("spear_lance", fn, assets, prefabs)
