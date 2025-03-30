#!/bin/bash

# Function to implement Round Robin Scheduling
round_robin() {
    local n=$1           # Number of processes
    local quantum=$2     # Time quantum

    local remaining_time=()  # Array to store remaining burst times
    local waiting_time=0
    local total_waiting_time=0
    local total_turnaround_time=0

    # Initialize remaining times
    for ((i = 0; i < n; i++)); do
        remaining_time[$i]=${burst_times[$i]}
    done

    local time=0  # Current time

    echo -e "\nProcess Execution Order (Round Robin):"

    while :; do
        done_flag=1  # Indicates whether all processes are done

        # Traverse all processes
        for ((i = 0; i < n; i++)); do
            if [ ${remaining_time[$i]} -gt 0 ]; then
                done_flag=0  # At least one process is not done

                if [ ${remaining_time[$i]} -gt $quantum ]; then
                    # Process executes for the time quantum
                    time=$((time + quantum))
                    remaining_time[$i]=$((remaining_time[$i] - quantum))
                    echo "Process $((i + 1)) executed for $quantum time units."
                else
                    # Process completes execution in less than the time quantum
                    time=$((time + ${remaining_time[$i]}))
                    waiting_time=$((time - ${burst_times[$i]}))
                    total_waiting_time=$((total_waiting_time + waiting_time))
                    total_turnaround_time=$((total_turnaround_time + time))
                    remaining_time[$i]=0
                    echo "Process $((i + 1)) completed at time $time."
                fi
            fi
        done

        # Break if all processes are done
        if [ $done_flag -eq 1 ]; then
            break
        fi
    done

    # Calculate and display average waiting and turnaround times
    echo -e "\nAverage Waiting Time: $(echo "scale=2; $total_waiting_time / $n" | bc)"
    echo "Average Turnaround Time: $(echo "scale=2; $total_turnaround_time / $n" | bc)"
}

# Input: Number of processes, burst times, and quantum time
echo "Enter the number of processes:"
read num_processes

declare -a burst_times

# Taking input for burst times of each process
for ((i = 0; i < num_processes; i++)); do
    echo "Enter burst time for process $((i + 1)): "
    read burst_time
    burst_times[$i]=$burst_time
done

echo "Enter time quantum:"
read quantum

# Call the Round Robin Scheduling function
round_robin $num_processes $quantum

