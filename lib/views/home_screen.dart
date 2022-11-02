import 'dart:typed_data';

import 'package:color_genertor_app/provider/color_provider.dart';
import 'package:color_genertor_app/provider/theme_provider.dart';
import 'package:color_genertor_app/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import 'package:provider/provider.dart';import 'package:screenshot/screenshot.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int i = 0;
  late Uint8List images;
  ScreenshotController screenshotController = ScreenshotController();

  Colorchange() async {
    Provider.of<ColorProvider>(context,listen: false).PallatreChange(index: i);

  }
  @override
  void initState() {
    super.initState();
    Colorchange();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Theme.of(context).backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 35, left: 15, right: 15),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Color Generator",
                  style: TextStyle(fontSize: 23),
                ),
                Spacer(),
                Switch(
                    activeColor: darkBottoncolor,
                    inactiveThumbColor: bottoncolor,
                    value: Provider.of<ThemeProvider>(context, listen: false)
                        .isDark,
                    onChanged: (val) {
                      Provider.of<ThemeProvider>(context, listen: false)
                          .changeTheme();

                    })
              ],
            ),
            SizedBox(
              height: 50,
            ),

            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Screenshot(
                  controller: screenshotController,
                  child: SizedBox(
                    height: 450,
                    width: double.infinity,

                    child: ListView.builder(itemCount: Provider
                        .of<ColorProvider>(context)
                        .pallete
                        .PallateList
                        .length,
                        itemBuilder:(context, i) =>Container(
                          height: 80,
                          width: 270,
                          decoration: BoxDecoration(
                            color: Provider
                                .of<ColorProvider>(context)
                                .pallete
                                .PallateList[i],

                          ),

                        ) ,),
                  ),
                ),


                SizedBox(height: 30,),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {

                      (i == 7) ? i = 0 : i++;
                      Provider.of<ColorProvider>(context, listen: false)
                          .PallatreChange(index: i);

                  },
                  child: Container(
                      height: 60,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Theme.of(context).cardColor,

                        boxShadow: [
                          BoxShadow(blurRadius: 2, color: Colors.grey)
                        ],
                      ),
                      child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.refresh,color: Colors.white,),
                              Text(
                                "change",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              )
                            ],
                          ))

                  ),
                ),
                InkWell(
                  onTap: () async {
                    await screenshotController.capture().then((Uint8List? image) {
                      setState(() {
                        images = image!;
                      });
                    });
                    await ImageGallerySaver.saveImage(images);
                    ScaffoldMessenger.of(context).showSnackBar(
                         const SnackBar(

                           padding: EdgeInsets.all(20),
                          content: Text("Success.."),
                          backgroundColor: Colors.green,
                        ),
                    );
                  },
                  child: Container(
                      height: 60,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Theme.of(context).cardColor,

                        boxShadow: [
                          BoxShadow(blurRadius: 2, color: Colors.grey)
                        ],
                      ),
                      child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.download_rounded,color: Colors.white,),
                              Text(
                                "save gallry",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              )
                            ],
                          ))

                  ),
                ),
              ],),

          ],
        ),
      ),
    );
  }
}
