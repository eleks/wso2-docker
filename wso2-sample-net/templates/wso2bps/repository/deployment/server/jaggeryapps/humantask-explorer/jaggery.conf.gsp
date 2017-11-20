{
    "displayName":"Human Task UI",
    "welcomeFiles":["/controller/loginController.jag"],
    "logLevel": "<%= new Boolean(log4j.DEBUG)?'debug':'info' %>",
    "errorPages": {
        "500": "/error500.html",
        "404": "/error404.html"
    }
    "securityConstraints": [{
        "securityConstraint": {
            "webResourceCollection": {
                "name": "WS-Humantask-Explorer",
                "urlPatterns": [
                    "/controller/*",
                    "/model/*",
                    "/template/*",
                    "/assets/*"
                ],
                "methods": ["GET", "POST", "PUT", "DELETE"]
            },
            "authRoles": ["admin"]
        }
    }],

    "loginConfig": {
        "authMethod": "BASIC"
    },

    "securityRoles": ["admin", "everyone"],

    "urlMappings" : [
                        { "url" : "/login/*"	, "path" : "/controller/loginController.jag"},
                        { "url" : "/auth/*"		, "path" : "/controller/authenticator.jag"},
                        { "url" : "/mytasks/*" 	, "path" : "/controller/myTasksController.jag"},
                        { "url" : "/task/*", "path" : "/controller/taskController.jag"},
                        { "url" : "/claimabletasks/*"	, "path" : "/controller/claimableTasksController.jag"},
                        { "url" : "/notificationlist/*"	, "path" : "/controller/notificationListController.jag"},
                        { "url" : "/search/*"	, "path" : "/controller/searchController.jag"},
                        { "url" : "/taskview/*"	, "path" : "/controller/taskController.jag"},
                        { "url" : "/notificationview/*"	, "path" : "/controller/notificationController.jag"},
                        { "url" : "/action/save/*"	, "path" : "/controller/saveActionController.jag"},
                        { "url" : "/action/complete/*"	, "path" : "/controller/completeActionController.jag"},
                        { "url" : "/action/*"	, "path" : "/controller/actionController.jag"},
                        { "url" : "/update/*"	, "path" : "/controller/updateController.jag"},
                        { "url" : "/logout/*"	, "path" : "/controller/logout.jag"},
                        { "url":"/stats/*", "path":"/controller/statsController.jag"}

                    ]
}
