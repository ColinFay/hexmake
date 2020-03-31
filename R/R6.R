#' @importFrom  hexSticker sticker
#' @importFrom R6 R6Class
#' @importFrom sysfonts font_families
#' @importFrom fs file_temp file_copy
#' @importFrom tools file_ext
#' @importFrom attempt stop_if
#' @importFrom purrr walk
Hex <- R6Class(
  "Hex", 
  public = list(
    subplot = NULL, 
    s_x = 1, 
    s_y = 0.7, 
    s_width = 0.4,
    s_height = 1, 
    package = "hexmake", 
    p_x = 1, 
    p_y = 1.4, 
    p_color = "#FFFFFF",
    p_family = sysfonts::font_families()[1], 
    p_size = 8, 
    h_size = 1.2,
    h_fill = "#1881C2", 
    h_color = "#87B13F", 
    spotlight = FALSE,
    l_x = 1, 
    l_y = 0.5, 
    l_width = 3, 
    l_height = 3, 
    l_alpha = 0.4,
    url = "",
    u_x = 1, 
    u_y = 0.08, 
    u_color = "black",
    u_family = sysfonts::font_families()[1], 
    u_size = 1.5, 
    u_angle = 30,
    white_around_sticker = FALSE,
    filename = paste0("package", ".png"), 
    asp = 1, 
    dpi = 600,
    saved_path = NULL,
    old = NULL,
    original_image = NULL,
    initialize = function(){
      
      # At launch, the original image is the horn emoji, we copy it 
      # as original image
      horns <- system.file("sign-of-the-horns.png", package = "hexmake")
      
      self$original_image <- fs::file_temp(
        file_ext(
          horns
        )
      )
      
      fs::file_copy(
        horns, 
        self$original_image 
      )
      
      # We also add a copy of this as subplot, the image that is actually
      # drawn on the hex
      self$subplot <- fs::file_temp(
        ext = tools::file_ext(
          horns
        )
      )
      
      fs::file_copy(
        horns, 
        self$subplot
      )
      
      self$old <- self$clone()
      
      attempt::stop_if(
        self$original_image == self$subplot
      )
      
    }, 
    self_ = function(){
      return(self)
    },
    new_original_image = function(path){
      self$original_image <- path
    },
    render = function(con){
      if (missing(con)){
        self$saved_path <- file_temp(ext = ".png")
      } else {
        self$saved_path <- con
      }

      sticker(
        subplot =  self$subplot, 
        s_x = self$s_x,
        s_y = self$s_y,
        s_width = self$s_width,
        s_height = self$s_height,
        package = self$package, 
        p_x = self$p_x,
        p_y = self$p_y,
        p_color = self$p_color,
        p_family = self$p_family,
        p_size = self$p_size,
        h_size = self$h_size,
        h_fill = self$h_fill,
        h_color = self$h_color,
        spotligh = self$spotlight,
        l_x = self$l_x,
        l_y = self$l_y,
        l_width = self$l_width,
        l_height = self$l_height,
        l_alpha = self$l_alpha,
        url = self$url,
        u_x = self$u_x,
        u_y = self$u_y,
        u_color = self$u_color,
        u_family = self$u_family,
        u_size = self$u_size,
        u_angle = self$u_angle,
        white_around_sticker = self$white_around_sticker,
        filename = self$saved_path, 
        asp = self$asp, 
        dpi = self$dpi
      )
      self$saved_path
    }, 
    restore = function(vals = self$old, subplot = self$subplot){
      walk(
        grep(
          "enclos_env|^old$|restore|render|initialize|clone|export|self_|new_original_image", 
          names(vals), 
          invert = TRUE, 
          value = TRUE
        ), ~ {
          self[[.x]] <- vals[[.x]]
        }
      )
      self$subplot <- subplot
    }, 
    export = function(con){
      saveRDS(list(
        self = self, 
        img = self$subplot
      ), con)
    }
  )
)
