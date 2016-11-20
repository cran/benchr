#' @title Plot method for the \code{benchmark} timings.
#'
#' @description
#' Displays measurement results as a scatter plot, with R expressions on X axis
#' and execution time on Y axis. Each expression is highlighted by its own colour.
#'
#' @param x An object of class \code{benchmark}.
#' @param units Character. The units to be used in printing the timings.
#' The available units are nanoseconds (\code{"ns"}), microseconds
#' (\code{"us"}), milliseconds (\code{"ms"}), seconds (\code{"s"}).
#' @param log Logical. Should times be plotted on log scale?
#' @param xlab Character. X axis label.
#' @param ylab Character. Y axis label.
#' @param \dots Not currently used.
#'
#' @details
#' If \code{ggplot2} package is available, it will be used. In order to switch to default
 #' \code{boxplot} from the \code{graphics} package set option \code{benchr.use_ggplot}
#' to \code{FALSE}: \code{options(benchr.use_ggplot = FALSE)}.
#'
#' @include utils.R
#' @importFrom graphics plot
#' @method plot benchmark
#' @export
#'
#' @author Artem Klevtsov \email{a.a.klevtsov@gmail.com}
#'
#' @seealso
#' \code{\link{boxplot.benchmark}}
#'
#' @examples
#' timings <- benchmark(
#'     rchisq(100, 0), rchisq(100, 1), rchisq(100, 2),
#'     rchisq(100, 3), rchisq(100, 5), times = 1000L)
#' plot(timings)
#'
plot.benchmark <- function(x, units = "auto", log = TRUE, xlab, ylab, ...) {
    x <- convert_units(x, units)
    if (missing(xlab))
        xlab <- "Replications"
    if (missing(ylab)) {
        if (log)
            ylab <- sprintf("Log Execution Time [%s]", attr(x, "units"))
        else
            ylab <- sprintf("Execution Time [%s]", attr(x, "units"))
    }
    if (is_installed("ggplot2") && getOption("benchr.use_ggplot", TRUE))
        return(plot_ggplot(x, log, xlab, ylab))
    else
        plot_default(x, log, xlab, ylab)
    invisible()
}

# ggplot2 variant of the plot
plot_ggplot <- function(x, log = TRUE, xlab, ylab) {
    expr <- as.symbol("expr")
    time <- as.symbol("time")
    aes <- ggplot2::aes(x = seq_along(time), y = time, colour = expr)
    p <- ggplot2::ggplot(x, aes) +
        ggplot2::geom_point(shape = 19) +
        ggplot2::labs(x = xlab, y = ylab, colour = NULL)
    if (log)
        p <- p + ggplot2::scale_y_log10()
    print(p)
}

# graphics variant of the plot
#' @importFrom graphics plot.default legend
plot_default <- function(x, log = TRUE, xlab, ylab) {
    plot.default(x$time, col = x$expr, xlab = xlab, ylab = ylab,
                 log = ifelse(log, "y", ""), pch = 19)
    legend("topright", legend = levels(x$expr),
           col = seq_along(levels(x$expr)), pch = 19)
}
