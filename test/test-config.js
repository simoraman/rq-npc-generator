require.config({
  // ...paths and stuff
});

require([
  'character', 'dice', 'character_test', 'weaponRepository', 'armorRepository', 'dice_test', 'repository_test'
], function(Char, dice, ct, weaponRepository, ArmorRepository, dt, rt) {
  rollD = dice;
  Character = Char;
  WeaponRepository = weaponRepository;
  if (window.mochaPhantomJS) { mochaPhantomJS.run(); }
  else { mocha.run(); }
});
