#!/bin/bash

echo "Enter the first number"
read num1
echo "Enter the second number"
read num2

echo "You enter Number 1: $num1 and Number 2: $num2"
addition=$((num1 + num2))
substraction=$((num1 - num2))
multiplication=$((num1 * num2))

if [ $num2 -ne 0 ]; then
	division=$((num1 / num2))
else
	division="undefined (division by zero)"
fi

echo "Result"
echo "Addition : $num1 + $num2 = $addition"
echo "Substraction : $num1 - $num2 = $substraction"
echo "Multiplication : $num1 * $num2 = $multiplication"
echo "Division : $num1 / $num2 = $division"
