
module.exports = (srv) => {
    srv.on('getStudentCourses', async (req) => {
        let stdId = req.data.studentId

        const db = srv.transaction(req)
        let {studentCourse} = srv.entities

        const results = await db.read(studentCourse).where({studentId: stdId})
        return results
    });

    srv.on('addCourse', async(req) => {
        let stdId = req.data.studentId
        let courseId = req.data.courseId
        const db = srv.transaction(req)
        let {studentCourse} = srv.entities

        db.run([
            INSERT.into(studentCourse) .entries({studentId: stdId, courseId: courseId})
        ])
    })
};