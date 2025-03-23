import 'package:brain_school/components/custom_buttons.dart';
import 'package:brain_school/constants.dart';
import 'package:brain_school/screens/home_screen/teacher_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../admin/Admin Dashboard.dart';
import '../password/Forgot Password.dart';
import '../Signup_Screen/Signup_Screen.dart';

late bool _passwordVisible;

class LoginScreen extends StatefulWidget {
  static String routeName = 'LoginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    _passwordVisible = true;
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        final AuthResponse response = await supabase.auth.signInWithPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );

        final user = response.user;
        if (user != null) {
          final data = await supabase
              .from('profiles')
              .select('user_type')
              .eq('id', user.id)
              .single();

          if (data.isNotEmpty && data.containsKey('user_type')) {
            String userType = data['user_type'];

            switch (userType) {
              case 'Student':
                Navigator.pushReplacementNamed(context, 'StudentProfile');
                break;
              case 'Teacher':
                Navigator.pushReplacementNamed(context, TeacherHomeScreen.routeName);
                break;
              case 'Parent':
                Navigator.pushReplacementNamed(context, 'ParentProfile');
                break;
              case 'Admin':
                Navigator.pushReplacementNamed(context, AdminDashboard.routeName);

                break;
              default:
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('User type not recognized')),
                );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('User profile not found')),
            );
          }
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login error: $error')),
        );
      }
    }
  }
  Future<void> signInWithGoogle() async {
    final supabase = Supabase.instance.client;

    try {
      await supabase.auth.signInWithOAuth(OAuthProvider.google);
      print('Connexion avec Google réussie !');
    } catch (e) {
      print('Erreur lors de la connexion avec Google : $e');
    }
  }

  Future<void> signInWithFacebook() async {
    final supabase = Supabase.instance.client;

    try {
      await supabase.auth.signInWithOAuth(OAuthProvider.facebook);
      print('Connexion avec Facebook réussie !');
    } catch (e) {
      print('Erreur lors de la connexion avec Facebook : $e');
    }
  }

  Future<void> signInWithApple() async {
    final supabase = Supabase.instance.client;

    try {
      await supabase.auth.signInWithOAuth(OAuthProvider.apple);
      print('Connexion avec Apple réussie !');
    } catch (e) {
      print('Erreur lors de la connexion avec Apple : $e');
    }
  }







  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: 100.w,
              height: 35.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hi Student',
                          style: Theme.of(context).textTheme.titleMedium),
                      Text('Sign in to continue',
                          style: Theme.of(context).textTheme.titleSmall),
                      SizedBox(height: 10),
                    ],
                  ),
                  Image.asset(
                    'assets/images/splash.png',
                    height: 40.h,
                    width: 60.w,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                decoration: BoxDecoration(
                  color: kOtherColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        buildEmailField(),
                        SizedBox(height: 20),
                        buildPasswordField(),
                        SizedBox(height: 20),
                        DefaultButton(
                          onPress: () {
                            if (_formKey.currentState!.validate()) {
                              _login();
                            }
                          },
                          title: 'SIGN IN',
                          iconData: Icons.arrow_forward_outlined,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(FontAwesomeIcons.google, color: Colors.red),
                              onPressed: () => signInWithGoogle(),
                            ),
                            SizedBox(width: 20),
                            IconButton(
                              icon: Icon(FontAwesomeIcons.facebook, color: Colors.blue),
                              onPressed: () => signInWithFacebook(),
                            ),
                            SizedBox(width: 20),
                            IconButton(
                              icon: Icon(FontAwesomeIcons.apple, color: Colors.black),
                              onPressed: () => signInWithApple(),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                            );
                          },
                          child: Text("Mot de passe oublié ?", style: TextStyle(color: Colors.blue)),
                        ),
                        SizedBox(height: 20),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignUpScreen()),
                            );
                          },
                          child: Text(
                            "Create an Account ?",
                            style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildEmailField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(fontSize: 16),
      decoration: InputDecoration(
        labelText: 'Email',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        return null;
      },
    );
  }

  TextFormField buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: _passwordVisible,
      keyboardType: TextInputType.visiblePassword,
      style: TextStyle(fontSize: 16),
      decoration: InputDecoration(
        labelText: 'Password',
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
          icon: Icon(_passwordVisible ? Icons.visibility_off : Icons.visibility),
        ),
      ),
      validator: (value) {
        if (value == null || value.length < 5) {
          return 'Must be more than 5 characters';
        }
        return null;
      },
    );
  }
}
