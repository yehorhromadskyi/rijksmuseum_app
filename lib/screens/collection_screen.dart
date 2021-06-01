import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rijksmuseum_app/models/collection_model.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({Key key}) : super(key: key);

  @override
  _CollectionScreenState createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  @override
  void initState() {
    super.initState();

    print('loading started');

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<CollectionModel>().load();

      print('loading finished');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<CollectionModel>(
        builder: (context, model, child) => ListView.builder(
          itemCount: model.artObjects.length,
          itemBuilder: (context, index) => Text(
            model.artObjects[index].title,
          ),
        ),
      ),
    );
  }
}
