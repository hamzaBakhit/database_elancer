import 'package:database_elancer/database/controllers/user_db_controller.dart';
import 'package:database_elancer/models/proccess_responce.dart';
import 'package:database_elancer/models/user.dart';
import 'package:database_elancer/prefs/shared_pref_controller.dart';
import 'package:database_elancer/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:database_elancer/utils/context_extinsion.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController _nameEditingController;
  late TextEditingController _emailEditingController;
  late TextEditingController _passwordEditingController;
  bool _obscure = false;
  late String _language;

  @override
  void initState() {
    super.initState();
    _language =
        SharedPrefController().getValueFor<String>(PrefKeys.language.name) ??
            'en';
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    _nameEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.register),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.register_title,
              style: GoogleFonts.cairo(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black),
            ),
            Text(
              AppLocalizations.of(context)!.register_subtitle,
              style: GoogleFonts.cairo(
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
                color: Colors.black45,
              ),
            ),
            AppTextField(
              hint: AppLocalizations.of(context)!.name,
              prefixIcon: Icons.person,
              keyboardType: TextInputType.emailAddress,
              textEditingController: _nameEditingController,
            ),
            SizedBox(
              height: 10.h,
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
              onPressed: () async => await _performRegister(),
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

  Future<void> _performRegister() async {
    if (_checkData())  _register();
  }

  bool _checkData() {
    if (_emailEditingController.text.isNotEmpty &&
        _passwordEditingController.text.isNotEmpty) {
      return true;
    }
    context.showSnackBar(message: 'Enter Required data', error: true);
    return false;
  }

  void _register() async {
    //  call register database function
    ProcessResponse processResponse =
        await UserDbController().register(user: user);
    if(processResponse.success){
      Navigator.pop(context);
    }
    context.showSnackBar(message: processResponse.message,error: !processResponse.success);
  }

  User get user {
    User user = User();
    user.name = _nameEditingController.text;
    user.email = _emailEditingController.text;
    user.password = _passwordEditingController.text;
    return user;
  }
}
