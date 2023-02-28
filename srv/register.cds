using { ntt_register as db } from '../db/schema';

service RegisterService@(path: '/RegisterService') {

    entity Students as projection on db.Students;
    entity Courses as projection on db.Courses excluding {
        modifiedAt,
        modifiedBy,
        createdAt,
        createdBy
    } actions {
        @Common : { IsActionCritical }
        action deleteCourse()
    };
        
    action addCourse(courseId: String, courseName: String) returns array of Courses;
//    action deleteCourse(courseId: String);
}