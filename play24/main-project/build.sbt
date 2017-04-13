name := """main-project"""

version := "1.0-SNAPSHOT"

lazy val root = (project in file("."))
  .enablePlugins(PlayJava)

libraryDependencies += "org.abariev" % "jar-dependency" % "1.0.0-beta7-SNAPSHOT"

resolvers += "Local Maven Repository" at "file://"+Path.userHome.absolutePath+"/.m2/repository"

scalaVersion := "2.11.8"

routesGenerator := InjectedRoutesGenerator
