//the require library is configuring paths
require.config({
    paths: {
        'jquery': ["http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min"],
        'handlebars': ["handlebars/handlebars"],
        'hbs': 'require-handlebars-plugin/hbs'
    },
    shim: {
        "handlebars": {exports:"Handlebars"}
    },
    waitSeconds: 10
});

require(['handlebars', 'hbs!../templates/character', 'app/character', 'app/dice'], function(Handlebars, character_template, Character, dice){
    var html = character_template(new Character(dice));
    document.querySelector("body").innerHTML = html;
});
