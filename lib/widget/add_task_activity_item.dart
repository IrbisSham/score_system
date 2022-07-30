import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import '../model/activity.dart';

class AddTaskActivityItem extends StatelessWidget {
  final Tuple2<Activity, List<Activity>> categoryWithActivities;

  AddTaskActivityItem(this.categoryWithActivities);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {

          },
          // child: Image.network(
          //   product.imageUrl,
          //   fit: BoxFit.cover,
          // ),
        ),
        // footer: GridTileBar(
        //   backgroundColor: Colors.black87,
        //   leading: Consumer<Product>(
        //     builder: (ctx, product, _) => IconButton(
        //       icon: Icon(
        //         product.isFavorite ? Icons.favorite : Icons.favorite_border,
        //       ),
        //       color: Theme.of(context).accentColor,
        //       onPressed: () {
        //         product.toggleFavoriteStatus();
        //       },
        //     ),
        //   ),
        //   title: Text(
        //     product.title,
        //     textAlign: TextAlign.center,
        //   ),
        //   trailing: IconButton(
        //     icon: Icon(
        //       Icons.shopping_cart,
        //     ),
        //     onPressed: () {
        //       cart.addItem(product.id, product.price, product.title);
        //     },
        //     color: Theme.of(context).accentColor,
        //   ),
        // ),
      ),
    );
  }
}


