define ['dice', 'character'], (dice, Character) ->
  class CharacterRepository
    constructor: () ->

    getStore: () ->
      store = localStorage['characterStore']
      if store == undefined or store == {}
        {}
      else
        JSON.parse(store)

    setStore: (content) -> localStorage['characterStore'] = JSON.stringify(content)

    save: (character) ->
      characterList = @getStore()
      characterList[character.name] = character
      @setStore characterList

    get: (key) ->
      values = @getStore()[key]
      character = new Character(dice)
      character.loadValues values
      character

    getCharacters: () ->
      chars = @getStore()
      array = []

      for key,val of chars
        character = new Character(dice)
        character.loadValues val
        array.push character
      array

    remove: (name) ->
      store = @getStore()
      delete(store[name])
      @setStore store

  return CharacterRepository
