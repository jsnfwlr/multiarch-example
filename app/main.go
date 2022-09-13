package main

import (
    "fmt"
    "io"
    "log"
    "os"
    "runtime"
)

func main() {
    f, err := os.Open("/app/msg")
    if err != nil {
	log.Fatalf("unable to read file: %v", err)
    }
    defer f.Close()
    buf := make([]byte, 1024)
    for {
	n, err := f.Read(buf)
	if err == io.EOF {
	    break
	}
	if err != nil {
	    fmt.Println(err)
	    continue
	}
	if n > 0 {
	    fmt.Print(string(buf[:n]))
	}
    }
    fmt.Printf("Running on %s/%s\n", runtime.GOOS, runtime.GOARCH)
}
