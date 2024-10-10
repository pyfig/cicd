# !/bin/bash

gcc -Wall -Werror -Wextra s21_cat.c -o s21_cat

filename=text.txt

func_cat_output(){
    cat_args="$*"
    cat $cat_args $filename > cat_output
    ./s21_cat $cat_args $filename > s21_cat_output
    
    if cmp -s cat_output s21_cat_output; then
        cmp_output="are identical"
    fi
    
    rm cat_output s21_cat_output
    
    echo "Flag $cat_args"

    if [[ $cmp_output == "are identical" ]]; then
        echo "PASS"
    else
        echo "FAIL"
        echo "cat $cat_args"
    fi

    cmp_output=" "
}

echo "======START TESTING====="
echo "======TESTING FIRST====="

func_cat_output -b

echo "======TESTING SECOND====="

func_cat_output -e

echo "======TESTING THIRD====="

func_cat_output -n

echo "======TESTING 4========="

func_cat_output -s

echo "======TESTING 5========="

func_cat_output -t

echo "=====END====="
