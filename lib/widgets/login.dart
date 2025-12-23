import 'package:flutter/material.dart';

import 'package:kljcafe_staff_new/domain/login_response_entity.dart';
import 'package:kljcafe_staff_new/utils/apputils.dart';
import 'package:kljcafe_staff_new/web/api_credentials.dart';
import 'package:kljcafe_staff_new/web/webcallRepository.dart';
import 'package:kljcafe_staff_new/widgets/home.dart';

import '../prefdata/sharedpref.dart';
import '../web/loginrepository.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //initPreference();
  }

  // initPreference()
  // async {
  //   await SharedPref().init();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 80),

                // App Title
                const Text(
                  "Welcome Back",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                const Text(
                  "Login to continue",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),

                const SizedBox(height: 40),

                // White rounded card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        spreadRadius: 3,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      // Mobile Field
                      TextField(
                        controller: mobileController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          labelText: "Mobile Number",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Password Field
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          labelText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2575FC),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () async {

                            if( mobileController.text.trim().isNotEmpty)
                            {
                              if( passwordController.text.trim().isNotEmpty)
                              {

                                AppUtils.showLoader(context);

                                try {

                                  final response =
                                  await LoginRepository.loginUser(mobileController.text.trim(), passwordController.text.trim());


                                  if (response["status"] == 1) {
                                    LoginResponseEntity loginResponseEntity=LoginResponseEntity.fromJson(response);

                                    AppUtils.hideLoader(context);


                                    SharedPref.setString(APICredentials.apptoken, loginResponseEntity.data!.token.toString());

                                    SharedPref.setString(APICredentials.name, loginResponseEntity.data!.name.toString());


                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(builder: (_) => HomeScreen()),
                                    );


                                  } else {


                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(response["message"] ?? "Login failed")),
                                    );

                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(e.toString())),
                                  );
                                }



                              }
                              else{
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Enter password")),
                                );

                              }

                            }
                            else{
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Enter mobile")),
                              );

                            }



                            // BlocProvider.of<LoginBloc>(context).add(
                            //   LoginButtonPressed(
                            //     mobileController.text,
                            //     passwordController.text,
                            //   ),
                            // );
                          },
                          child:  const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ),

                const SizedBox(height: 20),

                // Footer text
                const Text(
                  "Powered by KLJ Café",
                  style: TextStyle(color: Colors.white70),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
