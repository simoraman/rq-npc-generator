require.config({
  // ...paths and stuff
});

require([
  'character', 'dice', 'sanity_test'
], function(Char, dice, sanity_test) {
  rollD = dice
  Character = Char
  if (window.mochaPhantomJS) { mochaPhantomJS.run(); }
  else { mocha.run(); }
});
