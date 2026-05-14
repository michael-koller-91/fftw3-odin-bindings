/* Convenience functions that are not part of the FFTW3 library. */
package fftw3

import "core:math"

abs_f32 :: proc(x: f32) -> f32 {
	return math.abs(x)
}

abs_c64 :: proc(x: [2]f64) -> f64 {
	return math.abs(complex(x[0], x[1]))
}

abs :: proc {
	abs_f32,
	abs_c64,
}
