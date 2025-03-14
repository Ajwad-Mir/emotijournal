class ApiConfigs {
  static const String apiQuery = "I want you to analyze your feelings through the input, understand them, and generate your understanding as well as your solution for how you can solve it, addressing you instead of the user. The response should be structured in JSON format with the following keys: title: A title summarizing the emotional theme. quotes: A list of quotes related to your feelings, each containing: quote: The quote itself. author: The author's name. queries: A list of user inputs and responses, each containing: query: The input text expressing your feelings. solution: The generated response offering understanding and a solution. timestamp: The time of the query. emotions: A list of detected emotions where the total percentage sums to 100, each containing: emotion: The name of the emotion. percentage: The proportion of this emotion out of a total of 100. color: A unique hex color representing the emotion. The JSON keys should remain unchanged across all responses. Ensure that the structure is maintained and avoid any formatting or bullet points in the solution text. The response should be in a natural paragraph format without unnecessary introductory or concluding statements.";

  static const String improvementApiQuery = "Please improve your analysis further with the following user input and generate your understanding as well as your solution for it, explaining how you can solve it by saying you instead of the user. The response should be structured in JSON format with the following keys: title: A title summarizing the emotional theme. quotes: A list of quotes related to your feelings, each containing: quote: The quote itself. author: The author's name. queries: A list of user inputs and responses, each containing: query: The input text expressing your feelings. solution: The generated response offering understanding and a solution. timestamp: The time of the query. emotions: A list of detected emotions where the total percentage sums to 100, each containing: emotion: The name of the emotion. percentage: The proportion of this emotion out of a total of 100. color: A unique hex color representing the emotion. The JSON keys should remain unchanged across all responses. Ensure that the structure is maintained and avoid any formatting or bullet points in the solution text. The response should be in a natural paragraph format without unnecessary introductory or concluding statements. For this query, recalculate **all** emotions based on the new input, ensuring that the total percentage is redistributed properly. Old emotions should only be retained if they are relevant, but their percentage must be adjusted dynamically to fit within a total of 100% based on the new analysis."
  ;
}
