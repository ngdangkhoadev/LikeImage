import 'package:flutter/material.dart';
import 'package:flutter_swipe/flutter_swipe.dart';
import 'package:likeimage/model/item_modal.dart';
import 'package:likeimage/providers/item_providers.dart';
import 'package:provider/provider.dart';

class SwipeBody extends StatelessWidget {
  const SwipeBody({Key? key, required this.isFavorite}) : super(key: key);

  final isFavorite;

  @override
  Widget build(BuildContext context) {
    final dataItem = Provider.of<ItemProvider>(context);
    final items = isFavorite ? dataItem.showItemFavorite() : dataItem.items;

    return items.isNotEmpty
        ? Swiper(
            layout: SwiperLayout.STACK,
            itemWidth: 350.0,
            itemHeight: 650.0,
            itemCount: items.length,
            itemBuilder: (BuildContext context, index) {
              return ChangeNotifierProvider.value(
                value: items[index],
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: GridTile(
                    footer: GridTileBar(
                      backgroundColor: Colors.white12,
                      title: Consumer<Item>(
                        builder: (context, item, child) {
                          return InkWell(
                            onTap: (() {
                              item.toggleIsFavorite();
                              Provider.of<ItemProvider>(context, listen: false)
                                  .handleCountItemFav();
                            }),
                            child: Icon(
                              Icons.favorite,
                              size: 30,
                              color:
                                  item.isFavorite ? Colors.red : Colors.white,
                            ),
                          );
                        },
                      ),
                      subtitle: const Text('Like Image'),
                      trailing: Text(
                        items[index].name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    child: Image.asset(
                      items[index].image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          )
        : Container(
            child: const Center(
              child: Text('Không có hình nào'),
            ),
          );
  }
}
