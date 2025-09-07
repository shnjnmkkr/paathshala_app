import 'package:flutter/material.dart';

class CourseDetailsPage extends StatelessWidget {
  const CourseDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Course Details",
          style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {
              print("Liked!");
            },
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Video Placeholder
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Icon(Icons.play_circle_fill,
                    size: 60, color: Colors.deepPurple),
              ),
            ),

            const SizedBox(height: 20),

            // Course Name
            const Text(
              "AI/ML",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: "Poppins",
              ),
            ),

            const SizedBox(height: 10),

            // Description Heading
            const Text(
              "Description",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: "Poppins",
              ),
            ),

            const SizedBox(height: 5),

            // Description Text
            const Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
              "Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
              style: TextStyle(fontSize: 14, color: Colors.grey, height: 1.4),
            ),

            const SizedBox(height: 20),

            // Notes, Quizzes, Assignments
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _iconText(Icons.note, "Notes", () {
                  print("Notes Clicked");
                }),
                _iconText(Icons.quiz, "Quizzes", () {
                  print("Quizzes Clicked");
                }),
                _iconText(Icons.assignment, "Assignments", () {
                  print("Assignments Clicked");
                }),
              ],
            ),

            const SizedBox(height: 25),

            // Lessons Heading
            const Text(
              "Lessons",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "Poppins",
              ),
            ),

            const SizedBox(height: 15),

            // Lesson Buttons
            _lessonTile("Lecture 1", 0.3),
            const SizedBox(height: 12),
            _lessonTile("Lecture 2", 0.6),
            const SizedBox(height: 12),
            _lessonTile("Lecture 3", 0.9),
          ],
        ),
      ),
    );
  }

  // 🔹 Helper Widget for clickable Notes/Quizzes/Assignments
  static Widget _iconText(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: Colors.deepPurple),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: "Poppins",
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Helper Widget for Lessons
  static Widget _lessonTile(String title, double progress) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 242, 229, 255), // very light purple
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins",
                  ),
                ),
              ),
              Icon(Icons.play_circle_fill, color: Colors.deepPurple, size: 30),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            color: Colors.deepPurple,
            backgroundColor: Colors.deepPurple.shade100,
            minHeight: 6,
            borderRadius: BorderRadius.circular(6),
          ),
        ],
      ),
    );
  }
}
