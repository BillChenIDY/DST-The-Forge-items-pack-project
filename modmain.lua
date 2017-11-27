local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local STRINGS    = GLOBAL.STRINGS
local TECH       = GLOBAL.TECH

Assets =
{
  Asset("ATLAS", "images/inventoryimages/blowdart_lava.xml"),
  Asset("IMAGE", "images/inventoryimages/blowdart_lava.tex"),
	Asset("ATLAS", "images/inventoryimages/blowdart_lava2.xml"),
  Asset("IMAGE", "images/inventoryimages/blowdart_lava2.tex"),
	Asset("ATLAS", "images/inventoryimages/fireballstaff.xml"),
  Asset("IMAGE", "images/inventoryimages/fireballstaff.tex"),
	Asset("ATLAS", "images/inventoryimages/healingstaff.xml"),
  Asset("IMAGE", "images/inventoryimages/healingstaff.tex"),
	Asset("ATLAS", "images/inventoryimages/hammer_mjolnir.xml"),
  Asset("IMAGE", "images/inventoryimages/hammer_mjolnir.tex"),
	Asset("ATLAS", "images/inventoryimages/spear_gungnir.xml"),
  Asset("IMAGE", "images/inventoryimages/spear_gungnir.tex"),
	Asset("ATLAS", "images/inventoryimages/spear_lance.xml"),
  Asset("IMAGE", "images/inventoryimages/spear_lance.tex"),
	Asset("ATLAS", "images/inventoryimages/lavaarena_lucy.xml"),
  Asset("IMAGE", "images/inventoryimages/lavaarena_lucy.tex"),
	Asset("ATLAS", "images/inventoryimages/book_fossil.xml"),
  Asset("IMAGE", "images/inventoryimages/book_fossil.tex"),
	Asset("ATLAS", "images/inventoryimages/book_elemental.xml"),
  Asset("IMAGE", "images/inventoryimages/book_elemental.tex"),
	
	Asset("ATLAS", "images/tabimages/theforge_tab.xml"),
  Asset("IMAGE", "images/tabimages/theforge_tab.tex"),
}

PrefabsFiles =
{
	"blowdart_lava",
	"hammer_mjolnir",
	"blowdart_lava2",
	"spear_gungnir",
	"spear_lance",
	"lavaarena_lucy",
	"fireballstaff",
	"healingstaff",
	"armor_lavaarena",
	"fireball_projectile",
	"books_lavaarena",
	"hats_lavaarena",
}

STRINGS.RECIPE_DESC.BLOWDART_LAVA  = "[WIP]Darts from The Forge event"
STRINGS.RECIPE_DESC.BLOWDART_LAVA2 = "[WIP]Molten Darts from The Forge event"
STRINGS.RECIPE_DESC.FIREBALLSTAFF  = "[WIP]Infernal Staff from The Forge event"
STRINGS.RECIPE_DESC.HEALINGSTAFF   = "[WIP]Living Staff from The Forge event"
STRINGS.RECIPE_DESC.HAMMER_MJOLNIR = "[WIP]Forging Hammer from The Forge event"
STRINGS.RECIPE_DESC.SPEAR_GUNGNIR  = "[WIP]Pith Pike from The Forge event"
STRINGS.RECIPE_DESC.SPEAR_LANCE    = "[WIP]Spiral Spear from The Forge event"
STRINGS.RECIPE_DESC.LAVAARENA_LUCY = "[WIP]Riled Lucy from The Forge event"
STRINGS.RECIPE_DESC.BOOK_FOSSIL    = "[WIP]Petrifying Tome from The Forge event"
STRINGS.RECIPE_DESC.BOOK_ELEMENTAL = "[WIP]Tome of Beckoning from The Forge event"

