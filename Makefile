fftw3.a: fftw3/fftw3.odin fftw3/utils.odin
	odin build fftw3 -build-mode:lib -out:fftw3/fftw3.a

test: tests/tests.odin fftw3
	odin test tests -define:ODIN_TEST_THREADS=1

test-debug: tests/tests.odin fftw3
	odin test tests -define:ODIN_TEST_THREADS=1 -define:ODIN_TEST_LOG_LEVEL="debug"

download-odin:
	mkdir downloads
	# download and unpack Odin
	wget https://github.com/odin-lang/Odin/releases/download/dev-2026-03/odin-linux-amd64-dev-2026-03.tar.gz
	tar -xf odin-linux-amd64-dev-2026-03.tar.gz
	rm odin-linux-amd64-dev-2026-03.tar.gz
	# move to downloads
	mv odin-linux-amd64-nightly+2026-03-03 downloads
