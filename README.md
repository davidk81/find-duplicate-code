# find-duplicate-code

Finds duplicated code by first matching identical filenames, then for the set of matching files, script runs `pwd cpd` to check for minimum number of matching tokens

`filetype='*.java'` is hardcoded in `find-duplicate-code.sh`, be sure to change this

setup (mac):
```
brew install pwd
```

usage:
```
./find-duplicate-code.sh path-to-src | tee output.txt
```

sample output (stdout & stderr)
```
comparing files (pmd cpd -minimum-tokens 50):
./proj1/src/main/java/org.hello/returncode/OrderServiceApplication.java
./proj2/src/main/java/org.hello/returncode/OrderServiceApplication.java
./proj3/src/main/java/org.hello/returncode/OrderServiceApplication.java

matches: (filename       tokens          fullpath)

OrderServiceApplication.java       235     /Users/user1/git/proj1/src/main/java/org.hello/returncode/OrderServiceApplication.java
OrderServiceApplication.java       235     /Users/user1/git/proj2/src/main/java/org.hello/returncode/OrderServiceApplication.java
```

sample output (stdout only)
```
OrderServiceApplication.java       235     /Users/user1/git/proj1/src/main/java/org.hello/returncode/OrderServiceApplication.java
OrderServiceApplication.java       235     /Users/user1/git/proj2/src/main/java/org.hello/returncode/OrderServiceApplication.java
```