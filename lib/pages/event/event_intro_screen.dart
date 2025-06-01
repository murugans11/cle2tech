import 'package:flutter/material.dart'hide ModalBottomSheetRoute;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../constants/app_theme.dart';
import '../../constants/constants.dart';
import '../../widgets/buttons.dart';
import 'event_form_other_screen.dart';
import 'event_form_screen.dart';

class EventIntroScreen extends StatefulWidget {
  static const String routeName = "/EventIntroScreen";

  const EventIntroScreen({Key? key}) : super(key: key);

  @override
  State<EventIntroScreen> createState() => _EventIntroScreenState();
}

class _EventIntroScreenState extends State<EventIntroScreen> {
  String _verticalGroupValue = "Student";
  final List<String> _status = [
    "Student",
    "Others"
  ];

  @override
  void initState() {
    super.initState();
  }

  Column _buildButtonColumn() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: const Text(
            "Start From",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: const Text(
            "May 2023",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
  Column _buildButtonColumn1() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: const Text(
            "Special Awards for",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: const Text(
            "School/College/Institution",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: const Center(
        child: SpinKitCubeGrid(
          color: Colors.red,
          size: 50.0,
        ),
      ),
      overlayOpacity: 0.8,
      overlayWholeScreen: false,
      overlayHeight: 100,
      overlayWidth: 100,
      child: Scaffold(
        backgroundColor: secondaryColor3,
        body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
            children: [
              ///_____________Photo & Buttons_________________________
              Stack(
                children: [
                  Container(
                      height: 300,
                      width: double.infinity,
                      decoration:  BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(AppTheme.of(context)?.assets.ots ?? ''),
                            fit: BoxFit.cover),
                      ),
                      child: const Text('') // Foreground widget here
                      ),

                  ///__________BackButton__________________________________________________
                  Positioned(
                    left: 10,
                    top: 20,
                    child: Center(
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 5),

              Container(
                padding: const EdgeInsets.only(
                    left: 20, top: 20, bottom: 20, right: 20),
                width: double.infinity,
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
                    const MyGoogleText(
                      text: 'Join Shopeein Online Talent Show',
                      fontSize: 20,
                      fontColor: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 10),
                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Organized by : ',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          TextSpan(
                            text: 'Shopeein.com',
                            style: TextStyle(
                                fontSize: 16,
                                color: primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),


                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 5, top: 20, bottom: 20, right: 5),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildButtonColumn(),
                          _buildButtonColumn1(),

                        ],
                      ),
                    ),

                    const SizedBox(height: 10),
                    const MyGoogleText(
                      text: 'Select your category',
                      fontSize: 20,
                      fontColor: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 10),
                    RadioGroup<String>.builder(
                      direction: Axis.vertical,
                      groupValue: _verticalGroupValue,
                      horizontalAlignment: MainAxisAlignment.spaceAround,
                      activeColor: primaryColor,
                      onChanged: (value) => setState(() {
                        _verticalGroupValue = value!;
                      }),
                      items: _status,
                      textStyle:
                          const TextStyle(fontSize: 15, color: Colors.grey),
                      itemBuilder: (item) => RadioButtonBuilder(
                        item,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                          top: 25, bottom: 30, left: 15, right: 15),
                      child: Button1(
                        buttonText: 'Continue',
                        buttonColor: primaryColor,
                        onPressFunction: () {
                          if(_verticalGroupValue == "Student"){
                            Navigator.pushNamed(context, EventFormScreen.routeName);
                          }else{
                            Navigator.pushNamed(context, EventFormOtherScreen.routeName);
                          }

                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
