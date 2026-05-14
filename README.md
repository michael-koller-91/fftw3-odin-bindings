# Odin Bindings for the Fastest Fourier Transform in the West [FFTW3](https://fftw.org/)

Bindings for single precision (`float`, `f32`, `fftwf_`) and double precision (`double`, `f64`, `fftw_`) FFTW3 functions.

No bindings for long double (`fftwl_`) functions.

## License

This repository is under [MIT license](./LICENSE). FFTW3 have their own license, see [their website](https://fftw.org/).

## Quick Start

### Get Odin
```console
make download-odin
```
Make `odin` available, e.g., by adding it to PATH.

### Compile [fftw3.odin](./fftw3/fftw3.odin)
```console
make fftw3
```

### Run Tests
```console
make test
```

# Examples

Take a look at the [tests](./tests/tests.odin) for more example usage.

```go
import fftw3 "./fftw3"

// DFT length
n: i32 = 10

// complex input
buf_x := make([^]fftw3.fftw_complex, n)
defer free(buf_x)

// complex result of forward transform
buf_x_forward := make([^]fftw3.fftw_complex, n)
defer free(buf_x_forward)

// initialize complex input
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
defer fftw3.fftw_destroy_plan(plan)

// execute the forward transform
fftw3.fftw_execute_dft(plan, buf_x, buf_x_forward)
```

# How [fftw3.odin](./fftw3/fftw3.odin) was Created

1. generate [fftw3.odin](./fftw3/fftw3.odin) using the [Odin Bindings Generator for C Libraries](https://github.com/karl-zylinski/odin-c-bindgen)
1. add `FILE :: c.FILE`
1. add `foreign import lib "system:fftw3"` with `@(extra_linker_flags = "-lfftw3_threads -lfftw3 -lm -pthread")`; same for the single precision version
1. convert flags like `FFTW_MEASURE` to enum `Flags.MEASURE` and replace `flags: u32` with `flags: Flags` in signatures
1. convert `FFTW_FORWARD` and `FFTW_BACKWARD` to enum `Sign.FORWARD` and `Sign.BACKWARD` and replace `sign: i32` with `sign: Sign` in signatures

