class JournalResponseModel {
  String title;
  List<Query> queries;
  List<String> emotions;
  List<Quote> quotes;

  JournalResponseModel({
    required this.title,
    required this.queries,
    required this.emotions,
    required this.quotes,
  });

  
  factory JournalResponseModel.empty() => JournalResponseModel(
    title: '',
    queries: [],
    emotions: [],
    quotes: [],
  );

  factory JournalResponseModel.fromJson(Map<String, dynamic> json) => JournalResponseModel(
    title: json['title'],
    queries: List<Query>.from(json["queries"].map((x) => Query.fromJson(x))),
    emotions: List<String>.from(json["emotions"].map((x) => x)),
    quotes: List<Quote>.from(json["quotes"].map((x) => Quote.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "queries": List<dynamic>.from(queries.map((x) => x.toJson())),
    "emotions": List<dynamic>.from(emotions.map((x) => x)),
    "quotes": List<dynamic>.from(quotes.map((x) => x.toJson())),
  };
}

class Query {
  String query;
  String solution;

  Query({
    required this.query,
    required this.solution,
  });

  factory Query.fromJson(Map<String, dynamic> json) => Query(
    query: json["query"],
    solution: json["solution"],
  );

  Map<String, dynamic> toJson() => {
    "query": query,
    "solution": solution,
  };
}

class Quote {
  String quote;
  String author;

  Quote({
    required this.quote,
    required this.author,
  });

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
    quote: json["quote"],
    author: json["author"],
  );

  Map<String, dynamic> toJson() => {
    "quote": quote,
    "author": author,
  };
}
