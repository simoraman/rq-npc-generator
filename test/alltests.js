// Generated by CoffeeScript 1.6.3
(function() {
  var Character, rollD;

  rollD = function(d) {
    return Math.floor(Math.random() * d + 1);
  };

  describe('Rolling D6', function() {
    var result;
    result = null;
    before(function() {
      return result = rollD(6);
    });
    it('should be above zero', function() {
      return result.should.be.above(0);
    });
    return it('should be less or equal to 6', function() {
      return result.should.be.below(7);
    });
  });

  rollD = function(d) {
    return 3;
  };

  Character = (function() {
    function Character() {
      this.strength = (rollD(6)) + (rollD(6)) + (rollD(6));
      this.stamina = (rollD(6)) + (rollD(6)) + (rollD(6));
      this.power = (rollD(6)) + (rollD(6)) + (rollD(6));
      this.dexterity = (rollD(6)) + (rollD(6)) + (rollD(6));
      this.charisma = (rollD(6)) + (rollD(6)) + (rollD(6));
      this.intelligence = 6 + (rollD(6)) + (rollD(6));
      this.size = 6 + (rollD(6)) + (rollD(6));
      this.health = Math.round((this.stamina + this.size) / 2);
    }

    Character.prototype.dexterityStrikeRank = function() {
      if (this.dexterity > 19) {
        return 1;
      } else if (this.dexterity > 15) {
        return 2;
      } else if (this.dexterity > 9) {
        return 3;
      } else {
        return 4;
      }
    };

    Character.prototype.sizeStrikeRank = function() {
      switch (false) {
        case !(this.size > 19):
          return 0;
        case !(this.size > 15):
          return 1;
        case !(this.size > 9):
          return 2;
        default:
          return 3;
      }
    };

    return Character;

  })();

  describe('Character', function() {
    var character;
    character = null;
    before(function() {
      return character = new Character();
    });
    it('should have properties', function() {
      character.strength.should.equal(9);
      character.intelligence.should.equal(12);
      character.stamina.should.equal(9);
      character.power.should.be.equal(9);
      character.size.should.equal(12);
      character.dexterity.should.equal(9);
      return character.charisma.should.equal(9);
    });
    it('should have health', function() {
      return character.health.should.equal(11);
    });
    describe('Dexterity Strike rank', function() {
      it('should equal 4 for DEX 9', function() {
        return character.dexterityStrikeRank().should.equal(4);
      });
      it('should equal 3 for DEX 10', function() {
        character.dexterity = 10;
        return character.dexterityStrikeRank().should.equal(3);
      });
      it('should equal 2 for DEX 16', function() {
        character.dexterity = 16;
        return character.dexterityStrikeRank().should.equal(2);
      });
      return it('should equal 1 for DEX 20', function() {
        character.dexterity = 20;
        return character.dexterityStrikeRank().should.equal(1);
      });
    });
    return describe('Size Strike Rank', function() {
      it('should equal 3 for size 9', function() {
        character.size = 9;
        return character.sizeStrikeRank().should.equal(3);
      });
      it('should equal 2 for size 10', function() {
        character.size = 10;
        return character.sizeStrikeRank().should.equal(2);
      });
      it('should equal 1 for size 16', function() {
        character.size = 16;
        return character.sizeStrikeRank().should.equal(1);
      });
      return it('should equal 0 for size 20', function() {
        character.size = 20;
        return character.sizeStrikeRank().should.equal(0);
      });
    });
  });

}).call(this);
