const req = require("express/lib/request");

module.exports = (srv) => {

    var stdId;

    srv.before("READ", "Students", async(req) => {      //For adding courses to a user, studentId is fetched firstly
        if(req.data.studentId != undefined){
            stdId = req.data.studentId
            return            
        }
    })
    
    srv.on('addCourse', async(req) => {
        let studentId = stdId
        let courseId = req.data.courseId
        let courseName = req.data.courseName
        const db = srv.transaction(req)
        let {Students} = srv.entities
        let {Courses} = srv.entities
        const results = await db.read(Students).where({studentId: stdId})
        const courses = await db.read(Courses).where({courseId: courseId})
    

        if(courses.length === 0 && results.length != 0){
            try {
                db.run([
                    INSERT.into(Courses).entries({courseId: courseId, courseName: courseName, students_studentId: stdId})
                ])  
            } catch (error) {
                console.log(error)   
            }
        }
        else if(courses.length === 0){      //If the record exists, the course cannot be added
            console.log("The record exists")
        } 

    });

    srv.on('deleteCourse', async(req) => {
        let courseId = req.query.SELECT.from.ref[1].where[2].val
        const db = srv.transaction(req)
        let {Courses} = srv.entities
        const regCourses = await db.read(Courses).where({students_studentId: stdId})
        if(regCourses.length === 1){                 //For one-to-many, a student at least should have a course
            console.log('Each student should register to a course')
            return
        }

        db.run([
            DELETE.from(Courses).where({students_studentId: stdId, courseId: courseId}) 
        ])   
    });
};