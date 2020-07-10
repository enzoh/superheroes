/**
 * Module     : Main.mo
 * Copyright  : Enzo Haussecker
 * License    : Apache 2.0 with LLVM Exception
 * Maintainer : Enzo Haussecker <enzo@dfinity.org>
 * Stability  : Stable
 */

import List "mo:base/List";
import Option "mo:base/Option";
import Trie "mo:base/Trie";

actor Superheroes {

  /**
   * Types
   */

  // The type of a superhero identifier.
  public type SuperheroId = Word32;

  // The type of a superhero.
  public type Superhero = {
    name : Text;
    superpowers : List.List<Text>;
  };

  /**
   * Application State
   */

  // The next available superhero identifier.
  private stable var next : SuperheroId = 0;

  // The superhero data store.
  private stable var superheroes : Trie.Trie<SuperheroId, Superhero> = Trie.empty();

  /**
   * High-Level API
   */

  // Create a superhero.
  public func create(superhero : Superhero) : async SuperheroId {
    let superheroId = next;
    next += 1;
    superheroes := Trie.replace(
      superheroes,
      key(superheroId),
      eq,
      ?superhero,
    ).0;
    return superheroId;
  };

  // Read a superhero.
  public query func read(superheroId : SuperheroId) : async ?Superhero {
    let result = Trie.find(superheroes, key(superheroId), eq);
    return result;
  };

  // Update a superhero.
  public func update(superheroId : SuperheroId, superhero : Superhero) : async Bool {
    let result = Trie.find(superheroes, key(superheroId), eq);
    let exists = Option.isSome(result);
    if (exists) {
      superheroes := Trie.replace(
        superheroes,
        key(superheroId),
        eq,
        ?superhero,
      ).0;
    };
    return exists;
  };

  // Delete a superhero.
  public func delete(superheroId : SuperheroId) : async Bool {
    let result = Trie.find(superheroes, key(superheroId), eq);
    let exists = Option.isSome(result);
    if (exists) {
      superheroes := Trie.replace(
        superheroes,
        key(superheroId),
        eq,
        null,
      ).0;
    };
    return exists;
  };

  /**
   * Utilities
   */

  // Test two superhero identifiers for equality.
  private func eq(x : SuperheroId, y : SuperheroId) : Bool {
    return x == y;
  };

  // Create a trie key from a superhero identifier.
  private func key(x : SuperheroId) : Trie.Key<SuperheroId> {
    return { hash = x; key = x };
  };
};
