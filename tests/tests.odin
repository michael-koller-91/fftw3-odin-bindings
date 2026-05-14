package tests

import fftw3 "../fftw3"
import "core:log"
import "core:testing"


/*
Complex to complex forward DFT transform followed by complex to complex backward transform.
*/
@(test)
fftw_dft_1d :: proc(t: ^testing.T) {
	n: i32 = 10

	buf_x := make([^]fftw3.fftw_complex, n) // complex input
	buf_x_forward := make([^]fftw3.fftw_complex, n) // complex result of forward transform
	buf_x_backward := make([^]fftw3.fftw_complex, n) // complex result of forward transform
	defer {
		free(buf_x)
		free(buf_x_forward)
		free(buf_x_backward)
	}

	for i in 0 ..< n {
		buf_x[i][0] = f64(i) + 0.123 * f64(i)
		buf_x[i][1] = f64(n - i) - 0.456 * f64(n - i)
	}

	// plan a forward transform
	plan := fftw3.fftw_plan_dft_1d(
		n,
		buf_x,
		buf_x_forward,
		fftw3.Sign.FORWARD,
		fftw3.Flags.ESTIMATE,
	)
	log.debug("plan:", string(fftw3.fftw_sprint_plan(plan)))
	defer fftw3.fftw_destroy_plan(plan)

	// execute the forward transform
	fftw3.fftw_execute_dft(plan, buf_x, buf_x_forward)

	// plan a backward transform
	plan = fftw3.fftw_plan_dft_1d(
		n,
		buf_x_forward,
		buf_x_backward,
		fftw3.Sign.BACKWARD,
		fftw3.Flags.ESTIMATE,
	)
	log.debug("plan:", string(fftw3.fftw_sprint_plan(plan)))

	// execute the backward transform
	fftw3.fftw_execute_dft(plan, buf_x_forward, buf_x_backward)

	fftw3.rescale(buf_x_backward, n)

	// check if scaled backward transform is close enough to original input
	for i in 0 ..< n {
		diff := fftw3.abs(buf_x[i] - buf_x_backward[i])
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

/*
Real to complex forward DFT transform followed by complex to real backward transform.
*/
@(test)
fftwf_dft_r2c_1d :: proc(t: ^testing.T) {
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
	defer fftw3.fftwf_destroy_plan(plan_forward)

	// execute the forward transform
	fftw3.fftwf_execute_dft_r2c(plan_forward, buf_x, buf_x_forward)

	// plan a backward transform
	plan_backward := fftw3.fftwf_plan_dft_c2r_1d(
		n,
		buf_x_forward,
		buf_x_backward,
		fftw3.Flags.ESTIMATE,
	)
	log.debug("plan_backward:", string(fftw3.fftwf_sprint_plan(plan_backward)))
	defer fftw3.fftwf_destroy_plan(plan_backward)

	// execute the backward transform
	fftw3.fftwf_execute_dft_c2r(plan_backward, buf_x_forward, buf_x_backward)

	fftw3.rescale(buf_x_backward, n)

	// check if scaled backward transform is close enough to original input
	for i in 0 ..< n {
		diff := fftw3.abs(buf_x[i] - buf_x_backward[i])
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
