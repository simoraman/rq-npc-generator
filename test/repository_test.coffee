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
  describe 'when getting single character', ->
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

  describe 'when querying several characters', ->
    before ->
      repo = new CharacterRepository()
      character = new Character(rollD, null, {'protection':0}, 'name')
      character.health = 10
      repo.save character
      character = new Character(rollD, null, {'protection':0}, 'name2')
      repo.save character
      @characters = repo.getCharacters()

    it 'returns all characters', ->
      @characters.length.should.equal 2

    it 'returns correct characters', ->
      @characters[0].name.should.equal 'name'
      @characters[1].name.should.equal 'name2'

    it 'returns rich objects', ->
      char = @characters[0]
      char.hitFor(5)
      char.health.should.equal 5
    after -> localStorage.clear()

  describe 'when character is not needed', ->
    it 'can be removed', ->
      repo = new CharacterRepository()
      character = new Character(rollD, null, {'protection':0}, 'name')
      character.health = 10
      repo.save(character)
      characters = repo.getCharacters()
      characters.length.should.equal 1
      repo.remove('name')
      characters = repo.getCharacters()
      characters.length.should.equal 0
    after -> localStorage.clear()
