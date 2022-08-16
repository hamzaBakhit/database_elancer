import 'package:database_elancer/utils/helpers.dart';
import 'package:database_elancer/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Helpers {
  late TextEditingController _emailEditingController;
  late TextEditingController _passwordEditingController;
  bool _obscure = false;
  String _language = 'en';

  @override
  void initState() {
    super.initState();
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.login),
        actions: [
          IconButton(
            onPressed: () {
              _showLanguageBottomSheet();
            },
            icon: const Icon(
              Icons.language,
              color: Colors.blue,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.login_title,
              style: GoogleFonts.cairo(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black),
            ),
            Text(
              AppLocalizations.of(context)!.login_subtitle,
              style: GoogleFonts.cairo(
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
                color: Colors.black45,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            AppTextField(
              hint: AppLocalizations.of(context)!.email,
              prefixIcon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              textEditingController: _emailEditingController,
            ),
            SizedBox(
              height: 10.h,
            ),
            AppTextField(
              hint: AppLocalizations.of(context)!.password,
              prefixIcon: Icons.lock,
              obscure: _obscure,
              keyboardType: TextInputType.visiblePassword,
              textEditingController: _passwordEditingController,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() => _obscure = !_obscure);
                },
                icon: _obscure
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.r),
                  )),
              onPressed: () {
                _performLogIn();
              },
              child: Text(
                AppLocalizations.of(context)!.login,
                style: GoogleFonts.cairo(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguageBottomSheet() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        builder: (context) {
          return BottomSheet(
              onClosing: () {},
              builder: (context) {
                return StatefulBuilder(
                  builder: (context,setState){
                    return  Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.language_title,
                            style: GoogleFonts.cairo(
                                fontSize: 16.sp, color: Colors.black),
                          ),
                          Text(
                            AppLocalizations.of(context)!.language_sub_title,
                            style: GoogleFonts.cairo(
                                fontSize: 13.sp, color: Colors.black45),
                          ),
                          Divider(),
                          RadioListTile<String>(
                              title: Text(
                                'English',
                                style: GoogleFonts.cairo(),
                              ),
                              value: 'en',
                              groupValue: _language,
                              onChanged: (String? value) {
                                if (value != null) {
                                  setState(() {
                                    _language = value;
                                  });
                                }
                              }),
                          RadioListTile<String>(
                              title: Text(
                                'العربية',
                                style: GoogleFonts.cairo(),
                              ),
                              value: 'ar',
                              groupValue: _language,
                              onChanged: (String? value) {
                                if (value != null) {
                                  setState(() {
                                    _language = value;
                                  });
                                }
                              })
                        ],
                      ),
                    );
                  },
                );
              });
        });
  }

  void _performLogIn() {
    if (_checkData()) _login();
  }

  bool _checkData() {
    if (_emailEditingController.text.isNotEmpty &&
        _passwordEditingController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context, message: 'Enter Required data', error: true);
    return false;
  }

  void _login() {
    Navigator.pushReplacementNamed(context, '/home_screen');
  }
}
