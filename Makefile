MODEM_IMAGE := firmware-update/NON-HLOS.bin

TIMESTAMP := $(shell strings $(MODEM_IMAGE) | sed -n 's/.*"Time_Stamp": "\([^"]*\)"/\1/p')
VERSION := $(shell echo $(TIMESTAMP) | sed 's/[ :-]*//g')

TARGET := radio-$(VERSION).zip

# Build
# ==========

.PHONY: build
build: $(MODEM_IMAGE) $(TARGET)
	@echo Target: $(TARGET)
	@echo Timestamp: $(TIMESTAMP)

$(TARGET): META-INF RADIO firmware-update
	zip -r9 $@ $^

# Clean
# ==========

.PHONY: clean
clean:
	rm -f *.zip
