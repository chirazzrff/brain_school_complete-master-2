import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:brain_school/components/custom_buttons.dart';
import'package:supabase_flutter/supabase_flutter.dart';

class SignUpScreen extends StatefulWidget {
  static String routeName = 'SignUpScreen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  DateTime? _selectedDate;
  String? _gender;
  String? _userType;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1960),
      lastDate: DateTime(2024),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue.shade900,
            hintColor: Colors.blue.shade900,
            textTheme: TextTheme(
              bodyLarge: TextStyle(color: Colors.black, fontSize: 16), // Ajuster taille
              bodyMedium: TextStyle(color: Colors.black, fontSize: 14),
              labelLarge: TextStyle(color: Colors.black, fontSize: 14),
            ),
            colorScheme: ColorScheme.light(
              primary: Colors.blue.shade900,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 0.9), // Réduction globale
            child: child!,
          ),
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }




  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        final AuthResponse response = await Supabase.instance.client.auth.signUp(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );

        final user = response.user;
        if (user != null) {
          final userId = user.id;
          final fullName = _fullNameController.text.trim();
          final gender = _gender;
          final dateOfBirth = _selectedDate != null
              ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
              : null;
          final userType = _userType;

          // ✅ Insérer les données dans la table spécifique
          if (userType == "Student") {
            await Supabase.instance.client.from('students').insert({
              'id': userId,
              'full_name': fullName,
              'gender': gender,
              'date_of_birth': dateOfBirth,
            });
          } else if (userType == "Parent") {
            await Supabase.instance.client.from('parents').insert({
              'id': userId,
              'full_name': fullName,
              'gender': gender,
              'date_of_birth': dateOfBirth,
            });
          } else if (userType == "Teacher") {
            await Supabase.instance.client.from('teachers').insert({
              'id': userId,
              'full_name': fullName,
              'gender': gender,
              'date_of_birth': dateOfBirth,
            });

          }
          else if (userType == "Admin") {
            await Supabase.instance.client.from('admins').insert({
              'id': userId,
              'full_name': fullName,
              'gender': gender,
              'date_of_birth': dateOfBirth,
            });
          }

// ✅ Enregistrer le type d'utilisateur dans la table "profiles"
          await Supabase.instance.client.from('profiles').insert({
            'id': userId,
            'user_type': userType,
          });

          // ✅ Afficher une notification
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Sign-up successful!')),
          );

          // ✅ Redirection selon le type
          if (userType == "Student") {
            Navigator.pushReplacementNamed(context, 'myprofile');
          } else {
            Navigator.pop(context);
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Sign-up successful!')),
          );

          // ✅ Navigation selon le type
          if (userType == "Student") {
            Navigator.pushReplacementNamed(context, 'myprofile');
          } else {
            Navigator.pop(context);
          }
        }

      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign-up error: $error')),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          padding: EdgeInsets.all(5.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade900, Colors.blue.shade600],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(5.w),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Create New Account',
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade900)),
                      SizedBox(height: 3.h),
                      buildInputField(
                          controller: _emailController,
                          label: 'Email',
                          icon: Icons.email,
                          keyboardType: TextInputType.emailAddress),
                      SizedBox(height: 2.h),
                      buildInputField(
                          controller: _fullNameController,
                          label: 'Full Name',
                          icon: Icons.person),
                      SizedBox(height: 2.h),
                      buildInputField(
                          controller: _passwordController,
                          label: 'Password',
                          icon: Icons.lock,
                          obscureText: true),
                      SizedBox(height: 2.h),
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: AbsorbPointer(
                          child: buildInputField(
                            controller: TextEditingController(
                              text: _selectedDate == null
                                  ? ''
                                  : DateFormat('yyyy-MM-dd')
                                  .format(_selectedDate!),
                            ),
                            label: 'Date of Birth',
                            icon: Icons.calendar_today,
                          ),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      buildDropdownField(
                        label: 'Gender',
                        value: _gender,
                        items: ['Male', 'Female'],
                        onChanged: (val) => setState(() => _gender = val),
                      ),
                      SizedBox(height: 2.h),
                      buildDropdownField(
                        label: 'User Type',
                        value: _userType,
                        items: ['Student', 'Teacher', 'Parent', 'Admin'],
                        onChanged: (val) => setState(() => _userType = val),
                      ),
                      SizedBox(height: 3.h),
                      DefaultButton(
                        title: 'Sign Up',
                        iconData: Icons.check,
                        onPress: _signUp,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.blue.shade900),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) => value!.isEmpty ? 'Please enter $label' : null,
    );
  }

  Widget buildDropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
      onChanged: onChanged,
      validator: (value) => value == null ? 'Please select $label' : null,
    );
  }
}