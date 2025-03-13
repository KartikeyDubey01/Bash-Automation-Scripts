#!/bin/bash

# Function to display the menu
show_menu() {
    echo "========================="
    echo "    Basic Calculator     "
    echo "========================="
    echo "1. Addition"
    echo "2. Subtraction"
    echo "3. Multiplication"
    echo "4. Division"
    echo "5. Exit"
    echo "========================="
    echo -n "Enter your choice: "
}

# Infinite loop for menu-driven program
while true; do
    show_menu
    read choice
    
    case $choice in
        1)  
            echo -n "Enter first number: "
            read num1
            echo -n "Enter second number: "
            read num2
            result=$((num1 + num2))
            echo "Result: $num1 + $num2 = $result"
            ;;
        2)  
            echo -n "Enter first number: "
            read num1
            echo -n "Enter second number: "
            read num2
            result=$((num1 - num2))
            echo "Result: $num1 - $num2 = $result"
            ;;
        3)  
            echo -n "Enter first number: "
            read num1
            echo -n "Enter second number: "
            read num2
            result=$((num1 * num2))
            echo "Result: $num1 * $num2 = $result"
            ;;
        4)  
            echo -n "Enter first number: "
            read num1
            echo -n "Enter second number: "
            read num2
            if [ "$num2" -eq 0 ]; then
                echo "Error: Division by zero is not allowed!"
            else
                result=$(echo "scale=2; $num1 / $num2" | bc)
                echo "Result: $num1 / $num2 = $result"
            fi
            ;;
        5)  
            echo "Exiting the calculator. Goodbye!"
            exit 0
            ;;
        *)  
            echo "Invalid choice! Please enter a valid option."
            ;;
    esac

    echo "Press Enter to continue..."
    read  # Pause for user
    clear # Clear screen for better readability
done
