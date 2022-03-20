import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_shop/models/cart_item.dart';
import 'package:food_shop/utils/constant.dart';
import 'package:food_shop/utils/controller.dart';
import 'package:food_shop/utils/notifier.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(8),
      controller: Controller.scroll,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        mainAxisExtent: 250,
      ),
      itemCount: 20,
      itemBuilder: (context, index) {
        return Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text(
                  '$index Name',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                ),
                Flexible(
                    child: CachedNetworkImage(
                  imageUrl: "assets/images/placeholder_user_00.jpg",
                  // placeholder: (context, url) =>
                  //     CircularProgressIndicator(),
                  // progressIndicatorBuilder:
                  //     (context, url, downloadProgress) =>
                  //         CircularProgressIndicator(
                  //             value: downloadProgress.progress),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  // fit: BoxFit.cover,
                )
                    // Image(
                    //     image: CachedNetworkImageProvider(
                    //         snapshot.data![index].image))
                    // CachedNetworkImage(
                    //   imageUrl: ,
                    //   child: Image.network(
                    //     snapshot.data![index].image,
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // SizedBox(width: 5),
                    Text(
                      "Unit Price: \$" +
                          Constant.productPriceList[index].toString(),
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    Text(
                      "Quantity: " +
                          Constant.productQuantityList[index].toString(),
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    // const SizedBox(width: 50),
                    IconButton(
                      icon: const Icon(
                        FontAwesomeIcons.edit,
                        color: Colors.cyan,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
