//the require library is configuring paths
require.config({
    paths: {
        "jquery": ["http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min"],
        "handlebars": ["handlebars/handlebars"],
        "text": ["requirejs-text/text"],
        'hbs': 'require-handlebars-plugin/hbs'
    },
    shim: {
        "handlebars": {exports:"Handlebars"}
    },
    waitSeconds: 10
});

require(["handlebars", "hbs!../templates/character"], function(Handlebars, character_template){
   // var source = document.querySelector("#character-template").innerHTML;
   // template = Handlebars.compile(character_template);
    var html = character_template();
    document.querySelector("body").innerHTML = html;
});
