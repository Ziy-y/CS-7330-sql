CREATE DATABASE student;
USE student;

CREATE TABLE department (
    dept_name VARCHAR(20),
    building VARCHAR(20),
    budget DECIMAL(12,2),

    PRIMARY KEY (dept_name)
);

CREATE TABLE classroom (
    building VARCHAR(20),
    room_number VARCHAR(7),
    capacity INT,

    PRIMARY KEY (building, room_number)
);

CREATE TABLE time_slot (
    time_slot_id VARCHAR(4),
    day VARCHAR(1),
    start_hr INT,
    start_min INT,
    end_hr INT,
    end_min INT,

    PRIMARY KEY (
        time_slot_id,
        day,
        start_hr,
        start_min
    )
);

CREATE TABLE student (
    ID VARCHAR(5),
    name VARCHAR(20) NOT NULL,
    dept_name VARCHAR(20),
    tot_cred INT,

    PRIMARY KEY (ID),

    FOREIGN KEY (dept_name)
        REFERENCES department(dept_name)
);

CREATE TABLE instructor (
    ID VARCHAR(5),
    name VARCHAR(20) NOT NULL,
    dept_name VARCHAR(20),
    salary DECIMAL(8,2),

    PRIMARY KEY (ID),

    FOREIGN KEY (dept_name)
        REFERENCES department(dept_name)
);

CREATE TABLE course (
    course_id VARCHAR(8),
    title VARCHAR(50),
    dept_name VARCHAR(20),
    credits INT,

    PRIMARY KEY (course_id),

    FOREIGN KEY (dept_name)
        REFERENCES department(dept_name)
);

CREATE TABLE section (
    course_id VARCHAR(8),
    sec_id VARCHAR(8),
    semester VARCHAR(6),
    year INT,
    building VARCHAR(20),
    room_number VARCHAR(7),
    time_slot_id VARCHAR(4),

    PRIMARY KEY (
        course_id,
        sec_id,
        semester,
        year
    ),

    FOREIGN KEY (course_id)
        REFERENCES course(course_id),

    FOREIGN KEY (building, room_number)
        REFERENCES classroom(building, room_number)
);

CREATE TABLE takes (
    ID VARCHAR(5),
    course_id VARCHAR(8),
    sec_id VARCHAR(8),
    semester VARCHAR(6),
    year INT,
    grade VARCHAR(2),

    PRIMARY KEY (
        ID,
        course_id,
        sec_id,
        semester,
        year
    ),

    FOREIGN KEY (ID)
        REFERENCES student(ID),

    FOREIGN KEY (
        course_id,
        sec_id,
        semester,
        year
    )
        REFERENCES section(
            course_id,
            sec_id,
            semester,
            year
        )
);

CREATE TABLE teaches (
    ID VARCHAR(5),
    course_id VARCHAR(8),
    sec_id VARCHAR(8),
    semester VARCHAR(6),
    year INT,

    PRIMARY KEY (
        ID,
        course_id,
        sec_id,
        semester,
        year
    ),

    FOREIGN KEY (ID)
        REFERENCES instructor(ID),

    FOREIGN KEY (
        course_id,
        sec_id,
        semester,
        year
    )
        REFERENCES section(
            course_id,
            sec_id,
            semester,
            year
        )
);

CREATE TABLE advisor (
    s_ID VARCHAR(5),
    i_ID VARCHAR(5),

    PRIMARY KEY (s_ID),

    FOREIGN KEY (s_ID)
        REFERENCES student(ID),

    FOREIGN KEY (i_ID)
        REFERENCES instructor(ID)
);

CREATE TABLE prereq (
    course_id VARCHAR(8),
    prereq_id VARCHAR(8),

    PRIMARY KEY (
        course_id,
        prereq_id
    ),

    FOREIGN KEY (course_id)
        REFERENCES course(course_id),

    FOREIGN KEY (prereq_id)
        REFERENCES course(course_id)
);

USE student;

-- department
INSERT INTO department VALUES
('CS', 'Engineering', 120000),
('Math', 'Science', 90000),
('Biology', 'LifeSci', 100000);

-- classroom
INSERT INTO classroom VALUES
('Engineering', '101', 50),
('Engineering', '102', 40),
('Engineering', '103', 60);

-- student
INSERT INTO student VALUES
('1001', 'Alice', 'CS', 80),
('1002', 'Bob', 'CS', 70),
('1003', 'Carol', 'Math', 90),
('1004', 'David', 'CS', 60),
('1005', 'Emma', 'Biology', 50);

-- instructor
INSERT INTO instructor VALUES
('1101', 'Smith', 'CS', 90000),
('1102', 'Brown', 'Math', 85000);

-- course
INSERT INTO course VALUES
('CS101', 'Introduction to CS', 'CS', 3),
('CS201', 'Database Systems', 'CS', 3),
('CS301', 'Algorithms', 'CS', 3);

-- section
INSERT INTO section VALUES
('CS101', '1', 'Spring', 2018, 'Engineering', '101', 'A'),
('CS201', '1', 'Spring', 2018, 'Engineering', '102', 'B'),
('CS301', '1', 'Spring', 2018, 'Engineering', '103', 'C'),

-- another semester
('CS201', '1', 'Fall', 2018, 'Engineering', '102', 'B');

-- advisor
INSERT INTO advisor VALUES
('1001', '1101'),
('1002', '1101'),
('1003', '1102'),
('1004', '1101');

-- takes
INSERT INTO takes VALUES
('1001', 'CS101', '1', 'Spring', 2018, 'A'),
('1001', 'CS201', '1', 'Spring', 2018, 'A'),
('1001', 'CS301', '1', 'Spring', 2018, 'B'),

('1002', 'CS101', '1', 'Spring', 2018, 'B'),
('1002', 'CS201', '1', 'Spring', 2018, 'A'),

('1003', 'CS201', '1', 'Spring', 2018, 'B'),

('1004', 'CS201', '1', 'Fall', 2018, 'A');
