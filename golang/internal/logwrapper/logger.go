package logwrapper

import (
	"log"
)

type StandardLogger struct {
	*log.Logger
}

func NewLogger() *StandardLogger {
	baseLogger := log.Default()
	standardLogger := &StandardLogger{baseLogger}
	standardLogger.SetFlags(log.LstdFlags | log.LUTC)
	return standardLogger
}
