import Text "mo:base/Text";
import Nat "mo:base/Nat";
import Iter "mo:base/Iter";
import RbTree "mo:base/RBTree";

actor {

  type votesType = RbTree.RBTree<Text, Nat>;

  var question : Text = "What is your favourite programming language?";
  var votes : votesType = RbTree.RBTree(Text.compare);

  public query func getQuestion() : async Text {
    question;
  };

  public query func getVotes() : async [(Text, Nat)] {
    Iter.toArray(votes.entries());
  };

  public func vote(entry : Text) : async [(Text, Nat)] {
    // check if entry already has votes
    let votes_for_entry : ?Nat = votes.get(entry);

    // need to be explicit about what to do when it is null or a number so every case is taken care of
    let current_votes_for_entry : Nat = switch votes_for_entry {
      case null 0;
      case (?Nat) Nat;
    };

    // once you have the number of votes, update the votes for the entry
    votes.put(entry, current_votes_for_entry + 1);

    // return number of votes as an array
    Iter.toArray(votes.entries());
  };

  // the method reset the vote count
  public func resetVotes() : async [(Text, Nat)] {
    votes.put("Motoko", 0);
    votes.put("TypeScript", 0);
    votes.put("Rust", 0);
    votes.put("Python", 0);

    Iter.toArray(votes.entries());
  };
};
// so in Motoko there is no need to write a return statement?
