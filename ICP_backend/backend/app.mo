import Blob "mo:base/Blob";
import Cycles "mo:base/ExperimentalCycles";
import Text "mo:base/Text";
import IC "ic:aaaaa-aa";

// Actor definition
actor {

  // Transform function to strip headers (not interested in them)
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
      { name = "User-Agent"; 
        value = "twitter-api-client";
      },

      { name = "Authorization"; 
        value = "Bearer your-super-secret-api-key-here2";
      },
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

    decoded_text
  };
}
