import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rijksmuseum_app/models/collection_model.dart';
import 'package:rijksmuseum_app/screens/collection_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CollectionModel>(
      create: (context) => CollectionModel(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Consumer<CollectionModel>(
          builder: (context, model, child) => CollectionScreen(),
        ),
      ),
    );
  }
}
