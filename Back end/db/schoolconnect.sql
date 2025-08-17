-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 17, 2025 at 03:00 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `schoolconnect`
--

-- --------------------------------------------------------

--
-- Table structure for table `assignments`
--

CREATE TABLE `assignments` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `title` text NOT NULL,
  `description` text DEFAULT NULL,
  `teacher_id` char(36) NOT NULL,
  `subject_id` char(36) NOT NULL,
  `class_id` char(36) NOT NULL,
  `due_date` timestamp NULL DEFAULT NULL,
  `max_score` decimal(5,2) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `assignments`
--

INSERT INTO `assignments` (`id`, `title`, `description`, `teacher_id`, `subject_id`, `class_id`, `due_date`, `max_score`, `created_at`) VALUES
('1cada183-7b6a-11f0-9711-181deaaf4cf3', 'Math Homework 1', 'Solve problems from page 12', '1ca672c7-7b6a-11f0-9711-181deaaf4cf3', '1ca472c3-7b6a-11f0-9711-181deaaf4cf3', '1ca2895c-7b6a-11f0-9711-181deaaf4cf3', '2025-08-31 21:00:00', 100.00, '2025-08-17 13:00:12'),
('1cadd413-7b6a-11f0-9711-181deaaf4cf3', 'Science Project', 'Create a model of the solar system', '1ca68f00-7b6a-11f0-9711-181deaaf4cf3', '1ca48efa-7b6a-11f0-9711-181deaaf4cf3', '1ca29a15-7b6a-11f0-9711-181deaaf4cf3', '2025-09-09 21:00:00', 100.00, '2025-08-17 13:00:12');

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `student_id` char(36) NOT NULL,
  `class_id` char(36) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `present` tinyint(1) NOT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `attendance`
--

INSERT INTO `attendance` (`id`, `student_id`, `class_id`, `date`, `present`, `notes`, `created_at`) VALUES
('1cb35f8c-7b6a-11f0-9711-181deaaf4cf3', '1ca8bbc5-7b6a-11f0-9711-181deaaf4cf3', '1ca2895c-7b6a-11f0-9711-181deaaf4cf3', '2025-08-16 21:00:00', 1, 'On time', '2025-08-17 13:00:12'),
('1cb37ad4-7b6a-11f0-9711-181deaaf4cf3', '1ca8f09e-7b6a-11f0-9711-181deaaf4cf3', '1ca29a15-7b6a-11f0-9711-181deaaf4cf3', '2025-08-16 21:00:00', 0, 'Sick leave', '2025-08-17 13:00:12');

-- --------------------------------------------------------

--
-- Table structure for table `classes`
--

CREATE TABLE `classes` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `name` text NOT NULL,
  `grade` text NOT NULL,
  `section` text NOT NULL,
  `academic_year` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `classes`
--

INSERT INTO `classes` (`id`, `name`, `grade`, `section`, `academic_year`, `created_at`) VALUES
('1ca2895c-7b6a-11f0-9711-181deaaf4cf3', 'Class A', 'Grade 5', 'A', '2025', '2025-08-17 13:00:12'),
('1ca29a15-7b6a-11f0-9711-181deaaf4cf3', 'Class B', 'Grade 6', 'B', '2025', '2025-08-17 13:00:12');

-- --------------------------------------------------------

--
-- Table structure for table `news`
--

