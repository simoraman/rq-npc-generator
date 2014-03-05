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

describe 'Character repository', ->
    before ->
      repo = new CharacterRepository()
      character = new Character(rollD, null, {'protection':0}, 'name')
      character.health = 10
      repo.save(character)
      @result = repo.get('name')

    it 'should return persisted character', ->
      @result.health.should.equal 10

    it 'should return rich object', ->
      @result.hitFor(5)
      @result.health.should.equal 5

    it 'can fetch by name', ->
      @result.name.should.equal 'name'

    after -> localStorage.clear()
