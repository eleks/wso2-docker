def description(){'''
prints current version of java & groovy
'''
}

System.err.println """
-----------------------------
 groovy: ${GroovySystem.getVersion()}
 java:   ${System.getProperty("java.version")}
-----------------------------
"""
