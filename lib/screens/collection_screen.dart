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
      body: Consumer<CollectionModel>(builder: (context, model, child) {
        return RefreshIndicator(
          onRefresh: _pullToRefresh,
          child: Container(
            color: Colors.brown,
            child: ListView.builder(
              itemCount: model.artObjects.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            model.artObjects[index].headerImageUrl),
                      ),
                    ),
                    child: Text(
                      model.artObjects[index].title,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                );
              },
              controller: _scrollController,
            ),
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
