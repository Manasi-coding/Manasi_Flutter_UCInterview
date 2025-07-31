import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'The Despicable Shuffle',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const Home(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
