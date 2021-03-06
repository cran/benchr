library(benchr)

b <- benchr::benchmark(1 + 1, One = 0 + 1)
p <- capture.output(print(b, details = TRUE))
s <- capture.output(summary(b))
m <- capture.output(mean(b))

expect_identical(b, print(b))
expect_identical(summary(b), print(summary(b)))
expect_identical(mean(b), print(mean(b)))

expect_true(any(grepl("Timer precision : ", p)))
expect_true(any(grepl("Timer error : ", p)))
expect_true(any(grepl("Expressions order : ", p)))
expect_true(any(grepl("Garbage collection : ", p)))
expect_true(any(grepl("Replications : 100", p)))

expect_true(any(grepl("Time units : ", s)))
expect_true(any(grepl("1 + 1", s)))
expect_true(any(grepl("One", s)))
expect_true(any(grepl("min", s)))
expect_true(any(grepl("lw.qu", s)))
expect_true(any(grepl("mean", s)))
expect_true(any(grepl("median", s)))
expect_true(any(grepl("up.qu", s)))
expect_true(any(grepl("max", s)))
expect_true(any(grepl("total", s)))

expect_true(any(grepl("Time units : ", m)))
expect_true(any(grepl("1 + 1", m)))
expect_true(any(grepl("One", m)))
expect_true(any(grepl("mean", m)))
expect_true(any(grepl("trimmed", m)))
expect_true(any(grepl("lw.ci", m)))
expect_true(any(grepl("up.ci", m)))

