# Define variables for the build
FLUTTER = flutter
WEB_PORT = 59201
REPO = read_me_when
WEB_TARGET = ./lib/main_dev.dart

 
build-web:
	$(FLUTTER) build web --target=$(WEB_TARGET)  --release  --web-renderer html

 
run-dev:
	$(FLUTTER) run -d web-server --web-port=$(WEB_PORT)  -t ./lib/main_dev.dart

clean:
	@echo "Clean ..."
	flutter clean
	@echo "Clean Done ..."
	flutter pub get
	
build:
	@echo "Building ..."
	flutter build web --release --base-href /$(REPO)/ -t ./lib/main_prod.dart
	@echo "Building Done..."


deploy: clean build
	@echo "Deploying the project..."

	cd build/web && \
	\
	git init && \
	\
	git status && \
	\
	git remote add origin https://github.com/yeasin50/$(REPO).git && \
	\
	git checkout -b gh-pages && \
	\
	git add --all && \
	git commit -m "update" && \
	\
	git push origin gh-pages -f

	@echo "Deployment complete."
	
	
	cd .. 
	cd ..
	@echo "Back to the root dir"