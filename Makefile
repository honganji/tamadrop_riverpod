clean:
	flutter clean
	flutter pub get

format:
	dart fix --apply
	dart format .
	flutter analyze .

gen:
	dart run build_runner build

gen_all:
	dart run build_runner build -d

logo_gen:
	dart run flutter_launcher_icons:main

run_dev:
	flutter run -t lib/main.dart

.PHONY: clean run_dev format gen gen_all logo_gen run_dev
