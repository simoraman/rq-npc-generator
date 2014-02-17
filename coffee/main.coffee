require.config({
    paths: {
        'jquery': ['http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min'],
        'handlebars': ['../handlebars/handlebars'],
        'hbs': '../require-handlebars-plugin/hbs',
        'bacon':'http://cdnjs.cloudflare.com/ajax/libs/bacon.js/0.7.2/bacon.min.js'
    }
})

require(['jquery', 'handlebars', 'hbs!../../templates/character', 'character', 'dice'],
($, Handlebars, character_template, Character, dice) ->
  html = character_template(new Character(dice))
  $('body').html(html)

)
