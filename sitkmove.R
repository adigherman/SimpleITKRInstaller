movestuff <- function(builddir, destdir)
{
    pkgstuff <- list.files(path=builddir, full.names=TRUE)

    bn <- basename(pkgstuff)
    fulldest <- file.path(destdir, bn)
    alreadyexists <- file.exists(fulldest)
    file.rename(from=pkgstuff[!alreadyexists], to=fulldest[!alreadyexists])
}


args <- commandArgs( TRUE )
src <- args[[1]]
dest <- args[[2]]
fullsource <- as.logical(as.numeric(args[[3]]))
if (!fullsource) {
    ## move folders that don't exist (i.e) not the src folder
    movestuff(src, dest)
}
## copy the makefile
file.copy(file.path(src, "src/Makefile"), file.path(dest, "src"))
## copy the DESCRIPTION
file.copy(file.path(src, "DESCRIPTION"), file.path(dest, "DESCRIPTION"))

## move the library
file.rename(file.path(src, "src/SimpleITK.so"), file.path(dest, "src/SimpleITK.so"))

q(save="no")

