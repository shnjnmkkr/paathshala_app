import 'package:flutter/material.dart';
import 'dart:async';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;

  final List<String> subjects = ["Mathematics", "Physics", "English", "Chemistry"];
  final List<String> skillCourses = ["Web Dev", "AI/ML", "Cyber Sec"];

  final PageController _pageController = PageController(viewportFraction: 0.7);
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_currentPage < subjects.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Dashboard",
          style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(color: Color.fromARGB(255, 124, 151, 169)),
              child: Text(
                "Menu",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: "Poppins",
                ),
              ),
            ),
            ListTile(leading: Icon(Icons.book), title: Text("Syllabus")),
            ListTile(leading: Icon(Icons.notes), title: Text("Notes")),
            ListTile(leading: Icon(Icons.quiz), title: Text("Quiz")),
            ListTile(leading: Icon(Icons.calendar_today), title: Text("Calendar")),
            ListTile(leading: Icon(Icons.check_circle), title: Text("Attendance")),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              "Hi Student!",
              style: TextStyle(
                fontSize: 35,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Academic Courses",
              style: TextStyle(
                fontSize: 18,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),

            // PageView slider instead of carousel
            SizedBox(
              height: 120,
              child: PageView.builder(
                controller: _pageController,
                itemCount: subjects.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color.fromARGB(255, 0, 94, 157),
                    ),
                    child: Center(
                      child: Text(
                        subjects[index],
                        style: const TextStyle(
                          fontSize: 20,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 30),
const Text(
  "Skill Courses",
  style: TextStyle(
    fontSize: 18,
    fontFamily: "Poppins",
    fontWeight: FontWeight.w600,
  ),
),
const SizedBox(height: 10),

Column(
  children: skillCourses.map((skill) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0), // space between buttons
      child: SizedBox(
        width: double.infinity, // make button full width
        height: 60, // make button taller
        child: ElevatedButton(
          onPressed: () {
            print("$skill clicked");
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4A90E2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            skill,
            style: const TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold,
              fontSize: 18, // bigger font
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }).toList(),
),
const SizedBox(height: 30),

// Dashboard Image Card
Card(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  ),
  elevation: 5,
  child: ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: Image.asset(
      'asset/fonts/images/sketch.png',
      height: 300,
      width: double.infinity,
      fit: BoxFit.cover,
    ),
  ),
),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.video_library), label: "Live Classes"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
