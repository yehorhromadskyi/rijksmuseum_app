import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rijksmuseum_app/models/details_model.dart';
import 'package:rijksmuseum_app/styles/colors.dart';
import 'package:rijksmuseum_app/styles/text_styles.dart';
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
      backgroundColor: darkColor,
      appBar: AppBar(
        backgroundColor: darkColor,
        brightness: Brightness.light,
      ),
      body: Consumer<DetailsModel>(
        builder: (context, model, child) {
          return FutureBuilder(
            future: _loadFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
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
                            padding: EdgeInsets.only(right: 8.0),
                            child: Text(model.descriptionDutch,
                                style: detailsScreenStyle),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              model.descriptionEnglish,
                              style: detailsScreenStyle,
                            ),
                          ),
                        ],
                      )),
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Container(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Text(
                      'Oops! It’s not you. It’s us. Give it another try, please. ',
                      style: detailsScreenStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
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
