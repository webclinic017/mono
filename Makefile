SOURCE := $(shell git rev-parse --show-toplevel)

include $(SOURCE)/tools/make/build.mk
