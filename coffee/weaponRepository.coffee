define [], () ->
  class WeaponRepository
    constructor: (@weapons) ->
    getWeapon: () ->
      index = Math.floor(Math.random() * @weapons.length)
      @weapons[index]
  return WeaponRepository
