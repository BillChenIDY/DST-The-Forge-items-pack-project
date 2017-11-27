local function OnBlocked(owner)
		owner.SoundEmitter:PlaySound("dontstarve/wilson/hit_armour")
end

local function g_onequip(inst, owner)
		owner.AnimState:OverrideSymbol("swap_body", inst.armor, inst.armor)
		
		inst:ListenForEvent("blocked", OnBlocked, owner)
end

local function g_onunequip(inst, owner)
		owner.AnimState:ClearOverrideSymbol("swap_body")
    inst:RemoveEventCallback("blocked", OnBlocked, owner)
end

local function MakeArmour(name, data)
    local assets =
    {
        Asset("DYNAMIC_ANIM", "anim/dynamic/"..data.build..".zip"),
    }
				
    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()
				inst.armor = data.build
				
        MakeInventoryPhysics(inst)

        inst.AnimState:SetBank(data.build)
        inst.AnimState:SetBuild(data.build)
        inst.AnimState:PlayAnimation("anim")

        for i, v in ipairs(data.tags) do
            inst:AddTag(v)
        end
        inst:AddTag("hide_percentage")

        inst.foleysound = data.foleysound

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

				inst:AddComponent("inspectable")
				
				inst:AddComponent("inventoryitem")
				inst.components.inventoryitem.imagename = name
				inst.components.inventoryitem.atlasname = "images/inventoryimages/"..name..".xml"
				
				inst:AddComponent("armor")
				inst.components.armor:InitIndestructible(data.absorption)
				
				inst:AddComponent("equippable")
				inst.components.equippable.equipslot = EQUIPSLOTS.BODY
				inst.components.equippable:SetOnEquip(g_onequip)
				inst.components.equippable:SetOnUnequip(g_onunequip)
				if data.speedmult ~= nil then
					inst.components.equippable.walkspeedmult = data.speedmult
				end
				
				MakeHauntableLaunch(inst)
				
        --event_server_data("lavaarena", "prefabs/armor_lavaarena").master_postinit(inst, name, data.build)

        return inst
    end

    return Prefab(name, fn, assets)
end

local armors = {}
for k, v in pairs({
    ["lavaarena_armorlight"] =
    {
        build = "armor_grass_woven",
        tags = { "grass" },
        foleysound = "dontstarve/movement/foley/grassarmour",
				absorption = .5,
    },

    ["lavaarena_armorlightspeed"] =
    {
        build = "armor_grass_cloak",
        tags = { "grass" },
        foleysound = "dontstarve/movement/foley/grassarmour",
				absorption = .6,
				speedmult  = 1.1,
    },

    ["lavaarena_armormedium"] =
    {
        build = "armor_wood_lamellar",
        tags = { "wood" },
        foleysound = "dontstarve/movement/foley/logarmour",
				absorption = .75,
    },

    ["lavaarena_armormediumdamager"] =
    {
        build = "armor_wood_fangedcollar",
        tags = { "wood" },
        foleysound = "dontstarve/movement/foley/logarmour",
				absorption = .75,
    },

    ["lavaarena_armormediumrecharger"] =
    {
        build = "armor_wood_haramaki",
        tags = { "wood" },
        foleysound = "dontstarve/movement/foley/logarmour",
				absorption = .75,
    },

    ["lavaarena_armorheavy"] =
    {
        build = "armor_marble_chainmail",
        tags = { "marble" },
        foleysound = "dontstarve/movement/foley/marblearmour",
				absorption = .85,
    },

    ["lavaarena_armorextraheavy"] =
    {
        build = "armor_marble_rockabs",
        tags = { "marble", "heavyarmor" },
        foleysound = "dontstarve/movement/foley/marblearmour",
				absorption = .9,
				speedmult  = 0.85,
    },
}) do
    table.insert(armors, MakeArmour(k, v))
end

return unpack(armors)
