define [], () ->
  class Character
    constructor: (rollD) ->
      @strength = (rollD 6) + (rollD 6) + (rollD 6)
      @stamina = (rollD 6) + (rollD 6) + (rollD 6)
      @power = (rollD 6) + (rollD 6) + (rollD 6)
      @dexterity = (rollD 6) + (rollD 6) + (rollD 6)
      @charisma = (rollD 6) + (rollD 6) + (rollD 6)
      @intelligence = 6 + (rollD 6) + (rollD 6)
      @size = 6 + (rollD 6) + (rollD 6)
      @health = Math.round((@stamina + @size) / 2)

    dexterityStrikeRank: () ->
      switch
        when @dexterity > 19 then 1
        when @dexterity > 15 then 2
        when @dexterity > 9 then 3
        else 4

    sizeStrikeRank: () ->
      switch
        when @size > 19 then 0
        when @size > 15 then 1
        when @size > 9 then 2
        else 3

    hitFor: (damage) ->
      @health = @health - damage

  return Character
