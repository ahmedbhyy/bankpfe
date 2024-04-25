import 'package:flutter/widgets.dart';

class ContainerBackground extends StatelessWidget {
  final Widget mywidget;
  const ContainerBackground({super.key, required this.mywidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/background.jpg"),
          fit: BoxFit.fill,
          filterQuality: FilterQuality.medium,
        ),
      ),
      child: mywidget,
    );
  }
}
