package logutil

import (
	"log"
	"os"

	"github.com/hashicorp/logutils"
)

// Config log package
func Config() {
	filter := &logutils.LevelFilter{
		Levels:   []logutils.LogLevel{"DEBUG", "INFO", "WARN", "ERROR", "ERRORALERT"},
		MinLevel: logutils.LogLevel("INFO"),
		Writer:   os.Stderr,
	}
	log.SetOutput(filter)
}
