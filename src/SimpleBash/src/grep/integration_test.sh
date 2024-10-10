#!/bin/bash

filename=text.txt
secondfile=hi.txt
pattern=hello
filepatterns=templates.txt
pass=0
fail=0

func_grep_output(){
    grep_args="$*"
    grep $grep_args $pattern $filename > grep_output
    ./s21_grep $grep_args $pattern $filename > s21_grep_output
    
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

echo "======START INTEGRATION TESTING====="
func_grep_output -e
func_grep_output -i
func_grep_output -v
func_grep_output -c
func_grep_output -l
func_grep_output -n
func_grep_output -h
func_grep_output -s
func_grep_output -o
func_grep_f_output -f
echo "=====END====="
echo "=====PASS_$pass======FAIL_$fail======"
