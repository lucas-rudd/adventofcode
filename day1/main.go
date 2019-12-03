package main

import (
	"bufio"
    "os"
	"fmt"
	"math"
	"strconv"
)

func readLines(path string) ([]string, error) {
    file, err := os.Open(path)
    if err != nil {
        return nil, err
    }
    defer file.Close()

    var lines []string
    scanner := bufio.NewScanner(file)
    for scanner.Scan() {
        lines = append(lines, scanner.Text())
    }
    return lines, scanner.Err()
}
func calculateFuel(input int) (fuel int) {
	fuel = int(math.Floor(float64(input/3)) - 2)
	if fuel >= 0 {
		fuel+=calculateFuel(fuel)
		return 
	} else {
		return 0
	}
}

func main() {
	lines, err := readLines("./day1/input.txt")
    if err != nil {
        fmt.Println("File reading error", err)
        return
	}

	var sum=0
    for _, line := range lines {
		numericLine, err := strconv.Atoi(line)
		if err != nil {
			fmt.Println("Cannot convert to string", line)
		}
		sum += calculateFuel(numericLine)
	}
	fmt.Println("total sum of fuel", sum)
}