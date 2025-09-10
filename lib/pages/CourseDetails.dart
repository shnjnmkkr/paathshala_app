import 'package:flutter/material.dart';
import 'video_player.dart'; // adjust path if needed

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
            color: Colors.black,
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
            // Video Placeholder with image
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const VideoPlayerPage()),
                );
              },
              child: Stack(
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: const DecorationImage(
                        image: AssetImage("asset/fonts/images/course_detail.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Icon(Icons.play_circle_fill,
                          size: 60, color: Colors.white), // ✅ White play button
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // AI/ML Heading + Forum Button with icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "AI/ML",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: "Poppins",
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    print("Forum Button Clicked");
                  },
                  icon: const Icon(Icons.forum, color: Colors.white, size: 20),
                  label: const Text(
                    "Forum",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
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
              "This AI/ML course includes introduction to Machine Learning, "
              "Neural Networks, Natural Language Processing, Computer Vision, "
              "and hands-on projects to strengthen your skills.",
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
            _lessonTile(
              context,
              "Lecture 1",
              0.3,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const VideoPlayerPage()),
                );
              },
            ),
            const SizedBox(height: 12),
            _lessonTile(context, "Lecture 2", 0.6, () {
              print("Lecture 2 tapped");
            }),
            const SizedBox(height: 12),
            _lessonTile(context, "Lecture 3", 0.9, () {
              print("Lecture 3 tapped");
            }),
          ],
        ),
      ),
    );
  }

  // Helper Widget for clickable Notes/Quizzes/Assignments
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

  // Helper Widget for Lessons
  static Widget _lessonTile(
      BuildContext context, String title, double progress, VoidCallback onPlay) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 242, 229, 255),
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
              InkWell(
                onTap: onPlay,
                child: const Icon(Icons.play_circle_fill,
                    color: Colors.white, size: 30), // ✅ White play button
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: Colors.deepPurple.shade100,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Colors.deepPurple),
            ),
          ),
        ],
      ),
    );
  }
}
