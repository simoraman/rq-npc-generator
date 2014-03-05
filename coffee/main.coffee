require.config({
    paths: {
        'jquery': 'http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min',
        'handlebars': '../handlebars/handlebars',
        'hbs': '../require-handlebars-plugin/hbs',
        'bacon':'http://cdnjs.cloudflare.com/ajax/libs/bacon.js/0.7.2/bacon.min'
        'bacon.jquery': '../bacon.jquery/bacon.jquery.min',
        'bacon.model': '../bacon.model/bacon.model.min'
    }
})

require(['jquery', 'bacon', 'bacon.jquery', 'handlebars', 'hbs!../../templates/character', 'character', 'dice', 'weaponRepository', 'armorRepository', 'bacon.model', 'characterRepository'],
($, Bacon, bjq, Handlebars, character_template, Character, dice, WeaponRepository, ArmorRepository, Model, CharacterRepository) ->

  $.get('data/weapons.json', (weapons) ->
    $.get('data/armor.json', (armor) ->
      init(weapons, armor)
    )
  )

  init = (weapons, armor) ->
    repo = new WeaponRepository(weapons)
    armorRepo = new ArmorRepository(armor)
    characterRepo = new CharacterRepository()
    $('#createCharacter').clickE().subscribe( -> generateCharacter(repo, armorRepo, characterRepo))

  generateCharacter = (weaponRepo, armorRepo, characterRepo) ->
    character = new Character(dice, weaponRepo.getWeapon(), armorRepo.getArmor())
    html = character_template(character)

    hitAmount = bjq.textFieldValue($('#hitAmount'))
    hitAmount.changes().assign($('#hitDisplay'), 'text')

    clicks = $('#hit').clickE()
    clicks.onValue( ->
      character.hitFor($('#hitDisplay').text())
      $('#health').text(character.health)
      hitAmount.set(0)
    )

    saveClicks = html.find('.save').clickE()
    saveClicks.subscribe( -> characterRepo.save(character))

    $('body').append(html)
)
