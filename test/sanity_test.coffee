describe 'Rolling D6', ->
  result = null

  before ->
    result = rollD(6)

  it 'should be above zero', ->
    result.should.be.above(0)
  it 'should be less or equal to 6', ->
    result.should.be.below 7

describe 'Character', ->

  character = null
  beforeEach ->
    rollD = (d) -> 3
    weapon =
        {
          "Weapon":"Battleaxe",
          "Damage":"1d8+2",
          "STR":13,
          "DEX":9,
          "ENC":1,
          "BaseSkill":10,
          "AP":8,
          "StrikeRank":2
        }
    character = new Character(rollD, weapon)

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

  it 'should have a weapon', ->
    character.weapon.Weapon.should.equal 'Battleaxe'

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

  describe 'Total Strike Rank', ->
    it 'should equal sum of Size, Dexterity and weapon Strike Rank', ->
      character.totalStrikeRank().should.equal 8

  describe 'hitting', ->
    it 'should decrease health', ->
      character.health = 10
      character.hitFor(5)
      character.health.should.equal 5

describe 'Weapon repository', ->
  it 'should return a weapon', ->
    weapons = [{
      "Weapon":"Battleaxe",
      "Damage":"1d8+2",
      "STR":13,
      "DEX":9,
      "ENC":1,
      "BaseSkill":10,
      "AP":8
    }]
    repo = new WeaponRepository(weapons)
    repo.getWeapon().Weapon.should.equal "Battleaxe"
