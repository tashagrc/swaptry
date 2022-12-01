import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onClickedRegister;

  const LoginPage({
    Key? key,
    required this.onClickedRegister,
    
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  Color shadowColorPass  = const Color(0xff565656);
  Color shadowColorEmail  = const Color(0xff565656);

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(40),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 119, height: 55,
                      decoration: BoxDecoration(
                        color: const Color(0xff6E80FE),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: const Offset(0,3),
                            blurRadius: 11,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          'Login',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight:FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: widget.onClickedRegister,
                      child: const SizedBox(
                        width: 119, height: 55,
                        child: Center(
                          child: Text(
                            'Register',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight:FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                const Text(
                  'Welcome\nBack!',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff4A4A4A),
                  ),
                ),
                const Text(
                  'Glad to see you again.',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff4A4A4A),
                  ),
                ),
                const SizedBox(height: 30,),
                Stack(
                  children:[
                    Container(
                      height: 55,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(23),
                        boxShadow: [
                          BoxShadow(
                            color: shadowColorEmail.withOpacity(0.2),
                            offset: const Offset(0,5),
                            blurRadius: 7,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 20),
                      child: TextFormField(
                        controller: emailController,
                        autocorrect: false,
                        validator: (value) {
                          if(value!.isEmpty || value == null){
                            return 'Please enter a valid email address.';
                          }

                          String pattern = r'\w+@\w+\.\w+';
                          RegExp regex = RegExp(pattern);
                          if(!regex.hasMatch(value)) return 'Invalid E-mail Address format.';

                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ]
                ),
                const SizedBox(height: 30,),
                Stack(
                  children:[
                    Container(
                      height: 55,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(23),
                        boxShadow: [
                          BoxShadow(
                            color: shadowColorPass.withOpacity(0.2),
                            offset: const Offset(0,5),
                            blurRadius: 7,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 20),
                      child: TextFormField(
                        controller: passwordController,
                        autocorrect: false,
                        validator: (value) {
                          if(value!.isEmpty|| value.length < 7){
                            return 'Password must be at least 7 characters long.';
                          }
                          return null;
                        },
                        obscureText: true,
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50,),
                SizedBox(
                  height: 55,
                  child: ElevatedButton(
                    onPressed: signIn,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, 
                      backgroundColor: const Color(0xff6E80FE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23),
                      ),
                    ),
                    
                    child: const Center(
                      child: Text(
                        'Log In',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                  ),
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }

  Future signIn() async{
    try {
      if(_key.currentState!.validate()){
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(), 
          password: passwordController.text.trim(),
        );
      }
      
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        setState(() {
          shadowColorPass = Colors.red;
        });
      }else if(e.code != 'wrong-password'){
        setState(() {
          shadowColorPass = const Color(0xff565656);
        });
      }
      
      if (e.code == 'user-not-found') {
        setState(() {
          shadowColorEmail = Colors.red;
        });
      }else if(e.code != 'user-not-found'){
        setState(() {
          shadowColorEmail = const Color(0xff565656);
        });
      }
    } 
  }
}