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
    characterHtml = $('#character' + character.name)

    hitAmount = bjq.textFieldValue(characterHtml.find('.hitAmount'))
    hitAmount.changes().assign(characterHtml.find('.hitDisplay'), 'text')

    clicks = characterHtml.find('.hit').clickE()
    clicks.onValue( ->
      character.hitFor(characterHtml.find('.hitDisplay').text())
      characterHtml.find('.health').text(character.health)
      hitAmount.set(0)
    )

    saveClicks = characterHtml.find('.save').clickE()
    saveClicks.subscribe( ->
      character.name = characterHtml.find('.name').text()
      characterRepo.save(character)
    )

    deleteClicks = characterHtml.find('.delete').clickE()
    deleteClicks.subscribe( ->
      characterRepo.remove(character.name)
      characterHtml.fadeOut()
    )
    setupName(characterHtml)

  setupName = (document) ->
    document.find('.name').clickE().onValue((evt) ->
      $originalElement = $(evt.target)
      currentValue = evt.target.innerText
      $input = $('<input id="asd" type="text" value="' + currentValue + '"></input>')
      $originalElement.replaceWith($input)
      $input.focus()
      keyStream = $input.keyupE()
      keyStream.map('.keyCode').onValue((key) ->
        if(key == 13)
          $originalElement.text($input.val())
          $input.replaceWith($originalElement)
          setupName(document)
      )
    )
)