STRINGS.RECIPE_DESC.LAVAARENA_ARMORLIGHT           = "[WIP]Reed Tunic from The Forge event"
STRINGS.RECIPE_DESC.LAVAARENA_ARMORLIGHTSPEED      = "[WIP]Feathered Reed Tunic from The Forge event"
STRINGS.RECIPE_DESC.LAVAARENA_ARMORMEDIUM          = "[WIP]Wood Armor from The Forge event"
STRINGS.RECIPE_DESC.LAVAARENA_ARMORMEDIUMDAMAGER   = "[WIP]Jagged Wood Armor from The Forge event"
STRINGS.RECIPE_DESC.LAVAARENA_ARMORMEDIUMRECHARGER = "[WIP]Silken Wood Armor from The Forge event"
STRINGS.RECIPE_DESC.LAVAARENA_ARMORHEAVY           = "[WIP]Stone Splint Mail from The Forge event"
STRINGS.RECIPE_DESC.LAVAARENA_ARMOREXTRAHEAVY      = "[WIP]Steadfast Stone Armor from The Forge event"

STRINGS.RECIPE_DESC.LAVAARENA_LIGHTDAMAGERHAT      = "[WIP]Barbed Helm from The Forge event"
STRINGS.RECIPE_DESC.LAVAARENA_STRONGDAMAGERHAT     = "[WIP]Nox Helm from The Forge event"
STRINGS.RECIPE_DESC.LAVAARENA_FEATHERCROWNHAT      = "[WIP]Feathered Wreath from The Forge event"
STRINGS.RECIPE_DESC.LAVAARENA_RECHARGERHAT         = "[WIP]Crystal Tiara from The Forge event"
STRINGS.RECIPE_DESC.LAVAARENA_HEALINGFLOWERHAT     = "[WIP]Flower Headband from The Forge event"
STRINGS.RECIPE_DESC.LAVAARENA_TIARAFLOWERPETALSHAT = "[WIP]Woven Garland from The Forge event"
STRINGS.RECIPE_DESC.LAVAARENA_EYECIRCLETHAT        = "[WIP]Clairvoyant Crown from The Forge event"
STRINGS.RECIPE_DESC.LAVAARENA_CROWNDAMAGERHAT      = "[WIP]Resplendent Nox Helm from The Forge event"
STRINGS.RECIPE_DESC.LAVAARENA_HEALINGGARLANDHAT    = "[WIP]Blossomed Wreath from The Forge event"

local forgetab = AddRecipeTab("The Forge", 6, "images/tabimages/theforge_tab.xml", "theforge_tab.tex", nil)

