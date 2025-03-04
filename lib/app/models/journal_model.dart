import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emotijournal/app/models/journal_response_model.dart';

class JournalModel {
  final String id;
  final String title;
  final List<Emotion> emotionsList;
  final List<Quotes> quotesList;
  final List<Queries> queries;
  final DateTime createdAt;
  final DateTime updatedAt;

  JournalModel({
    required this.id,
    required this.title,
    required this.emotionsList,
    required this.quotesList,
    required this.queries,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'emotionsList': emotionsList.map((emotion) => emotion.toJson()).toList(),
      'quotesList': quotesList.map((quote) => quote.toMap()).toList(),
      'newQueries': queries.map((query) => query.toMap()).toList(),
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt)
    };
  }

  factory JournalModel.fromMap(Map<String, dynamic> map) {
    return JournalModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      emotionsList: List<Emotion>.from(map['emotionsList']?.map((emotionMap) => Emotion.fromJson(emotionMap))),
      quotesList: List<Quotes>.from(
        map['quotesList']?.map((quoteMap) => Quotes.fromMap(quoteMap)) ?? [],
      ),
      queries: List<Queries>.from(
        map['newQueries']?.map((queryMap) => Queries.fromMap(queryMap)) ?? [],
      ),
      createdAt:(map['createdAt'] as Timestamp).toDate(),
      updatedAt:(map['updatedAt'] as Timestamp).toDate(),
    );
  }

  factory JournalModel.fromJournalResponseModel(JournalResponseModel responseModel) {
    return JournalModel(
      id: '',
      title: responseModel.title,
      emotionsList: responseModel.emotions,
      quotesList: responseModel.quotes.map((quote) => Quotes(quote: quote.quote, author: quote.author)).toList(),
      queries: responseModel.queries
          .map((query) => Queries(
                query: query.query,
                analysis: query.solution,
                analysisTimestamp: Timestamp.now(),
              ))
          .toList(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  factory JournalModel.empty() {
    return JournalModel(
      id: '',
      title: '',
      emotionsList: [],
      quotesList: <Quotes>[],
      queries: <Queries>[],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  JournalModel copyWith({
    String? id,
    String? title,
    List<Emotion>? emotionsList,
    List<Queries>? queries,
    List<Quotes>? quotesList,
    DateTime? updatedAt,
  }) {
    return JournalModel(
      id: id ?? this.id,
      title:title ?? this.title,
      emotionsList: emotionsList ?? this.emotionsList,
      quotesList: quotesList ?? this.quotesList,
      queries: queries ?? this.queries,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class Quotes {
  final String quote;
  final String author;

  Quotes({required this.quote, required this.author});

  Map<String, dynamic> toMap() {
    return {
      'quote': quote,
      'author': author,
    };
  }

  factory Quotes.fromMap(Map<String, dynamic> map) {
    return Quotes(
      quote: map['quote'] ?? '',
      author: map['author'] ?? '',
    );
  }
}

class Queries {
  final String query;
  final String analysis;
  final Timestamp analysisTimestamp;

  Queries({
    required this.query,
    required this.analysis,
    required this.analysisTimestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'query': query,
      'analysis': analysis,
      'analysisTimestamp': analysisTimestamp,
    };
  }

  factory Queries.fromMap(Map<String, dynamic> map) {
    return Queries(
      query: map['query'] ?? '',
      analysis: map['analysis'] ?? '',
      analysisTimestamp: map['analysisTimestamp'] ?? Timestamp.now(),
    );
  }
}
