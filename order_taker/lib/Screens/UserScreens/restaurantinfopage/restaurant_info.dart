import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:order_taker/Screens/project_widgets.dart';
import 'package:readmore/readmore.dart';

class RestaurantInfo extends StatefulWidget {
  const RestaurantInfo({Key? key}) : super(key: key);

  @override
  State<RestaurantInfo> createState() => _RestaurantInfoState();
}

class _RestaurantInfoState extends State<RestaurantInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundWidget(),
          SafeArea(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GFButton(
                      onPressed: () {},
                      type: GFButtonType.outline2x,
                      text: "Overview",
                    ),
                    GFButton(
                      onPressed: () {},
                      type: GFButtonType.outline2x,
                      text: "Photos",
                    ),
                    GFButton(
                      onPressed: () {},
                      type: GFButtonType.outline2x,
                      text: "Menu",
                    ),
                    GFButton(
                      onPressed: () {},
                      type: GFButtonType.outline2x,
                      text: "Reviews",
                    ),
                  ],
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey[400],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30, top: 30, left: 10),
                  child: Text(
                    "Pizza Don Vito",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey[400],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Review stars"),
                    Text("Other stuff"),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                const Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: ReadMoreText(
                    "Some information about the resaturant",
                    trimLines: 2,
                    colorClickableText: Colors.pink,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: '+ Read more',
                    trimExpandedText: '- Read less',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey[400],
                ),
                Text(
                  "Photos from the restaurant",
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey[400],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
