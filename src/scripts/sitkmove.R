movestuff <- function(builddir, destdir)
{
    pkgstuff <- list.files(path=builddir, full.names=TRUE)

    bn <- basename(pkgstuff)
    fulldest <- file.path(destdir, bn)
    alreadyexists <- file.exists(fulldest)
    print(pkgstuff[!alreadyexists])
    print(fulldest[!alreadyexists])
    file.rename(from=pkgstuff[!alreadyexists], to=fulldest[!alreadyexists])
}


args <- commandArgs(TRUE)
src <- args[[1]]
dest <- args[[2]]

print(src)
## Part of constructing a source distribution is putting the source
## version var file in the correct place. If it isn't there it means
## we're building the source package for distribution.
## source package.
fullsource <- TRUE
SITKCMAKEDIR <- file.path("SITK", "SimpleITK","CMake")
SITKVERSIONVARS <- file.path(SITKCMAKEDIR, "sitkSourceVersionVars.cmake")
if (!file.exists((SITKVERSIONVARS))) {
    fullsource <- FALSE
    file.copy(file.path("SITK", "Build", "SimpleITK-build", "sitkSourceVersionVars.cmake"),
              SITKVERSIONVARS)
    ## copy the DESCRIPTION
    file.copy(file.path(src, "DESCRIPTION"), file.path(dest, "DESCRIPTION"))
}
if (!fullsource) {
    ## move folders that don't exist (i.e) not the src folder
    movestuff(src, dest)
}
file.rename(file.path(src, "src", "SimpleITK.so"), file.path("SimpleITK.so"))

q(save="no")

