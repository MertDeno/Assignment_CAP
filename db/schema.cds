namespace ntt_register;
using { managed } from '@sap/cds/common';

entity Courses : managed {
    courseId: String;
    courseName: String;
    students: Association to Students 
}

entity Students : managed {
    studentId: Integer;
    studentName: String;
    courses: Association[1,*] to Courses on courses.students = $self
}

entity studentCourse : managed{
    studentId: Integer;
    courseId : String;
}
