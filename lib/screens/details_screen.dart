import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rijksmuseum_app/models/details_model.dart';
import 'package:rijksmuseum_app/styles/colors.dart';
import 'package:transparent_image/transparent_image.dart';

class DetailsScreen extends StatefulWidget {
  final String objectNumber;

  DetailsScreen(this.objectNumber);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Future _loadFuture;

  @override
  void initState() {
    super.initState();

    _loadFuture = context.read<DetailsModel>().load(widget.objectNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: accentColor,
      ),
      body: Consumer<DetailsModel>(
        builder: (context, model, child) {
          return FutureBuilder(
            future: _loadFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  children: [
                    Expanded(
                      child: Container(
                        child: FadeInImage.memoryNetwork(
                          image: model.imageUrl,
                          placeholder: kTransparentImage,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.0),
                    Expanded(
                      child: Container(
                          child: PageView(
                        controller: PageController(viewportFraction: 0.9),
                        children: [
                          Container(
                            child: Text(model.descriptionDutch),
                          ),
                          Container(child: Text(model.descriptionEnglish)),
                        ],
                      )),
                    )
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          );
        },
      ),
    );
  }
}
