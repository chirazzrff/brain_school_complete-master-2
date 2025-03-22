import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:brain_school/constants.dart';

class ParentProfileScreen extends StatelessWidget {
  const ParentProfileScreen({Key? key}) : super(key: key);
  static String routeName = 'ParentProfileScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 8.h),
                CircleAvatar(
                  radius: 15.w,
                  backgroundColor: kSecondaryColor,
                  backgroundImage: AssetImage('assets/images/profile.png'),
                ),
                SizedBox(height: 3.h),
                Text(
                  'Full Name of Parent',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  'Parent Account',
                  style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                ),
                SizedBox(height: 5.h),
                _buildProfileField('Phone Number', ''),
                _buildProfileField('Email', ''),
                _buildProfileField('Admission Number', ''),
                _buildProfileField('Date of Admission', ''),
                _buildProfileField('Date of Birth', ''),
                _buildProfileField('First Name', ''),
                _buildProfileField('Second Name', ''),
                SizedBox(height: 5.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 8.w),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Edit Profile',
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileField(String title, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 0.5.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 3.w),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              value.isNotEmpty ? value : 'Not provided',
              style: TextStyle(fontSize: 12.sp, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}
