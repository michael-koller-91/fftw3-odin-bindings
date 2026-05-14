package tests

import fftw3 "../fftw3"
import "core:log"
import "core:math"
import "core:testing"

/*
Real to complex forward DFT transform followed by complex to real backward transform.
*/
@(test)
r2c_1d :: proc(t: ^testing.T) {
	n: i32 = 10
	m := n / 2 + 1

	buf_x := make([^]f32, n) // real input
	buf_x_forward := make([^]fftw3.fftwf_complex, m) // complex result of forward transform
	buf_x_backward := make([^]f32, n) // real result of backward transform
	defer {
		free(buf_x)
		free(buf_x_forward)
		free(buf_x_backward)
	}

	for i in 0 ..< n {
		buf_x[i] = f32(i) + 0.123 * f32(i)
	}

	// plan a forward transform
	plan_forward := fftw3.fftwf_plan_dft_r2c_1d(n, buf_x, buf_x_forward, fftw3.Flags.ESTIMATE)
	log.debug("plan_forward:", string(fftw3.fftwf_sprint_plan(plan_forward)))

	// execute the forward transform
	fftw3.fftwf_execute_dft_r2c(plan_forward, buf_x, buf_x_forward)

	// plan a backward transform
	plan_idft := fftw3.fftwf_plan_dft_c2r_1d(
		n,
		buf_x_forward,
		buf_x_backward,
		fftw3.Flags.ESTIMATE,
	)
	log.debug("plan_idft:", string(fftw3.fftwf_sprint_plan(plan_idft)))

	// execute the backward transform
	fftw3.fftwf_execute_dft_c2r(plan_idft, buf_x_forward, buf_x_backward)

	// scale backward transform
	for i in 0 ..< n {
		buf_x_backward[i] /= f32(n)
	}

	// check if scaled backward transform is close enough to original input
	for i in 0 ..< n {
		diff := math.abs(buf_x[i] - buf_x_backward[i])
		testing.expectf(
			t,
			diff < 1e-6,
			"[i=%v]: %v is not close enough to the expected value %v",
			i,
			buf_x_backward[i],
			buf_x[i],
		)
	}
}
