import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/item.dart';

class HomePage extends StatelessWidget {
  List<Item> items = [];

  // get teams
  Future getItems() async {
    //https://api.cleanandmoreuae.com/CMProduct/read-product
    var response = await http
        .get(Uri.https('api.cleanandmoreuae.com', 'CMProduct/read-product'));
    var jsonData = jsonDecode(response.body);
    for (var eachItem in jsonData['data']) {
      final item = Item(
        id: eachItem['id'],
        name: eachItem['name'],
        price: eachItem['price'],
        cost: eachItem['cost'],
        quantity: eachItem['quantity'],
        sku: eachItem['sku'],
        packageSize: eachItem['packageSize'],
        details: eachItem['details'],
        image: eachItem['productImages'],
        stars: eachItem['stars'],
      );
      items.add(item);
    }
    print(items.length);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Store')),
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: getItems(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                  itemCount: items.length,
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 22),
                                  child: Text(
                                    items[index].name,
                                    style:const TextStyle(color: Colors.black,fontSize: 20),
                                        //Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 22, vertical: 5),
                                  width: MediaQuery.of(context).size.width,
                                  height: 500,
                                  //image
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.6),
                                        offset: const Offset(
                                          0.0,
                                          15.0,
                                        ),
                                        blurRadius: 10.0,
                                        spreadRadius: -6.0,
                                      ),
                                    ],
                                    image: DecorationImage(
                                      colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.35),
                                        BlendMode.multiply,
                                      ),
                                      image: NetworkImage(
                                          items[index].image[0].toString()),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ]),

                          // Align(
                          //   alignment: Alignment.center,
                          //   child: Padding(
                          //     padding: const EdgeInsets.symmetric(
                          //         horizontal: 5.0),
                          //     child: Text(
                          //       items[index].name,
                          //       style: const TextStyle(
                          //         fontSize: 19,
                          //       ),
                          //       overflow: TextOverflow.ellipsis,
                          //       maxLines: 2,
                          //       textAlign: TextAlign.center,
                          //     ),
                          //   ),
                          // ),
                          // //price+quantaty
                          // Align(
                          //   alignment: Alignment.bottomLeft,
                          //   child: Row(
                          //     mainAxisAlignment:
                          //         MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       //price
                          //       Container(
                          //         padding: const EdgeInsets.all(5),
                          //         margin: const EdgeInsets.all(10),
                          //         decoration: BoxDecoration(
                          //           color: Colors.black.withOpacity(0.4),
                          //           borderRadius: BorderRadius.circular(15),
                          //         ),
                          //         child: Row(
                          //           children: [
                          //             const Icon(
                          //               Icons.monetization_on,
                          //               color: Colors.yellow,
                          //               size: 18,
                          //             ),
                          //             const SizedBox(width: 7),
                          //             Text(items[index].price.toString()),
                          //           ],
                          //         ),
                          //       ),
                          //       //quantaty
                          //       Container(
                          //         padding: const EdgeInsets.all(5),
                          //         margin: const EdgeInsets.all(10),
                          //         decoration: BoxDecoration(
                          //           color: Colors.black.withOpacity(0.4),
                          //           borderRadius: BorderRadius.circular(15),
                          //         ),
                          //         child: Row(
                          //           children: [
                          //             const Icon(
                          //               Icons.production_quantity_limits,
                          //               color: Colors.yellow,
                          //               size: 18,
                          //             ),
                          //             SizedBox(width: 7),
                          //             Text(items[index].name),
                          //           ],
                          //         ),
                          //       )
                          //     ],
                          //   ),
                          // ),
                          Positioned(
                            bottom: 0.0,
                            left: 10.0,
                            child: SizedBox(
                              height: 136.0,
                              width: size.width - 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    child: Text(
                                      items[index].details,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          //const Spacer(),
                          Positioned(
                            bottom: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.all(25),
                              child: SizedBox(
                                width: size.width - 100,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 20 / 5,
                                      ),
                                      child: Text(
                                          'price ${items[index].price.toString()}\$'),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Colors.black,
                                          size: 18,
                                        ),
                                        Text(items[index].stars.toString()),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
