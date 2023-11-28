CPATH='.:../lib/hamcrest-core-1.3.jar:../lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission > /dev/null 2>&1
echo 'Finished cloning'

# Check if the correct file is submitted
if [ -e "student-submission/ListExamples.java" ]; then
    echo "Student submitted the correct file."
else
    echo "Incorrect file submitted. Please submit a repository with a file named ListExamples.java."
    exit 1
fi

# Copy the student's code to the grading-area directory
cp "student-submission/ListExamples.java" "grading-area/ListExamples.java"

# Copy the grading tests to the grading-area directory
cp "TestListExamples.java" "grading-area/TestListExamples.java"


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests


# Compile the files

cd grading-area

javac -cp $CPATH *.java 2> error.txt

# Check the exit status of the compilation

if [ $? -eq 0 ]; then
    # Run the JUnit tests
    java -cp "$CPATH" org.junit.runner.JUnitCore TestListExamples > JUNIT_OUTPUT.txt
    #cat JUNIT_OUTPUT.txt

    # Calculate grade 
    
    # Search for the line containing information about passed tests
    #passed_line= `grep "OK" JUNIT_OUTPUT.txt`
    passed_line=$(grep "OK" JUNIT_OUTPUT.txt)

    #Extract the number of passed tests from the line
    if [ -n "$passed_line" ]; then
        grade=$(echo "$passed_line" | grep -oE '[0-9]+')
        echo "Grade : $grade/$grade"
    else 
        num_tests_line=$(grep -oE "Tests run: [0-9]+" JUNIT_OUTPUT.txt)
        numTests=$(echo "$num_tests_line" | grep -oE '[0-9]+')
        num_failed_line=$(grep -oE "Failures: [0-9]+" JUNIT_OUTPUT.txt)
        numFailed=$(echo "$num_tests_line" | grep -oE '[0-9]+')
        numCorrect=$((numTests - numFailed))
        echo "Grade : $numCorrect/$numTests"

    fi
else
    echo "Compilation failed. Please check your code."
    exit 1
fi


