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
