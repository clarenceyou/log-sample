package main

import (
	"errors"
	"log"
	"time"

	"github.com/yougroupteam/go-toolbox/util/logutil"
)

func main() {

	logutil.Config()

	count := 1

	err := errors.New("Some application error")

	for {
		log.Printf("[DEBUG] Received GpsTransaction with key: %d", count)
		log.Printf("[INFO] Received GpsTransaction with key: %d", count)
		log.Printf("[WARN] Received GpsTransaction with key: %d", count)
		log.Printf("[ERROR] Received GpsTransaction with key: %d, err: %s", count, err)
		log.Printf("[ERRORALERT] Received GpsTransaction with key: %d, err: %s", count, err)
		log.Printf("Not an error with key: %d", count)
		log.Printf("Received GpsTransaction with key: %d", count)
		count++
		time.Sleep(10 * time.Second)
	}

}
