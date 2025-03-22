import 'package:brain_school/constants.dart';
import 'package:brain_school/screens/assignment_screen/assignment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:brain_school/screens/my_profile/teacher_profile.dart';

class TeacherHomeScreen extends StatefulWidget {
  const TeacherHomeScreen({Key? key}) : super(key: key);
  static String routeName = 'TeacherHomeScreen';

  @override
  _TeacherHomeScreenState createState() => _TeacherHomeScreenState();
}

class _TeacherHomeScreenState extends State<TeacherHomeScreen> {
  final supabase = Supabase.instance.client;
  String teacherName = 'Loading...';

  @override
  void initState() {
    super.initState();
    _fetchTeacherData();
  }

  Future<void> _fetchTeacherData() async {
    final user = supabase.auth.currentUser;
    if (user != null) {
      final response = await supabase
          .from('teachers')
          .select('name')
          .eq('id', user.id)
          .single();

      setState(() {
        teacherName = response['name'] ?? 'Teacher';
      });
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
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            padding: EdgeInsets.all(kDefaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Colors.white),
                        ),
                        Text(
                          teacherName,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, TeacherProfileScreen.routeName);
                      },
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage:
                        AssetImage('assets/images/teacher.png'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: 100.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Wrap(
                        spacing: 20,
                        runSpacing: 20,
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
                            title: 'Mark Attendance',
                          ),
                          HomeCard(
                            onPress: () {},
                            icon: 'assets/icons/timetable.svg',
                            title: 'Time Table',
                          ),
                          HomeCard(
                            onPress: () {},
                            icon: 'assets/icons/lock.svg',
                            title: 'Change Password',
                          ),
                          HomeCard(
                            onPress: () {},
                            icon: 'assets/icons/logout.svg',
                            title: 'Logout',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard({Key? key, required this.onPress, required this.icon, required this.title})
      : super(key: key);
  final VoidCallback onPress;
  final String icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        width: 40.w,
        height: 18.h,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              height: 40.sp,
              width: 40.sp,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
