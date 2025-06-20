import Blob "mo:base/Blob";
import Cycles "mo:base/ExperimentalCycles";
import Text "mo:base/Text";
import IC "ic:aaaaa-aa";
import HashMap "mo:base/HashMap";
import Array "mo:base/Array";
import Nat "mo:base/Nat";
import Char "mo:base/Char";

import analyzer "llm_analyzer";

actor {

  func indexOfChar(t : Text, c : Char) : ?Nat {
    let arr = Text.toArray(t);
    var i : Nat = 0;
    for (ch in arr.vals()) {
      if (Char.equal(ch, c)) return ?i;
      i += 1;
    };
    return null;
  };

  func lastIndexOfChar(t : Text, c : Char) : ?Nat {
    let arr = Text.toArray(t);
    var last : ?Nat = null;
    var i : Nat = 0;
    for (ch in arr.vals()) {
      if (Char.equal(ch, c)) last := ?i;
      i += 1;
    };
    last
  };

  func iteratorToArray(it : {next : () -> ?Char}) : [Char] {
    var result : [Char] = [];
    var nxt = it.next();
    while (switch nxt {
      case (?c) {
        result := Array.append(result, [c]);
        nxt := it.next();
        true
      };
      case null { false }
    }) {};
    result
  };

  func extractJSON(text : Text) : Text {
    let start = indexOfChar(text, '{');
    let end = lastIndexOfChar(text, '}');

    switch (start, end) {
      case (?s, ?e) {
        if (s < e) {
          let chars = Text.toArray(text);
          let fromInclusive : Nat = s;
          let toExclusive : Nat = e + 1;
          
          if (fromInclusive < chars.size() and toExclusive <= chars.size()) {
            let sliceIter = Array.slice(chars, fromInclusive, toExclusive);
            let sliceArr = iteratorToArray(sliceIter);
            return Text.fromArray(sliceArr);
          } else {
            return "ERROR: Index out of bounds";
          };
        } else {
          return "ERROR: Start index not less than end index";
        };
      };
      case _ {
        "ERROR: No valid JSON found"
      };
    }
  };

  let tweets = HashMap.HashMap<Text, Text>(10, Text.equal, Text.hash);

  public query func transform({
    context : Blob;
    response : IC.http_request_result;
  }) : async IC.http_request_result {
    {
      response with headers = [];
    };
  };

  public func get_twitter_post(postId : Text) : async Text {
    let host : Text = "jackskehan.tech";
    let url = "https://xapi." # host # "/2/tweet/" # postId;

    let request_headers = [
      { name = "User-Agent"; value = "twitter-api-client"; },
      { name = "Authorization"; value = "Bearer your-super-secret-api-key-here2"; },
    ];

    let http_request : IC.http_request_args = {
      url = url;
      max_response_bytes = null;
      headers = request_headers;
      body = null;
      method = #get;
      transform = ?{
        function = transform;
        context = Blob.fromArray([]);
      };
    };

    let http_response : IC.http_request_result = await (with cycles = 230_949_972_000) IC.http_request(http_request);

    let decoded_text : Text = switch (Text.decodeUtf8(http_response.body)) {
      case (null) { "No value returned" };
      case (?y) { y };
    };

    let raw_sentiment = await analyzer.analyzerPrompt(decoded_text);

    let json = extractJSON(raw_sentiment);

    tweets.put(postId, json);

    json
  };

  public query func get_stored(postId : Text) : async ?Text {
    tweets.get(postId)
  };
}