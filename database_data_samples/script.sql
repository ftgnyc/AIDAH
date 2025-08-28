INSERT INTO `aidah.dim_dates` (`date`, year, month, month_full_name, month_short_name, day)
WITH DateRange AS (
  SELECT
    GENERATE_DATE_ARRAY(
      DATE_SUB(CURRENT_DATE(), INTERVAL 3 MONTH),
      DATE_ADD(CURRENT_DATE(), INTERVAL 3 MONTH)
    ) AS dates
)
SELECT
  date AS `date`,
  EXTRACT(YEAR FROM date) AS year,
  EXTRACT(MONTH FROM date) AS month,
  FORMAT_DATE('%B', date) AS month_full_name,
  FORMAT_DATE('%b', date) AS month_short_name,
  EXTRACT(DAY FROM date) AS day
FROM DateRange, UNNEST(dates) AS date;

INSERT INTO `aidah.dim_semesters` (id_semester, year, semester)
VALUES
  (1, 2020, 'Spring'),
  (2, 2020, 'Fall'),
  (3, 2021, 'Spring'),
  (4, 2021, 'Fall'),
  (5, 2022, 'Spring'),
  (6, 2022, 'Fall'),
  (7, 2023, 'Spring'),
  (8, 2023, 'Fall'),
  (9, 2024, 'Spring'),
  (10, 2024, 'Fall'),
  (11, 2025, 'Spring'),
  (12, 2025, 'Fall'),
  (13, 2026, 'Spring'),
  (14, 2026, 'Fall'),
  (15, 2027, 'Spring'),
  (16, 2027, 'Fall'),
  (17, 2028, 'Spring'),
  (18, 2028, 'Fall'),
  (19, 2029, 'Spring'),
  (20, 2029, 'Fall'),
  (21, 2030, 'Spring'),
  (22, 2030, 'Fall');

INSERT INTO `aidah.dim_institutions` (id_institution, code, name, type, state, city)
VALUES
    (1, 'UNV-S-24', 'Greenwood State University', 'College', 'GA', 'Atlanta'),
    (2, 'HS-234', 'Maplewood High School', 'High School', 'WA', 'Seattle'),
    (3, 'TCC-65', 'Riverside Community College', 'College', 'TX', 'Austin'),
    (4, 'HS-567', 'Highland Park High School', 'High School', 'CA', 'San Francisco'),
    (5, 'HS-890', 'Liberty Hill High School', 'High School', 'FL', 'Miami');

INSERT INTO `aidah.dim_agreements` (id_agreement, code, title, description, d_valid_since, d_valid_until)
VALUES
    (101, 'GSU-AGR', 'Transfer Agreement with Greenwood State University', 'This agreement establishes a partnership between the university and the school district to facilitate student transfers and academic collaboration.', '2024-08-01', '2028-07-31');

INSERT INTO `aidah.dim_degree_programs` (id_degree_program, code, name)
VALUES
    (1, 'CS-BS', 'Bachelor of Computing Science'),
    (2, 'BUS-BA', 'Bachelor of Arts in Business Administration'),
    (3, 'NUR-BSN', 'Bachelor of Science in Nursing');

INSERT INTO `aidah.dim_courses` (id_course, code, name, type)
VALUES
    (1, 'CS101', 'Introduction to Programming', 'College'),
    (2, 'CS201', 'Data Structures and Algorithms', 'College'),
    (3, 'CS301', 'Database Systems', 'College'),
    (4, 'CS401', 'Software Engineering', 'College'),
    (5, 'BUS101', 'Principles of Accounting', 'College'),
    (6, 'BUS201', 'Financial Management', 'College'),
    (7, 'BUS301', 'Marketing Principles', 'College'),
    (8, 'BUS401', 'Business Ethics', 'College'),
    (9, 'NUR101', 'Foundations of Nursing', 'College'),
    (10, 'NUR201', 'Pharmacology', 'College'),
    (11, 'NUR301', 'Pediatric Nursing', 'College'),
    (12, 'NUR401', 'Mental Health Nursing', 'College'),
    (13, 'HS-MTH101', 'Algebra I', 'High School'),
    (14, 'HS-SCI202', 'Biology', 'High School'),
    (15, 'HS-ENG303', 'American Literature', 'High School'),
    (16, 'HS-HIS404', 'World History', 'High School'),
    (17, 'HS-MTH202', 'Geometry', 'High School'),
    (18, 'HS-SCI303', 'Chemistry', 'High School'),
    (19, 'HS-ENG404', 'Creative Writing', 'High School'),
    (20, 'HS-HIS505', 'U.S. Government', 'High School');

INSERT INTO `aidah.dim_users` (id_user, first_name, second_name, last_name, email, phone)
VALUES
    (1, 'John', 'Michael', 'Smith', 'john.m.smith@testschema.com', '555-123-4567'),
    (2, 'Emily', NULL, 'Jones', 'emily.jones@testschema.com', '555-987-6543'),
    (3, 'Chris', 'David', 'Garcia', 'chris.d.garcia@testschema.com', NULL),
    (4, 'Maria', 'Isabel', 'Rodriguez', 'maria.i.rodriguez@testschema.com', '555-555-1212'),
    (5, 'Alex', NULL, 'Lee', 'alex.lee@testschema.com', '555-321-7890'),
    (6, 'Jessica', 'Marie', 'Chen', 'jessica.m.chen@testschema.com', '555-444-5555'),
    (7, 'Daniel', NULL, 'Kim', 'daniel.kim@testschema.com', '555-777-8888'),
    (8, 'Sophia', 'Grace', 'Miller', 'sophia.g.miller@testschema.com', NULL),
    (9, 'Ethan', 'Charles', 'Wilson', 'ethan.c.wilson@testschema.com', '555-111-2222'),
    (10, 'Olivia', NULL, 'Taylor', 'olivia.taylor@testschema.com', '555-333-4444');