CREATE TABLE `news` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `title` text NOT NULL,
  `content` text NOT NULL,
  `excerpt` text DEFAULT NULL,
  `image_url` text DEFAULT NULL,
  `author_id` char(36) NOT NULL,
  `published` tinyint(1) DEFAULT 0,
  `published_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `news`
--

INSERT INTO `news` (`id`, `title`, `content`, `excerpt`, `image_url`, `author_id`, `published`, `published_at`, `created_at`) VALUES
('1cb88f34-7b6a-11f0-9711-181deaaf4cf3', 'School Sports Day', 'Annual sports event on Sept 15.', 'Sports Day 2025', '/images/sports.jpg', '1c9fd7ee-7b6a-11f0-9711-181deaaf4cf3', 1, '2025-08-17 13:00:12', '2025-08-17 13:00:12'),
('1cb89d69-7b6a-11f0-9711-181deaaf4cf3', 'New Library Books', 'We have added new science books.', 'Library Update', '/images/library.jpg', '1c9fd7ee-7b6a-11f0-9711-181deaaf4cf3', 1, '2025-08-17 13:00:12', '2025-08-17 13:00:12');

-- --------------------------------------------------------

--
-- Table structure for table `schedule`
--

CREATE TABLE `schedule` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `class_id` char(36) NOT NULL,
  `subject_id` char(36) NOT NULL,
  `teacher_id` char(36) NOT NULL,
  `day_of_week` int(11) NOT NULL,
  `start_time` text NOT NULL,
  `end_time` text NOT NULL,
  `room` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `schedule`
--

INSERT INTO `schedule` (`id`, `class_id`, `subject_id`, `teacher_id`, `day_of_week`, `start_time`, `end_time`, `room`, `created_at`) VALUES
('1cb6121f-7b6a-11f0-9711-181deaaf4cf3', '1ca2895c-7b6a-11f0-9711-181deaaf4cf3', '1ca472c3-7b6a-11f0-9711-181deaaf4cf3', '1ca672c7-7b6a-11f0-9711-181deaaf4cf3', 1, '09:00', '10:00', 'Room 101', '2025-08-17 13:00:12'),
('1cb63f1a-7b6a-11f0-9711-181deaaf4cf3', '1ca29a15-7b6a-11f0-9711-181deaaf4cf3', '1ca48efa-7b6a-11f0-9711-181deaaf4cf3', '1ca68f00-7b6a-11f0-9711-181deaaf4cf3', 2, '11:00', '12:00', 'Lab 1', '2025-08-17 13:00:12');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `sid` varchar(255) NOT NULL,
  `sess` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`sess`)),
  `expire` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `user_id` char(36) NOT NULL,
  `student_id` text NOT NULL,
  `class_id` char(36) DEFAULT NULL,
  `date_of_birth` timestamp NULL DEFAULT NULL,
  `parent_id` char(36) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `phone_number` text DEFAULT NULL,
  `emergency_contact` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `user_id`, `student_id`, `class_id`, `date_of_birth`, `parent_id`, `address`, `phone_number`, `emergency_contact`, `created_at`) VALUES
('1ca8bbc5-7b6a-11f0-9711-181deaaf4cf3', '1c9fef7d-7b6a-11f0-9711-181deaaf4cf3', 'STU1001', '1ca2895c-7b6a-11f0-9711-181deaaf4cf3', '2013-05-09 21:00:00', '1c9fefee-7b6a-11f0-9711-181deaaf4cf3', 'Cairo', '01055556666', '01099998888', '2025-08-17 13:00:12'),
('1ca8f09e-7b6a-11f0-9711-181deaaf4cf3', '1c9fefb6-7b6a-11f0-9711-181deaaf4cf3', 'STU1002', '1ca29a15-7b6a-11f0-9711-181deaaf4cf3', '2012-03-14 22:00:00', '1c9fefee-7b6a-11f0-9711-181deaaf4cf3', 'Giza', '01077778888', '01044443333', '2025-08-17 13:00:12');

-- --------------------------------------------------------

--
-- Table structure for table `subjects`
--

CREATE TABLE `subjects` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `name` text NOT NULL,
  `code` text NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subjects`
--

INSERT INTO `subjects` (`id`, `name`, `code`, `description`, `created_at`) VALUES
('1ca472c3-7b6a-11f0-9711-181deaaf4cf3', 'Mathematics', 'MATH101', 'Basic Mathematics', '2025-08-17 13:00:12'),
('1ca48efa-7b6a-11f0-9711-181deaaf4cf3', 'Science', 'SCI101', 'General Science', '2025-08-17 13:00:12');

-- --------------------------------------------------------

--
-- Table structure for table `submissions`
--

