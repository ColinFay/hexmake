#' @importFrom  attempt stop_if
assert_different <- function(
  r, img
){
  # We need to be sure these three paths are different
  stop_if(
    img$original_image == img$subplot
  )
  stop_if(
    img$original_image == r$sub_file
  )
  stop_if(
    r$sub_file == img$subplot
  )
}