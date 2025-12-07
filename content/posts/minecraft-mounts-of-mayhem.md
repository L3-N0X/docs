---
author: ["L3N0X"]
title: "Mounts of Mayhem Summary"
date: "2025-12-02"
description: "A summary of the new features and changes in the Mounts of Mayhem update for Minecraft."
summary: "This document summarizes the new features and changes introduced in the Mounts of Mayhem update for Minecraft."
tags: ["snapshot", "minecraft"]
categories: ["minecraft"]
ShowToc: true
TocOpen: true
---

This document summarizes the new features and changes introduced in the Mounts of Mayhem update, collecting information from snapshots 25w41a to 1.21.11-pre4.

## Big Changes

### New Mobs

*   **Nautilus:** 
    *   ![Nautilus](https://minecraft.wiki/images/Nautilus_Breathe_JE1_BE2.gif?af9c0&format=original)
    *   A neutral aquatic mob found in all ocean biomes. It can be tamed and ridden, providing the "Breath of the Nautilus" effect to the player, which pauses oxygen consumption.
    *   **Breeding:** Can be bred and tamed using Pufferfish or a Bucket of Pufferfish.
    *   **Drops:** Has a chance to drop Nautilus Shells. The Looting enchantment now correctly increases this drop chance (as of pre-release 1).
    *   **Misc:** Dispensers can now equip Saddles and Nautilus Armor onto a tamed Nautilus.

*   **Zombie Nautilus:** 
    *   ![Zombie Nautilus](https://minecraft.wiki/images/Zombie_Nautilus_Breathe_JE1_BE2.gif) 
    *   An undead version of the Nautilus that spawns with a Drowned rider wielding a Trident. It is not hostile unless ridden by a hostile mob and cannot be bred.
    *   **Drops:** The specific drops are not detailed in the source files, but the Looting enchantment now correctly affects its drops (as of pre-release 4).
    *   **Coral Zombie Nautilus:** A rare, colorful variant that spawns in Warm Oceans.
        *   ![Coral Zombie Nautilus](https://minecraft.wiki/images/Coral_Zombie_Nautilus_Breathe_JE1.gif?09a03)

*   **Camel Husk:** 
    *   ![Camel Husk](https://minecraft.wiki/images/Camel_Husk_JE1.png?37710&format=original)
    *   An undead Camel variant that spawns in deserts at light level 0, often with two riders: a Husk with a Spear and a Parched. It does not burn in sunlight and is hostile when ridden.
    *   **Breeding:** Cannot be bred, but its favorite food is Rabbit Foot.
    *   **Drops:** 2-3 Rotten Flesh, with an additional 0-1 per level of the Looting enchantment.

*   **Parched:** 
    *   ![The Parched](https://minecraft.wiki/images/Parched_JE1.png?6678c&format=original)
    *   A new Skeleton variant that spawns in deserts at light level 0. It does not burn in sunlight.
    *   **Behavior:** It shoots Arrows of Weakness, has a slower rate of fire than a regular Skeleton, and is immune to the Weakness effect.
    *   **Drops:** Drops Bones, Arrows and Arrow of Weakness (Player kill only)

*   **Zombie Horse:** 
    *   ![Zombie Horse](https://www.minecraft.net/content/dam/minecraftnet/games/minecraft/screenshots/zombiehorse_mountsofmayhemdateannounce_1280x72.jpg)
    *   Now spawns naturally in plains and savannas with a Zombie rider holding an iron spear. It burns in sunlight but can be protected with Horse Armor. It can be tamed, saddled, and ridden, but not bred.
    *   **Taming:** Can be healed and tempted using Red Mushrooms.
    *   **Drops:** 2-3 Rotten Flesh (plus 0-1 per Looting level). The Zombie rider has a chance to drop a Red Mushroom.

### New Items & Equipment

*   **Spear:** 
    *   A new weapon with a longer reach than swords. It can be crafted from various materials (Wood, Stone, Copper, Iron, Gold, Diamond, and Netherite).
    *   **Attacks:** It has a quick "Jab" and a powerful "Charge" attack. The Charge attack's damage increases with velocity.
    *   **Damage:** See https://minecraft.wiki/w/Spear#Usage for detailed Damage overview + calculator
    *   **Images of Spears:**
        *   ![Wooden Spear](https://minecraft.wiki/images/Wooden_Spear_JE1_BE1.png)
        *   ![Stone Spear](https://minecraft.wiki/images/Stone_Spear_JE1_BE1.png)
        *   ![Iron Spear](https://minecraft.wiki/images/Iron_Spear_JE1_BE1.png)
        *   ![Golden Spear](https://minecraft.wiki/images/Golden_Spear_JE1_BE1.png)
        *   ![Diamond Spear](https://minecraft.wiki/images/Diamond_Spear_JE1_BE1.png)
        *   ![Netherite Spear](https://minecraft.wiki/images/Netherite_Spear_JE1_BE1.png)
	-  **Enchantments:** All sword enchantments + Lunge
*   **Lunge Enchantment:** 
    *   A Spear-exclusive enchantment that propels the player forward during a Jab attack. Level 1-3
    *   **Cost:** Consumes 1, 2, or 3 hunger points (depending on the level) and 1 durability point per use. It requires the player to have at least 6 hunger points.
    *   **Acquisition:** Enchanting, Trading or Fishing.

*   **Nautilus Armor:** 
    *   Armor for the Nautilus and Zombie Nautilus, available in Copper, Iron, Gold, Diamond, and Netherite. It can be found in Buried Treasure, Ocean Ruins, and Shipwreck chests.
    *   **Images of Nautilus Armor:**
        *   ![Copper Nautilus Armor](https://minecraft.wiki/images/Copper_Nautilus_Armor_JE1_BE2.png)
        *   ![Iron Nautilus Armor](https://minecraft.wiki/images/Iron_Nautilus_Armor_JE1_BE2.png)
        *   ![Golden Nautilus Armor](https://minecraft.wiki/images/Golden_Nautilus_Armor_JE1_BE2.png)
        *   ![Diamond Nautilus Armor](https://minecraft.wiki/images/Diamond_Nautilus_Armor_JE1_BE2.png)
        *   ![Netherite Nautilus Armor](https://minecraft.wiki/images/Netherite_Nautilus_Armor_JE1_BE2.png)

*   **Netherite Horse Armor:** 
    *   ![Netherite Horse Armor](https://minecraft.wiki/images/Netherite_Horse_Armor.png?ad3a3&format=original)
    *   Can be crafted by upgrading Diamond Horse Armor at a Smithing Table.

## Smaller Changes

### Gameplay

*   **Mounts in Water:** Horses, Donkeys, Mules, and Camels no longer sink when ridden in water.
*   **Mob Behavior:**
    *   Tamed horses no longer run into cacti or sweet berry bushes.
    *   Mounts controlled by mobs will not panic.
    *   Piglins now favor Golden Spears.
    *   Zombified Piglins can now charge with Spears.
    *   Skeleton variants and Drowned can no longer pick up Spears.
*   **Advancements:**
    *   New "Mob Kabob" advancement for spearing multiple enemies.
	    * "Hit five mobs in the same Charge attack using the Spear."
    *   Existing advancements updated to include new mobs and items.

### World & Environment

*   **Underwater Fog:** The fog color and distance in underwater biomes now blend smoothly between biomes.
*   **Nether Fog:** Environmental fog in the Nether is now consistent and not dependent on render distance. ![nether_fog.png](https://i.goett.top/StructuralGothicImage.png)
*   **Weather Effects:** The sky color during sunrise and sunset is now affected by rain and thunder.
*   **Halloween Bats:** Bats no longer have increased spawn rates during Halloween.

### Graphics & UI

* New Debug renderer for showing a Light Level Overlay in F3 Menu can be enabled ![light_overlay.png](https://i.goett.top/TenseCurrentImage.png)
* **Chunk Fading:** Chunks now fade in smoothly instead of appearing suddenly. (Fade-In Time is a new option)
*   **Video Settings:**
    *   Graphics presets ("Fast", "Fancy", "Fabulous!") replace the old graphics modes.
    *   "Texture Filtering" option added to control Anisotropic and RGSS filtering.![texture_filtering.png](https://i.goett.top/NuclearCharmingImage.png)
    *   "See-Through Leaves" is now off by default on the "Fast" preset and provides a greater performance boost. When disabled, leaf gaps are dark green instead of black.
    * Items will no longer “bob” whenever their durability changes, such as when losing durability from an attack, or repaired by Mending ![mending_item](https://i.goett.top/RationalClassicalImage.png)
*   **UI Improvements:**
    *   Search boxes added to the Single Biome and Language selection screens.
    *   Spawn Eggs are now thematically sorted in the Creative Inventory.
    *   An inventory UI has been added for the Nautilus.
    *   The "Music Toast" option now has three states.

## Other Changes

*   **Data & Resource Packs:**
    *   Game rules were renamed to use a `snake_case` format (e.g., `doDaylightCycle` is now `advance_time`).
    *   **Environment Attributes:** A new data-driven system to control visual and gameplay effects like sky color, fog, and mob behavior.
    *   **Timelines:** An experimental feature to modify game behavior based on the in-game time of day.
    *   The `attack_range` item component was added to customize weapon reach.
*   **Commands:** The `stopwatch` command was added to track real-time, and the `worldborder` command now accepts time in ticks, seconds, or days.

## Important Bugfixes

*   [MC-2791](https://bugs.mojang.com/browse/MC-2791) - Player model in the inventory screen renders in the wrong orientation.
*   [MC-73186](https://bugs.mojang.com/browse/MC-73186) - Gaps appear between faces of item and complex block models.
*   [MC-114265](https://bugs.mojang.com/browse/MC-114265) - Mipmaps are too dark around transparent edges.
*   [MC-149630](https://bugs.mojang.com/browse/MC-149630) - Particles have thin, vertical lines flashing around them.
*   [MC-154651](https://bugs.mojang.com/browse/MC-154651) - Boats and rafts can break paintings and item frames.
*   [MC-238715](https://bugs.mojang.com/browse/MC-238715) - The `minecraft:block.chest.locked` sound is not audible to other players.
