import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rijksmuseum_app/styles/colors.dart';

class ArtObjectCard extends StatelessWidget {
  final String objectTitle;
  final String headerImageUrl;
  final String objectNumber;

  ArtObjectCard(this.objectNumber, this.objectTitle, this.headerImageUrl);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          _artObjectImage(headerImageUrl),
          _artObjectDescription(objectNumber, objectTitle)
        ],
      ),
    );
  }

  Widget _artObjectImage(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: FadeInImage(
        image: NetworkImage(url),
        placeholder: AssetImage('assets/placeholder.png'),
        fit: BoxFit.fitHeight,
      ),
    );
  }

  Widget _artObjectDescription(String number, String title) {
    return _artObjectDescriptionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            number,
            style: TextStyle(
              color: lightestColor,
              fontSize: 12.0,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            title,
            style: TextStyle(
              color: lightestColor,
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _artObjectDescriptionContainer({Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(child: Container()),
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
              child: Container(
                child: child,
                decoration: BoxDecoration(
                  color: darkestColor.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: EdgeInsets.all(12.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
