<?php
$connection = new mysqli("localhost", "admin", "admin", "world");

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