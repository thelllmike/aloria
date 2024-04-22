import 'package:flutter/material.dart';

class SelfieScreen extends StatefulWidget {
  @override
  _SelfieScreenState createState() => _SelfieScreenState();
}

class _SelfieScreenState extends State<SelfieScreen> {
  int currentPage = 0; // Current page indicator

  final List<String> stepContents = [
    'Take a selfie! Make sure you’re in a well-lit area for the best shot',
    'Now, let’s take a closer look at your skin',
    'Reach out to a dermatologist for a chat.',
    'Kickstart your clear skin journey with confidence.',
    'Take the first step towards radiant skin with treatments uniquely designed for you.',
    // ... Add more content as needed for additional steps
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/Logo.png',
          width: 167,
          height: 64,
          fit: BoxFit.contain,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 80,
      ),
      body: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(),
           Container(
  width: 285,
  height: 285,
  decoration: BoxDecoration(
    color: Color(0xFFC6C4FF).withOpacity(0.15),
    shape: BoxShape.circle,
  ),
  alignment: Alignment.center,
  child: OverflowBox(
    maxWidth: 390,
    maxHeight: 390,
    child: currentPage >= 0 && currentPage <= 4 // Ensure currentPage is within the range
        ? Transform(
            // Apply different transformations depending on the page.
            transform: Matrix4.identity()
              ..translate(
                currentPage == 0 ? 0.0 :
                currentPage == 1 ? -8.0 :
                currentPage == 2 ? 30.0 :
                currentPage == 3 ? 0.0 :
                currentPage == 4 ? 20.0 : 0.0, // X translation

                currentPage == 0 ? 0.0 :
                currentPage == 1 ? -74.5 :
                currentPage == 2 ? -10.0 :
                currentPage == 3 ? 0.0 :
                currentPage == 4 ? -25.0 : 0.0, // Y translation
              )
              ..scale(
                currentPage == 0 ? 1.0 :
                currentPage == 1 ? 1.05 :
                currentPage == 2 ? 0.98 :
                currentPage == 3 ? 1.0 :
                currentPage == 4 ? 0.93 : 1.0, // Scale
              ),
            child: Image.asset(
              'assets/images/step${currentPage + 1}.png',
              fit: BoxFit.cover,
            ),
          )
        : Image.asset(
            // No transformation for other steps.
            'assets/images/step${currentPage + 1}.png',
            fit: BoxFit.cover,
          ),
  ),
),

              SizedBox(height: 20),
              Text(
                'STEP ${currentPage + 1}',
                style: TextStyle(
                  fontFamily: 'Bebas Neue',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
                textAlign: TextAlign.left,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  stepContents[
                      currentPage], // Access the content based on the current page
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.125,
                  ),
                ),
              ),
              Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(5, (index) {
                  return Container(
                    width: index == currentPage ? 64 : 8,
                    height: 8,
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: index == currentPage
                          ? Color(0xFF403D3D1A)
                          : Color(0xFF403D3D1A).withOpacity(0.5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 29),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF77BF43),
                    onPrimary: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    textStyle: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      if (currentPage < 4) {
                        // Assume there are 3 steps
                        currentPage++;
                      }
                    });
                  },
                  child: Text('Next'),
                ),
              ),
              SizedBox(height: 34),
            ],
          ),
        ],
      ),
    );
  }
}
