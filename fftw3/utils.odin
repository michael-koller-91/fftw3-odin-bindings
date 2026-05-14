/* Convenience functions that are not part of the FFTW3 library. */
package fftw3

import "core:math"

abs_f32 :: proc(x: f32) -> f32 {
	return math.abs(x)
}

abs_fftwf_complex :: proc(x: fftwf_complex) -> f32 {
	return math.abs(complex(x[0], x[1]))
}

abs_fftw_complex :: proc(x: fftw_complex) -> f64 {
	return math.abs(complex(x[0], x[1]))
}

abs :: proc {
	abs_f32,
	abs_fftwf_complex,
	abs_fftw_complex,
}

rescale_f32 :: proc(x: [^]f32, length_x: i32) {
	for i in 0 ..< length_x {
		x[i] /= f32(length_x)
	}
}

rescale_fftwf_complex :: proc(x: [^]fftwf_complex, length_x: i32) {
	for i in 0 ..< length_x {
		x[i][0] /= f32(length_x)
		x[i][1] /= f32(length_x)
	}
}

rescale_fftw_complex :: proc(x: [^]fftw_complex, length_x: i32) {
	for i in 0 ..< length_x {
		x[i][0] /= f64(length_x)
		x[i][1] /= f64(length_x)
	}
}

rescale :: proc {
	rescale_f32,
	rescale_fftwf_complex,
	rescale_fftw_complex,
}
