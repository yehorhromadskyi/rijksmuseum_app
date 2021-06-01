import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rijksmuseum_app/models/collection_model.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({Key key}) : super(key: key);

  @override
  _CollectionScreenState createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_scrollListener);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<CollectionModel>().load();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<CollectionModel>(builder: (context, model, child) {
        return RefreshIndicator(
          onRefresh: _pullToRefresh,
          child: ListView.builder(
            itemCount: model.artObjects.length,
            itemBuilder: (context, index) {
              return Container(
                height: 100,
                child: Text(
                  model.artObjects[index].title,
                  style: TextStyle(fontSize: 18),
                ),
              );
            },
            controller: _scrollController,
          ),
        );
      }),
    );
  }

  void _scrollListener() async {
    var model = context.read<CollectionModel>();
    if (_scrollController.position.extentAfter < 500 && !model.isLoading) {
      await context.read<CollectionModel>().loadMore();
    }
  }

  Future<void> _pullToRefresh() async {
    await context.read<CollectionModel>().load();
  }
}
