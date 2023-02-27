namespace ntt_register;
using { managed } from '@sap/cds/common';

entity Students : managed {  //One to many relationship between entities
    key studentId: Integer;
    studentName: String;
    courses: Association to many Courses on courses.students = $self
}

entity Courses : managed {
    key courseId: String;
    courseName: String;
    students: Association to Students
}