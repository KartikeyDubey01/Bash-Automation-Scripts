#!/bin/bash

# Function to check if the system is in a safe state
is_safe() {
    local -n avail=$1
    local -n alloc=$2
    local -n max=$3
    local -n need=$4
    local n=$5  # Number of processes
    local m=$6  # Number of resource types

    local finish=()
    for ((i = 0; i < n; i++)); do
        finish[i]=0
    done

    local work=("${avail[@]}")  # Work vector initialized to available resources
    local safe_sequence=()      # Stores the safe sequence
    local count=0               # Counter to track the number of processes

    while [ $count -lt $n ]; do
        found=false
        for ((p = 0; p < n; p++)); do
            if [ ${finish[$p]} -eq 0 ]; then
                local j
                for ((j = 0; j < m; j++)); do
                    if [ ${need[$p * m + $j]} -gt ${work[$j]} ]; then
                        break
                    fi
                done

                if [ $j -eq $m ]; then
                    # Allocate the resources of the process p to work
                    for ((k = 0; k < m; k++)); do
                        work[$k]=$((work[$k] + alloc[$p * m + $k]))
                    done
                    safe_sequence+=($p)
                    finish[$p]=1
                    found=true
                    count=$((count + 1))
                fi
            fi
        done

        if [ "$found" = false ]; then
            echo "The system is not in a safe state!"
            return 1
        fi
    done

    echo "The system is in a safe state."
    echo "Safe sequence: ${safe_sequence[@]}"
    return 0
}

# Example input
n=5  # Number of processes
m=3  # Number of resource types

# Available resources
available=(3 3 2)

# Allocation matrix (n x m)
allocation=(
    0 1 0
    2 0 0
    3 0 2
    2 1 1
    0 0 2
)

# Maximum matrix (n x m)
max=(
    7 5 3
    3 2 2
    9 0 2
    2 2 2
    4 3 3
)

# Need matrix = Max - Allocation (n x m)
need=()
for ((i = 0; i < n; i++)); do
    for ((j = 0; j < m; j++)); do
        need[$((i * m + j))]=$((max[$((i * m + j))] - allocation[$((i * m + j))]))
    done
done

# Run the safety check
is_safe available allocation max need $n $m
