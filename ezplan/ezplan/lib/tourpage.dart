import 'package:flutter/material.dart';

class TourPage extends StatefulWidget {
  const TourPage({super.key});

  @override
  State<TourPage> createState() => _TourPageState();
}

class _TourPageState extends State<TourPage> {

  PageController pageController = PageController();

  void nextPage() {
    pageController.animateToPage(
      pageController.page!.toInt() + 1, 
      duration: Duration(milliseconds: 400), 
      curve: Curves.easeIn
    );
  }

  void previousPage() {
    pageController.animateToPage(
      pageController.page!.toInt() - 1, 
      duration: Duration(milliseconds: 400), 
      curve: Curves.easeIn
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.horizontal,
        pageSnapping: true,
        controller: pageController,
        children: [
          Container(
            color: const Color.fromARGB(255, 249, 247, 239),
            child: FractionallySizedBox(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.local_airport,
                    size: 80,
                    color: Color.fromARGB(255, 252, 163, 17),
                  ),
                  const SizedBox(height: 20,),
                  const Text(
                    'Plan anything from a trip\n to a group dinner with friends.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(255, 252, 163, 17),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 18
                    ),
                  ),
                  const SizedBox(
                    height: 150,
                  ),
                  TextButton(
                    onPressed: nextPage, 
                    style: ButtonStyle(  
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.amber),
                      shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.zero)
                      )),
                      fixedSize: MaterialStateProperty.all(const Size(302, 60)),            
                    ),
                    child: const Text(
                      'Tell Me More',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        fontSize: 20
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: const Color.fromARGB(255, 249, 247, 239),
            child: FractionallySizedBox(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.chat,
                    size: 80,
                    color: Color.fromARGB(255, 252, 163, 17),
                  ),
                  const SizedBox(height: 20,),
                  const Text(
                    'Co-plan any gatherings with \nfriends for everyones input',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(255, 252, 163, 17),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 18
                    ),
                  ),
                  const SizedBox(
                    height: 150,
                  ),
                  TextButton(
                    onPressed: nextPage,
                    style: ButtonStyle(  
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.amber),
                      shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.zero)
                      )),
                      fixedSize: MaterialStateProperty.all(const Size(302, 60)),            
                    ),
                    child: const Text(
                      'What Else',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        fontSize: 20
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: const Color.fromARGB(255, 249, 247, 239),
            child: FractionallySizedBox(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.share,
                    size: 80,
                    color: Color.fromARGB(255, 252, 163, 17),
                  ),
                  const SizedBox(height: 20,),
                  const Text(
                    'Share any trips or plans \nwith anyone',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(255, 252, 163, 17),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 18
                    ),
                  ),
                  const SizedBox(
                    height: 150,
                  ),
                  TextButton(
                    onPressed: nextPage, 
                    style: ButtonStyle(  
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.amber),
                      shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.zero)
                      )),
                      fixedSize: MaterialStateProperty.all(const Size(302, 60)),            
                    ),
                    child: const Text(
                      'Let\'s Get Started',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        fontSize: 20
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}