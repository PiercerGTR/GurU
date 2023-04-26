import 'package:clone/providers/user_provider.dart';
import 'package:clone/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//rn its stateless widget, later on it will become stateful after we use init
class ResponsiveLayout extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  const ResponsiveLayout(
      {Key? key,
      required this.webScreenLayout,
      required this.mobileScreenLayout})
      : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addData();
  }

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > webScreenSize) {
        //will give constraints of our app, like max,min width etc
        return widget.webScreenLayout;
        //web screen
      }
      return widget.mobileScreenLayout;
      //mobile screen
    }); //helps in building responsive layout
  }
}
