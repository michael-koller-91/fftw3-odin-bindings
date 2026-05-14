/*
 * Copyright (c) 2003, 2007-14 Matteo Frigo
 * Copyright (c) 2003, 2007-14 Massachusetts Institute of Technology
 *
 * The following statement of license applies *only* to this header file,
 * and *not* to the other files distributed with FFTW or derived therefrom:
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS
 * OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
 * GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/***************************** NOTE TO USERS *********************************
 *
 *                 THIS IS A HEADER FILE, NOT A MANUAL
 *
 *    If you want to know how to use FFTW, please read the manual,
 *    online at http://www.fftw.org/doc/ and also included with FFTW.
 *    For a quick start, see the manual's tutorial section.
 *
 *   (Reading header files to learn how to use a library is a habit
 *    stemming from code lacking a proper manual.  Arguably, it's a
 *    *bad* habit in most cases, because header files can contain
 *    interfaces that are not part of the public, stable API.)
 *
 ****************************************************************************/
package fftw3

import "core:c"

when ODIN_OS == .Windows { /* NOTE: This has not been tested. PR welcome. */
	foreign import lib "fftw3.lib"
} else when ODIN_OS == .Linux {
	@(extra_linker_flags = "-lfftw3f -lm")
	foreign import lib "system:fftw3"
} else { /* NOTE: This has not been tested. PR welcome. */
	foreign import lib "system:fftw3"
}

FILE :: c.FILE

fftw_r2r_kind_do_not_use_me :: enum u32 {
	R2HC    = 0,
	HC2R    = 1,
	DHT     = 2,
	REDFT00 = 3,
	REDFT01 = 4,
	REDFT10 = 5,
	REDFT11 = 6,
	RODFT00 = 7,
	RODFT01 = 8,
	RODFT10 = 9,
	RODFT11 = 10,
}

fftw_iodim_do_not_use_me :: struct {
	n:  i32, /* dimension size */
	is: i32, /* input stride */
	os: i32, /* output stride */
}

fftw_iodim64_do_not_use_me :: struct {
	n:  c.ptrdiff_t, /* dimension size */
	is: c.ptrdiff_t, /* input stride */
	os: c.ptrdiff_t, /* output stride */
}

fftw_write_char_func_do_not_use_me :: proc "c" (_c: i8, _: rawptr)
fftw_read_char_func_do_not_use_me :: proc "c" (_: rawptr) -> i32

/* end of FFTW_DEFINE_API macro */
fftw_complex :: [2]f64
fftw_plan_s :: struct {}

/* end of FFTW_DEFINE_API macro */
fftw_plan :: ^fftw_plan_s

/* end of FFTW_DEFINE_API macro */
fftw_iodim :: fftw_iodim_do_not_use_me

/* end of FFTW_DEFINE_API macro */
fftw_iodim64 :: fftw_iodim64_do_not_use_me

/* end of FFTW_DEFINE_API macro */
fftw_r2r_kind :: fftw_r2r_kind_do_not_use_me

/* end of FFTW_DEFINE_API macro */
fftw_write_char_func :: fftw_write_char_func_do_not_use_me

/* end of FFTW_DEFINE_API macro */
fftw_read_char_func :: fftw_read_char_func_do_not_use_me