AddRecipe("blowdart_lava", {Ingredient("blowdart_fire", 1), Ingredient("redgem", 1)}, forgetab, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/blowdart_lava.xml", "blowdart_lava.tex")
AddRecipe("hammer_mjolnir", {Ingredient("hammer", 1), Ingredient("goldnugget", 4)}, forgetab, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/hammer_mjolnir.xml", "hammer_mjolnir.tex")
AddRecipe("blowdart_lava2", {Ingredient("blowdart_lava", 1), Ingredient("dragon_scales", 2)}, forgetab, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/blowdart_lava2.xml", "blowdart_lava2.tex")
AddRecipe("spear_gungnir", {Ingredient("lightninggoathorn", 2), Ingredient("goldnugget", 4)}, forgetab, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/spear_gungnir.xml", "spear_gungnir.tex")
AddRecipe("spear_lance", {Ingredient("spear_gungnir", 1), Ingredient("townportaltalisman", 2)}, forgetab, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/spear_lance.xml", "spear_lance.tex")
AddRecipe("lavaarena_lucy", {Ingredient("lucy", 1)}, forgetab, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/lavaarena_lucy.xml", "lavaarena_lucy.tex")
AddRecipe("fireballstaff", {Ingredient("firestaff", 1), Ingredient("boneshard", 2), Ingredient("dragon_scales", 2)}, forgetab, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/fireballstaff.xml", "fireballstaff.tex")
AddRecipe("healingstaff", {Ingredient("spear", 1), Ingredient("petals", 20), Ingredient("twigs", 3)}, forgetab, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/healingstaff.xml", "healingstaff.tex")
AddRecipe("book_fossil", {Ingredient("papyrus", 3), Ingredient("fossil_piece", 1)}, forgetab, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/book_fossil.xml", "book_fossil.tex")
AddRecipe("book_elemental", {Ingredient("book_fossil", 1), Ingredient("papyrus", 3), Ingredient("redgem", 2)}, forgetab, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/book_elemental.xml", "book_elemental.tex")

for name, data in pairs({
  ["lavaarena_armorlight"] = {
		ingredients = {
			Ingredient("cutreeds", 10),
			Ingredient("rope", 1),
		}
  },
  ["lavaarena_armorlightspeed"] = {
		ingredients = {
			Ingredient("cutreeds", 12),
			Ingredient("rope", 1),
			Ingredient("feather_robin_winter", 1),
		}
  },
  ["lavaarena_armormedium"] = {
		ingredients = {
			Ingredient("boards", 2),
			Ingredient("rope", 2),
		},
  },
  ["lavaarena_armormediumdamager"] = {
		ingredients = {
			Ingredient("boards", 2),
			Ingredient("houndstooth", 4),
		},
  },
  ["lavaarena_armormediumrecharger"] = {
		ingredients = {
			Ingredient("boards", 2),
			Ingredient("rope", 3),
		},
  },
  ["lavaarena_armorheavy"] = {
		ingredients = {
			Ingredient("rocks", 16),
			Ingredient("rope", 2),
		},
  },
  ["lavaarena_armorextraheavy"] = {
		ingredients = {
			Ingredient("cutstone", 4),
			Ingredient("rope", 4),
		},
  },
}) do
		table.insert(Assets, Asset("ATLAS", "images/inventoryimages/"..name..".xml"))
		table.insert(Assets, Asset("IMAGE", "images/inventoryimages/"..name..".tex"))
    AddRecipe(name, data.ingredients, forgetab, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/"..name..".xml", name..".tex")
end

for name, data in pairs({
  ["lavaarena_lightdamagerhat"] = {
		ingredients = {
			Ingredient("footballhat", 1),
			Ingredient("houndstooth", 2)
		}
  },
  ["lavaarena_strongdamagerhat"] = {
		ingredients = {
			Ingredient("lavaarena_lightdamagerhat", 1),
			Ingredient("houndstooth", 4),
			Ingredient("boneshard", 2)
		}
  },
  ["lavaarena_feathercrownhat"] = {
		ingredients = {
			Ingredient("feather_robin_winter", 8),
			Ingredient("furtuft", 10),
			Ingredient("silk", 2)
		},
  },
  ["lavaarena_rechargerhat"] = {
		ingredients = {
			Ingredient("moonrocknugget", 4)
		}
  },
  ["lavaarena_healingflowerhat"] = {
		ingredients = {
			Ingredient("petals", 4),
			Ingredient("twigs", 2)
		}
  },
  ["lavaarena_tiaraflowerpetalshat"] = {
		ingredients = {
			Ingredient("succulent_picked", 6),
			Ingredient("twigs", 2)
		}
  },
  ["lavaarena_eyecirclethat"] = {
		ingredients = {
			Ingredient("orangegem", 1),
			Ingredient("purplegem", 1),
			Ingredient("houndstooth", 8)
		}
  },
  ["lavaarena_crowndamagerhat"] = {
		ingredients = {
			Ingredient("lavaarena_strongdamagerhat", 1),
			Ingredient("goldnugget", 4),
			Ingredient("houndstooth", 4)
		}
  },
  ["lavaarena_healinggarlandhat"] = {
		ingredients = {
			Ingredient("lavaarena_healingflowerhat", 6),
			Ingredient("silk", 3)
		}
  },
}) do
		table.insert(Assets, Asset("ATLAS", "images/inventoryimages/"..name..".xml"))
		table.insert(Assets, Asset("IMAGE", "images/inventoryimages/"..name..".tex"))
    AddRecipe(name, data.ingredients, forgetab, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/"..name..".xml", name..".tex")
end
