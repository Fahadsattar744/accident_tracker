import 'package:accident_tracker/pages/splash_screen.dart';
import 'package:accident_tracker/pages/timer.dart';
import 'package:accident_tracker/pages/widgets/header_widget.dart';
import 'package:accident_tracker/pages/widgets/user_info_view.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

import '../common/theme_helper.dart';
import 'forgot_password_page.dart';
import 'forgot_password_verification_page.dart';
import 'login_page.dart';
import 'registration_page.dart';

class ProfilePage extends StatefulWidget {
  final String userName;
  final String email;
  const ProfilePage(
      {Key? key,
      this.userName = 'Your name here',
      this.email = 'Your email here'})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  double _drawerIconSize = 24;
  double _drawerFontSize = 17;
  bool _location = false;
  bool _alarm = false;
  Time _time = Time(hour: 11, minute: 30, second: 20);
  bool iosStyle = true;
  bool showAlarmSwitch = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void onTimeChanged(Time newTime) {
    setState(() {
      _time = newTime;
      showAlarmSwitch = true;
    });
  }

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
              // gradient: LinearGradient(
              //     begin: Alignment.topLeft,
              //     end: Alignment.bottomRight,
              //     stops: [0.0, 1.0],
              //     colors: [
              //       Theme.of(context).primaryColor.withOpacity(0.2),
              //       Theme.of(context).indicatorColor.withOpacity(0.5),
              //     ]
              // )
              ),
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 1.0],
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).indicatorColor,
                    ],
                  ),
                ),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Accident Tracker",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.screen_lock_landscape_rounded,
                  size: _drawerIconSize,
                  color: Theme.of(context).indicatorColor,
                ),
                title: Text(
                  'Splash Screen',
                  style: TextStyle(
                      fontSize: 17, color: Theme.of(context).indicatorColor),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SplashScreen(title: "Splash Screen")));
                },
              ),
              Divider(
                color: Theme.of(context).primaryColor,
                height: 1,
              ),
              ListTile(
                leading: Icon(Icons.login_rounded,
                    size: _drawerIconSize,
                    color: Theme.of(context).indicatorColor),
                title: Text(
                  'Login Page',
                  style: TextStyle(
                      fontSize: _drawerFontSize,
                      color: Theme.of(context).indicatorColor),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
              ),
              Divider(
                color: Theme.of(context).primaryColor,
                height: 1,
              ),
              ListTile(
                leading: Icon(Icons.person_add_alt_1,
                    size: _drawerIconSize,
                    color: Theme.of(context).indicatorColor),
                title: Text(
                  'Registration Page',
                  style: TextStyle(
                      fontSize: _drawerFontSize,
                      color: Theme.of(context).indicatorColor),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegistrationPage()),
                  );
                },
              ),
              Divider(
                color: Theme.of(context).primaryColor,
                height: 1,
              ),
              ListTile(
                leading: Icon(
                  Icons.password_rounded,
                  size: _drawerIconSize,
                  color: Theme.of(context).indicatorColor,
                ),
                title: Text(
                  'Forgot Password Page',
                  style: TextStyle(
                      fontSize: _drawerFontSize,
                      color: Theme.of(context).indicatorColor),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ForgotPasswordPage()),
                  );
                },
              ),
              Divider(
                color: Theme.of(context).primaryColor,
                height: 1,
              ),
              ListTile(
                leading: Icon(
                  Icons.verified_user_sharp,
                  size: _drawerIconSize,
                  color: Theme.of(context).indicatorColor,
                ),
                title: Text(
                  'Verification Page',
                  style: TextStyle(
                      fontSize: _drawerFontSize,
                      color: Theme.of(context).indicatorColor),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ForgotPasswordVerificationPage()),
                  );
                },
              ),
              Divider(
                color: Theme.of(context).primaryColor,
                height: 1,
              ),
              ListTile(
                leading: Icon(
                  Icons.logout_rounded,
                  size: _drawerIconSize,
                  color: Theme.of(context).indicatorColor,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(
                      fontSize: _drawerFontSize,
                      color: Theme.of(context).indicatorColor),
                ),
                onTap: () {
                  SystemNavigator.pop();
                },
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(height: 250, child: HeaderWidget(250, false, Icons.add)),
              Positioned(
                top: 30,
                child: IconButton(
                    onPressed: () {
                      _scaffoldKey.currentState!.openDrawer();
                    },
                    icon: Icon(
                      Icons.menu_rounded,
                      color: Colors.white,
                    )),
              ),
              Positioned(
                  top: 120,
                  left: MediaQuery.of(context).size.width / 4.2,
                  child: Text(
                    "Car Accident Tracker",
                    style: TextStyle(
                        fontSize: 23,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          ),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                UserInfoView(
                  userName: widget.userName,
                  animation: Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                          parent: animationController!,
                          curve: Interval((1 / 9) * 1, 1.0,
                              curve: Curves.fastOutSlowIn))),
                  animationController: animationController!,
                  email: widget.email,
                ),
                SizedBox(height: 40),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(0, 3),
                        )
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          print("object");
                          Get.to(() => AccidentTraker());
                        },
                        child: Text(
                          'Accident Alert',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      // FlutterSwitch(
                      //   value: _location,
                      //   borderRadius: 30.0,
                      //   showOnOff: true,
                      //   onToggle: (val) {
                      //     setState(() {
                      //       _location = val;
                      //     });
                      //   },
                      // ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(0, 3),
                        )
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Alarm',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${_time.hour}:${_time.minute} ${_time.period.name}"
                                .toUpperCase(),
                          )
                        ],
                      ),
                      showAlarmSwitch
                          ? FlutterSwitch(
                              value: _alarm,
                              borderRadius: 30.0,
                              showOnOff: true,
                              onToggle: (val) {
                                setState(() {
                                  _alarm = val;
                                });
                              },
                            )
                          : Container(
                              decoration:
                                  ThemeHelper().buttonBoxDecoration(context),
                              child: ElevatedButton(
                                style: ThemeHelper().buttonStyle(),
                                child: Text(
                                  'Set'.toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    showPicker(
                                        iosStylePicker: iosStyle,
                                        context: context,
                                        value: _time,
                                        sunrise: TimeOfDay(
                                            hour: 6, minute: 0), // optional
                                        sunset: TimeOfDay(
                                            hour: 18, minute: 0), // optional
                                        duskSpanInMinutes: 120, // optional
                                        onChange: onTimeChanged,
                                        is24HrFormat: false),
                                  );
                                },
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
