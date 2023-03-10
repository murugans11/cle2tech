import 'package:flutter/material.dart'hide ModalBottomSheetRoute;
import 'package:nb_utils/nb_utils.dart';

import '../constants/app_theme.dart';
import '../constants/constants.dart';



class NotificationsScreen extends StatefulWidget {

  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();

}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: const MyGoogleText(
          text: 'Notifications',
          fontColor: Colors.white,
          fontWeight: FontWeight.normal,
          fontSize: 20,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              width: context.width(),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Container(
                            height: 60,
                            width: 60,
                            decoration:  BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    AppTheme.of(context)?.assets.logo1 ?? '',
                                  ),
                                  fit: BoxFit.fitWidth),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                          ),
                          title: const MyGoogleText(
                            text: 'New Arrival',
                            fontColor: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                          ),
                          subtitle: const MyGoogleText(
                            text: '2 min ago “New Message”',
                            fontColor: textColors,
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                          ),
                          trailing: const Icon(
                            Icons.circle,
                            size: 8,
                            color: secondaryColor1,
                          ),
                        );
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
