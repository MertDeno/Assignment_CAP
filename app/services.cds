using { RegisterService } from '../srv/register';
using from './nttproject/annotations';

annotate RegisterService.Students with @Capabilities.Deletable : false;
annotate RegisterService.Students with @Capabilities.Insertable : false;

annotate RegisterService.Students with @(
    UI: {
        LineItem  : [
            {Value:studentId,
                Label : 'Student Number'},
            {Value:studentName,
                Label : 'Student Name'}
        ],
        HeaderInfo  : {
            $Type : 'UI.HeaderInfoType',
            TypeName : 'Students',
            TypeNamePlural : 'Students',
            Title : {
                $Type : 'UI.DataField',
                Value : studentName,
            },
        },
        Facets  : [
            {
                $Type : 'UI.CollectionFacet',
                Label : 'Registered Courses',
                ID    : 'CourseInfo',
                Facets : [
                    {$Type: 'UI.ReferenceFacet', Target:'@UI.LineItem#courses'},
                    {
                        $Type : 'UI.ReferenceFacet',
                        Label : 'Courses',
                        ID : 'Courses',
                        Target : 'courses/@UI.PresentationVariant#Courses',
                    }
                ]
            }
        ],
    }
);

annotate RegisterService.Courses with @(
    UI.LineItem #Courses : [
        {
            $Type : 'UI.DataField',
            Value : courseId,
            Label : 'Course ID',
        },{
            $Type : 'UI.DataField',
            Value : courseName,
            Label : 'Course Name',
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'RegisterService.EntityContainer/addCourse',
            Label : 'Add',
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'RegisterService.deleteCourse',
            Label : 'Delete',
            Inline : true,
            ![@UI.Importance] : #Medium,
        } 
    ]
);

annotate RegisterService.Courses with @Capabilities.Insertable: true;
annotate RegisterService.Courses with @Capabilities.Deletable: true;


/* annotate service.Courses with @(
    UI.LineItem #Course : [
    ]
); */
annotate RegisterService.Students with @(
    UI.HeaderFacets : [],
    UI.FieldGroup #Form : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : studentName,
                Label : 'studentName',
            },],
    }
);
annotate RegisterService.Students with {
    studentName @UI.MultiLineText : true
};

annotate RegisterService.Courses with @(
    UI.PresentationVariant #Courses : {
        $Type : 'UI.PresentationVariantType',
        Visualizations : [
            '@UI.LineItem#Courses',
        ],
    }
);
