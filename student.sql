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