@(default_calling_convention = "c")
foreign lib {
	/* end of FFTW_DEFINE_API macro */
	fftw_execute :: proc(p: fftw_plan) ---

	/* end of FFTW_DEFINE_API macro */
	fftw_plan_dft :: proc(rank: i32, n: ^i32, _in: ^fftw_complex, out: ^fftw_complex, sign: i32, flags: Flags) -> fftw_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftw_plan_dft_1d :: proc(n: i32, _in: ^fftw_complex, out: ^fftw_complex, sign: i32, flags: Flags) -> fftw_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftw_plan_dft_2d :: proc(n0: i32, n1: i32, _in: ^fftw_complex, out: ^fftw_complex, sign: i32, flags: Flags) -> fftw_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftw_plan_dft_3d :: proc(n0: i32, n1: i32, n2: i32, _in: ^fftw_complex, out: ^fftw_complex, sign: i32, flags: Flags) -> fftw_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftw_plan_many_dft :: proc(rank: i32, n: ^i32, howmany: i32, _in: ^fftw_complex, inembed: ^i32, istride: i32, idist: i32, out: ^fftw_complex, onembed: ^i32, ostride: i32, odist: i32, sign: i32, flags: Flags) -> fftw_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftw_plan_guru_dft :: proc(rank: i32, dims: ^fftw_iodim, howmany_rank: i32, howmany_dims: ^fftw_iodim, _in: ^fftw_complex, out: ^fftw_complex, sign: i32, flags: Flags) -> fftw_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftw_plan_guru_split_dft :: proc(rank: i32, dims: ^fftw_iodim, howmany_rank: i32, howmany_dims: ^fftw_iodim, ri: ^f64, ii: ^f64, ro: ^f64, io: ^f64, flags: Flags) -> fftw_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftw_plan_guru64_dft :: proc(rank: i32, dims: ^fftw_iodim64, howmany_rank: i32, howmany_dims: ^fftw_iodim64, _in: ^fftw_complex, out: ^fftw_complex, sign: i32, flags: Flags) -> fftw_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftw_plan_guru64_split_dft :: proc(rank: i32, dims: ^fftw_iodim64, howmany_rank: i32, howmany_dims: ^fftw_iodim64, ri: ^f64, ii: ^f64, ro: ^f64, io: ^f64, flags: Flags) -> fftw_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftw_execute_dft :: proc(p: fftw_plan, _in: ^fftw_complex, out: ^fftw_complex) ---

	/* end of FFTW_DEFINE_API macro */
	fftw_execute_split_dft :: proc(p: fftw_plan, ri: ^f64, ii: ^f64, ro: ^f64, io: ^f64) ---

	/* end of FFTW_DEFINE_API macro */
	fftw_plan_many_dft_r2c :: proc(rank: i32, n: ^i32, howmany: i32, _in: ^f64, inembed: ^i32, istride: i32, idist: i32, out: ^fftw_complex, onembed: ^i32, ostride: i32, odist: i32, flags: Flags) -> fftw_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftw_plan_dft_r2c :: proc(rank: i32, n: ^i32, _in: ^f64, out: ^fftw_complex, flags: Flags) -> fftw_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftw_plan_dft_r2c_1d :: proc(n: i32, _in: ^f64, out: ^fftw_complex, flags: Flags) -> fftw_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftw_plan_dft_r2c_2d :: proc(n0: i32, n1: i32, _in: ^f64, out: ^fftw_complex, flags: Flags) -> fftw_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftw_plan_dft_r2c_3d :: proc(n0: i32, n1: i32, n2: i32, _in: ^f64, out: ^fftw_complex, flags: Flags) -> fftw_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftw_plan_many_dft_c2r :: proc(rank: i32, n: ^i32, howmany: i32, _in: ^fftw_complex, inembed: ^i32, istride: i32, idist: i32, out: ^f64, onembed: ^i32, ostride: i32, odist: i32, flags: Flags) -> fftw_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftw_plan_dft_c2r :: proc(rank: i32, n: ^i32, _in: ^fftw_complex, out: ^f64, flags: Flags) -> fftw_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftw_plan_dft_c2r_1d :: proc(n: i32, _in: ^fftw_complex, out: ^f64, flags: Flags) -> fftw_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftw_plan_dft_c2r_2d :: proc(n0: i32, n1: i32, _in: ^fftw_complex, out: ^f64, flags: Flags) -> fftw_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftw_plan_dft_c2r_3d :: proc(n0: i32, n1: i32, n2: i32, _in: ^fftw_complex, out: ^f64, flags: Flags) -> fftw_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftw_plan_guru_dft_r2c :: proc(rank: i32, dims: ^fftw_iodim, howmany_rank: i32, howmany_dims: ^fftw_iodim, _in: ^f64, out: ^fftw_complex, flags: Flags) -> fftw_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftw_plan_guru_dft_c2r :: proc(rank: i32, dims: ^fftw_iodim, howmany_rank: i32, howmany_dims: ^fftw_iodim, _in: ^fftw_complex, out: ^f64, flags: Flags) -> fftw_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftw_plan_guru_split_dft_r2c :: proc(rank: i32, dims: ^fftw_iodim, howmany_rank: i32, howmany_dims: ^fftw_iodim, _in: ^f64, ro: ^f64, io: ^f64, flags: Flags) -> fftw_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftw_plan_guru_split_dft_c2r :: proc(rank: i32, dims: ^fftw_iodim, howmany_rank: i32, howmany_dims: ^fftw_iodim, ri: ^f64, ii: ^f64, out: ^f64, flags: Flags) -> fftw_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftw_plan_guru64_dft_r2c :: proc(rank: i32, dims: ^fftw_iodim64, howmany_rank: i32, howmany_dims: ^fftw_iodim64, _in: ^f64, out: ^fftw_complex, flags: Flags) -> fftw_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftw_plan_guru64_dft_c2r :: proc(rank: i32, dims: ^fftw_iodim64, howmany_rank: i32, howmany_dims: ^fftw_iodim64, _in: ^fftw_complex, out: ^f64, flags: Flags) -> fftw_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftw_plan_guru64_split_dft_r2c :: proc(rank: i32, dims: ^fftw_iodim64, howmany_rank: i32, howmany_dims: ^fftw_iodim64, _in: ^f64, ro: ^f64, io: ^f64, flags: Flags) -> fftw_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftw_plan_guru64_split_dft_c2r :: proc(rank: i32, dims: ^fftw_iodim64, howmany_rank: i32, howmany_dims: ^fftw_iodim64, ri: ^f64, ii: ^f64, out: ^f64, flags: Flags) -> fftw_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftw_execute_dft_r2c :: proc(p: fftw_plan, _in: ^f64, out: ^fftw_complex) ---

	/* end of FFTW_DEFINE_API macro */
	fftw_execute_dft_c2r :: proc(p: fftw_plan, _in: ^fftw_complex, out: ^f64) ---

	/* end of FFTW_DEFINE_API macro */
	fftw_execute_split_dft_r2c :: proc(p: fftw_plan, _in: ^f64, ro: ^f64, io: ^f64) ---

	/* end of FFTW_DEFINE_API macro */
	fftw_execute_split_dft_c2r :: proc(p: fftw_plan, ri: ^f64, ii: ^f64, out: ^f64) ---

	/* end of FFTW_DEFINE_API macro */
	fftw_plan_many_r2r :: proc(rank: i32, n: ^i32, howmany: i32, _in: ^f64, inembed: ^i32, istride: i32, idist: i32, out: ^f64, onembed: ^i32, ostride: i32, odist: i32, kind: ^fftw_r2r_kind, flags: Flags) -> fftw_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftw_plan_r2r :: proc(rank: i32, n: ^i32, _in: ^f64, out: ^f64, kind: ^fftw_r2r_kind, flags: Flags) -> fftw_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftw_plan_r2r_1d :: proc(n: i32, _in: ^f64, out: ^f64, kind: fftw_r2r_kind, flags: Flags) -> fftw_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftw_plan_r2r_2d :: proc(n0: i32, n1: i32, _in: ^f64, out: ^f64, kind0: fftw_r2r_kind, kind1: fftw_r2r_kind, flags: Flags) -> fftw_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftw_plan_r2r_3d :: proc(n0: i32, n1: i32, n2: i32, _in: ^f64, out: ^f64, kind0: fftw_r2r_kind, kind1: fftw_r2r_kind, kind2: fftw_r2r_kind, flags: Flags) -> fftw_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftw_plan_guru_r2r :: proc(rank: i32, dims: ^fftw_iodim, howmany_rank: i32, howmany_dims: ^fftw_iodim, _in: ^f64, out: ^f64, kind: ^fftw_r2r_kind, flags: Flags) -> fftw_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftw_plan_guru64_r2r :: proc(rank: i32, dims: ^fftw_iodim64, howmany_rank: i32, howmany_dims: ^fftw_iodim64, _in: ^f64, out: ^f64, kind: ^fftw_r2r_kind, flags: Flags) -> fftw_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftw_execute_r2r :: proc(p: fftw_plan, _in: ^f64, out: ^f64) ---

	/* end of FFTW_DEFINE_API macro */
	fftw_destroy_plan :: proc(p: fftw_plan) ---

	/* end of FFTW_DEFINE_API macro */
	fftw_forget_wisdom :: proc() ---

	/* end of FFTW_DEFINE_API macro */
	fftw_cleanup :: proc() ---

	/* end of FFTW_DEFINE_API macro */
	fftw_set_timelimit :: proc(t: f64) ---

	/* end of FFTW_DEFINE_API macro */
	fftw_plan_with_nthreads :: proc(nthreads: i32) ---

	/* end of FFTW_DEFINE_API macro */
	fftw_planner_nthreads :: proc() -> i32 ---

	/* end of FFTW_DEFINE_API macro */
	fftw_init_threads :: proc() -> i32 ---

	/* end of FFTW_DEFINE_API macro */
	fftw_cleanup_threads :: proc() ---

	/* end of FFTW_DEFINE_API macro */
	fftw_threads_set_callback :: proc(parallel_loop: proc "c" (work: proc "c" (_: cstring) -> rawptr, jobdata: cstring, elsize: c.size_t, njobs: i32, data: rawptr), data: rawptr) ---

	/* end of FFTW_DEFINE_API macro */
	fftw_make_planner_thread_safe :: proc() ---

	/* end of FFTW_DEFINE_API macro */
	fftw_export_wisdom_to_filename :: proc(filename: cstring) -> i32 ---

	/* end of FFTW_DEFINE_API macro */
	fftw_export_wisdom_to_file :: proc(output_file: ^FILE) ---

	/* end of FFTW_DEFINE_API macro */
	fftw_export_wisdom_to_string :: proc() -> cstring ---

	/* end of FFTW_DEFINE_API macro */
	fftw_export_wisdom :: proc(write_char: fftw_write_char_func, data: rawptr) ---

	/* end of FFTW_DEFINE_API macro */
	fftw_import_system_wisdom :: proc() -> i32 ---

	/* end of FFTW_DEFINE_API macro */
	fftw_import_wisdom_from_filename :: proc(filename: cstring) -> i32 ---

	/* end of FFTW_DEFINE_API macro */
	fftw_import_wisdom_from_file :: proc(input_file: ^FILE) -> i32 ---

	/* end of FFTW_DEFINE_API macro */
	fftw_import_wisdom_from_string :: proc(input_string: cstring) -> i32 ---

	/* end of FFTW_DEFINE_API macro */
	fftw_import_wisdom :: proc(read_char: fftw_read_char_func, data: rawptr) -> i32 ---

	/* end of FFTW_DEFINE_API macro */
	fftw_fprint_plan :: proc(p: fftw_plan, output_file: ^FILE) ---

	/* end of FFTW_DEFINE_API macro */
	fftw_print_plan :: proc(p: fftw_plan) ---

	/* end of FFTW_DEFINE_API macro */
	fftw_sprint_plan :: proc(p: fftw_plan) -> cstring ---

	/* end of FFTW_DEFINE_API macro */
	fftw_malloc :: proc(n: c.size_t) -> rawptr ---

	/* end of FFTW_DEFINE_API macro */
	fftw_alloc_real :: proc(n: c.size_t) -> ^f64 ---

	/* end of FFTW_DEFINE_API macro */
	fftw_alloc_complex :: proc(n: c.size_t) -> ^fftw_complex ---

	/* end of FFTW_DEFINE_API macro */
	fftw_free :: proc(p: rawptr) ---

	/* end of FFTW_DEFINE_API macro */
	fftw_flops :: proc(p: fftw_plan, add: ^f64, mul: ^f64, fmas: ^f64) ---

	/* end of FFTW_DEFINE_API macro */
	fftw_estimate_cost :: proc(p: fftw_plan) -> f64 ---

	/* end of FFTW_DEFINE_API macro */
	fftw_cost :: proc(p: fftw_plan) -> f64 ---

	/* end of FFTW_DEFINE_API macro */
	fftw_alignment_of :: proc(p: ^f64) -> i32 ---
}

