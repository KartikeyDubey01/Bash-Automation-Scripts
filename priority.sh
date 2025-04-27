#!/bin/bash

# Function to implement the Priority Scheduling Algorithm
priority_scheduling() {
    local n=$1   # Number of processes
    local total_waiting_time=0
    local total_turnaround_time=0

    echo -e "\nProcess Execution Order (by Priority):"

    # Sort processes by priority (lower number indicates higher priority)
    for ((i = 0; i < n; i++)); do
        for ((j = i + 1; j < n; j++)); do
            if [ ${priorities[$i]} -gt ${priorities[$j]} ]; then
                # Swap the burst time, priorities, and process IDs
                temp=${priorities[$i]}
                priorities[$i]=${priorities[$j]}
                priorities[$j]=$temp

                temp=${burst_times[$i]}
                burst_times[$i]=${burst_times[$j]}
                burst_times[$j]=$temp

                temp=${process_ids[$i]}
                process_ids[$i]=${process_ids[$j]}
                process_ids[$j]=$temp
            fi
        done
    done

    local waiting_time=0

    # Calculate waiting time and turnaround time for each process
    for ((i = 0; i < n; i++)); do
        turnaround_time=$((waiting_time + ${burst_times[$i]}))
        echo "Process ${process_ids[$i]} executed with priority ${priorities[$i]}."

        total_waiting_time=$((total_waiting_time + waiting_time))
        total_turnaround_time=$((total_turnaround_time + turnaround_time))

        # Update the waiting time for the next process
        waiting_time=$((waiting_time + ${burst_times[$i]}))
    done

    # Calculate and display the average waiting and turnaround time
    echo -e "\nAverage Waiting Time: $(echo "scale=2; $total_waiting_time / $n" | bc)"
    echo "Average Turnaround Time: $(echo "scale=2; $total_turnaround_time / $n" | bc)"
}

# Input: Number of processes, burst times, and their priorities
echo "Enter the number of processes:"
read num_processes

declare -a burst_times
declare -a priorities
declare -a process_ids

# Taking input for burst times and priorities of each process
for ((i = 0; i < num_processes; i++)); do
    echo "Enter burst time for process $((i + 1)): "
    read burst_time
    burst_times[$i]=$burst_time

    echo "Enter priority for process $((i + 1)) (Lower number = Higher priority): "
    read priority
    priorities[$i]=$priority

    process_ids[$i]=$((i + 1))  # Process IDs
done

# Call the Priority Scheduling function
priority_scheduling $num_processes
