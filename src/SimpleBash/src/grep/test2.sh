# !/bin/bash

filename=text.txt
secondfile=hi.txt
pattern=hello
filepatterns=templates.txt
pass=0
fail=0


func_grep_output(){
    grep_args="$*"
    grep $grep_args $pattern $filename $secondfile > grep_output
    ./s21_grep $grep_args $pattern $filename $secondfile > s21_grep_output
   
 
    if cmp -s grep_output s21_grep_output; then
        cmp_output="are identical"
    fi
    
    rm grep_output s21_grep_output
    
    echo "Flag $grep_args"

    if [[ $cmp_output == "are identical" ]]; then
        echo "PASS"
        let "pass += 1"
    else
        echo "FAIL"
        let "fail += 1"
        echo "grep $grep_args"
    fi

#    valgrind --tool=memcheck --leak-check=yes  ./s21_grep $grep_args $pattern $filename $secondfile > config.txt 

    cmp_output=" "
}

func_grep_f_output(){
    grep_args="$*"
    grep $grep_args $filepatterns $filename $secondfile > grep_output
    ./s21_grep $grep_args $filepatterns $filename $secondfile > s21_grep_output
    
    if cmp -s grep_output s21_grep_output; then
        cmp_output="are identical"
    fi
    
    rm grep_output s21_grep_output
    
    echo "Flag $grep_args"

    if [[ $cmp_output == "are identical" ]]; then
        echo "PASS"
    else
        echo "FAIL"
        echo "grep $grep_args"
    fi

    cmp_output=" "
}



echo "======START TESTING====="
echo "========PART 2=========="
echo "======TESTING FIRST====="

func_grep_output -e

echo "======TESTING SECOND====="

func_grep_output -i

echo "======TESTING THIRD====="

func_grep_output -v

echo "======TESTING 4========="

func_grep_output -c

echo "======TESTING 5========="

func_grep_output -l

echo "======TESTING 6========="

func_grep_output -n

echo "========PART 3=========="
echo "======TESTING 6========="

func_grep_output -h

echo "======TESTING 6========="

func_grep_output -s

echo "======TESTING 6========="

func_grep_output -o

echo "======TESTING 7========="

func_grep_f_output -f

echo "=====END====="
echo "=====PASS_$pass======FAIL_$fail======"