CREATE TABLE `submissions` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `assignment_id` char(36) NOT NULL,
  `student_id` char(36) NOT NULL,
  `content` text DEFAULT NULL,
  `file_path` text DEFAULT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `score` decimal(5,2) DEFAULT NULL,
  `feedback` text DEFAULT NULL,
  `graded_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `submissions`
--

INSERT INTO `submissions` (`id`, `assignment_id`, `student_id`, `content`, `file_path`, `submitted_at`, `score`, `feedback`, `graded_at`) VALUES
('1cb0ed3d-7b6a-11f0-9711-181deaaf4cf3', '1cada183-7b6a-11f0-9711-181deaaf4cf3', '1ca8bbc5-7b6a-11f0-9711-181deaaf4cf3', 'Answers attached', '/uploads/omar_math.pdf', '2025-08-17 13:00:12', 95.00, 'Good job!', '2025-08-17 13:00:12'),
('1cb10c16-7b6a-11f0-9711-181deaaf4cf3', '1cadd413-7b6a-11f0-9711-181deaaf4cf3', '1ca8f09e-7b6a-11f0-9711-181deaaf4cf3', 'Solar system model submitted', '/uploads/sara_science.pdf', '2025-08-17 13:00:12', 90.00, 'Well done!', '2025-08-17 13:00:12');

-- --------------------------------------------------------

--
-- Table structure for table `teachers`
--

CREATE TABLE `teachers` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `user_id` char(36) NOT NULL,
  `employee_id` text NOT NULL,
  `specialization` text DEFAULT NULL,
  `qualifications` text DEFAULT NULL,
  `experience` int(11) DEFAULT NULL,
  `phone_number` text DEFAULT NULL,
  `address` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `teachers`
--

INSERT INTO `teachers` (`id`, `user_id`, `employee_id`, `specialization`, `qualifications`, `experience`, `phone_number`, `address`, `created_at`) VALUES
('1ca672c7-7b6a-11f0-9711-181deaaf4cf3', '1c9feeb9-7b6a-11f0-9711-181deaaf4cf3', 'EMP1001', 'Mathematics', 'B.Ed, M.Ed', 5, '01011112222', 'Cairo', '2025-08-17 13:00:12'),
('1ca68f00-7b6a-11f0-9711-181deaaf4cf3', '1c9fef3d-7b6a-11f0-9711-181deaaf4cf3', 'EMP1002', 'Science', 'B.Sc, M.Sc', 7, '01033334444', 'Giza', '2025-08-17 13:00:12');

-- --------------------------------------------------------

--
-- Table structure for table `teacher_subjects`
--

CREATE TABLE `teacher_subjects` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `teacher_id` char(36) NOT NULL,
  `subject_id` char(36) NOT NULL,
  `class_id` char(36) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `teacher_subjects`
--

INSERT INTO `teacher_subjects` (`id`, `teacher_id`, `subject_id`, `class_id`, `created_at`) VALUES
('1cab4d75-7b6a-11f0-9711-181deaaf4cf3', '1ca672c7-7b6a-11f0-9711-181deaaf4cf3', '1ca472c3-7b6a-11f0-9711-181deaaf4cf3', '1ca2895c-7b6a-11f0-9711-181deaaf4cf3', '2025-08-17 13:00:12'),
('1cab8295-7b6a-11f0-9711-181deaaf4cf3', '1ca68f00-7b6a-11f0-9711-181deaaf4cf3', '1ca48efa-7b6a-11f0-9711-181deaaf4cf3', '1ca29a15-7b6a-11f0-9711-181deaaf4cf3', '2025-08-17 13:00:12');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `email` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `profile_image_url` varchar(255) DEFAULT NULL,
  `role` enum('admin','teacher','student','parent') NOT NULL DEFAULT 'student',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `first_name`, `last_name`, `profile_image_url`, `role`, `created_at`, `updated_at`) VALUES
('1c9fd7ee-7b6a-11f0-9711-181deaaf4cf3', 'admin@school.com', 'Admin', 'User', NULL, 'admin', '2025-08-17 13:00:12', '2025-08-17 13:00:12'),
('1c9feeb9-7b6a-11f0-9711-181deaaf4cf3', 'ahmed.teacher@school.com', 'Ahmed', 'Hassan', NULL, 'teacher', '2025-08-17 13:00:12', '2025-08-17 13:00:12'),
('1c9fef3d-7b6a-11f0-9711-181deaaf4cf3', 'mona.teacher@school.com', 'Mona', 'Ali', NULL, 'teacher', '2025-08-17 13:00:12', '2025-08-17 13:00:12'),
('1c9fef7d-7b6a-11f0-9711-181deaaf4cf3', 'omar.student@school.com', 'Omar', 'Khaled', NULL, 'student', '2025-08-17 13:00:12', '2025-08-17 13:00:12'),
('1c9fefb6-7b6a-11f0-9711-181deaaf4cf3', 'sara.student@school.com', 'Sara', 'Mohamed', NULL, 'student', '2025-08-17 13:00:12', '2025-08-17 13:00:12'),
('1c9fefee-7b6a-11f0-9711-181deaaf4cf3', 'parent1@school.com', 'Mahmoud', 'Khaled', NULL, 'parent', '2025-08-17 13:00:12', '2025-08-17 13:00:12');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assignments`
--
ALTER TABLE `assignments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `teacher_id` (`teacher_id`),
  ADD KEY `subject_id` (`subject_id`),
  ADD KEY `class_id` (`class_id`);

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `class_id` (`class_id`);

--
-- Indexes for table `classes`
--
ALTER TABLE `classes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`id`),
  ADD KEY `author_id` (`author_id`);

