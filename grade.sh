CPATH='.:../lib/hamcrest-core-1.3.jar:../lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

if [[ -f student-submission/ListExamples.java ]]
then 
 echo 'The file is in the directory'
else 
 echo 'The file does not exist'
 exit 
fi 
cp -r *.java grading-area
cp -r student-submission/*.java grading-area

cd grading-area
javac -cp $CPATH *.java

if [[ $? > 0 ]]
then 
    echo 'compile failed'
    exit 
else 
    echo 'compile success'
fi

java -cp $CPATH org.junit.runner.JUnitCore TestListExamples.java > output.txt

result=$(grep -ci 'OK' output.txt)
fails=$(grep -ci 'caused by' output.txt)

if [[ $result > 0 ]]
then
    echo 'test success'
    exit
else
    echo 'test failed'
fi

echo $fails






# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
