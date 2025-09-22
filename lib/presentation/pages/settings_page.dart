import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text('Settings',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.secondary,),),
        backgroundColor:Theme.of(context).colorScheme.surface,
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(10)
            ),
            margin: EdgeInsets.only(left: 25, right: 25, top: 20),
            padding: EdgeInsets.all(25),
            child: Row(
              children: [
                //dark mode
                Text('Dark mode', style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.primary,
                ),),
                Spacer(),
                //switch
                Switch.adaptive(
                  value: Provider.of<ThemeProvider>(context, listen: false).isDarkMode,
                  onChanged: (value){
                    Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
