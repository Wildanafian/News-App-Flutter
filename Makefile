.PHONY: coverage

coverage:
	flutter test --coverage
	lcov --remove coverage/lcov.info 'lib/**.g.dart' 'lib/**/core/di/*' 'lib/**/interceptor*' -o coverage/lcov.info --ignore-errors unused,unused
	genhtml coverage/lcov.info --output-directory coverage/html
	@echo "FINISHED : Coverage report generated at coverage/html/index.html"
