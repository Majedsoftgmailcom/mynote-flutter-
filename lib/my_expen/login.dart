import 'package:flutter/material.dart';

class LoginS extends StatefulWidget {
  const LoginS({super.key});

  @override
  State<LoginS> createState() => _LoginSState();
}
class _LoginSState extends State<LoginS> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        // backgroundColor: Colors.blueAccent,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'حساباتي',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Card(
                    
                    elevation: 20,
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    //color: Colors.amber,
                    child: Column(
                      children: [
                         const SizedBox(
                          height:20,
                         
                        ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                hintText: 'أسم المستخدم',
                                prefixIcon: const Icon(Icons.person),
                                fillColor: Colors.blue),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                            
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              hintText: 'كلمة المرور',
                              
                              prefixIcon: const Icon(Icons.lock),
                              
                              suffixIcon: const Icon(Icons.remove_red_eye),
                              // fillColor: Colors.blue
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(onPressed: () {
                      Navigator.of(context).pushReplacementNamed('tran2');
                        }, 
                        child: const Text('   دخول   '))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
