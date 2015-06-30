## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function

makeCacheMatrix <- function(x = matrix()) {
  ## create inverted matrix object i
  i <- NULL
  ## set matrix and overwrite i to null
  set <- function(y) {
    x <<- y
    i <<- NULL
  }
  ## return matrix
  get <- function() x
  ## set i (at parent level) to object solve passed from cacheSolve
  setinvert <- function(solve) i <<- solve
  ## return inverted matrix
  getinvert <- function() i
  ## create list of functions
  list(set = set, get = get,
       setinvert = setinvert,
       getinvert = getinvert)
}


## Write a short comment describing this function

cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  ## Assumes matrix is non-singular and invertible
  i <- x$getinvert()
  ## return cached matrix if present
  if(!is.null(i)) {
    message("getting cached data")
    return(i)
  }
  ## otherwise solve, cache and return inverted matrix
  data <- x$get()
  i <- solve(data, ...)
  x$setinvert(i)
  i
}
