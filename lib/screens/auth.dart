// import 'package:flutter/material.dart';

// import 'package:firebase_auth/firebase_auth.dart';

// final _firebase = FirebaseAuth.instance;

// class AuthScreen extends StatefulWidget {
//   const AuthScreen({super.key});
//   @override
//   State<AuthScreen> createState() {
//     return _AuthScreenState();
//   }
// }

// class _AuthScreenState extends State<AuthScreen> {
//   final _form = GlobalKey<FormState>();

//   var _isLogin = true;
//   var _enteredEmail = '';
//   var _enteredPassword = '';

//   void _submit() {
//     final isValid = _form.currentState!.validate();

//     if (!isValid) {
//       return;
//     }

//     _form.currentState!.save();

//     //  print(_enteredEmail);
//     //  print(_enteredPassword);

//     if (_isLogin) {
//       // log users in
//     } else {
//       try {
//         _firebase.createUserWithEmailAndPassword(
//             email: _enteredEmail, password: _enteredPassword);
//       } on FirebaseAuthException catch (error) {
//         if (error.code == "email-already-in-use") {
//           // ..
//         }

//         ScaffoldMessenger.of(context).clearSnackBars();
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(error.message ?? ''),
//           ),
//         );
//       }
//     }
//   }
// }

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     backgroundColor: Theme.of(context).colorScheme.primary,
//     body: Center(
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               margin: const EdgeInsets.only(
//                 top: 30,
//                 bottom: 20,
//                 left: 20,
//                 right: 20,
//               ),
//               width: 200,
//               child: Image.asset('assets/images/chat.png'),
//             ),
//             Card(
//               margin: const EdgeInsets.all(20),
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Form(
//                     key: _form,
//                     child: Column(
//                       children: [
//                         TextFormField(
//                             decoration: InputDecoration(
//                               labelText: 'Email Address',
//                             ),
//                             keyboardType: TextInputType.emailAddress,
//                             autocorrect: false,
//                             textCapitalization: TextCapitalization.none,
//                             validator: (value) {
//                               if (value == null ||
//                                   value.trim().isEmpty ||
//                                   !value.contains("@")) {
//                                 return " Please enter a valid email address";
//                               }
//                               return null;
//                             },
//                             onSaved: (value) {
//                               _enteredEmail = value!;
//                             }),
//                         TextFormField(
//                             decoration: InputDecoration(
//                               labelText: "Password",
//                             ),
//                             obscureText: true,
//                             validator: (value) {
//                               if (value == null || value.trim().length < 6) {
//                                 return "Password must be at least 6 character long";
//                               }
//                               return null;
//                             },
//                             onSaved: (value) {
//                               _enteredPassword = value!;
//                             }),
//                         const SizedBox(
//                           height: 12,
//                         ),
//                         ElevatedButton(
//                           onPressed: _submit,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor:
//                                 Theme.of(context).colorScheme.primaryContainer,
//                           ),
//                           child: Text(_isLogin ? 'Login' : "Signup"),
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             setState(() {
//                               _isLogin = !_isLogin;
//                             });
//                           },
//                           child: Text(
//                             _isLogin
//                                 ? "Create an account"
//                                 : "I already have an account. Login.",
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends State<AuthScreen> {
  final _form = GlobalKey<FormState>();
  var _isLogin = true;
  var _enteredEmail = '';
  var _enteredPassword = '';

  Future<void> _submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }
    _form.currentState!.save();

    try {
      if (_isLogin) {
        // Login logic
      } else {
        final UserCredentials = await _firebase.createUserWithEmailAndPassword(
          email: _enteredEmail,
          password: _enteredPassword,
        );

        print(UserCredentials);
        // User created successfully, you can use authResult.user
      }
    } on FirebaseAuthException catch (error) {
      String errorMessage = 'An error occurred, please try again.';
      if (error.code == 'email-already-in-use') {
        //errorMessage = 'The email address is already in use.';
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage ?? 'Authentication failed..'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 30,
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                width: 200,
                child: Image.asset('assets/images/chat.png'),
              ),
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _form,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email Address',
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.contains("@")) {
                                return " Please enter a valid email address";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredEmail = value!;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Password",
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.trim().length < 6) {
                                return "Password must be at least 6 characters long";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredPassword = value!;
                            },
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          ElevatedButton(
                            onPressed: _submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                            ),
                            child: Text(_isLogin ? 'Login' : "Signup"),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isLogin = !_isLogin;
                              });
                            },
                            child: Text(
                              _isLogin
                                  ? "Create an account"
                                  : "I already have an account. Login.",
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
      ),
    );
  }
}
