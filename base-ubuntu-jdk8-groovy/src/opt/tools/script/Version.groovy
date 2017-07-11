def description(){'''
prints current version of java & groovy
'''
}

println "  groovy: ${GroovySystem.getVersion()}"
println "  java:   ${System.getProperty("java.version")}"
