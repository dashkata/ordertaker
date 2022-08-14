import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_taker/providers/auth_provider.dart';
import 'package:order_taker/providers/common_providers.dart';
import 'package:order_taker/themes/themes.dart';

class ReservationCard extends ConsumerWidget {
  const ReservationCard({
    required this.titleText,
    required this.date,
    required this.imagePath,
    required this.id,

    required this.numberOfPeople,
    Key? key,
  }) : super(key: key);
  final String titleText;
  final String date;
  final String imagePath;
  final String id;
  final int numberOfPeople;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _database = ref.watch(databaseProvider);
    final _auth = ref.watch(authServicesProvider);
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Card(
        color: complementaryColor,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        child: Column(
          children: [
            GFListTile(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
              avatar: GFAvatar(
                backgroundImage: AssetImage("Assets/$imagePath"),
                radius: 40,
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titleText,
                    style: GoogleFonts.roboto(
                      color: accentColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    date,
                    style: GoogleFonts.roboto(
                      color: accentColor,
                      fontStyle: FontStyle.italic,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    "${numberOfPeople.toString()} people",
                    style: GoogleFonts.roboto(
                      color: accentColor,
                      fontStyle: FontStyle.italic,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              description: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GFButton(
                    onPressed: () {
                      _database.deleteReservation(
                          _auth.getCurrentUser()!.uid, id);
                    },
                    elevation: 10,
                    shape: GFButtonShape.pills,
                    color: mainColor,
                    child: Text(
                      "Cancel reservation",
                      style: GoogleFonts.roboto(
                        color: accentColor,
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
