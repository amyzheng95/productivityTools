#!/bin/bash

# Function to check if the screensaver is active
is_screensaver_active() {
    ps ax | grep [S]creenSaverEngine > /dev/null
}

# Function to activate the screensaver
activate_screensaver() {
    open -a ScreenSaverEngine
}

# Countdown duration in seconds (20 minutes)
countdown_duration=$((20 * 60))
countdown_timer=$countdown_duration

# Initialize session count
session_count=0

clear

while true; do
    # Check if the screensaver is active
    if is_screensaver_active; then
        # If screensaver is active, reset countdown
        countdown_timer=$countdown_duration
    else
        # If screensaver is not active, decrement countdown timer
        ((countdown_timer--))

        # Check if countdown has reached zero
        if [ $countdown_timer -le 0 ]; then
            # Activate screensaver
            activate_screensaver
            # Increment session count
            ((session_count++))
            # Reset countdown
            countdown_timer=$countdown_duration
        fi
    fi

    # Display the countdown and session count in the terminal
    echo -ne "\rTime remaining: $((countdown_timer / 60)):$((countdown_timer % 60)) | Sessions completed: $session_count"

    # Sleep for 1 second before checking again
    sleep 1
done
