.PHONY: bundle clean setup venv


VENV_DIR = .venv
VENV = . $(VENV_DIR)/bin/activate;
TARGET_BIN = out/dotmade
SRC_DIR = dotmade
REQUIREMENTS = requirements.txt


venv: $(VENV_DIR)/bin/activate
$(VENV_DIR)/bin/activate:
	test -d $(VENV_DIR) || python -m venv $(VENV_DIR)


setup: venv $(REQUIREMENTS)
	$(VENV) pip install -U pip wheel setuptools
	$(VENV) pip install -r $(REQUIREMENTS)


_SRC_ASSETS = $(shell find $(SRC_DIR))

bundle: $(TARGET_BIN)
$(TARGET_BIN): $(SRC_DIR) $(_SRC_ASSETS) $(REQUIREMENTS)
	$(MAKE) clean
	mkdir -p build out
	cp -r dotmade build/dotmade
	$(VENV) pip install -r requirements.txt --target build
	$(VENV) python -m zipapp build -p '/usr/bin/env python' -o out/dotmade --main dotmade:main


clean:
	-rm -r build
	-rm -r out
