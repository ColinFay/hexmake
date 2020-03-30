assert_different <- function(
  r, img
){
  # We need to be sure these three paths are different
  attempt::stop_if(
    img$original_image == img$subplot
  )
  attempt::stop_if(
    img$original_image == r$sub_file
  )
  attempt::stop_if(
    r$sub_file == img$subplot
  )
}