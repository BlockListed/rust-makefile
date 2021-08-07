VERSION=1.0
NAME=rust-makefile
EXEC=rust-exec
PREFIX=$(HOME)/.local

default: build_release

clean:
	@echo "Cleaning build dir"
	@rm -rf target/*
	@echo "Cleaning using cargo"
	@cargo clean
check:
	@echo "Checking $(NAME)"
	@cargo check
build_release:
	@echo "Building release: $(VERSION)"
	@cargo build --release
build_debug:
	@echo "Building debug"
	@cargo build
run:
	@echo "Running debug"
	@cargo run
install_debug: build_debug
	@echo "Installing debug"
	@cp target/debug/$(EXEC) $(PREFIX)/bin
install: build_release
	@echo "Installing release: $(VERSION)"
	@cp target/release/$(EXEC) $(PREFIX)/bin
dist: build_release
	@if [ ! -d ./pkg ]; \
	then \
		mkdir ./pkg; \
	fi

	@if [ -d ./pkg/$(NAME)-$(VERSION) ]; \
	then \
		echo "Current version number already exists! Removing old files!"; \
		rm -rf ./pkg/$(NAME)-$(VERSION); \
	fi

	@mkdir ./pkg/$(NAME)-$(VERSION)

	@cp ./dist-scripts/install.sh ./pkg/$(NAME)-$(VERSION)/

	@sed -i 's#{prefix}#$(PREFIX)#g' ./pkg/$(NAME)-$(VERSION)/install.sh
	@sed -i 's#{version}#$(VERSION)#g' ./pkg/$(NAME)-$(VERSION)/install.sh
	@sed -i 's#{name}#$(NAME)#g' ./pkg/$(NAME)-$(VERSION)/install.sh
	@sed -i 's#{exec}#$(EXEC)#g' ./pkg/$(NAME)-$(VERSION)/install.sh

	@mkdir ./pkg/$(NAME)-$(VERSION)/files
	@cp target/release/$(EXEC) ./pkg/$(NAME)-$(VERSION)/files/
	@strip ./pkg/$(NAME)-$(VERSION)/files/$(EXEC)

	@cp LICENSE ./pkg/$(NAME)-$(VERSION)/

	@cd ./pkg && tar -czf ./$(NAME)-$(VERSION).tar.gz ./$(NAME)-$(VERSION)
	@echo "Cleaning up"
	@rm -rf ./pkg/$(NAME)-$(VERSION)
