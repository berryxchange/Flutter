import 'package:flutter/material.dart';

class TermsOfUsePage extends StatefulWidget {
  static String id = "terms_page";
  @override
  _TermsOfUsePageState createState() => _TermsOfUsePageState();
}

class _TermsOfUsePageState extends State<TermsOfUsePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Terms"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10, top: 20, bottom: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Terms of Use (Terms)", 
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 8,),

              Text("Last updated: 7/29/2018 \n \n"),

                  Text("Please read these Terms of Use (Terms, Terms of Use) carefully before "
                  "using the Mobile Church App (The Service) operated by BerryXChange.LLC & BerryXChange-Innovations. \n \n"

                  "Your access to and use of the Service is conditioned on your acceptance of and compliance with these Terms. "
                  "These Terms apply to all visitors, users and others who access or use the Service. \n \n"

                  "By accessing or using the Service, you agree to be bound by these Terms. "
                  "If you disagree with any part of the terms then you may not access the Service.  \n \n"),

                  Text("Content \n", 
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),

                  Text("Our Service allows you to post, like, store, share and otherwise make available certain information, "
                  "text, graphics, images, or other material (Content). You are responsible for the material you provide and post. \n \n"),
                  
                  Text("Links To Other Web Sites \n", 
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text("Our Service may contain links to third-party web sites or services that "
                  "are not owned or controlled by BerryXChange.LLC or BerryXChange-Innovations. \n \n"

                  "BerryXChange.LLC & BerryXChange-Innovations has no control over, "
                  "and assumes no responsibility for, the content, privacy policies, "
                  "or practices of any third party web sites or services. "
                  "You further acknowledge and agree that BerryXChange.LLC & BerryXChange-Innovations"
                  "shall not be responsible or liable, directly or indirectly, "
                  "for any damage or loss caused or alleged to be caused by or in connection with "
                  "use of or reliance on any such content, goods or services available on "
                  "or through any such web sites or services.\n \n"),

                  Text("Termination \n", 
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),

                  Text("We may terminate or suspend access to our Service immediately, without prior notice "
                  "or liability, for any reason whatsoever of bullying, inappropriate behavior, "
                  "language, images that harm or objectify others in any manner, "
                  "including without limitation if you breach these Terms. \n \n"

                  "All provisions of the Terms which by their nature should survive termination "
                  "shall survive termination, including, without limitation, ownership provisions, "
                  "warranty disclaimers, indemnity and limitations of liability. "
                  "Should any user be subject to any of these objectifications or inappropriate behavior, "
                  "you have the right and responsibility to report it to berryxchange.innovations@gmail.com "
                  "or use the in-app chat to report to your administrator. \n \n"),

                  Text("Changes \n", 
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),

                  Text("We reserve the right, at our sole discretion, to modify or replace these Terms at any time. "
                  "If a revision is material, we will try to provide at least 30 days' notice "
                  "prior to any new terms taking effect. What constitutes a material change "
                  "will be determined at our sole discretion. \n \n"),

                  Text("Contact Us \n", 
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),

                  Text("If you have any questions about these Terms, please contact us at berryxchange.innovations@gmail.com"),
            ],
          ),
        ),
      ),
    );
  }
}
