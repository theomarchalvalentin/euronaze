import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:projet_dac/src/widgets/homepage/FeaturedTiles.dart';

class TrendingList extends StatelessWidget {
  const TrendingList({
    Key? key,
    required this.assetsImages,
    required this.assetsNames,
  }) : super(key: key);

  final List<String> assetsImages;
  final List<String> assetsNames;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: bullAssetsImages.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              child: ListTile(
            leading: FlutterLogo(size: 56.0),
            title: Text(bullAssetsNames[index]),
            subtitle: Text('Here is a second line'),
            trailing: Icon(Icons.more_vert),
          ));
        });
  }
}
