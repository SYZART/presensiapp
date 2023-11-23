import 'package:flutter/material.dart';
import 'package:presensiapp/providers/auth_provider.dart';
import 'package:presensiapp/style.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    String enteredIdKaryawan = '';
    String enteredPassword = '';
    Widget passwordField(String hint) {
      return Consumer<AuthProvider>(
        builder: (context, value, child) {
          return Container(
            height: 44,
            margin: const EdgeInsets.only(top: 8, bottom: 16),
            child: TextField(
              obscureText: value.showPassword,
              onChanged: (value) => enteredPassword = value,
              decoration: InputDecoration(
                suffixIconColor: primaryColor,
                suffixIcon: IconButton(
                  icon: value.showPassword
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                  onPressed: () => value.showHidePassword(),
                ),
                focusColor: primaryColor,
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: secondaryColor, width: 1.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: primaryColor)),
                hintText: hint,
                hintStyle: primayTextStyle.copyWith(fontSize: 12),
              ),
            ),
          );
        },
      );
    }

    Widget idKaryawanField(String hint) {
      return Container(
        height: 44,
        margin: const EdgeInsets.only(top: 8, bottom: 16),
        child: TextField(
          onChanged: (value) => enteredIdKaryawan = value,
          decoration: InputDecoration(
              focusColor: primaryColor,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: secondaryColor, width: 1.5),
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: primaryColor)),
              hintText: hint,
              hintStyle: primayTextStyle.copyWith(fontSize: 12)),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          )),
          padding: const EdgeInsets.all(24),
          child: ListView(
            children: [
              Column(
                children: [
                  Center(
                    child: Image.asset("assets/images/sdd_logo.png"),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 40),
                    child: Center(
                      child: Text(
                        'Presensi Karyawan PT Swadharma Duta Data',
                        textAlign: TextAlign.center,
                        style: secondaryTextStyle.copyWith(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
              Consumer<AuthProvider>(builder: (context, value, child) {
                if (value.state == ResultStateAuthProvider.unregisterId) {
                  return SizedBox(
                    height: 64,
                    child: Center(
                      child: Text(
                        'ID Karyawan tidak terdaftar',
                        style: primayTextStyle.copyWith(
                            color: Colors.red[700],
                            fontSize: 16,
                            letterSpacing: 1),
                      ),
                    ),
                  );
                } else if (value.state ==
                    ResultStateAuthProvider.wrongPassword) {
                  return SizedBox(
                    height: 64,
                    child: Center(
                      child: Text(
                        'Password Salah',
                        style: primayTextStyle.copyWith(
                            color: Colors.red[700],
                            fontSize: 16,
                            letterSpacing: 1),
                      ),
                    ),
                  );
                } else if (value.state == ResultStateAuthProvider.error) {
                  return SizedBox(
                    height: 64,
                    child: Center(
                      child: Text(
                        'Terjadi Kesalahan',
                        style: primayTextStyle.copyWith(
                            color: Colors.red[700],
                            fontSize: 16,
                            letterSpacing: 1),
                      ),
                    ),
                  );
                }
                return const SizedBox(
                  height: 64,
                );
              }),
              Text(
                'Login',
                textAlign: TextAlign.start,
                style: secondaryTextStyle.copyWith(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // StreamBuilder(
                    //     stream: Stream.periodic(const Duration(milliseconds: 30)),
                    //     builder: (context, snapshot) {
                    //       return Text(
                    //         DateFormat.Hm().format(DateTime.now()),
                    //         style: const TextStyle(fontSize: 40),
                    //       );
                    //     }),
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: Text(
                        'ID Karyawan',
                        style: secondaryTextStyle.copyWith(fontWeight: medium),
                      ),
                    ),
                    idKaryawanField("Masukkan ID Karyawan"),
                    Text(
                      'Password',
                      style: secondaryTextStyle.copyWith(fontWeight: medium),
                    ),
                    passwordField("Masukkan Password Anda"),
                    Consumer<AuthProvider>(
                      builder: (BuildContext context, AuthProvider value,
                          Widget? child) {
                        return CheckboxListTile(
                          checkboxShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3)),
                          side: const BorderSide(
                            color: primaryColor,
                            width: 2,
                          ),
                          activeColor: secondaryColor,
                          contentPadding: EdgeInsets.zero,
                          value: value.rememberMe,
                          onChanged: (val) {
                            value.checkRememberMe();
                          },
                          title: Text(
                            'Remember me next time',
                            style: primayTextStyle.copyWith(
                                fontSize: 12, fontWeight: bold),
                          ),
                        );
                      },
                    ),
                    Consumer<AuthProvider>(
                      builder: (context, value, child) => SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(vertical: 12)),
                              backgroundColor:
                                  MaterialStateProperty.all(secondaryColor)),
                          onPressed: () async {
                            await value.login(
                                enteredIdKaryawan, enteredPassword);
                            debugPrint(value.state.toString());
                            if (value.state ==
                                    ResultStateAuthProvider.success &&
                                context.mounted) {
                              Navigator.pushReplacementNamed(
                                  context, '/main-page');
                            }
                          },
                          // onPressed: () => Navigator.pushReplacementNamed(
                          //     context, '/main-page'),
                          child: value.state == ResultStateAuthProvider.loading
                              ? const SizedBox(
                                  height: 15,
                                  width: 15,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2, color: primaryColor),
                                )
                              : Text(
                                  'Login',
                                  style: secondaryTextStyle.copyWith(
                                      fontWeight: superBold,
                                      letterSpacing: 0.28),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class Login extends StatefulWidget {
//   const Login({Key? key}) : super(key: key);

//   @override
//   _LoginState createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   String enteredIdKaryawan = '';
//   String enteredPassword = '';

//   @override
//   Widget build(BuildContext context) {
    
// }
