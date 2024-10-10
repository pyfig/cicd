#!/bin/bash

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

echo "======START INTEGRATION TESTING====="
func_cat_output -b
func_cat_output -e
func_cat_output -n
func_cat_output -s
func_cat_output -t
echo "=====END====="
