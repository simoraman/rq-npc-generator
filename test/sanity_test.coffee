describe 'Dice', ->
  describe 'when rolling D6', ->
    result = null

    before ->
      result = rollD(6)

    it 'should be above zero', ->
      result.should.be.above(0)
    it 'should be less or equal to 6', ->
      result.should.be.below 7
  describe 'when rolling D0', ->
    it 'should return 0', ->
      rollD(0).should.equal 0

describe 'Character', ->

  character = null
  init =  ->
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
    armor =
      {
        "armor":"No Armor",
        "protection":0
      }
    character = new Character(rollD, weapon, armor)
  describe 'creation', ->
    before(init)
    it 'should have properties', ->
      character.strength.should.equal 9
      character.intelligence.should.equal 12
      character.stamina.should.equal 9
      character.power.should.be.equal 9
      character.size.should.equal 12
      character.dexterity.should.equal 9
      character.charisma.should.equal 9

  it 'should have health', ->
    init()
    character.health.should.equal 11

  it 'should have a weapon', ->
    init()
    character.weapon.Weapon.should.equal 'Battleaxe'

  describe 'armor', ->
    before ->
      init()
      armor =
        {
          "armor":"Leather",
          "protection":5
        }
      character.armor = armor
    it 'should have armor', ->
      character.armor.armor.should.equal 'Leather'
    it 'armor should decrease damage', ->
      character.health = 10
      character.hitFor(5)
      character.health.should.equal 8

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
    before(init)
    it 'should equal sum of Size, Dexterity and weapon Strike Rank', ->
      character.totalStrikeRank().should.equal 8

  describe 'When getting hit', ->
    before(init)
    it 'should decrease health', ->
      character.rollD = -> 0
      character.health = 10
      character.hitFor(5)
      character.health.should.equal 5

  describe 'Fighting', ->
    it 'should have some attack/defence-skill', ->
      character.attack.should.equal 13
      character.defence.should.equal 8

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
