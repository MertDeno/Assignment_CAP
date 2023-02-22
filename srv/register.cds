using { ntt_register as db } from '../db/schema';

service RegisterService@(path: '/RegisterService') {

    entity Students as projection on db.Students;
    entity Courses as projection on db.Courses excluding {
        modifiedAt,
        modifiedBy,
        createdAt,
        createdBy
    };
    entity studentCourse as projection on db.studentCourse excluding {
        modifiedAt,
        modifiedBy,
        createdAt,
        createdBy
    };
    function getStudentCourses(studentId: String) returns array of String;
    action addCourse(studentId: String, courseId: String);
}