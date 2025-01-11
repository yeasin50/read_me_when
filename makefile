# Define variables for the build
FLUTTER = flutter
WEB_PORT = 59201
WEB_HOSTNAME = /read_me_when/
WEB_TARGET = ./lib/main_dev.dart


# Default target: Build the Flutter Web app
build:
	$(FLUTTER) build web --target=$(WEB_TARGET)  --release 

run:
	$(FLUTTER) run --target=$(WEB_TARGET) --web-port=$(WEB_PORT) --web-hostname=$(WEB_HOSTNAME)

# Clean the build
clean:
	$(FLUTTER) clean

# Build and serve the app in one step
build-and-serve: build
	$(FLUTTER) serve --target=$(WEB_TARGET) --web-port=$(WEB_PORT) --web-hostname=$(WEB_HOSTNAME)
