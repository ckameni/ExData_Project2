# ExData_Project2 
===============
plot.new() set up plot region
plot.window() set up coordinate system (xlim, ylim)
box() Draw rectangle around plot
axis Draw axes, lines(), points(), text, ...
usr provides/sets the coordinate system

###set up canvas with 3 plot regions
par(mfrow=c(3,1), mar=rep(0,4), oma = c(4,4,3,3))

### make the top plot
plot(density(rtraffic$Occ[rtraffic$lane =="Slow"]),
ylim=c(0,15), xlim=c(0, 0.5), main="", axes = FALSE)

###add text to top margin
mtext("Loop Detector Occupancy for Left (bottom),
Middle, and Right (top) lanes", side = 3, line = 2)


### Add box around first plot region
box()

###Add axes to the right side
axis(2, labels=FALSE); axis(3, labels=FALSE); axis(4)
Graphics# Make middle plot
plot(density(rtraffic$Occ[rtraffic$lane =="Middle"]),
ylim=c(0,15), xlim=c(0, 0.5), main="", axes = FALSE)

### Draw box around it - no axes ticks or labels
box(); axis(2, labels=FALSE); axis(4,labels=FALSE)

### Draw bottom plot
plot(density(rtraffic$Occ[rtraffic$lane =="Passing"]),
ylim=c(0,15), xlim=c(0, 0.5), main="", axes = FALSE)

### add box, then x and y axes
box();axis(1);axis(2)

### add text for a label on the y axes
mtext("Occupancy", side = 1, line =2.5)

Lattice Panel Functions
xyplot(y ~ x | f,
panel = function(x, y, ...) {
panel.xyplot(x, y, ...)
panel.abline(h = median(y),
lty = 2)
})
plots y vs. x conditioned on f with horizontal (dashed) line drawn
at the median of y for each panel


Adding a regression line
xyplot(y ~ x | f,
panel = function(x, y, ...) {
panel.xyplot(x, y, ...)
panel.lmline(x, y, col = 2)
})
fits and plots a simple linear regression line to each panel of the
plot


http://www.stat.berkeley.edu/~statcur/WorkshopBC/Presentations/Graphics/graphics.pdf
