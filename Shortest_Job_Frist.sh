#!/bin/bash

# Function to simulate SJF scheduling
sjf_scheduling() {
    local n=$1
    shift
    local burst_times=("$@")

    # Sort the burst times in ascending order and keep track of original indices
    local sorted_indices=($(for i in "${!burst_times[@]}"; do echo $i ${burst_times[i]}; done | sort -n -k2,2 | awk '{print $1}'))
    local sorted_burst_times=($(for i in "${sorted_indices[@]}"; do echo ${burst_times[i]}; done))

    local waiting_times=()
    local turnaround_times=()

    waiting_times[0]=0

    # Calculate waiting times
    for (( i=1; i<n; i++ )); do
        waiting_times[i]=$((waiting_times[i-1] + sorted_burst_times[i-1]))
    done

    # Calculate turnaround times
    for (( i=0; i<n; i++ )); do
        turnaround_times[i]=$((waiting_times[i] + sorted_burst_times[i]))
    done

    # Print results
    echo "Process    Burst Time    Waiting Time    Turnaround Time"
    for (( i=0; i<n; i++ )); do
        original_index=${sorted_indices[i]}
        echo "P$original_index           ${sorted_burst_times[i]}               ${waiting_times[i]}                ${turnaround_times[i]}"
    done

    # Calculate average waiting and turnaround times
    local total_waiting_time=0
    local total_turnaround_time=0

    for (( i=0; i<n; i++ )); do
        total_waiting_time=$((total_waiting_time + waiting_times[i]))
        total_turnaround_time=$((total_turnaround_time + turnaround_times[i]))
    done

    local avg_waiting_time=$(echo "scale=2; $total_waiting_time / $n" | bc)
    local avg_turnaround_time=$(echo "scale=2; $total_turnaround_time / $n" | bc)

    echo "Average Waiting Time: $avg_waiting_time"
    echo "Average Turnaround Time: $avg_turnaround_time"
}

# Main script starts here
echo "Enter the number of processes: "
read num_processes

burst_times=()

for (( i=0; i<num_processes; i++ )); do
    echo "Enter the burst time for process P$i: "
    read burst_time
    burst_times+=($burst_time)
done

# Call the SJF scheduling function
sjf_scheduling "$num_processes" "${burst_times[@]}"
