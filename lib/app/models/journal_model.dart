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
      emotionsList: List<Emotion>.from(map['emotionsList']
          ?.map((emotionMap) => Emotion.fromJson(emotionMap))),
      quotesList: List<Quotes>.from(
        map['quotesList']?.map((quoteMap) => Quotes.fromMap(quoteMap)) ?? [],
      ),
      queries: List<Queries>.from(
        map['newQueries']?.map((queryMap) => Queries.fromMap(queryMap)) ?? [],
      ),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
    );
  }

  factory JournalModel.fromJournalResponseModel(
      JournalResponseModel responseModel) {
    return JournalModel(
      id: '',
      title: responseModel.title,
      emotionsList: responseModel.emotions,
      quotesList: responseModel.quotes
          .map((quote) => Quotes(quote: quote.quote, author: quote.author))
          .toList(),
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

  factory JournalModel.mergeWithResponseModel(
      JournalModel existingJournal, JournalResponseModel responseModel) {
    // Combine all emotions from both lists
    final List<Emotion> combinedEmotions = [
      ...existingJournal.emotionsList,
      ...responseModel.emotions
    ];

    // Group emotions by name
    final Map<String, List<Emotion>> groupedEmotions = {};

    for (var emotion in combinedEmotions) {
      groupedEmotions.putIfAbsent(emotion.emotion, () => []).add(emotion);
    }

    // Merge emotions, summing percentages where duplicates exist
    List<Emotion> mergedEmotions = groupedEmotions.entries.map((entry) {
      final String emotionName = entry.key;
      final List<Emotion> emotionInstances = entry.value;

      // Sum all percentages for this emotion
      final int totalPercentage =
          emotionInstances.fold(0, (sum, e) => sum + e.percentage);

      return Emotion(
        emotion: emotionName,
        percentage: totalPercentage, // Keep summed percentage for now
        colorHex: emotionInstances.first.colorHex, // Keep first color
      );
    }).toList();

    // Normalize percentages to ensure total = 100%
    final int sumPercentages =
        mergedEmotions.fold(0, (sum, e) => sum + e.percentage);
    if (sumPercentages > 0) {
      int remainingPercentage = 100;
      mergedEmotions = mergedEmotions.map((e) {
        int newPercentage = ((e.percentage * 100) / sumPercentages).round();

        // Ensure rounding does not cause total to exceed 100
        remainingPercentage -= newPercentage;
        return Emotion(
          emotion: e.emotion,
          percentage: newPercentage,
          colorHex: e.colorHex,
        );
      }).toList();

      // Adjust rounding errors by modifying the last emotion
      if (remainingPercentage != 0 && mergedEmotions.isNotEmpty) {
        mergedEmotions.last = mergedEmotions.last.copyWith(
          percentage: mergedEmotions.last.percentage + remainingPercentage,
        );
      }
    }

    return JournalModel(
      id: existingJournal.id,
      title: responseModel.title,
      emotionsList: mergedEmotions,
      // Use normalized emotions
      quotesList: [
        ...existingJournal.quotesList, // Retain previous quotes
        ...responseModel.quotes
            .map((quote) => Quotes(quote: quote.quote, author: quote.author)),
      ],
      queries: [
        ...existingJournal.queries, // Retain previous queries
        ...responseModel.queries.map((query) => Queries(
              query: query.query,
              analysis: query.solution,
              analysisTimestamp: Timestamp.now(),
            )),
      ],
      createdAt: existingJournal.createdAt,
      // Preserve original creation date
      updatedAt: DateTime.now(), // Update timestamp
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
      title: title ?? this.title,
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
