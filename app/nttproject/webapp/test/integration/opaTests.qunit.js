sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'ntt/register/nttproject/test/integration/FirstJourney',
		'ntt/register/nttproject/test/integration/pages/StudentsList',
		'ntt/register/nttproject/test/integration/pages/StudentsObjectPage'
    ],
    function(JourneyRunner, opaJourney, StudentsList, StudentsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('ntt/register/nttproject') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheStudentsList: StudentsList,
					onTheStudentsObjectPage: StudentsObjectPage
                }
            },
            opaJourney.run
        );
    }
);