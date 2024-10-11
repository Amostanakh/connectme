import 'package:connectme/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardData = [
    {
      'title': 'Welcome to ConnectMe',
      'description':
          'Real-time communication made easy with WebRTC technology.',
      'image': 'assets/logo.png',
    },
    {
      'title': 'Connect with anyone',
      'description': 'Use peer-to-peer connections for seamless communication.',
      'image': 'assets/logo.png',
    },
    {
      'title': 'Start your call',
      'description':
          'Just a few taps to begin your first WebRTC-based video or voice call!',
      'image': 'assets/logo.png',
    },
  ];

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: _onboardData.length,
                itemBuilder: (context, index) {
                  return OnboardContent(
                    title: _onboardData[index]['title']!,
                    description: _onboardData[index]['description']!,
                    image: _onboardData[index]['image']!,
                  );
                },
              ),
            ),
            _buildIndicator(),
            _buildNextButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_onboardData.length, (index) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4),
          height: 10,
          width: _currentPage == index ? 20 : 10,
          decoration: BoxDecoration(
            color: _currentPage == index ? Colors.blue : Colors.grey,
            borderRadius: BorderRadius.circular(5),
          ),
        );
      }),
    );
  }

  Widget _buildNextButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          if (_currentPage == _onboardData.length - 1) {
            // Navigate to Get Started or Home screen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SignUpPage()),
            );
          } else {
            _pageController.nextPage(
              duration: Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          }
        },
        child: Text(
            _currentPage == _onboardData.length - 1 ? 'Get Started' : 'Next'),
      ),
    );
  }
}

class OnboardContent extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  const OnboardContent({
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 250,
            width: 250,
          ),
          SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
