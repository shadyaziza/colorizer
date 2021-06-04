import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    Key? key,
    required this.image,
  }) : super(key: key);
  final Image? image;
  @override
  Widget build(BuildContext context) {
    return image != null
        ? Card(
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.blueGrey, width: 8)),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(16), child: image),
            ),
          )
        : Container();
  }
}
