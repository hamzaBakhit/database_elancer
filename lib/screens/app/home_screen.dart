import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.pushReplacementNamed(context, 'login_screen');
              _confirmLogoutDialog();
            },
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
    );
  }

  void _confirmLogoutDialog() async{
    bool? result = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      // barrierColor: Colors.pink.shade100,
      builder: (context) => AlertDialog(
        title: Text(
          AppLocalizations.of(context)!.confirm_logout_title,
          style: GoogleFonts.cairo(fontSize: 16, color: Colors.black),
        ),
        content: Text(
          AppLocalizations.of(context)!.confirm_logout_content,
          style: GoogleFonts.cairo(fontSize: 13, color: Colors.black45),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context,true);
            },
            child: Text(
              AppLocalizations.of(context)!.confirm,
              style: GoogleFonts.cairo(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context,false);
            },
            child: Text(
              AppLocalizations.of(context)!.cancel,
              style: GoogleFonts.cairo(),
            ),
          ),
        ],
      ),
    );

    if(result?? false){
      Navigator.pushReplacementNamed(context, '/login_screen');
    }
  }
}