/* end of FFTW_DEFINE_API macro */
fftwf_complex :: [2]f32
fftwf_plan_s :: struct {}

/* end of FFTW_DEFINE_API macro */
fftwf_plan :: ^fftwf_plan_s

/* end of FFTW_DEFINE_API macro */
fftwf_iodim :: fftw_iodim_do_not_use_me

/* end of FFTW_DEFINE_API macro */
fftwf_iodim64 :: fftw_iodim64_do_not_use_me

/* end of FFTW_DEFINE_API macro */
fftwf_r2r_kind :: fftw_r2r_kind_do_not_use_me

/* end of FFTW_DEFINE_API macro */
fftwf_write_char_func :: fftw_write_char_func_do_not_use_me

/* end of FFTW_DEFINE_API macro */
fftwf_read_char_func :: fftw_read_char_func_do_not_use_me

@(default_calling_convention = "c")
foreign lib {
	/* end of FFTW_DEFINE_API macro */
	fftwf_execute :: proc(p: fftwf_plan) ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_plan_dft :: proc(rank: i32, n: ^i32, _in: ^fftwf_complex, out: ^fftwf_complex, sign: i32, flags: Flags) -> fftwf_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_plan_dft_1d :: proc(n: i32, _in: ^fftwf_complex, out: ^fftwf_complex, sign: i32, flags: Flags) -> fftwf_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_plan_dft_2d :: proc(n0: i32, n1: i32, _in: ^fftwf_complex, out: ^fftwf_complex, sign: i32, flags: Flags) -> fftwf_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_plan_dft_3d :: proc(n0: i32, n1: i32, n2: i32, _in: ^fftwf_complex, out: ^fftwf_complex, sign: i32, flags: Flags) -> fftwf_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_plan_many_dft :: proc(rank: i32, n: ^i32, howmany: i32, _in: ^fftwf_complex, inembed: ^i32, istride: i32, idist: i32, out: ^fftwf_complex, onembed: ^i32, ostride: i32, odist: i32, sign: i32, flags: Flags) -> fftwf_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_plan_guru_dft :: proc(rank: i32, dims: ^fftwf_iodim, howmany_rank: i32, howmany_dims: ^fftwf_iodim, _in: ^fftwf_complex, out: ^fftwf_complex, sign: i32, flags: Flags) -> fftwf_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_plan_guru_split_dft :: proc(rank: i32, dims: ^fftwf_iodim, howmany_rank: i32, howmany_dims: ^fftwf_iodim, ri: ^f32, ii: ^f32, ro: ^f32, io: ^f32, flags: Flags) -> fftwf_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_plan_guru64_dft :: proc(rank: i32, dims: ^fftwf_iodim64, howmany_rank: i32, howmany_dims: ^fftwf_iodim64, _in: ^fftwf_complex, out: ^fftwf_complex, sign: i32, flags: Flags) -> fftwf_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_plan_guru64_split_dft :: proc(rank: i32, dims: ^fftwf_iodim64, howmany_rank: i32, howmany_dims: ^fftwf_iodim64, ri: ^f32, ii: ^f32, ro: ^f32, io: ^f32, flags: Flags) -> fftwf_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_execute_dft :: proc(p: fftwf_plan, _in: ^fftwf_complex, out: ^fftwf_complex) ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_execute_split_dft :: proc(p: fftwf_plan, ri: ^f32, ii: ^f32, ro: ^f32, io: ^f32) ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_plan_many_dft_r2c :: proc(rank: i32, n: ^i32, howmany: i32, _in: ^f32, inembed: ^i32, istride: i32, idist: i32, out: ^fftwf_complex, onembed: ^i32, ostride: i32, odist: i32, flags: Flags) -> fftwf_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_plan_dft_r2c :: proc(rank: i32, n: ^i32, _in: ^f32, out: ^fftwf_complex, flags: Flags) -> fftwf_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_plan_dft_r2c_1d :: proc(n: i32, _in: ^f32, out: ^fftwf_complex, flags: Flags) -> fftwf_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_plan_dft_r2c_2d :: proc(n0: i32, n1: i32, _in: ^f32, out: ^fftwf_complex, flags: Flags) -> fftwf_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_plan_dft_r2c_3d :: proc(n0: i32, n1: i32, n2: i32, _in: ^f32, out: ^fftwf_complex, flags: Flags) -> fftwf_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_plan_many_dft_c2r :: proc(rank: i32, n: ^i32, howmany: i32, _in: ^fftwf_complex, inembed: ^i32, istride: i32, idist: i32, out: ^f32, onembed: ^i32, ostride: i32, odist: i32, flags: Flags) -> fftwf_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_plan_dft_c2r :: proc(rank: i32, n: ^i32, _in: ^fftwf_complex, out: ^f32, flags: Flags) -> fftwf_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_plan_dft_c2r_1d :: proc(n: i32, _in: ^fftwf_complex, out: ^f32, flags: Flags) -> fftwf_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_plan_dft_c2r_2d :: proc(n0: i32, n1: i32, _in: ^fftwf_complex, out: ^f32, flags: Flags) -> fftwf_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_plan_dft_c2r_3d :: proc(n0: i32, n1: i32, n2: i32, _in: ^fftwf_complex, out: ^f32, flags: Flags) -> fftwf_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_plan_guru_dft_r2c :: proc(rank: i32, dims: ^fftwf_iodim, howmany_rank: i32, howmany_dims: ^fftwf_iodim, _in: ^f32, out: ^fftwf_complex, flags: Flags) -> fftwf_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_plan_guru_dft_c2r :: proc(rank: i32, dims: ^fftwf_iodim, howmany_rank: i32, howmany_dims: ^fftwf_iodim, _in: ^fftwf_complex, out: ^f32, flags: Flags) -> fftwf_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_plan_guru_split_dft_r2c :: proc(rank: i32, dims: ^fftwf_iodim, howmany_rank: i32, howmany_dims: ^fftwf_iodim, _in: ^f32, ro: ^f32, io: ^f32, flags: Flags) -> fftwf_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_plan_guru_split_dft_c2r :: proc(rank: i32, dims: ^fftwf_iodim, howmany_rank: i32, howmany_dims: ^fftwf_iodim, ri: ^f32, ii: ^f32, out: ^f32, flags: Flags) -> fftwf_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_plan_guru64_dft_r2c :: proc(rank: i32, dims: ^fftwf_iodim64, howmany_rank: i32, howmany_dims: ^fftwf_iodim64, _in: ^f32, out: ^fftwf_complex, flags: Flags) -> fftwf_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_plan_guru64_dft_c2r :: proc(rank: i32, dims: ^fftwf_iodim64, howmany_rank: i32, howmany_dims: ^fftwf_iodim64, _in: ^fftwf_complex, out: ^f32, flags: Flags) -> fftwf_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_plan_guru64_split_dft_r2c :: proc(rank: i32, dims: ^fftwf_iodim64, howmany_rank: i32, howmany_dims: ^fftwf_iodim64, _in: ^f32, ro: ^f32, io: ^f32, flags: Flags) -> fftwf_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_plan_guru64_split_dft_c2r :: proc(rank: i32, dims: ^fftwf_iodim64, howmany_rank: i32, howmany_dims: ^fftwf_iodim64, ri: ^f32, ii: ^f32, out: ^f32, flags: Flags) -> fftwf_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_execute_dft_r2c :: proc(p: fftwf_plan, _in: ^f32, out: ^fftwf_complex) ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_execute_dft_c2r :: proc(p: fftwf_plan, _in: ^fftwf_complex, out: ^f32) ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_execute_split_dft_r2c :: proc(p: fftwf_plan, _in: ^f32, ro: ^f32, io: ^f32) ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_execute_split_dft_c2r :: proc(p: fftwf_plan, ri: ^f32, ii: ^f32, out: ^f32) ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_plan_many_r2r :: proc(rank: i32, n: ^i32, howmany: i32, _in: ^f32, inembed: ^i32, istride: i32, idist: i32, out: ^f32, onembed: ^i32, ostride: i32, odist: i32, kind: ^fftwf_r2r_kind, flags: Flags) -> fftwf_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_plan_r2r :: proc(rank: i32, n: ^i32, _in: ^f32, out: ^f32, kind: ^fftwf_r2r_kind, flags: Flags) -> fftwf_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_plan_r2r_1d :: proc(n: i32, _in: ^f32, out: ^f32, kind: fftwf_r2r_kind, flags: Flags) -> fftwf_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_plan_r2r_2d :: proc(n0: i32, n1: i32, _in: ^f32, out: ^f32, kind0: fftwf_r2r_kind, kind1: fftwf_r2r_kind, flags: Flags) -> fftwf_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_plan_r2r_3d :: proc(n0: i32, n1: i32, n2: i32, _in: ^f32, out: ^f32, kind0: fftwf_r2r_kind, kind1: fftwf_r2r_kind, kind2: fftwf_r2r_kind, flags: Flags) -> fftwf_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_plan_guru_r2r :: proc(rank: i32, dims: ^fftwf_iodim, howmany_rank: i32, howmany_dims: ^fftwf_iodim, _in: ^f32, out: ^f32, kind: ^fftwf_r2r_kind, flags: Flags) -> fftwf_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_plan_guru64_r2r :: proc(rank: i32, dims: ^fftwf_iodim64, howmany_rank: i32, howmany_dims: ^fftwf_iodim64, _in: ^f32, out: ^f32, kind: ^fftwf_r2r_kind, flags: Flags) -> fftwf_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_execute_r2r :: proc(p: fftwf_plan, _in: ^f32, out: ^f32) ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_destroy_plan :: proc(p: fftwf_plan) ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_forget_wisdom :: proc() ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_cleanup :: proc() ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_set_timelimit :: proc(t: f64) ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_plan_with_nthreads :: proc(nthreads: i32) ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_planner_nthreads :: proc() -> i32 ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_init_threads :: proc() -> i32 ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_cleanup_threads :: proc() ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_threads_set_callback :: proc(parallel_loop: proc "c" (work: proc "c" (_: cstring) -> rawptr, jobdata: cstring, elsize: c.size_t, njobs: i32, data: rawptr), data: rawptr) ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_make_planner_thread_safe :: proc() ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_export_wisdom_to_filename :: proc(filename: cstring) -> i32 ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_export_wisdom_to_file :: proc(output_file: ^FILE) ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_export_wisdom_to_string :: proc() -> cstring ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_export_wisdom :: proc(write_char: fftwf_write_char_func, data: rawptr) ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_import_system_wisdom :: proc() -> i32 ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_import_wisdom_from_filename :: proc(filename: cstring) -> i32 ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_import_wisdom_from_file :: proc(input_file: ^FILE) -> i32 ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_import_wisdom_from_string :: proc(input_string: cstring) -> i32 ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_import_wisdom :: proc(read_char: fftwf_read_char_func, data: rawptr) -> i32 ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_fprint_plan :: proc(p: fftwf_plan, output_file: ^FILE) ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_print_plan :: proc(p: fftwf_plan) ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_sprint_plan :: proc(p: fftwf_plan) -> cstring ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_malloc :: proc(n: c.size_t) -> rawptr ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_alloc_real :: proc(n: c.size_t) -> ^f32 ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_alloc_complex :: proc(n: c.size_t) -> ^fftwf_complex ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_free :: proc(p: rawptr) ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_flops :: proc(p: fftwf_plan, add: ^f64, mul: ^f64, fmas: ^f64) ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_estimate_cost :: proc(p: fftwf_plan) -> f64 ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_cost :: proc(p: fftwf_plan) -> f64 ---

	/* end of FFTW_DEFINE_API macro */
	fftwf_alignment_of :: proc(p: ^f32) -> i32 ---
}

