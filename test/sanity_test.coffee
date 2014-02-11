rollD = (d) -> Math.floor(Math.random() * d + 1)

describe 'Rolling D6', ->
  result = null

  before ->
    result = rollD(6)

  it 'should be above zero', ->
    result.should.be.above(0)
  it 'should be less or equal to 6', ->
    result.should.be.below 7


rollD = (d) -> 3

class Character
  constructor: ->
    @strength = (rollD 6) + (rollD 6) + (rollD 6)
    @stamina = (rollD 6) + (rollD 6) + (rollD 6)
    @power = (rollD 6) + (rollD 6) + (rollD 6)
    @dexterity = (rollD 6) + (rollD 6) + (rollD 6)
    @charisma = (rollD 6) + (rollD 6) + (rollD 6)
    @intelligence = 6 + (rollD 6) + (rollD 6)
    @size = 6 + (rollD 6) + (rollD 6)
    @health = Math.round((@stamina + @size) / 2)

  dexterityStrikeRank: () ->
    if @dexterity > 19
      1
    else if @dexterity > 15
      2
    else if @dexterity > 9
      3
    else
      4

  sizeStrikeRank: () ->
    switch
      when @size > 19 then 0
      when @size > 15 then 1
      when @size > 9 then 2
      else 3

describe 'Character', ->
  character = null
  before ->
    character = new Character()

  it 'should have properties', ->
    character.strength.should.equal 9
    character.intelligence.should.equal 12
    character.stamina.should.equal 9
    character.power.should.be.equal 9
    character.size.should.equal 12
    character.dexterity.should.equal 9
    character.charisma.should.equal 9

  it 'should have health', ->
    character.health.should.equal 11

  describe 'Dexterity Strike rank', ->
    it 'should equal 4 for DEX 9', ->
      character.dexterityStrikeRank().should.equal 4

    it 'should equal 3 for DEX 10', ->
      character.dexterity = 10
      character.dexterityStrikeRank().should.equal 3

    it 'should equal 2 for DEX 16', ->
      character.dexterity = 16
      character.dexterityStrikeRank().should.equal 2

    it 'should equal 1 for DEX 20', ->
      character.dexterity = 20
      character.dexterityStrikeRank().should.equal 1

  describe 'Size Strike Rank', ->
    it 'should equal 3 for size 9', ->
      character.size = 9
      character.sizeStrikeRank().should.equal 3

    it 'should equal 2 for size 10', ->
      character.size = 10
      character.sizeStrikeRank().should.equal 2

    it 'should equal 1 for size 16', ->
      character.size = 16
      character.sizeStrikeRank().should.equal 1

    it 'should equal 0 for size 20', ->
      character.size = 20
      character.sizeStrikeRank().should.equal 0
