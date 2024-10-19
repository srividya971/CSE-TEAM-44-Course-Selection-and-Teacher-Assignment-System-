CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    course_type ENUM('theory', 'lab') NOT NULL
);

-- Create Teachers Table
CREATE TABLE teachers (
    teacher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    rating DECIMAL(2,1) DEFAULT 0,
    research_areas TEXT,
    patents INT DEFAULT 0,
    academic_background VARCHAR(255)
);

-- Create Assignments Table (Course-Teacher Assignment)
CREATE TABLE assignments (
    assignment_id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT,
    teacher_id INT,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE,
    FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id) ON DELETE CASCADE
);

-- Create Feedback Table
CREATE TABLE feedback (
    feedback_id INT AUTO_INCREMENT PRIMARY KEY,
    teacher_id INT,
    feedback TEXT,
    FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id) ON DELETE CASCADE
);

-- Insert Sample Courses
INSERT INTO courses (course_name, course_type) VALUES 
('C', 'theory'), ('C++', 'theory'), ('Python', 'theory'), 
('Java', 'theory'), ('BEEE', 'theory'), 
('Web Designing Lab', 'lab'), ('Python Lab', 'lab');

-- Insert Sample Teachers
INSERT INTO teachers (name, rating, research_areas, patents, academic_background) VALUES
('Ravikanth', 4.7, 'C, ADS, C-Lab', 3, 'PG in Computer Science, RGMCET'),
('Madusudhana Reddy', 4.8, 'C, ADS, C-Lab', 3, 'PG in Computer Science, RGMCET'),
('Naveen', 4.8, 'Web Technology', 3, 'PhD in Computer Science'),
('Sravan', 4.8, 'Python', 3, 'PhD in Computer Science');

-- Insert Course-Teacher Assignments
INSERT INTO assignments (course_id, teacher_id) VALUES 
(1, 1), (2, 2), (6, 3), (7, 4);
Connecting HTML Form to Database (Backend Example in PHP)
Below is a simple PHP code snippet to submit course selection and store feedback.

submit-courses.php
php
Copy code
<?php
$connection = new mysqli("localhost", "username", "password", "database_name");

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $theory1 = $_POST['theory1'];
    $teacher1 = $_POST['teacher1'];
    
    // Save the course-teacher assignment
    $query = "INSERT INTO assignments (course_id, teacher_id) VALUES (?, ?)";
    $stmt = $connection->prepare($query);
    $stmt->bind_param("ii", $theory1, $teacher1);
    $stmt->execute();
    
    echo "Course selection submitted successfully!";
}
?>
submit-feedback.php
php
Copy code
<?php
$connection = new mysqli("localhost", "username", "password", "database_name");

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $teacher = $_POST['teacher'];
    $feedback = $_POST['feedback'];

    $query = "INSERT INTO feedback (teacher_id, feedback) VALUES (?, ?)";
    $stmt = $connection->prepare($query);
    $stmt->bind_param("is", $teacher, $feedback);
    $stmt->execute();

    echo "Feedback submitted successfully!";
}
?>
