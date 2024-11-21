import 'package:cloud_firestore/cloud_firestore.dart';

class Quotes {
  final String quote;
  final String author;

  Quotes({required this.quote, required this.author});

  // Convert Quotes to Map
  Map<String, dynamic> toMap() {
    return {
      'quote': quote,
      'author': author,
    };
  }

  // Create Quotes from Map
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

  // Convert NewQuery to Map
  Map<String, dynamic> toMap() {
    return {
      'query': query,
      'analysis': analysis,
      'analysisTimestamp': analysisTimestamp,
    };
  }

  // Create NewQuery from Map
  factory Queries.fromMap(Map<String, dynamic> map) {
    return Queries(
      query: map['query'] ?? '',
      analysis: map['analysis'] ?? '',
      analysisTimestamp: map['analysisTimestamp'] ?? Timestamp.now(),
    );
  }
}

class JournalModel {
  final String id;
  final String title;
  final List<String> emotionsList;
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

  // Convert JournalModel to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'emotionsList': emotionsList,
      'quotesList': quotesList.map((quote) => quote.toMap()).toList(),
      'newQueries': queries.map((query) => query.toMap()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // Create JournalModel from Map
  factory JournalModel.fromMap(Map<String, dynamic> map) {
    return JournalModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      emotionsList: List<String>.from(map['emotionsList'] ?? []),
      quotesList: List<Quotes>.from(
        map['quotes']?.map((quoteMap) => Quotes.fromMap(quoteMap)) ?? [],
      ),
      queries: List<Queries>.from(
        map['queries']?.map((queryMap) => Queries.fromMap(queryMap)) ?? [],
      ),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}