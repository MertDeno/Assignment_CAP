using { ntt_register as db } from '../db/schema';

service RegisterService@(path: '/RegisterService') {

    entity Students as projection on db.Students;
    entity Courses as projection on db.Courses excluding {
        modifiedAt,
        modifiedBy,
        createdAt,
        createdBy
    };
        
    action addCourse(courseId: String, courseName: String);
    action deleteCourse(courseId: String);
}