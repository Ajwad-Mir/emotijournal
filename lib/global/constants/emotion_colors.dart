
import 'dart:math';

import 'package:flutter/material.dart';

class EmotionColorGenerator {
  static final Map<String, Color> _emotionColors = {
    'Joy': Colors.yellow,
    'Sadness': Colors.blueGrey,
    'Anger': Colors.redAccent,
    'Surprise': Colors.orange,
    'Disgust': Colors.brown,
    'Fear': Colors.deepPurple,
    'Trust': Colors.teal,
    'Anticipation': Colors.amber,
    'Love': Colors.pinkAccent,
    'Happiness': Colors.lime,
    'Gratitude': Colors.lightGreen,
    'Shame': Colors.grey,
    'Guilt': Colors.deepOrange,
    'Boredom': Colors.lightBlue,
    'Excitement': Colors.cyan,
    'Contentment': Colors.green,
    'Loneliness': Colors.indigo,
    'Confusion': Colors.deepPurpleAccent,
    'Frustration': Colors.red,
    'Resentment': Colors.deepOrangeAccent,
    'Jealousy': Colors.green,
    'Pride': Colors.deepPurple,
    'Hope': Colors.lightBlueAccent,
    'Despair': Colors.black54,
    'Euphoria': Colors.yellowAccent,
    'Insecurity': Colors.blueGrey,
    'Amazement': Colors.orangeAccent,
    'Courage': Colors.blue,
    'Serenity': Colors.cyanAccent,
    'Affection': Colors.pink,
    'Melancholy': Colors.grey,
    'Humiliation': Colors.brown,
    'Anxiety': Colors.tealAccent,
    'Relief': Colors.greenAccent,
    'Sympathy': Colors.lightGreen,
    'Shock': Colors.blueAccent,
  };

  static Color getColorForEmotion(String emotion) {
    return _emotionColors[emotion] ?? _getRandomColor();
  }

  static Color _getRandomColor() {
    int red = Random().nextInt(200);
    int green = Random().nextInt(200);
    int blue = Random().nextInt(200);
    return Color.fromRGBO(red, green, blue, 1);
  }
}
