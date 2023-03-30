const req = require("express/lib/request");

module.exports = (srv) => {

    var stdId;

    srv.before("READ", "Students", async(req) => {      //For adding courses to a user, studentId is fetched firstly
        if(req.data.studentId != undefined){
            stdId = req.data.studentId
            return            
        }
    });

    
    srv.on('addCourse', async(req) => {
        let studentId = stdId
        let courseId = req.data.courseId
        let courseName = req.data.courseName
        //const db = srv.transaction(req)
        const tx = srv.transaction()

        let {Students} = srv.entities
        let {Courses} = srv.entities
        const results = await tx.read(Students).where({studentId: stdId})
        const courses = await tx.read(Courses).where({courseId: courseId})
    
        if(courses.length === 0 && results.length != 0){
            if(courseId.trim().length != 0 && courseName.trim().length != 0){
                try {
                    let result1 = await tx.run(
                        INSERT.into(Courses).entries({courseId: courseId, courseName: courseName, students_studentId: studentId})
                    )

                    let result2 = await tx.run(
                        SELECT.from(Courses).where({students_studentId: stdId})
                    )

                    await tx.commit()

                    return [result1,result2]
                } catch (error) {
                    await tx.rollback()
                    console.log(error)   
                }
            }
            else{
                console.log('All Fields should be filled')
            }
        }
        else if(courses.length != 0){      //If the record exists, the course cannot be added
            console.log("The record exists")
        } 
        
        //return Courses
    });

    srv.after('addCourse', async(req) => {
        const tx = srv.transaction()
        let {Courses} = srv.entities 
        return await tx.read(Courses).where({students_studentId: stdId})
    })

    srv.on('deleteCourse', async(req) => {
        let courseId = req.query.SELECT.from.ref[1].where[2].val
        const tx = srv.transaction()
        let {Courses} = srv.entities 
        const regCourses = await tx.read(Courses).where({students_studentId: stdId})
        
        if(regCourses.length === 1){                 //For one-to-many, a student at least should have a course
            console.log('Each student should register to a course')
            return
        }

        tx.run([
            DELETE.from(Courses).where({students_studentId: stdId, courseId: courseId}) 
        ])

        tx.commit()

        const regCourses2 = await tx.read(Courses).where({students_studentId: stdId})
            
        return regCourses2
    });
};
1