import Blob "mo:base/Blob";
import Cycles "mo:base/ExperimentalCycles";
import Text "mo:base/Text";
import IC "ic:aaaaa-aa";
import Debug "mo:base/Debug";

import analyzer "canister:llm_analyzer";

actor {

  // Transform function to strip headers
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
    let url = "http://xapi." # host # "/2/tweet/" # postId;

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

    // Attach cycles for the HTTPS outcall
    Cycles.add<system>(230_949_972_000);

    // Make the HTTPS request
    let http_response : IC.http_request_result = await IC.http_request(http_request);

    // Decode the response body (Blob) to Text
    let decoded_text : Text = switch (Text.decodeUtf8(http_response.body)) {
      case (null) { "No value returned" };
      case (?y) { y };
    };

    let tweet_content : Text = decoded_text;

    //let sentiment_json : Text = await LLM.analyze_sentiment(tweet_content);
    let sentiment = await analyzer.prompt(" Read and understand this output from twitter api. Format it in like"
										# "an object json file to be stored in a hashmap later( content, sentiment" 
										# "analisys, date , author), you also are in charge of the sentiment "
										# "analysis of the tweet(political inclination, energy, mood) " 
										# "ONLY OUTPUT JSON AND NOTHING ELSE " # tweet_content);
    Debug.print(sentiment);
    Debug.print(tweet_content);
	tweet_content
  };
}
