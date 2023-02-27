using RegisterService as service from '../../srv/register';

annotate RegisterService.Students with @(
    UI: {
        SelectionFields  : [],
        LineItem  : [
            {Value:studentName,
                Label : 'Student Name'},
            {Value:studentId,
                Label : 'Student Number'}
        ],
        /* HeaderInfo  : {
            $Type : 'UI.HeaderInfoType',
            TypeName : 'Students',
            TypeNamePlural : 'Students',
            Title : {
                $Type : 'UI.DataField',
                Value : studentName,
            },
        }, */
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

annotate service.Courses with @(
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
        }]
);
/* annotate service.Courses with @(
    UI.LineItem #Course : [
    ]
); */
annotate service.Students with @(
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
annotate service.Students with {
    studentName @UI.MultiLineText : true
};

annotate service.Courses with @(
    UI.PresentationVariant #Courses : {
        $Type : 'UI.PresentationVariantType',
        Visualizations : [
            '@UI.LineItem#Courses',
        ],
    }
);
annotate service.Students with @(
    UI.SelectionPresentationVariant #tableView : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem',
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
        Text : 'Table View',
    },
    UI.LineItem #tableView : [
    ],
    UI.SelectionPresentationVariant #tableView1 : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem#tableView',
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
        Text : 'Table View 1',
    }
);
