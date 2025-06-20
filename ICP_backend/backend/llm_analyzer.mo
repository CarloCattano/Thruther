import LLM "mo:llm";

module {

  func systemPromptMessage(text : Text) : LLM.ChatMessage {
    #system_ {
      content = text;
    }
  };

  func userMessage(text : Text) : LLM.ChatMessage {
      #user {
      content = text;
    }
  };

  public func analyzerPrompt(userInput : Text) : async Text {
    let systemPrompt = systemPromptMessage(
                      "OUTPUT ONLY JSON DATA, nothing else you read and analyze the prompt for sentiment analisis and organize it in a fromated json way, no code. Read the tweet data from the "
                      # "prompt and output a single JSON object with the following fields: "
                      # "content, sentimentAnalysis (politicalInclination, energy, mood), date, author"
                      # "You must also perform sentiment analysis. "
                      # "Your output must be a valid JSON object only — do not include any exp"
    );
    let userMsg = userMessage(userInput);
    let messages = [systemPrompt, userMsg];

    let response = await LLM.chat(#Llama3_1_8B).withMessages(messages).send();

    switch (response.message.content) {
      case (?text) text;
      case null "";
    };
  };
};

