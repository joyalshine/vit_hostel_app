import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vit_hostel_repo/backend/backend.dart';
import 'package:vit_hostel_repo/firebase/user_validation.dart';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen(
      {super.key, required this.nextScreen, required this.showError});

  final void Function(int, String, Map<String, dynamic>) nextScreen;
  final bool showError;

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  bool _isLoading = false;
  var emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.showError) {
        final snackBar = SnackBar(
          /// need to set following properties for best effect of awesome_snackbar_content
          elevation: 0,
          duration: Duration(seconds: 10),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'On Snap!',
            message:
                'Some error occured while fetching the data please try again later!',
            contentType: ContentType.failure,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    void validate() async {
      String email = emailController.text.trim();
      FocusManager.instance.primaryFocus?.unfocus();
      if (email.isEmpty || email == '') {
        final snackBar = SnackBar(
          /// need to set following properties for best effect of awesome_snackbar_content
          elevation: 0,
          duration: Duration(seconds: 5),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Oops!',
            message: 'Enter a Email!',
            contentType: ContentType.failure,
          ),
        );
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      } else if (!email.contains('@')) {
        const snackBar = SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(bottom: 45, left: 25, right: 25),
          backgroundColor: Color.fromARGB(255, 223, 57, 19),
          content: Text('Enter a valid Email!'),
        );

        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (!email.contains('vitstudent.ac.in')) {
        const snackBar = SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(bottom: 15, left: 5, right: 5),
          backgroundColor: Color.fromARGB(255, 223, 57, 19),
          content: Text('Enter your VIT mail ID!'),
        );

        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        final connectivityResult = await Connectivity().checkConnectivity();
        if (connectivityResult == ConnectivityResult.none) {
          setState(() {
            _isLoading = false;
          });
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (_) => NetworkErrorDialog(),
          );
        } else {
          Map<String, dynamic> userDetails = await loginUser(email);
          print(userDetails);
          print('{}{{{{{{{{}}}}}}}}');
          if (userDetails['isValid']) {
            widget.nextScreen(
                userDetails['OTP'], userDetails['email'], userDetails);
          } else {
            if (userDetails['type'] == 'invalidUser') {
              const snackBar = SnackBar(
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.only(bottom: 15, left: 5, right: 5),
                backgroundColor: Color.fromARGB(255, 223, 57, 19),
                duration: Duration(seconds: 10),
                content: Text(
                    'Check the entered mail ID. We are unable to find your details. If issue persists please contact the hostel office'),
              );

              setState(() {
                _isLoading = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
              const snackBar = SnackBar(
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.only(bottom: 15, left: 5, right: 5),
                backgroundColor: Color.fromARGB(255, 223, 57, 19),
                duration: Duration(seconds: 10),
                content: Text('Some error occured. try again later'),
              );

              setState(() {
                _isLoading = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          }
        }
      }
    }

    return Column(
      children: [
        SizedBox(
          height: deviceHeight * 0.30,
          child: Padding(
            padding: EdgeInsets.only(
                left: deviceWidth * 0.07,
                right: deviceWidth * 0.07,
                bottom: deviceHeight * 0.00,
                top: deviceHeight * 0.07),
            child: SizedBox(
              width: double.infinity,
              child: Center(
                child: Text(
                  "Effortless Complaints, Maintenance, and Menus for a Better Stay!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          height: deviceHeight * 0.70,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 35),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Email",
                  style: GoogleFonts.poppins(
                    fontSize: 24.33,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(182, 255, 255, 255),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: double.infinity,
                child: TextFormField(
                  controller: emailController,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Email Here...',
                    prefixIcon: const Icon(
                      Icons.account_circle_outlined,
                      color: Colors.grey,
                    ),
                    hintStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.grey.shade200.withOpacity(0.1),
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12.0)),
                      borderSide: BorderSide(
                          color: Colors.white.withOpacity(0.2), width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: Colors.white.withOpacity(0.2),
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: _isLoading
                    ? null
                    : () {
                        setState(() {
                          _isLoading = true;
                        });
                        validate();
                      },
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(
                    const Color.fromARGB(0, 255, 193, 7),
                  ),
                ),
                child: Container(
                  alignment: Alignment.center,
                  constraints:
                      const BoxConstraints(minWidth: 30.0, minHeight: 50.0),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0x6e8f6ad0), Color(0x996539b3)],
                      stops: [0, 1],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: Colors.purpleAccent,
                          ),
                        )
                      : const Text(
                          'Sign in',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17.92,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                ),
              ),
              Text(
                "Use VIT mail ID only",
                style: GoogleFonts.poppins(
                  fontSize: 14.33,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromARGB(118, 255, 255, 255),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class NetworkErrorDialog extends StatelessWidget {
  const NetworkErrorDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
              width: 200, child: Image.asset('assets/images/no_internet.webp')),
          const SizedBox(height: 32),
          const Text(
            "Whoops!",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Text(
            "No internet connection found.",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          const Text(
            "Check your connection and try again.",
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            child: const Text("Ok"),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
