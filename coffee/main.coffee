require.config({
    paths: {
        'jquery': 'http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min',
        'handlebars': '../handlebars/handlebars',
        'hbs': '../require-handlebars-plugin/hbs',
        'bacon':'../bacon/dist/Bacon.min'
        'bacon.jquery': '../bacon.jquery/dist/bacon.jquery.min',
        'bacon.model': '../bacon.model/dist/bacon.model.min'
    }
})

require(['jquery', 'bacon', 'bacon.jquery', 'handlebars', 'hbs!../../templates/character', 'character', 'dice', 'weaponRepository', 'armorRepository', 'bacon.model', 'characterRepository'],
($, Bacon, bjq, Handlebars, character_template, Character, dice, WeaponRepository, ArmorRepository, Model, CharacterRepository) ->

  weaponStream = Bacon.$.ajax('data/weapons.json')
  armorStream = Bacon.$.ajax('data/armor.json')
  Bacon.combineAsArray(weaponStream, armorStream).onValue( (result) -> init(result[0], result[1]) )

  init = (weapons, armor) ->
    repo = new WeaponRepository(weapons)
    armorRepo = new ArmorRepository(armor)
    characterRepo = new CharacterRepository()
    $('#createCharacter').clickE().subscribe( -> generateCharacter(repo, armorRepo, characterRepo))
    loadCharacters(characterRepo)

  loadCharacters = (characterRepo) ->
    characters = characterRepo.getCharacters()
    renderCharacter(character, characterRepo) for character in characters

  generateCharacter = (weaponRepo, armorRepo, characterRepo) ->
    character = new Character(dice, weaponRepo.getWeapon(), armorRepo.getArmor())
    renderCharacter(character, characterRepo)

  renderCharacter = (character, characterRepo) ->
    html = character_template(character)
    $('body').append(html)
    character_html = $('#character' + character.name)

    hitAmount = bjq.textFieldValue(character_html.find('.hitAmount'))
    hitAmount.changes().assign(character_html.find('.hitDisplay'), 'text')

    clicks = character_html.find('.hit').clickE()
    clicks.onValue( ->
      character.hitFor(character_html.find('.hitDisplay').text())
      character_html.find('.health').text(character.health)
      hitAmount.set(0)
    )

    saveClicks = character_html.find('.save').clickE()
    saveClicks.subscribe( -> characterRepo.save(character))

    deleteClicks = character_html.find('.delete').clickE()
    deleteClicks.subscribe( ->
      characterRepo.remove(character.name)
      character_html.fadeOut()
    )
)
