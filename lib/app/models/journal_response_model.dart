class JournalResponseModel {
  String title;
  List<Query> queries;
  List<Emotion> emotions;
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

  factory JournalResponseModel.fromJson(Map<String, dynamic> json) {
    return JournalResponseModel(
      title: json['title'] ?? '',
      quotes: (json['quotes'] as List?)?.map((e) => Quote.fromJson(e)).toList() ?? [],
      queries: (json['queries'] as List?)?.map((e) => Query.fromJson(e)).toList() ?? [],
      emotions: (json['emotions'] as List?)?.map((e) => Emotion.fromJson(e)).toList() ?? [], // Fix null issue
    );
  }


  Map<String, dynamic> toJson() => {
    "title": title,
    "queries": List<dynamic>.from(queries.map((x) => x.toJson())),
    "emotions": List<dynamic>.from(emotions.map((x) => x.toJson())),
    "quotes": List<dynamic>.from(quotes.map((x) => x.toJson())),
  };
}

class Emotion {
  final String emotion;
  final int percentage;
  final String colorHex;

  Emotion({
    required this.emotion,
    required this.percentage,
    required this.colorHex,
  });

  factory Emotion.fromJson(Map<String, dynamic> json) => Emotion(
    emotion: json["emotion"],
    percentage: json["percentage"],
    colorHex: json["colorHex"],
  );

  Map<String, dynamic> toJson() => {
    "emotion": emotion,
    "percentage": percentage,
    "colorHex": colorHex ,
  };

  Emotion copyWith({String? emotion, String? colorHex, int? percentage}) {
    return Emotion(
      emotion: emotion ?? this.emotion,
      percentage: percentage ?? this.percentage,
      colorHex: colorHex ?? this.colorHex,
    );
  }
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
