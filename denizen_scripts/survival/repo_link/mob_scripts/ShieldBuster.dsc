#Used to make Mythicmobs break shields faster. Shoutout to Pjochillin for making this for me.

shield_degradation:
  # $ [ converted until MythicMobs is added ]
  type: world
  debug: false
  events:
    on player damaged by entity:
      - if !<player.is_blocking> || !<context.damager.is_mythicmob>:
        - stop
      - if <player.item_in_hand.material.name> == shield:
        - define slot <player.held_item_slot>
        - define shield <player.item_in_hand>
      - else:
        - define slot 41
        - define shield <player.item_in_offhand>
      - if <[shield].durability.add[<context.damager.mythicmob.level>]> >= <[shield].max_durability>:
        - playeffect effect:ITEM_CRACK at:<player.eye_location> special_data:shield offset:0.25 quantity:20
        - playsound <player> sound:ITEM_SHIELD_BREAK
        - take slot:<[slot]>
      - else:
        - inventory adjust slot:<[slot]> durability:<[shield].durability.add[<context.damager.mythicmob.level>]>