/* end of FFTW_DEFINE_API macro */
fftwl_complex :: [2]f64
fftwl_plan_s :: struct {}

/* end of FFTW_DEFINE_API macro */
fftwl_plan :: ^fftwl_plan_s

/* end of FFTW_DEFINE_API macro */
fftwl_iodim :: fftw_iodim_do_not_use_me

/* end of FFTW_DEFINE_API macro */
fftwl_iodim64 :: fftw_iodim64_do_not_use_me

/* end of FFTW_DEFINE_API macro */
fftwl_r2r_kind :: fftw_r2r_kind_do_not_use_me

/* end of FFTW_DEFINE_API macro */
fftwl_write_char_func :: fftw_write_char_func_do_not_use_me

/* end of FFTW_DEFINE_API macro */
fftwl_read_char_func :: fftw_read_char_func_do_not_use_me

@(default_calling_convention = "c")
foreign lib {
	/* end of FFTW_DEFINE_API macro */
	fftwl_execute :: proc(p: fftwl_plan) ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_plan_dft :: proc(rank: i32, n: ^i32, _in: ^fftwl_complex, out: ^fftwl_complex, sign: i32, flags: Flags) -> fftwl_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_plan_dft_1d :: proc(n: i32, _in: ^fftwl_complex, out: ^fftwl_complex, sign: i32, flags: Flags) -> fftwl_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_plan_dft_2d :: proc(n0: i32, n1: i32, _in: ^fftwl_complex, out: ^fftwl_complex, sign: i32, flags: Flags) -> fftwl_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_plan_dft_3d :: proc(n0: i32, n1: i32, n2: i32, _in: ^fftwl_complex, out: ^fftwl_complex, sign: i32, flags: Flags) -> fftwl_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_plan_many_dft :: proc(rank: i32, n: ^i32, howmany: i32, _in: ^fftwl_complex, inembed: ^i32, istride: i32, idist: i32, out: ^fftwl_complex, onembed: ^i32, ostride: i32, odist: i32, sign: i32, flags: Flags) -> fftwl_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_plan_guru_dft :: proc(rank: i32, dims: ^fftwl_iodim, howmany_rank: i32, howmany_dims: ^fftwl_iodim, _in: ^fftwl_complex, out: ^fftwl_complex, sign: i32, flags: Flags) -> fftwl_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_plan_guru_split_dft :: proc(rank: i32, dims: ^fftwl_iodim, howmany_rank: i32, howmany_dims: ^fftwl_iodim, ri: ^f64, ii: ^f64, ro: ^f64, io: ^f64, flags: Flags) -> fftwl_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_plan_guru64_dft :: proc(rank: i32, dims: ^fftwl_iodim64, howmany_rank: i32, howmany_dims: ^fftwl_iodim64, _in: ^fftwl_complex, out: ^fftwl_complex, sign: i32, flags: Flags) -> fftwl_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_plan_guru64_split_dft :: proc(rank: i32, dims: ^fftwl_iodim64, howmany_rank: i32, howmany_dims: ^fftwl_iodim64, ri: ^f64, ii: ^f64, ro: ^f64, io: ^f64, flags: Flags) -> fftwl_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_execute_dft :: proc(p: fftwl_plan, _in: ^fftwl_complex, out: ^fftwl_complex) ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_execute_split_dft :: proc(p: fftwl_plan, ri: ^f64, ii: ^f64, ro: ^f64, io: ^f64) ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_plan_many_dft_r2c :: proc(rank: i32, n: ^i32, howmany: i32, _in: ^f64, inembed: ^i32, istride: i32, idist: i32, out: ^fftwl_complex, onembed: ^i32, ostride: i32, odist: i32, flags: Flags) -> fftwl_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_plan_dft_r2c :: proc(rank: i32, n: ^i32, _in: ^f64, out: ^fftwl_complex, flags: Flags) -> fftwl_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_plan_dft_r2c_1d :: proc(n: i32, _in: ^f64, out: ^fftwl_complex, flags: Flags) -> fftwl_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_plan_dft_r2c_2d :: proc(n0: i32, n1: i32, _in: ^f64, out: ^fftwl_complex, flags: Flags) -> fftwl_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_plan_dft_r2c_3d :: proc(n0: i32, n1: i32, n2: i32, _in: ^f64, out: ^fftwl_complex, flags: Flags) -> fftwl_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_plan_many_dft_c2r :: proc(rank: i32, n: ^i32, howmany: i32, _in: ^fftwl_complex, inembed: ^i32, istride: i32, idist: i32, out: ^f64, onembed: ^i32, ostride: i32, odist: i32, flags: Flags) -> fftwl_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_plan_dft_c2r :: proc(rank: i32, n: ^i32, _in: ^fftwl_complex, out: ^f64, flags: Flags) -> fftwl_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_plan_dft_c2r_1d :: proc(n: i32, _in: ^fftwl_complex, out: ^f64, flags: Flags) -> fftwl_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_plan_dft_c2r_2d :: proc(n0: i32, n1: i32, _in: ^fftwl_complex, out: ^f64, flags: Flags) -> fftwl_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_plan_dft_c2r_3d :: proc(n0: i32, n1: i32, n2: i32, _in: ^fftwl_complex, out: ^f64, flags: Flags) -> fftwl_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_plan_guru_dft_r2c :: proc(rank: i32, dims: ^fftwl_iodim, howmany_rank: i32, howmany_dims: ^fftwl_iodim, _in: ^f64, out: ^fftwl_complex, flags: Flags) -> fftwl_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_plan_guru_dft_c2r :: proc(rank: i32, dims: ^fftwl_iodim, howmany_rank: i32, howmany_dims: ^fftwl_iodim, _in: ^fftwl_complex, out: ^f64, flags: Flags) -> fftwl_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_plan_guru_split_dft_r2c :: proc(rank: i32, dims: ^fftwl_iodim, howmany_rank: i32, howmany_dims: ^fftwl_iodim, _in: ^f64, ro: ^f64, io: ^f64, flags: Flags) -> fftwl_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_plan_guru_split_dft_c2r :: proc(rank: i32, dims: ^fftwl_iodim, howmany_rank: i32, howmany_dims: ^fftwl_iodim, ri: ^f64, ii: ^f64, out: ^f64, flags: Flags) -> fftwl_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_plan_guru64_dft_r2c :: proc(rank: i32, dims: ^fftwl_iodim64, howmany_rank: i32, howmany_dims: ^fftwl_iodim64, _in: ^f64, out: ^fftwl_complex, flags: Flags) -> fftwl_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_plan_guru64_dft_c2r :: proc(rank: i32, dims: ^fftwl_iodim64, howmany_rank: i32, howmany_dims: ^fftwl_iodim64, _in: ^fftwl_complex, out: ^f64, flags: Flags) -> fftwl_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_plan_guru64_split_dft_r2c :: proc(rank: i32, dims: ^fftwl_iodim64, howmany_rank: i32, howmany_dims: ^fftwl_iodim64, _in: ^f64, ro: ^f64, io: ^f64, flags: Flags) -> fftwl_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_plan_guru64_split_dft_c2r :: proc(rank: i32, dims: ^fftwl_iodim64, howmany_rank: i32, howmany_dims: ^fftwl_iodim64, ri: ^f64, ii: ^f64, out: ^f64, flags: Flags) -> fftwl_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_execute_dft_r2c :: proc(p: fftwl_plan, _in: ^f64, out: ^fftwl_complex) ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_execute_dft_c2r :: proc(p: fftwl_plan, _in: ^fftwl_complex, out: ^f64) ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_execute_split_dft_r2c :: proc(p: fftwl_plan, _in: ^f64, ro: ^f64, io: ^f64) ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_execute_split_dft_c2r :: proc(p: fftwl_plan, ri: ^f64, ii: ^f64, out: ^f64) ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_plan_many_r2r :: proc(rank: i32, n: ^i32, howmany: i32, _in: ^f64, inembed: ^i32, istride: i32, idist: i32, out: ^f64, onembed: ^i32, ostride: i32, odist: i32, kind: ^fftwl_r2r_kind, flags: Flags) -> fftwl_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_plan_r2r :: proc(rank: i32, n: ^i32, _in: ^f64, out: ^f64, kind: ^fftwl_r2r_kind, flags: Flags) -> fftwl_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_plan_r2r_1d :: proc(n: i32, _in: ^f64, out: ^f64, kind: fftwl_r2r_kind, flags: Flags) -> fftwl_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_plan_r2r_2d :: proc(n0: i32, n1: i32, _in: ^f64, out: ^f64, kind0: fftwl_r2r_kind, kind1: fftwl_r2r_kind, flags: Flags) -> fftwl_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_plan_r2r_3d :: proc(n0: i32, n1: i32, n2: i32, _in: ^f64, out: ^f64, kind0: fftwl_r2r_kind, kind1: fftwl_r2r_kind, kind2: fftwl_r2r_kind, flags: Flags) -> fftwl_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_plan_guru_r2r :: proc(rank: i32, dims: ^fftwl_iodim, howmany_rank: i32, howmany_dims: ^fftwl_iodim, _in: ^f64, out: ^f64, kind: ^fftwl_r2r_kind, flags: Flags) -> fftwl_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_plan_guru64_r2r :: proc(rank: i32, dims: ^fftwl_iodim64, howmany_rank: i32, howmany_dims: ^fftwl_iodim64, _in: ^f64, out: ^f64, kind: ^fftwl_r2r_kind, flags: Flags) -> fftwl_plan ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_execute_r2r :: proc(p: fftwl_plan, _in: ^f64, out: ^f64) ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_destroy_plan :: proc(p: fftwl_plan) ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_forget_wisdom :: proc() ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_cleanup :: proc() ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_set_timelimit :: proc(t: f64) ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_plan_with_nthreads :: proc(nthreads: i32) ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_planner_nthreads :: proc() -> i32 ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_init_threads :: proc() -> i32 ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_cleanup_threads :: proc() ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_threads_set_callback :: proc(parallel_loop: proc "c" (work: proc "c" (_: cstring) -> rawptr, jobdata: cstring, elsize: c.size_t, njobs: i32, data: rawptr), data: rawptr) ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_make_planner_thread_safe :: proc() ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_export_wisdom_to_filename :: proc(filename: cstring) -> i32 ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_export_wisdom_to_file :: proc(output_file: ^FILE) ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_export_wisdom_to_string :: proc() -> cstring ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_export_wisdom :: proc(write_char: fftwl_write_char_func, data: rawptr) ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_import_system_wisdom :: proc() -> i32 ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_import_wisdom_from_filename :: proc(filename: cstring) -> i32 ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_import_wisdom_from_file :: proc(input_file: ^FILE) -> i32 ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_import_wisdom_from_string :: proc(input_string: cstring) -> i32 ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_import_wisdom :: proc(read_char: fftwl_read_char_func, data: rawptr) -> i32 ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_fprint_plan :: proc(p: fftwl_plan, output_file: ^FILE) ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_print_plan :: proc(p: fftwl_plan) ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_sprint_plan :: proc(p: fftwl_plan) -> cstring ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_malloc :: proc(n: c.size_t) -> rawptr ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_alloc_real :: proc(n: c.size_t) -> ^f64 ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_alloc_complex :: proc(n: c.size_t) -> ^fftwl_complex ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_free :: proc(p: rawptr) ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_flops :: proc(p: fftwl_plan, add: ^f64, mul: ^f64, fmas: ^f64) ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_estimate_cost :: proc(p: fftwl_plan) -> f64 ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_cost :: proc(p: fftwl_plan) -> f64 ---

	/* end of FFTW_DEFINE_API macro */
	fftwl_alignment_of :: proc(p: ^f64) -> i32 ---
}

