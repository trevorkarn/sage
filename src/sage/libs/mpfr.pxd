from sage.libs.gmp.types cimport *

cdef extern from "mpfr.h":
    ctypedef struct __mpfr_struct:
        pass

    ctypedef __mpfr_struct mpfr_t[1]
    ctypedef __mpfr_struct* mpfr_ptr
    ctypedef __mpfr_struct* mpfr_srcptr
    ctypedef enum mpfr_rnd_t:
        MPFR_RNDN
        MPFR_RNDZ
        MPFR_RNDU
        MPFR_RNDD
        MPFR_RNDA
        MPFR_RNDF
        MPFR_RNDNA
        GMP_RNDN
        GMP_RNDZ
        GMP_RNDU
        GMP_RNDD

    ctypedef long mp_prec_t
    ctypedef long mpfr_prec_t

    mpfr_prec_t MPFR_PREC_MIN, MPFR_PREC_MAX

    # Initialization Functions
    void mpfr_init2 (mpfr_t x, mpfr_prec_t prec)
    void mpfr_clear (mpfr_t x)
    void mpfr_init (mpfr_t x)
    void mpfr_set_default_prec (mpfr_prec_t prec)
    mpfr_prec_t mpfr_get_default_prec ()
    void mpfr_set_prec (mpfr_t x, mpfr_prec_t prec)
    mpfr_prec_t mpfr_get_prec (mpfr_t x)

    # Assignment Functions
    int mpfr_set (mpfr_t rop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_set_ui (mpfr_t rop, unsigned long int op, mpfr_rnd_t rnd)
    int mpfr_set_si (mpfr_t rop, long int op, mpfr_rnd_t rnd)
    int mpfr_set_d (mpfr_t rop, double op, mpfr_rnd_t rnd)
    int mpfr_set_ld (mpfr_t rop, long double op, mpfr_rnd_t rnd)
    # int mpfr_set_decimal64 (mpfr_t rop, _Decimal64 op, mpfr_rnd_t rnd)
    int mpfr_set_z (mpfr_t rop, mpz_t op, mpfr_rnd_t rnd)
    int mpfr_set_q (mpfr_t rop, mpq_t op, mpfr_rnd_t rnd)
    # int mpfr_set_f (mpfr_t rop, mpf_t op, mpfr_rnd_t rnd)
    int mpfr_set_ui_2exp (mpfr_t rop, unsigned long int op, mp_exp_t e, mpfr_rnd_t rnd)
    int mpfr_set_si_2exp (mpfr_t rop, long int op, mp_exp_t e, mpfr_rnd_t rnd)
    int mpfr_set_str (mpfr_t rop,  char *s, int base, mpfr_rnd_t rnd)
    int mpfr_strtofr (mpfr_t rop, char *nptr, char **endptr, int base, mpfr_rnd_t rnd)
    void mpfr_set_inf (mpfr_t x, int sign)
    void mpfr_set_nan (mpfr_t x)
    void mpfr_set_zero (mpfr_t x, int sign)
    void mpfr_swap (mpfr_t x, mpfr_t y)

    # Combined Initialization and Assignment Functions
    int mpfr_init_set (mpfr_t rop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_init_set_ui (mpfr_t rop, unsigned long int op, mpfr_rnd_t rnd)
    int mpfr_init_set_si (mpfr_t rop, signed long int op, mpfr_rnd_t rnd)
    int mpfr_init_set_d (mpfr_t rop, double op, mpfr_rnd_t rnd)
    int mpfr_init_set_ld (mpfr_t rop, long double op, mpfr_rnd_t rnd)
    int mpfr_init_set_z (mpfr_t rop, mpz_t op, mpfr_rnd_t rnd)
    int mpfr_init_set_q (mpfr_t rop, mpq_t op, mpfr_rnd_t rnd)
    # int mpfr_init_set_f (mpfr_t rop, mpf_t op, mpfr_rnd_t rnd)
    int mpfr_init_set_str (mpfr_t x, char *s, int base, mpfr_rnd_t rnd)

    # Conversion Functions
    double mpfr_get_d (mpfr_t op, mpfr_rnd_t rnd)
    long double mpfr_get_ld (mpfr_t op, mpfr_rnd_t rnd)
    # _Decimal64 mpfr_get_decimal64 (mpfr_t op, mpfr_rnd_t rnd)
    double mpfr_get_d_2exp (long *exp, mpfr_t op, mpfr_rnd_t rnd)
    long double mpfr_get_ld_2exp (long *exp, mpfr_t op, mpfr_rnd_t rnd)
    long mpfr_get_si (mpfr_t op, mpfr_rnd_t rnd)
    unsigned long mpfr_get_ui (mpfr_t op, mpfr_rnd_t rnd)
    mp_exp_t mpfr_get_z_exp (mpz_t rop, mpfr_t op)
    void mpfr_get_z (mpz_t rop, mpfr_t op, mpfr_rnd_t rnd)
    # int mpfr_get_f (mpf_t rop, mpfr_t op, mpfr_rnd_t rnd)
    char * mpfr_get_str (char *str, mp_exp_t *expptr, int b, size_t n, mpfr_t op, mpfr_rnd_t rnd)
    void mpfr_free_str (char *str)
    bint mpfr_fits_ulong_p (mpfr_t op, mpfr_rnd_t rnd)
    bint mpfr_fits_slong_p (mpfr_t op, mpfr_rnd_t rnd)
    bint mpfr_fits_uint_p (mpfr_t op, mpfr_rnd_t rnd)
    bint mpfr_fits_sint_p (mpfr_t op, mpfr_rnd_t rnd)
    bint mpfr_fits_ushort_p (mpfr_t op, mpfr_rnd_t rnd)
    bint mpfr_fits_sshort_p (mpfr_t op, mpfr_rnd_t rnd)
    bint mpfr_fits_intmax_p (mpfr_t op, mpfr_rnd_t rnd)
    bint mpfr_fits_uintmax_p (mpfr_t op, mpfr_rnd_t rnd)

    # Basic Arithmetic Functions
    int mpfr_add (mpfr_t rop, mpfr_t op1, mpfr_t op2, mpfr_rnd_t rnd)
    int mpfr_add_ui (mpfr_t rop, mpfr_t op1, unsigned long int op2, mpfr_rnd_t rnd)
    int mpfr_add_si (mpfr_t rop, mpfr_t op1, long int op2, mpfr_rnd_t rnd)
    int mpfr_add_z (mpfr_t rop, mpfr_t op1, mpz_t op2, mpfr_rnd_t rnd)
    int mpfr_add_q (mpfr_t rop, mpfr_t op1, mpq_t op2, mpfr_rnd_t rnd)
    int mpfr_sub (mpfr_t rop, mpfr_t op1, mpfr_t op2, mpfr_rnd_t rnd)
    int mpfr_ui_sub (mpfr_t rop, unsigned long int op1, mpfr_t op2, mpfr_rnd_t rnd)
    int mpfr_sub_ui (mpfr_t rop, mpfr_t op1, unsigned long int op2, mpfr_rnd_t rnd)
    int mpfr_si_sub (mpfr_t rop, long int op1, mpfr_t op2, mpfr_rnd_t rnd)
    int mpfr_sub_si (mpfr_t rop, mpfr_t op1, long int op2, mpfr_rnd_t rnd)
    int mpfr_sub_z (mpfr_t rop, mpfr_t op1, mpz_t op2, mpfr_rnd_t rnd)
    int mpfr_sub_q (mpfr_t rop, mpfr_t op1, mpq_t op2, mpfr_rnd_t rnd)
    int mpfr_mul (mpfr_t rop, mpfr_t op1, mpfr_t op2, mpfr_rnd_t rnd)
    int mpfr_mul_ui (mpfr_t rop, mpfr_t op1, unsigned long int op2, mpfr_rnd_t rnd)
    int mpfr_mul_si (mpfr_t rop, mpfr_t op1, long int op2, mpfr_rnd_t rnd)
    int mpfr_mul_z (mpfr_t rop, mpfr_t op1, mpz_t op2, mpfr_rnd_t rnd)
    int mpfr_mul_q (mpfr_t rop, mpfr_t op1, mpq_t op2, mpfr_rnd_t rnd)
    int mpfr_sqr (mpfr_t rop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_div (mpfr_t rop, mpfr_t op1, mpfr_t op2, mpfr_rnd_t rnd)
    int mpfr_ui_div (mpfr_t rop, unsigned long int op1, mpfr_t op2, mpfr_rnd_t rnd)
    int mpfr_div_ui (mpfr_t rop, mpfr_t op1, unsigned long int op2, mpfr_rnd_t rnd)
    int mpfr_si_div (mpfr_t rop, long int op1, mpfr_t op2, mpfr_rnd_t rnd)
    int mpfr_div_si (mpfr_t rop, mpfr_t op1, long int op2, mpfr_rnd_t rnd)
    int mpfr_div_z (mpfr_t rop, mpfr_t op1, mpz_t op2, mpfr_rnd_t rnd)
    int mpfr_div_q (mpfr_t rop, mpfr_t op1, mpq_t op2, mpfr_rnd_t rnd)
    int mpfr_sqrt (mpfr_t rop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_sqrt_ui (mpfr_t rop, unsigned long int op, mpfr_rnd_t rnd)
    int mpfr_cbrt (mpfr_t rop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_root (mpfr_t rop, mpfr_t op, unsigned long int k, mpfr_rnd_t rnd)
    int mpfr_pow (mpfr_t rop, mpfr_t op1, mpfr_t op2, mpfr_rnd_t rnd)
    int mpfr_pow_ui (mpfr_t rop, mpfr_t op1, unsigned long int op2, mpfr_rnd_t rnd)
    int mpfr_pow_si (mpfr_t rop, mpfr_t op1, long int op2, mpfr_rnd_t rnd)
    int mpfr_pow_z (mpfr_t rop, mpfr_t op1, mpz_t op2, mpfr_rnd_t rnd)
    int mpfr_ui_pow_ui (mpfr_t rop, unsigned long int op1, unsigned long int op2, mpfr_rnd_t rnd)
    int mpfr_ui_pow (mpfr_t rop, unsigned long int op1, mpfr_t op2, mpfr_rnd_t rnd)
    int mpfr_neg (mpfr_t rop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_abs (mpfr_t rop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_dim (mpfr_t rop, mpfr_t op1, mpfr_t op2, mpfr_rnd_t rnd)
    int mpfr_mul_2ui (mpfr_t rop, mpfr_t op1, unsigned long int op2, mpfr_rnd_t rnd)
    int mpfr_mul_2si (mpfr_t rop, mpfr_t op1, long int op2, mpfr_rnd_t rnd)
    int mpfr_div_2ui (mpfr_t rop, mpfr_t op1, unsigned long int op2, mpfr_rnd_t rnd)
    int mpfr_div_2si (mpfr_t rop, mpfr_t op1, long int op2, mpfr_rnd_t rnd)

    # Comparison Functions
    int mpfr_cmp (mpfr_t op1, mpfr_t op2)
    int mpfr_cmp_ui (mpfr_t op1, unsigned long int op2)
    int mpfr_cmp_si (mpfr_t op1, signed long int op2)
    int mpfr_cmp_d (mpfr_t op1, double op2)
    int mpfr_cmp_ld (mpfr_t op1, long double op2)
    int mpfr_cmp_z (mpfr_t op1, mpz_t op2)
    int mpfr_cmp_q (mpfr_t op1, mpq_t op2)
    # int mpfr_cmp_f (mpfr_t op1, mpf_t op2)
    int mpfr_cmp_ui_2exp (mpfr_t op1, unsigned long int op2, mp_exp_t e)
    int mpfr_cmp_si_2exp (mpfr_t op1, long int op2, mp_exp_t e)
    int mpfr_cmpabs (mpfr_t op1, mpfr_t op2)
    bint mpfr_nan_p (mpfr_t op)
    bint mpfr_inf_p (mpfr_t op)
    bint mpfr_number_p (mpfr_t op)
    bint mpfr_zero_p (mpfr_t op)
    bint mpfr_regular_p (mpfr_t op)
    int mpfr_sgn (mpfr_t op)
    bint mpfr_greater_p (mpfr_t op1, mpfr_t op2)
    bint mpfr_greaterequal_p (mpfr_t op1, mpfr_t op2)
    bint mpfr_less_p (mpfr_t op1, mpfr_t op2)
    bint mpfr_lessequal_p (mpfr_t op1, mpfr_t op2)
    bint mpfr_lessgreater_p (mpfr_t op1, mpfr_t op2)
    bint mpfr_equal_p (mpfr_t op1, mpfr_t op2)
    bint mpfr_unordered_p (mpfr_t op1, mpfr_t op2)

    # Special Functions
    int mpfr_log (mpfr_t rop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_log2 (mpfr_t rop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_log10 (mpfr_t rop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_exp (mpfr_t rop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_exp2 (mpfr_t rop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_exp10 (mpfr_t rop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_cos (mpfr_t rop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_sin (mpfr_t rop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_tan (mpfr_t rop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_sec (mpfr_t rop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_csc (mpfr_t rop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_cot (mpfr_t rop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_sin_cos (mpfr_t sop, mpfr_t cop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_acos (mpfr_t rop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_asin (mpfr_t rop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_atan (mpfr_t rop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_atan2 (mpfr_t rop, mpfr_t y, mpfr_t x, mpfr_rnd_t rnd)
    int mpfr_cosh (mpfr_t rop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_sinh (mpfr_t rop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_tanh (mpfr_t rop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_sech (mpfr_t rop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_csch (mpfr_t rop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_coth (mpfr_t rop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_acosh (mpfr_t rop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_asinh (mpfr_t rop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_atanh (mpfr_t rop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_fac_ui (mpfr_t rop, unsigned long int op, mpfr_rnd_t rnd)
    int mpfr_log1p (mpfr_t rop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_expm1 (mpfr_t rop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_eint (mpfr_t y, mpfr_t x, mpfr_rnd_t rnd)
    int mpfr_li2 (mpfr_t y, mpfr_t x, mpfr_rnd_t rnd)
    int mpfr_gamma (mpfr_t rop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_lngamma (mpfr_t rop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_lgamma (mpfr_t rop, int *signp, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_zeta (mpfr_t rop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_zeta_ui (mpfr_t rop, unsigned long op, mpfr_rnd_t rnd)
    int mpfr_erf (mpfr_t rop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_erfc (mpfr_t rop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_j0 (mpfr_t rop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_j1 (mpfr_t rop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_jn (mpfr_t rop, long n, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_y0 (mpfr_t rop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_y1 (mpfr_t rop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_yn (mpfr_t rop, long n, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_fma (mpfr_t rop, mpfr_t op1, mpfr_t op2, mpfr_t op3, mpfr_rnd_t rnd)
    int mpfr_fms (mpfr_t rop, mpfr_t op1, mpfr_t op2, mpfr_t op3, mpfr_rnd_t rnd)
    int mpfr_agm (mpfr_t rop, mpfr_t op1, mpfr_t op2, mpfr_rnd_t rnd)
    int mpfr_hypot (mpfr_t rop, mpfr_t x, mpfr_t y, mpfr_rnd_t rnd)
    int mpfr_const_log2 (mpfr_t rop, mpfr_rnd_t rnd)
    int mpfr_const_pi (mpfr_t rop, mpfr_rnd_t rnd)
    int mpfr_const_euler (mpfr_t rop, mpfr_rnd_t rnd)
    int mpfr_const_catalan (mpfr_t rop, mpfr_rnd_t rnd)
    void mpfr_free_cache ()
    int mpfr_sum (mpfr_t rop, mpfr_ptr tab[], unsigned long n, mpfr_rnd_t rnd)

    # Input and Output Functions
    # size_t mpfr_out_str (file *stream, int base, size_t n, mpfr_t op, mpfr_rnd_t rnd)
    # size_t mpfr_inp_str (mpfr_t rop, file *stream, int base, mpfr_rnd_t rnd)

    # Integer Related Functions
    int mpfr_rint (mpfr_t rop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_ceil (mpfr_t rop, mpfr_t op)
    int mpfr_floor (mpfr_t rop, mpfr_t op)
    int mpfr_round (mpfr_t rop, mpfr_t op)
    int mpfr_trunc (mpfr_t rop, mpfr_t op)
    int mpfr_rint_ceil (mpfr_t rop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_rint_floor (mpfr_t rop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_rint_round (mpfr_t rop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_rint_trunc (mpfr_t rop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_frac (mpfr_t rop, mpfr_t op, mpfr_rnd_t rnd)
    int mpfr_remainder (mpfr_t r, mpfr_t x, mpfr_t y, mpfr_rnd_t rnd)
    int mpfr_remquo (mpfr_t r, long* q, mpfr_t x, mpfr_t y, mpfr_rnd_t rnd)
    bint mpfr_integer_p (mpfr_t op)

    # Miscellaneous Functions
    void mpfr_nexttoward (mpfr_t x, mpfr_t y)
    void mpfr_nextabove (mpfr_t x)
    void mpfr_nextbelow (mpfr_t x)
    int mpfr_min (mpfr_t rop, mpfr_t op1, mpfr_t op2, mpfr_rnd_t rnd)
    int mpfr_max (mpfr_t rop, mpfr_t op1, mpfr_t op2, mpfr_rnd_t rnd)
    int mpfr_urandomb (mpfr_t rop, gmp_randstate_t state)
    void mpfr_random (mpfr_t rop)
    void mpfr_random2 (mpfr_t rop, mp_size_t size, mp_exp_t exp)
    mp_exp_t mpfr_get_exp (mpfr_t x)
    int mpfr_set_exp (mpfr_t x, mp_exp_t e)
    int mpfr_signbit (mpfr_t op)
    int mpfr_setsign (mpfr_t rop, mpfr_t op, int s, mpfr_rnd_t rnd)
    int mpfr_copysign (mpfr_t rop, mpfr_t op1, mpfr_t op2, mpfr_rnd_t rnd)
    char * mpfr_get_version ()
    long MPFR_VERSION_NUM (major, minor, patchlevel)
    char * mpfr_get_patches ()

    # Printf-Like Functions
    int mpfr_printf (const char*, ...)
    int mpfr_asprintf (char**, const char*, ...)
    int mpfr_sprintf (char**, const char*, ...)
    int mpfr_snprintf (char*, size_t, const char*, ...)

    # Rounding Mode Related Functions
    void mpfr_set_default_rounding_mode (mpfr_rnd_t rnd)
    mpfr_rnd_t mpfr_get_default_rounding_mode ()
    int mpfr_prec_round (mpfr_t x, mpfr_prec_t prec, mpfr_rnd_t rnd)
    char * mpfr_print_rnd_mode (mpfr_rnd_t rnd)

    # Exception Related Functions
    mp_exp_t mpfr_get_emin ()
    mp_exp_t mpfr_get_emax ()
    int mpfr_set_emin (mp_exp_t exp)
    int mpfr_set_emax (mp_exp_t exp)
    mp_exp_t mpfr_get_emin_min ()
    mp_exp_t mpfr_get_emin_max ()
    mp_exp_t mpfr_get_emax_min ()
    mp_exp_t mpfr_get_emax_max ()
    int mpfr_check_range (mpfr_t x, int t, mpfr_rnd_t rnd)
    int mpfr_subnormalize (mpfr_t x, int t, mpfr_rnd_t rnd)
    void mpfr_clear_underflow ()
    void mpfr_clear_overflow ()
    void mpfr_clear_nanflag ()
    void mpfr_clear_inexflag ()
    void mpfr_clear_erangeflag ()
    void mpfr_set_underflow ()
    void mpfr_set_overflow ()
    void mpfr_set_nanflag ()
    void mpfr_set_inexflag ()
    void mpfr_set_erangeflag ()
    void mpfr_clear_flags ()
    bint mpfr_underflow_p ()
    bint mpfr_overflow_p ()
    bint mpfr_nanflag_p ()
    bint mpfr_inexflag_p ()
    bint mpfr_erangeflag_p ()

    # Advanced Functions
    MPFR_DECL_INIT (name, prec)
    void mpfr_inits (mpfr_t x, ...)
    void mpfr_inits2 (mpfr_prec_t prec, mpfr_t x, ...)
    void mpfr_clears (mpfr_t x, ...)

    # Compatibility With MPF
    void mpfr_set_prec_raw (mpfr_t x, mpfr_prec_t prec)
    int mpfr_eq (mpfr_t op1, mpfr_t op2, unsigned long int op3)
    void mpfr_reldiff (mpfr_t rop, mpfr_t op1, mpfr_t op2, mpfr_rnd_t rnd)
    int mpfr_mul_2exp (mpfr_t rop, mpfr_t op1, unsigned long int op2, mpfr_rnd_t rnd)
    int mpfr_div_2exp (mpfr_t rop, mpfr_t op1, unsigned long int op2, mpfr_rnd_t rnd)

    # Custom Interface
    size_t mpfr_custom_get_size (mpfr_prec_t prec)
    void mpfr_custom_init (void *significand, mpfr_prec_t prec)
    void mpfr_custom_init_set (mpfr_t x, int kind, mp_exp_t exp, mpfr_prec_t prec, void *significand)
    int mpfr_custom_get_kind (mpfr_t x)
    void * mpfr_custom_get_mantissa (mpfr_t x)
    mp_exp_t mpfr_custom_get_exp (mpfr_t x)
    void mpfr_custom_move (mpfr_t x, void *new_position)

    # Internals
    int mpfr_can_round (mpfr_t b, mp_exp_t err, mpfr_rnd_t rnd1, mpfr_rnd_t rnd2, mpfr_prec_t prec)
    double mpfr_get_d1 (mpfr_t op)
