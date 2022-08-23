import 'package:database_elancer/prefs/shared_pref_controller.dart';
import 'package:database_elancer/utils/context_extinsion.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localizations.products),
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
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(Icons.shop),
              title: const Text('Title'),
              subtitle: const Text('Title'),
              trailing: IconButton(
                onPressed: ()=> Navigator.pushNamed(context, '/product_screen'),
                icon: const Icon(Icons.delete),
              ),
            );
          }),
    );
  }

  void _confirmLogoutDialog() async {
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
              Navigator.pop(context, true);
            },
            child: Text(
              AppLocalizations.of(context)!.confirm,
              style: GoogleFonts.cairo(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Text(
              AppLocalizations.of(context)!.cancel,
              style: GoogleFonts.cairo(),
            ),
          ),
        ],
      ),
    );

    if (result ?? false) {
      // bool cleared = await SharedPrefController().removeValueFor(PrefKeys.loggedIn.name);
      bool cleared = await SharedPrefController().clear();
      if (cleared) {
        Navigator.pushReplacementNamed(context, '/login_screen');
      }
    }
  }
}