Sign :: enum i32 {
	FORWARD  = -1,
	BACKWARD = +1,
}

FFTW_NO_TIMELIMIT :: (-1.0)

/* documented flags */
Flags :: enum u32 {
	MEASURE         = 0,
	DESTROY_INPUT   = (1 << 0),
	UNALIGNED       = (1 << 1),
	CONSERVE_MEMORY = (1 << 2),
	EXHAUSTIVE      = (1 << 3), /* NO_EXHAUSTIVE is default */
	PRESERVE_INPUT  = (1 << 4), /* cancels FFTW_DESTROY_INPUT */
	PATIENT         = (1 << 5), /* IMPATIENT is default */
	ESTIMATE        = (1 << 6),
	WISDOM_ONLY     = (1 << 21),
}

/* undocumented beyond-guru flags */
FFTW_ESTIMATE_PATIENT :: (1 << 7)
FFTW_BELIEVE_PCOST :: (1 << 8)
FFTW_NO_DFT_R2HC :: (1 << 9)
FFTW_NO_NONTHREADED :: (1 << 10)
FFTW_NO_BUFFERING :: (1 << 11)
FFTW_NO_INDIRECT_OP :: (1 << 12)
FFTW_ALLOW_LARGE_GENERIC :: (1 << 13) /* NO_LARGE_GENERIC is default */
FFTW_NO_RANK_SPLITS :: (1 << 14)
FFTW_NO_VRANK_SPLITS :: (1 << 15)
FFTW_NO_VRECURSE :: (1 << 16)
FFTW_NO_SIMD :: (1 << 17)
FFTW_NO_SLOW :: (1 << 18)
FFTW_NO_FIXED_RADIX_LARGE_N :: (1 << 19)
FFTW_ALLOW_PRUNING :: (1 << 20)
