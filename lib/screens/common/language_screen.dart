import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secura_entry/screens/common/localization_service.dart';

class LanguageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localization = Provider.of<LocalizationService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(localization.translate('Select Language')),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text("English"),
            onTap: () {
              localization.loadLanguage("en");
            },
          ),
          ListTile(
            title: Text("हिन्दी"),
            onTap: () {
              localization.loadLanguage("hi");
            },
          ),
          ListTile(
            title: Text("Spanish"),
            onTap: () {
              localization.loadLanguage("es");
            },
          ),
        ],
      ),
    );
  }
}
