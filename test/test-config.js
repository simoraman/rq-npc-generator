require.config({
  // ...paths and stuff
});

require([
  'character', 'dice', 'character_test', 'weaponRepository', 'armorRepository', 'dice_test', 'repository_test', 'characterRepository'
], function(Char, dice, ct, weaponRepository, ArmorRepository, dt, rt, characterRepository) {
  rollD = dice;
  Character = Char;
  WeaponRepository = weaponRepository;
  CharacterRepository = characterRepository;
  if (window.mochaPhantomJS) { mochaPhantomJS.run(); }
  else { mocha.run(); }
});
