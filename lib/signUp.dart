import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();

  void Login(email, password) async {
    try {
      Response response =
          await post(Uri.parse('https://reqres.in/api/register'), body: {
        'email': email,
        'Password': password,
      });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data['token']);
        print('Account Created Successfull');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('SignUp')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(hintText: 'Eamil'),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: PasswordController,
              decoration: InputDecoration(hintText: 'Password'),
            ),
            SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                Login(emailController.text.toString(),
                    PasswordController.text.toString());
              },
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.amber, borderRadius: BorderRadius.circular(15)),
              child: Center(child: Text('SignUp')),
            )
          ],
        ),
      ),
    );
  }
}
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
// import 'package:http/http.dart';

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({Key? key}) : super(key: key);

//   @override
//   _SignUpScreenState createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();

//   void login(String email, password) async {
//     try {
//       Response response = await post(Uri.parse('https://reqres.in/api/login'),
//           body: {'email': email, 'password': password});

//       if (response.statusCode == 200) {
//         var data = jsonDecode(response.body.toString());
//         print(data['token']);
//         print('Login successfully');
//       } else {
//         print('failed');
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Sign Up Api'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextFormField(
//               controller: emailController,
//               decoration: InputDecoration(hintText: 'Email'),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             TextFormField(
//               controller: passwordController,
//               decoration: InputDecoration(hintText: 'Password'),
//             ),
//             SizedBox(
//               height: 40,
//             ),
//             GestureDetector(
//               onTap: () {
//                 login(emailController.text.toString(),
//                     passwordController.text.toString());
//               },
//               child: Container(
//                 height: 50,
//                 decoration: BoxDecoration(
//                     color: Colors.green,
//                     borderRadius: BorderRadius.circular(10)),
//                 child: Center(
//                   child: Text('Login'),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
