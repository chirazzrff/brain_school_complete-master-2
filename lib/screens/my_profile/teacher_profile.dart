import 'package:brain_school/constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TeacherProfileScreen extends StatefulWidget {
  const TeacherProfileScreen({Key? key}) : super(key: key);
  static String routeName = 'TeacherProfileScreen';

  @override
  _TeacherProfileScreenState createState() => _TeacherProfileScreenState();
}

class _TeacherProfileScreenState extends State<TeacherProfileScreen> {
  final supabase = Supabase.instance.client;
  String fullName = 'Loading...';
  String email = 'Loading...';
  String phoneNumber = 'Loading...';
  String subject = 'Loading...';

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
          .select('full_name, email, phone, subject')
          .eq('id', user.id)
          .single();

      setState(() {
        fullName = response['full_name'] ?? 'Unknown';
        email = response['email'] ?? 'Unknown';
        phoneNumber = response['phone'] ?? 'Unknown';
        subject = response['subject'] ?? 'Unknown';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Teacher Profile'),
        centerTitle: true,
      ),
      body: Container(
        color: kOtherColor,
        child: Column(
          children: [
            Container(
              width: 100.w,
              height: 20.h,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: kBottomBorderRadius,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 10.w,
                    backgroundImage: AssetImage('assets/images/teacher.png'),
                    // Si l'avatar du professeur existe dans la base de données, tu peux changer l'image.
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    fullName,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.h),
            ProfileDetailRow(title: 'Email', value: email),
            ProfileDetailRow(title: 'Phone Number', value: phoneNumber),
            ProfileDetailRow(title: 'Subject', value: subject),
            SizedBox(height: 3.h),
            ElevatedButton(
              onPressed: () {
                // Redirection vers une page de mise à jour du profil
                Navigator.pushNamed(context, '/update-profile');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Modifier Profil',
                style: TextStyle(fontSize: 16.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileDetailRow extends StatelessWidget {
  const ProfileDetailRow({Key? key, required this.title, required this.value})
      : super(key: key);
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