-- FACT USER EVENTS
INSERT INTO `aidah.fact_user_events` (
    id_enrollment,
    id_user,
    id_institution,
    id_agreement,
    id_degree_program,
    student_id,
    grade_level,
    d_enrollment,
    d_expected_graduation,
    d_graduation,
    event_type
)
VALUES
    -- User 1: High School to College journey
    (1, 1, 2, NULL, NULL, 'S001', 9, '2020-09-01', '2024-06-01', '2024-06-01', 'HS Enrollment'),
    (2, 1, 1, 101, 1, 'C1001', NULL, '2024-08-20', '2028-05-30', NULL, 'College Enrollment'),

    -- User 2: Only High School
    (3, 2, 4, NULL, NULL, 'S002', 10, '2021-09-05', '2025-06-05', NULL, 'HS Enrollment'),

    -- User 3: High School and College
    (4, 3, 5, NULL, NULL, 'S003', 11, '2022-09-10', '2026-06-10', NULL, 'HS Enrollment'),
    (5, 3, 3, NULL, 3, 'C1002', NULL, '2026-08-25', '2030-05-25', NULL, 'College Enrollment'),

    -- User 4: High School only
    (6, 4, 2, NULL, NULL, 'S004', 12, '2022-09-01', '2026-06-01', NULL, 'HS Enrollment'),

    -- User 5: High School to College with agreement
    (7, 5, 4, NULL, NULL, 'S005', 9, '2023-09-01', '2027-06-01', NULL, 'HS Enrollment'),
    (8, 5, 1, 101, 2, 'C1003', NULL, '2027-08-20', '2031-05-30', NULL, 'College Enrollment'),
    (9, 5, 1, 101, 2, 'C1003', NULL, '2027-08-20', NULL, NULL, 'Agreement Enrollment'),

    -- User 6: Only College enrollment
    (10, 6, 1, NULL, 1, 'C1004', NULL, '2023-08-20', '2027-05-30', NULL, 'College Enrollment'),

    -- User 7: Only High School
    (11, 7, 5, NULL, NULL, 'S007', 9, '2024-09-01', '2028-06-01', NULL, 'HS Enrollment'),

    -- User 8: Only High School
    (12, 8, 4, NULL, NULL, 'S008', 10, '2023-09-05', '2027-06-05', NULL, 'HS Enrollment'),

    -- User 9: Only High School
    (13, 9, 2, NULL, NULL, 'S009', 11, '2022-09-10', '2026-06-10', NULL, 'HS Enrollment'),

    -- User 10: High School to College
    (14, 10, 5, NULL, NULL, 'S010', 12, '2021-09-01', '2025-06-01', '2025-06-01', 'HS Enrollment'),
    (15, 10, 3, NULL, 3, 'C1005', NULL, '2025-08-25', '2029-05-25', NULL, 'College Enrollment'),
    
    -- New Record: User 3 signing a new agreement
    (16, 3, 3, 102, 3, 'C1002', NULL, '2026-08-26', NULL, NULL, 'Agreement Enrollment');

-- FACT USER GRADES
INSERT INTO `aidah.fact_grades` (id_user, id_institution, id_degree_program, id_course, grade, course_year, id_semester, is_transferred, date)
VALUES
    -- User 1: John Smith (College Student, enrolled at Greenwood State University)
    -- This user has completed a college program. Grades are for Computer Science and Business courses.
    (1, 1, 1, 1, 'A', 2024, 9, false, '2024-12-15'),
    (1, 1, 1, 2, 'B+', 2025, 11, false, '2025-05-18'),
    (1, 1, 1, 3, 'A-', 2025, 11, false, '2025-05-18'),
    
    -- User 3: Chris Garcia (High School and College)
    -- This user is transferring high school credits to college.
    (3, 5, NULL, 13, 'B', 2023, 7, false, '2023-05-20'),
    (3, 5, NULL, 14, 'A', 2023, 7, false, '2023-05-20'),
    (3, 3, 3, 9, 'B+', 2026, 13, false, '2026-12-20'),
    (3, 3, 3, 11, 'A', 2026, 13, false, '2026-12-20'),

    -- User 5: Alex Lee (High School to College with Agreement)
    -- This user transferred high school credits to college under an agreement.
    (5, 4, NULL, 15, 'A-', 2024, 9, false, '2024-12-18'),
    (5, 4, NULL, 16, 'B+', 2024, 9, false, '2024-12-18'),
    (5, 1, 2, 7, 'B', 2028, 17, true, '2028-05-20'),
    (5, 1, 2, 8, 'A', 2028, 17, false, '2028-05-20'),
    
    -- User 10: Olivia Taylor (High School to College)
    -- This user completed high school and is now in college.
    (10, 5, NULL, 18, 'A', 2025, 11, false, '2025-05-22'),
    (10, 3, 3, 10, 'B', 2025, 12, false, '2025-12-20');