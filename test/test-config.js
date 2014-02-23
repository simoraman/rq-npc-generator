require.config({
  // ...paths and stuff
});

require([
  'character', 'dice', 'sanity_test', 'weaponRepository'
], function(Char, dice, sanity_test, weaponRepository) {
  rollD = dice;
  Character = Char;
  WeaponRepository = weaponRepository;
  if (window.mochaPhantomJS) { mochaPhantomJS.run(); }
  else { mocha.run(); }
});
