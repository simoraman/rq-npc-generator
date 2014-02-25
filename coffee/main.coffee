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

require(['jquery', 'bacon', 'bacon.jquery', 'handlebars', 'hbs!../../templates/character', 'character', 'dice', 'weaponRepository', 'armorRepository', 'bacon.model'],
($, Bacon, bjq, Handlebars, character_template, Character, dice, WeaponRepository, ArmorRepository, Model) ->

  $.get('data/weapons.json', (weapons) ->
    $.get('data/armor.json', (armor) ->
      init(weapons, armor)
    )
  )
  init = (weapons, armor) ->
    repo = new WeaponRepository(weapons)
    character = new Character(dice, repo.getWeapon(), new ArmorRepository(armor).getArmor())

    html = character_template(character)
    $('body').html(html)

    hitAmount = bjq.textFieldValue($('#hitAmount'))
    hitAmount.changes().assign($('#hitDisplay'), 'text')

    $hitDisplay = $('#hitDisplay')
    clicks = $('#hit').clickE()
    clicks.onValue( ->
      character.hitFor($hitDisplay.text())
      $('#health').text(character.health)
      hitAmount.set(0)
    )

)
