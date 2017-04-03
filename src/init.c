#include <R.h>
#include <Rinternals.h>
#include <stdlib.h>
#include <R_ext/Rdynload.h>

/* .Call calls */
extern SEXP benchr_do_benchmark(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP benchr_do_timing(SEXP, SEXP);
extern SEXP benchr_timer_error(SEXP);
extern SEXP benchr_timer_precision();

static const R_CallMethodDef CallEntries[] = {
    {"benchr_do_benchmark",    (DL_FUNC) &benchr_do_benchmark,    5},
    {"benchr_do_timing",       (DL_FUNC) &benchr_do_timing,       2},
    {"benchr_timer_error",     (DL_FUNC) &benchr_timer_error,     1},
    {"benchr_timer_precision", (DL_FUNC) &benchr_timer_precision, 0},
    {NULL, NULL, 0}
};

void R_init_benchr(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
