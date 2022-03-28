import 'package:flutter/material.dart';

import 'package:getwidget/getwidget.dart';
import 'package:order_taker/Screens/customwidgets.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({Key? key}) : super(key: key);

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomWidgets.returnBackground(),
          SafeArea(
            child: Column(
              children: [
                GFCard(
                  boxFit: BoxFit.cover,
                  titlePosition: GFPosition.start,
                  image: Image.asset('your asset image'),
                  title: const GFListTile(
                    title: Text('Pizza Don Vito'),
                  ),
                  content: const Text("A nice pizza restaurant"),
                  buttonBar: GFButtonBar(
                    children: <Widget>[
                      GFButton(
                        onPressed: () {},
                        text: 'Choose',
                      ),
                    ],
                  ),
                ),
                GFCard(
                  boxFit: BoxFit.cover,
                  titlePosition: GFPosition.start,
                  imageOverlay: const AssetImage('lib/Assets/PizzaDonVito.jpg'),
                  showOverlayImage: true,
                  title: const GFListTile(
                    title: Text('Pizza Don Vito'),
                  ),
                  content: const Text("A nice pizza restaurant"),
                  buttonBar: GFButtonBar(
                    children: <Widget>[
                      GFButton(
                        onPressed: () {},
                        text: 'Choose',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
