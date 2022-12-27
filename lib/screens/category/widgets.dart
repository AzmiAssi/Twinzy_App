import 'package:flutter/material.dart';
import 'package:twinzy/theme/colors.dart';

class BuildProfile extends StatelessWidget {
  final Function()? onTap;
  final String? title;
  final String? image;

  // ignore: use_key_in_widget_constructors
  const BuildProfile({this.onTap, this.title, this.image});

  @override
  Widget build(BuildContext context) {
    var heightScreen = (MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top);
    var widthScreen = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: heightScreen * 0.02, horizontal: widthScreen * 0.1),
        child: Card(
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.only(right: 5, left: 5),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    color: const Color.fromRGBO(244, 245, 247, 1),
                    image: DecorationImage(
                      image: AssetImage(image!),
                      fit: BoxFit.cover,
                    )),
                height: heightScreen * 0.3,
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                // ignore: avoid_unnecessary_containers
                child: SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title!,
                        style: const TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w700,
                            color: primary),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
