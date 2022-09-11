import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tutor_group/screens/auth/tools/login_and_signup_text_fields.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutDeveloper extends StatelessWidget {
  const AboutDeveloper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'WeCode',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(
              height: 50,
              child: Image.asset('assets/images/rwanga.png'),
            ),
            Text(
              '2022',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        )
      ],
      appBar: AppBar(
        elevation: 2,
        title: const Text('About'),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (notification) {
            notification.disallowIndicator();
            return true;
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
//                 myTextForAboutScreen(
//                     title: '',
//                     text: """Hello,
// I'm Safin Saber Nori from duhok and fresh graduated from Computer Science department at CIHAN Universit-Duhok, After i have finished the college with not much experience with flutter and i have started my journey with flutter.
// started to collect some information from it with a help of my dear friend ( Imad Manaf ) and a while later heard about a bootcamp is about to begin in July 22 by RWANGA foundation for beginner programmers supporting.
// where the leader of this bootcamp was Dear ( Mr.Hooshyar Mohammed ) and his kind treatment with bootcamp joiners.
// I believe that every joiner have gained a lot of information and enough skills to start,Improve their skills and keep going on after their goals .
//  """,
                myTextForAboutScreen(
                    title: 'About app',
                    text:
                        """This application is developed by Safin Saber Nori during the july of 2022 Rwanga WeCode bootcamp Which was full of  experience and 3 months of code challengings.
                        """,
                    context: context),
                const Divider(thickness: 1, indent: 10, endIndent: 10),
                myTextForAboutScreen(
                    title: 'About Developer',
                    text: """
                        
                        """,
                    context: context),

                ToolsForLogAndSignup().buildButton(
                    onPressed: (() async {
                      Uri uri = Uri.parse('https://github.com/Safin9');
                      await launchUrl(uri);
                    }),
                    color: Colors.black,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        FaIcon(FontAwesomeIcons.github),
                        SizedBox(
                          width: 20,
                        ),
                        Text('Safin9'),
                      ],
                    )),

                ToolsForLogAndSignup().buildButton(
                    onPressed: (() async {
                      Uri uri = Uri.parse(
                          'https://www.linkedin.com/in/safin-saber-233677207/');
                      await launchUrl(uri);
                    }),
                    color: Colors.blue.shade800,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        FaIcon(FontAwesomeIcons.linkedin),
                        SizedBox(
                          width: 20,
                        ),
                        Text('Safin Saber'),
                      ],
                    )),
                ToolsForLogAndSignup().buildButton(
                    onPressed: (() async {
                      Uri uri = Uri.parse(
                          'https://stackoverflow.com/users/edit/19226099');
                      await launchUrl(uri);
                    }),
                    color: Colors.orange.shade700,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        FaIcon(FontAwesomeIcons.stackOverflow),
                        SizedBox(
                          width: 20,
                        ),
                        Text('Safin Saber Nori'),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget myTextForAboutScreen(
      {required String text,
      required String title,
      required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: 10,
          ),
          SelectableText(
            text,
            strutStyle: const StrutStyle(fontSize: 20),
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ],
      ),
    );
  }
}
