import 'package:brain_school/constants.dart';
import 'package:brain_school/screens/assignment_screen/assignment_screen.dart';
import 'package:brain_school/screens/datesheet_screen/datesheet_screen.dart';
import 'package:brain_school/screens/fee_screen/fee_screen.dart';
import 'package:brain_school/screens/home_screen/widgets/student_data.dart';
import 'package:brain_school/screens/my_profile/parent_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../my_profile/profile.dart';
import 'home_screen.dart';

class ParentHomeScreen extends StatefulWidget {
  const ParentHomeScreen({Key? key}) : super(key: key);
  static String routeName = 'ParentHomeScreen';

  @override
  _ParentHomeScreenState createState() => _ParentHomeScreenState();
}

class _ParentHomeScreenState extends State<ParentHomeScreen> {
  final supabase = Supabase.instance.client;
  String parentName = "Parent";

  @override
  void initState() {
    super.initState();
    _fetchParentData();
  }

  Future<void> _fetchParentData() async {
    final user = supabase.auth.currentUser;
    if (user != null) {
      final response = await supabase.from('parents').select().eq('id', user.id).single();
      if (response != null) {
        setState(() {
          parentName = response['name'] ?? "Parent";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: 100.w,
            height: 35.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.lightBlue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            padding: EdgeInsets.all(kDefaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hi, $parentName',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                    ),

                    StudentPicture(
                        picAddress: '',
                        onPress: () {
                          Navigator.pushNamed(
                              context, ParentProfileScreen.routeName);
                        }),
                  ],
                ),
                sizedBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    StudentDataCard(
                      onPress: () {},
                      title: 'Attendance',
                      value: '90.02%',
                    ),
                    StudentDataCard(
                      onPress: () {
                        Navigator.pushNamed(context, FeeScreen.routeName);
                      },
                      title: 'Fees Due',
                      value: '600\$',
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: 100.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: GridView.count(
                padding: EdgeInsets.all(20),
                physics: BouncingScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  HomeCard(
                    onPress: () {},
                    icon: 'assets/icons/resume.svg',
                    title: 'Registration',
                  ),
                  HomeCard(
                    onPress: () {
                      Navigator.pushNamed(
                          context, AssignmentScreen.routeName);
                    },
                    icon: 'assets/icons/assignment.svg',
                    title: 'Assignments',
                  ),
                  HomeCard(
                    onPress: () {},
                    icon: 'assets/icons/resume.svg',
                    title: 'Check Attendance',
                  ),
                  HomeCard(
                    onPress: () {},
                    icon: 'assets/icons/timetable.svg',
                    title: 'Time Table',
                  ),
                ],
              ),


            ),
          ),
        ],
      ),
    );
  }
}
