import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rijksmuseum_app/styles/colors.dart';

class ArtObjectCard extends StatelessWidget {
  final String title;
  final String headerImageUrl;
  final String objectNumber;

  ArtObjectCard(this.objectNumber, this.title, this.headerImageUrl);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(headerImageUrl),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        objectNumber,
                        style: TextStyle(color: lightestColor, fontSize: 12.0),
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
                  decoration: BoxDecoration(
                    color: darkestColor.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
