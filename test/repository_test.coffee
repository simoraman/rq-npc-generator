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

class CharacterRepository
  constructor: () ->

  save: (character) -> localStorage[1] = JSON.stringify(character)

  get: () -> JSON.parse(localStorage[1])

describe 'Character repository', ->
  before ->
    @repo = new CharacterRepository()
    @character = new Character(rollD)
    @repo.save(@character)

  it 'should return persisted character', ->
    result = @repo.get()
    result.health.should.equal @character.health
