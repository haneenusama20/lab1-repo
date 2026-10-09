DIR=dir
MALICIOUS_DIR=malicious_dir
INTERVAL_SECS=7

setup:
	mkdir -p $(MALICIOUS_DIR)

antivirus: setup
	./antivirusd.sh $(DIR) $(MALICIOUS_DIR) $(INTERVAL_SECS)

restore: setup
	./restore.sh $(DIR) $(MALICIOUS_DIR)
