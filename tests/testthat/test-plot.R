context("ggplot")

b <- benchmark(1 + 1, 2 + 2)

test_that("Draw plot without errors", {
    expect_error(plot(b), NA)
    options(benchr.use_ggplot = FALSE)
    expect_error(plot(b), NA)
})

test_that("Draw boxplot without errors", {
    expect_error(boxplot(b), NA)
    expect_error(boxplot(b, horizontal = TRUE), NA)
    options(benchr.use_ggplot = FALSE)
    expect_error(boxplot(b), NA)
    expect_error(boxplot(b, horizontal = TRUE), NA)
})

test_that("Plot return NULL", {
    options(benchr.use_ggplot = FALSE)
    expect_equal(plot(b), NULL)
})

test_that("Boxplot return NULL", {
    options(benchr.use_ggplot = FALSE)
    expect_equal(boxplot(b), NULL)
})

test_that("Boxplot ggplot without log", {
    skip_if_not_installed("ggplot2")
    p <- boxplot_ggplot(b, xlab = "expr", ylab = "time", log = FALSE)
    expect_is(p$plot, "gg")
    expect_is(p$plot, "ggplot")
    expect_identical(b, p$plot$data)
    expect_equal(p$plot$labels, list(x = "expr", y = "time"))
    expect_equal(p$layout$panel_ranges[[1]]$x.labels, c("1 + 1", "2 + 2"))
    expect_is(p$plot$layers[[2]]$geom, "GeomBoxplot")
    expect_is(p$plot$layers[[2]]$stat, "StatBoxplot")
    expect_equal(p$plot$scales$scales[[1]]$trans$name, "identity")
})

test_that("Boxplot ggplot with log and horizontal", {
    skip_if_not_installed("ggplot2")
    p <- boxplot_ggplot(b, xlab = "expr", ylab = "time", horizontal = TRUE)
    expect_is(p$plot, "gg")
    expect_is(p$plot, "ggplot")
    expect_identical(b, p$plot$data)
    expect_equal(p$plot$labels, list(x = "expr", y = "time"))
    expect_equal(p$layout$panel_ranges[[1]]$y.labels, c("1 + 1", "2 + 2"))
    expect_is(p$plot$layers[[2]]$geom, "GeomBoxplot")
    expect_is(p$plot$layers[[2]]$stat, "StatBoxplot")
    expect_equal(p$plot$scales$scales[[1]]$trans$name, "log-10")
})

test_that("Boxplot ggplot with violin geom", {
    skip_if_not_installed("ggplot2")
    p <- boxplot_ggplot(b, xlab = "expr", ylab = "time", violin = TRUE)
    expect_is(p$plot, "gg")
    expect_is(p$plot, "ggplot")
    expect_identical(b, p$plot$data)
    expect_equal(p$plot$labels, list(x = "expr", y = "time"))
    expect_equal(p$layout$panel_ranges[[1]]$x.labels, c("1 + 1", "2 + 2"))
    expect_is(p$plot$layers[[2]]$geom, "GeomViolin")
    expect_is(p$plot$layers[[2]]$stat, "StatYdensity")
    expect_equal(p$plot$scales$scales[[1]]$trans$name, "log-10")
})

test_that("Scatter plot ggplot with log", {
    skip_if_not_installed("ggplot2")
    p <- plot_ggplot(b, xlab = "replications", ylab = "time")
    expect_is(p$plot, "gg")
    expect_is(p$plot, "ggplot")
    expect_identical(b, p$plot$data)
    expect_named(p$plot$labels, c("x", "y", "colour"))
    expect_equal(p$plot$labels, list(x = "replications", y = "time", colour = NULL))
    expect_is(p$plot$layers[[1]]$geom, "GeomPoint")
    expect_is(p$plot$layers[[1]]$stat, "StatIdentity")
    expect_equal(p$plot$layers[[1]]$aes_params, list(shape = 19))
    expect_equal(p$plot$scales$scales[[1]]$trans$name, "log-10")
    expect_equal(p$plot$scales$scales[[2]]$trans$name, "identity")
})

test_that("Scatter plot ggplot without log", {
    skip_if_not_installed("ggplot2")
    p <- plot_ggplot(b, xlab = "replications", ylab = "time", log = FALSE)
    expect_is(p$plot, "gg")
    expect_is(p$plot, "ggplot")
    expect_identical(b, p$plot$data)
    expect_named(p$plot$labels, c("x", "y", "colour"))
    expect_equal(p$plot$labels, list(x = "replications", y = "time", colour = NULL))
    expect_is(p$plot$layers[[1]]$geom, "GeomPoint")
    expect_is(p$plot$layers[[1]]$stat, "StatIdentity")
    expect_equal(p$plot$layers[[1]]$aes_params, list(shape = 19))
    expect_equal(p$plot$scales$scales[[1]]$trans$name, "identity")
    expect_equal(p$plot$scales$scales[[2]]$trans$name, "identity")
})
