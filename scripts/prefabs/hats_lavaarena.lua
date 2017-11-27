local function onequip(inst, owner) 
	owner.AnimState:OverrideSymbol("swap_hat", inst.hat, inst.hat)
	owner.AnimState:Show("HAT")
  owner.AnimState:Show("HAIR_HAT")
  owner.AnimState:Hide("HAIR_NOHAT")
  owner.AnimState:Hide("HAIR")
	if owner:HasTag("player") then
    owner.AnimState:Hide("HEAD")
    owner.AnimState:Show("HEAD_HAT")
  end
	
	if inst.regentask ~= nil then
		if owner.components.health:GetPercent() < .8 then
			owner.components.health:StartRegen(2, 1, true)
		else
			owner.components.health:StopRegen()
		end
	end
end

local function onunequip(inst, owner) 
	owner.AnimState:ClearOverrideSymbol("swap_hat")
	owner.AnimState:Hide("HAT")
  owner.AnimState:Hide("HAIR_HAT")
  owner.AnimState:Show("HAIR_NOHAT")
  owner.AnimState:Show("HAIR")

  if owner:HasTag("player") then
     owner.AnimState:Show("HEAD")
    owner.AnimState:Hide("HEAD_HAT")
  end
	
	if inst.regentask ~= nil then
		owner.components.health:StopRegen()
	end
end

local function MakeHat(name, data)
    local build = "hat_"..name
    local symbol = name.."hat"
		local fullname = "lavaarena_"..name.."hat"
		print(fullname)
		
    local assets =
    {
        Asset("DYNAMIC_ANIM", "anim/dynamic/"..data.hat..".zip"),
    }

    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()
				
				inst.hat = data.hat
				inst.regentask = data.regentask or false
				
        MakeInventoryPhysics(inst)

        inst.AnimState:SetBank(symbol)
        inst.AnimState:SetBuild(build)
        inst.AnimState:PlayAnimation("anim")

        inst:AddTag("hat")

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end
				
				inst:AddComponent("inventoryitem")
				inst.components.inventoryitem.imagename = fullname
				inst.components.inventoryitem.atlasname = "images/inventoryimages/"..fullname..".xml"
				
				inst:AddComponent("equippable")
        inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
        inst.components.equippable:SetOnEquip(onequip)
        inst.components.equippable:SetOnUnequip(onunequip)
				if data.movespeedmult ~= nil then
					inst.components.equippable.walkspeedmult = data.movespeedmult
				end
				
				MakeHauntableLaunch(inst)
				
        --event_server_data("lavaarena", "prefabs/hats_lavaarena").master_postinit(inst, name, build, symbol)

        return inst
    end

    return Prefab(fullname, fn, assets)
end

return MakeHat("feathercrown", {
			movespeedmult = 1.2,
			hat = "flowerhat_ribbon_wreath"
		}),
    MakeHat("lightdamager", {
			damagemult = 1.1,
			hat = "footballhat_combathelm"
		}),
    MakeHat("recharger", {
			cooldownmult = 1.1,
			hat = "flowerhat_ribbon_wreath"
		}),
    MakeHat("healingflower", {
			healreceivemult = 1.2,
			hat = "flowerhat_healing"
		}),
    MakeHat("tiaraflowerpetals", {
			healdealtmult = 1.2,
			hat = "flowerhat_crown"
		}),
    MakeHat("strongdamager", {
			damagemult = 1.15,
			hat = "footballhat_combathelm"
		}),
    MakeHat("crowndamager", {
			damagemult    = 1.15,
			cooldownmult  = 1.1,
			movespeedmult = 1.1,
			hat = "footballhat_combathelm"
		}),
    MakeHat("healinggarland", {
			regentask     = true,
			cooldownmult  = 1.1,
			movespeedmult = 1.1,
			hat = "flowerhat_holly_wreath"
		}),
    MakeHat("eyecirclet", {
			magicdamagemult = 1.25,
			cooldownmult    = 1.1,
			movespeedmult   = 1.1,
			hat = "flowerhat_ribbon_wreath"
		})
