define [], () ->
  class Character
    constructor: (@rollD, @weapon, @armor, name) ->
      @strength = (@rollD 6) + (@rollD 6) + (@rollD 6)
      @stamina = (@rollD 6) + (@rollD 6) + (@rollD 6)
      @power = (@rollD 6) + (@rollD 6) + (@rollD 6)
      @dexterity = (@rollD 6) + (@rollD 6) + (@rollD 6)
      @charisma = (@rollD 6) + (@rollD 6) + (@rollD 6)
      @intelligence = 6 + (@rollD 6) + (@rollD 6)
      @size = 6 + (@rollD 6) + (@rollD 6)
      @health = Math.round((@stamina + @size) / 2)
      @attack = 10 + (@rollD 90)
      @defence = 5 + (@rollD 90)
      @name = name || (rollD 1000)

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

    totalStrikeRank: () ->
      this.dexterityStrikeRank() + this.sizeStrikeRank() + @weapon.StrikeRank

    hitFor: (damage) ->
      damage = damage - @rollD(@armor.protection)
      if damage > 0
        @health = @health - damage

    loadValues: (valueObject) ->
      { @strength, @stamina, @power, @dexterity, @charisma,
      @intelligence, @size, @health, @attack, @defence, @weapon, @armor, @name } = valueObject

  return Character