--
-- Indexes for table `schedule`
--
ALTER TABLE `schedule`
  ADD PRIMARY KEY (`id`),
  ADD KEY `class_id` (`class_id`),
  ADD KEY `subject_id` (`subject_id`),
  ADD KEY `teacher_id` (`teacher_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`sid`),
  ADD KEY `IDX_session_expire` (`expire`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `student_id` (`student_id`) USING HASH,
  ADD KEY `user_id` (`user_id`),
  ADD KEY `class_id` (`class_id`),
  ADD KEY `parent_id` (`parent_id`);

--
-- Indexes for table `subjects`
--
ALTER TABLE `subjects`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`) USING HASH;

--
-- Indexes for table `submissions`
--
ALTER TABLE `submissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `assignment_id` (`assignment_id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `teachers`
--
ALTER TABLE `teachers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `employee_id` (`employee_id`) USING HASH,
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `teacher_subjects`
--
ALTER TABLE `teacher_subjects`
  ADD PRIMARY KEY (`id`),
  ADD KEY `teacher_id` (`teacher_id`),
  ADD KEY `subject_id` (`subject_id`),
  ADD KEY `class_id` (`class_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `assignments`
--
ALTER TABLE `assignments`
  ADD CONSTRAINT `assignments_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`id`),
  ADD CONSTRAINT `assignments_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`),
  ADD CONSTRAINT `assignments_ibfk_3` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`);

--
-- Constraints for table `attendance`
--
ALTER TABLE `attendance`
  ADD CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`),
  ADD CONSTRAINT `attendance_ibfk_2` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`);

--
-- Constraints for table `news`
--
ALTER TABLE `news`
  ADD CONSTRAINT `news_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `schedule`
--
ALTER TABLE `schedule`
  ADD CONSTRAINT `schedule_ibfk_1` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`),
  ADD CONSTRAINT `schedule_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`),
  ADD CONSTRAINT `schedule_ibfk_3` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`id`);

--
-- Constraints for table `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `students_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `students_ibfk_2` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`),
  ADD CONSTRAINT `students_ibfk_3` FOREIGN KEY (`parent_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `submissions`
--
ALTER TABLE `submissions`
  ADD CONSTRAINT `submissions_ibfk_1` FOREIGN KEY (`assignment_id`) REFERENCES `assignments` (`id`),
  ADD CONSTRAINT `submissions_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`);

--
-- Constraints for table `teachers`
--
ALTER TABLE `teachers`
  ADD CONSTRAINT `teachers_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `teacher_subjects`
--
ALTER TABLE `teacher_subjects`
  ADD CONSTRAINT `teacher_subjects_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`id`),
  ADD CONSTRAINT `teacher_subjects_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`),
  ADD CONSTRAINT `teacher_subjects_ibfk_3` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
