require.config({
    paths: {
        'jquery': ['http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min'],
        'handlebars': ['../handlebars/handlebars'],
        'hbs': '../require-handlebars-plugin/hbs',
        'bacon':'http://cdnjs.cloudflare.com/ajax/libs/bacon.js/0.7.2/bacon.min'
        'bacon.jquery': '../bacon.jquery/bacon.jquery.min',
        'bacon.model': '../bacon.model/bacon.model.min'
    }
})

require(['jquery', 'bacon', 'bacon.jquery', 'handlebars', 'hbs!../../templates/character', 'character', 'dice', 'bacon.model'],
($, Bacon, bjq, Handlebars, character_template, Character, dice, Model) ->
  html = character_template(new Character(dice))
  $('body').html(html)

  left = bjq.textFieldValue($("#left"))

  right = bjq.textFieldValue($("#hitAmount"))

  right.map(".toUpperCase").changes().assign($("#hitDisplay"), "text")

)
