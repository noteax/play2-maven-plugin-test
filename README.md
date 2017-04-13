# play2-maven-plugin-test
Little investigation on how work hot-reload feature in play2-maven-plugin and sbt-play-plugin. Consists from:
 - jar dependency with class which contains static singleton and holds reference to "hot-reloading" classes
 - main application module with "hot-reloading" play project

Looks like that only classes from main application module loaded by ReloadableClassloader on both maven and sbt.

#### Result: Don't do that on real projects with play, keep everything stateless (if you don't want to ruin hot-reload feature).
