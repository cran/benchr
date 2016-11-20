context("Timer")

test_that("'timer_precision' return correct object", {
    expect_is(timer_precision(), "numeric")
    expect_length(timer_precision(), 1L)
})

test_that("Timer precision less then 1 millisecond", {
    expect_lte(timer_precision(), 1e-3)
})

test_that("'timer_error' return correct object", {
    expect_is(timer_error(), "numeric")
    expect_length(timer_error(), 1L)
})

test_that("Timer error greater then 0", {
    expect_gt(timer_error(), 0)
})

test_that("Test 'do_timing' and 'Sys.sleep'", {
    expect_gte(do_timing(quote(Sys.sleep(1e-3)), .GlobalEnv), 1e-3)
    expect_gte(do_timing(quote(Sys.sleep(2e-3)), .GlobalEnv), 2e-3)
    expect_gte(do_timing(quote(Sys.sleep(3e-3)), .GlobalEnv), 3e-3)
})

test_that("'do_timing' result greater then timer error", {
    expect_gte(do_timing(quote(2^8), .GlobalEnv), timer_error())
})

test_that("'do_benchmark' return correct object", {
    b <- do_benchmark(1, .GlobalEnv, rep(1, 10), FALSE)
    expect_is(b, "numeric")
    expect_length(b, 10L)
})

test_that("Allocate larger vector are slower", {
    b <- benchmark(1:10, 1:10000)
    m <- tapply(b$time, b$expr, median)
    expect_lte(m[1], m[2])
})
