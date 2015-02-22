return {
  version = "1.1",
  luaversion = "5.1",
  orientation = "orthogonal",
  width = 30,
  height = 30,
  tilewidth = 16,
  tileheight = 16,
  properties = {},
  tilesets = {
    {
      name = "testtiles",
      firstgid = 1,
      tilewidth = 16,
      tileheight = 16,
      spacing = 0,
      margin = 0,
      image = "../image/testtiles.png",
      imagewidth = 256,
      imageheight = 256,
      properties = {},
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "floor",
      x = 0,
      y = 0,
      width = 30,
      height = 30,
      visible = false,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57,
        57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57,
        57, 57, 57, 57, 59, 57, 59, 57, 59, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57,
        57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57,
        57, 57, 57, 57, 59, 57, 57, 57, 59, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57,
        57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57,
        57, 153, 152, 152, 153, 153, 152, 152, 152, 152, 153, 57, 57, 57, 57, 57, 57, 57, 57, 57, 59, 57, 59, 57, 59, 57, 57, 57, 57, 57,
        57, 151, 151, 152, 153, 152, 153, 151, 152, 153, 151, 151, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57,
        57, 151, 153, 152, 152, 151, 152, 153, 153, 151, 153, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57,
        57, 153, 153, 153, 151, 152, 152, 151, 152, 153, 153, 57, 57, 57, 57, 57, 57, 57, 57, 107, 106, 107, 105, 107, 106, 107, 57, 57, 57, 57,
        57, 152, 153, 152, 153, 151, 152, 151, 153, 153, 152, 57, 57, 57, 57, 57, 57, 57, 57, 107, 106, 105, 107, 105, 106, 107, 57, 57, 57, 57,
        57, 152, 153, 153, 153, 153, 152, 152, 152, 151, 153, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 59, 57, 57, 57, 57, 57, 57, 57,
        57, 153, 152, 153, 153, 152, 152, 153, 153, 151, 153, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 59, 57, 59, 57, 57, 57, 57, 57, 57,
        57, 153, 151, 153, 153, 153, 152, 152, 152, 151, 153, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57,
        57, 57, 57, 57, 57, 57, 57, 151, 153, 151, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57,
        152, 151, 153, 151, 153, 151, 151, 153, 152, 152, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57,
        152, 153, 152, 151, 153, 152, 152, 152, 153, 153, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 59, 57, 57, 59, 57, 57,
        151, 151, 152, 152, 151, 151, 152, 152, 152, 153, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57,
        153, 153, 151, 151, 153, 152, 151, 152, 153, 151, 57, 59, 57, 59, 57, 57, 59, 57, 57, 59, 57, 57, 57, 57, 59, 57, 57, 59, 57, 57,
        151, 151, 153, 152, 151, 153, 153, 153, 152, 152, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 43, 57, 57,
        153, 152, 153, 153, 151, 153, 152, 151, 152, 153, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57,
        153, 151, 151, 151, 153, 153, 153, 152, 153, 153, 57, 59, 57, 57, 57, 57, 57, 57, 57, 59, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57,
        152, 151, 153, 152, 57, 152, 153, 152, 152, 153, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57,
        152, 152, 152, 151, 152, 153, 151, 151, 153, 153, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57,
        152, 153, 152, 151, 152, 152, 152, 152, 152, 153, 57, 59, 57, 57, 57, 57, 57, 57, 57, 59, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57,
        151, 153, 151, 152, 151, 152, 151, 153, 153, 151, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57,
        152, 151, 153, 152, 151, 152, 153, 152, 151, 151, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 59, 57, 57, 59, 57, 57,
        153, 153, 151, 152, 152, 151, 151, 153, 152, 153, 57, 59, 57, 59, 57, 57, 59, 57, 57, 59, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57,
        151, 152, 153, 151, 151, 152, 152, 151, 152, 151, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 59, 57, 57, 59, 57, 57,
        152, 153, 153, 151, 152, 153, 152, 153, 152, 151, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 43, 57, 57, 57, 57, 57
      }
    },
    {
      type = "tilelayer",
      name = "walls",
      x = 0,
      y = 0,
      width = 30,
      height = 30,
      visible = true,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        42, 40, 40, 42, 41, 42, 40, 40, 41, 40, 40, 42, 41, 41, 40, 41, 40, 41, 42, 40, 40, 40, 41, 40, 41, 42, 42, 40, 41, 42,
        40, 42, 42, 41, 40, 40, 40, 41, 40, 42, 40, 41, 41, 40, 40, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 42,
        40, 41, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 40, 47, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 41,
        42, 41, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 41,
        40, 41, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 40, 47, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 42,
        40, 42, 41, 41, 40, 135, 0, 90, 40, 40, 41, 41, 42, 40, 40, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 40,
        42, 136, 136, 136, 136, 136, 0, 90, 135, 136, 136, 40, 41, 40, 40, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 40,
        42, 137, 0, 0, 0, 0, 0, 96, 136, 136, 137, 40, 40, 40, 40, 40, 0, 0, 89, 89, 93, 94, 93, 94, 93, 89, 89, 0, 0, 41,
        40, 135, 0, 0, 0, 0, 0, 96, 136, 136, 135, 40, 41, 40, 40, 40, 0, 0, 89, 92, 96, 96, 92, 92, 95, 92, 89, 0, 0, 40,
        41, 135, 0, 0, 92, 95, 95, 91, 137, 137, 137, 41, 40, 40, 40, 40, 0, 0, 90, 0, 0, 0, 0, 0, 0, 0, 92, 0, 0, 41,
        42, 137, 0, 0, 91, 90, 89, 90, 95, 89, 135, 42, 42, 40, 40, 40, 0, 0, 89, 0, 0, 0, 0, 0, 0, 0, 89, 0, 0, 40,
        42, 137, 0, 0, 0, 0, 0, 0, 0, 0, 137, 42, 41, 40, 40, 40, 0, 0, 89, 90, 89, 93, 0, 93, 96, 96, 89, 0, 0, 41,
        42, 136, 0, 0, 0, 0, 0, 0, 0, 0, 135, 40, 41, 40, 40, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 42,
        40, 136, 136, 139, 138, 138, 139, 138, 0, 137, 136, 41, 41, 40, 40, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 40,
        42, 41, 42, 42, 40, 41, 42, 138, 0, 136, 42, 42, 41, 42, 42, 41, 41, 41, 41, 40, 41, 44, 42, 44, 40, 40, 40, 40, 40, 41,
        143, 143, 143, 143, 139, 138, 139, 138, 0, 136, 41, 41, 41, 41, 41, 40, 42, 46, 45, 40, 42, 42, 40, 41, 40, 41, 41, 41, 42, 42,
        143, 0, 0, 143, 138, 0, 0, 0, 0, 136, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 41, 41, 0, 0, 0, 0, 0, 0, 42,
        143, 0, 0, 143, 139, 0, 0, 0, 0, 136, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 41, 40, 0, 0, 0, 0, 0, 0, 42,
        143, 0, 0, 143, 138, 0, 0, 0, 0, 137, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 40, 40, 0, 0, 0, 0, 0, 0, 40,
        143, 0, 0, 143, 138, 0, 0, 0, 0, 135, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 40, 40, 42, 0, 42, 40, 40, 42, 42,
        143, 0, 0, 0, 0, 0, 0, 0, 0, 135, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 41, 41, 40, 0, 40, 41, 40, 42, 40,
        143, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 41,
        137, 135, 136, 135, 141, 0, 0, 0, 0, 136, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 40,
        135, 135, 137, 135, 141, 0, 0, 0, 0, 137, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 41, 40, 42, 0, 42, 40, 40, 42, 41,
        137, 137, 137, 137, 141, 0, 0, 0, 0, 135, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 41, 41, 42, 0, 40, 41, 41, 41, 40,
        135, 136, 135, 135, 141, 0, 0, 0, 0, 135, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 42, 42, 0, 0, 0, 0, 0, 0, 40,
        135, 135, 136, 137, 141, 0, 0, 0, 0, 136, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 42, 42, 0, 0, 0, 0, 0, 0, 42,
        135, 135, 137, 136, 141, 0, 0, 0, 0, 135, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 41, 42, 0, 0, 0, 0, 0, 0, 42,
        135, 137, 137, 136, 141, 0, 0, 0, 0, 137, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 41, 42, 0, 0, 0, 0, 0, 0, 42,
        135, 137, 137, 136, 135, 135, 137, 135, 136, 137, 135, 137, 136, 137, 137, 135, 135, 135, 136, 135, 135, 135, 40, 42, 40, 42, 45, 46, 40, 41
      }
    },
    {
      type = "tilelayer",
      name = "ceiling",
      x = 0,
      y = 0,
      width = 30,
      height = 30,
      visible = false,
      opacity = 0.41,
      properties = {},
      encoding = "lua",
      data = {
        25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25,
        25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25,
        25, 25, 25, 25, 27, 25, 27, 25, 27, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25,
        25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 31, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25,
        25, 25, 25, 25, 27, 25, 25, 25, 27, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25,
        25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25,
        25, 120, 119, 120, 120, 120, 121, 121, 119, 119, 120, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25,
        25, 119, 120, 122, 123, 119, 121, 119, 120, 119, 121, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25,
        25, 121, 121, 119, 123, 122, 120, 121, 119, 121, 121, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25,
        25, 120, 122, 121, 121, 119, 119, 119, 121, 119, 121, 25, 25, 25, 25, 25, 25, 25, 25, 73, 74, 73, 73, 73, 74, 73, 25, 25, 25, 25,
        25, 120, 119, 120, 120, 119, 121, 119, 119, 119, 120, 25, 25, 25, 25, 25, 25, 25, 25, 73, 74, 73, 73, 73, 74, 73, 25, 25, 25, 25,
        25, 119, 121, 122, 119, 121, 123, 122, 120, 119, 121, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25,
        25, 121, 121, 119, 119, 122, 123, 121, 119, 121, 121, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25,
        25, 120, 119, 119, 119, 120, 120, 120, 120, 121, 121, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25,
        25, 25, 25, 25, 25, 25, 25, 120, 122, 119, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25,
        119, 120, 120, 120, 121, 120, 119, 120, 119, 121, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25,
        119, 120, 119, 119, 121, 121, 121, 119, 119, 120, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 27, 25, 25, 27, 25, 25,
        120, 122, 119, 120, 120, 120, 119, 122, 121, 121, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25,
        120, 119, 120, 120, 120, 124, 124, 124, 124, 121, 25, 27, 25, 27, 25, 25, 27, 25, 25, 27, 25, 25, 25, 25, 27, 25, 25, 27, 25, 25,
        120, 119, 122, 120, 120, 119, 122, 120, 119, 119, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25,
        120, 119, 119, 119, 119, 119, 121, 121, 121, 121, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25,
        119, 121, 121, 121, 120, 119, 119, 122, 121, 119, 25, 27, 25, 25, 25, 25, 25, 25, 25, 27, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25,
        119, 119, 119, 121, 121, 121, 121, 120, 120, 121, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25,
        119, 121, 120, 121, 120, 119, 122, 121, 120, 120, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25,
        121, 120, 119, 121, 121, 121, 120, 120, 120, 120, 25, 27, 25, 25, 25, 25, 25, 25, 25, 27, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25,
        121, 119, 120, 119, 121, 120, 119, 122, 120, 119, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25,
        121, 120, 120, 121, 120, 124, 124, 124, 124, 119, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 27, 25, 25, 27, 25, 25,
        120, 119, 121, 120, 120, 120, 122, 119, 120, 119, 25, 27, 25, 27, 25, 25, 27, 25, 25, 27, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25,
        119, 119, 121, 121, 121, 121, 119, 120, 119, 120, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 27, 25, 25, 27, 25, 25,
        119, 120, 119, 120, 120, 119, 120, 121, 119, 119, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25
      }
    },
    {
      type = "objectgroup",
      name = "entities",
      visible = true,
      opacity = 0.97,
      properties = {},
      objects = {
        {
          name = "",
          type = "player",
          shape = "rectangle",
          x = 80,
          y = 58,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "headcrab",
          shape = "rectangle",
          x = 136,
          y = 59,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "headcrab",
          shape = "rectangle",
          x = 166,
          y = 46,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "headcrab",
          shape = "rectangle",
          x = 316,
          y = 58,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "crate",
          shape = "rectangle",
          x = 314,
          y = 162,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "crate",
          shape = "rectangle",
          x = 315,
          y = 150,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "crate",
          shape = "rectangle",
          x = 335,
          y = 162,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "crate",
          shape = "rectangle",
          x = 336,
          y = 150,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "crate",
          shape = "rectangle",
          x = 380,
          y = 165,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "crate",
          shape = "rectangle",
          x = 402,
          y = 153,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "crate",
          shape = "rectangle",
          x = 381,
          y = 153,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "crate",
          shape = "rectangle",
          x = 401,
          y = 165,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "battery",
          shape = "rectangle",
          x = 439,
          y = 280,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "firstaid",
          shape = "rectangle",
          x = 34,
          y = 274,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "barnacle",
          shape = "rectangle",
          x = 403,
          y = 296,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "barnacle",
          shape = "rectangle",
          x = 402,
          y = 411,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "barnacle",
          shape = "rectangle",
          x = 190,
          y = 56,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "scientist",
          shape = "rectangle",
          x = 110,
          y = 62,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "scientist",
          shape = "rectangle",
          x = 194,
          y = 45,
          width = 0,
          height = 0,
          visible = true,
          properties = {
            ["skin"] = "3"
          }
        }
      }
    },
    {
      type = "objectgroup",
      name = "freewalls",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {
        {
          name = "door1",
          type = "",
          shape = "polyline",
          x = 232,
          y = 48,
          width = 0,
          height = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 16 }
          },
          properties = {
            ["texture"] = "data/image/door/blastdoor.png"
          }
        }
      }
    },
    {
      type = "tilelayer",
      name = "top",
      x = 0,
      y = 0,
      width = 30,
      height = 30,
      visible = false,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 40, 0, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      name = "bottom",
      x = 0,
      y = 0,
      width = 30,
      height = 30,
      visible = false,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      name = "left",
      x = 0,
      y = 0,
      width = 30,
      height = 30,
      visible = false,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      name = "usabletiles",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {
        {
          name = "",
          type = "recharger",
          shape = "rectangle",
          x = 440,
          y = 467,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "firstaid",
          shape = "rectangle",
          x = 423,
          y = 466,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "firstaid",
          shape = "rectangle",
          x = 296,
          y = 253,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "recharger",
          shape = "rectangle",
          x = 278,
          y = 253,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "button",
          shape = "rectangle",
          x = 210,
          y = 73,
          width = 0,
          height = 0,
          visible = true,
          properties = {
            ["onActivate"] = "'openDoor'",
            ["onDeactivate"] = "'closeDoor'",
            ["resetTime"] = "5"
          }
        }
      }
    },
    {
      type = "objectgroup",
      name = "triggers",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {
        {
          name = "",
          type = "",
          shape = "polygon",
          x = 244,
          y = 38,
          width = 0,
          height = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 1, y = 34 },
            { x = 33, y = 53 },
            { x = 33, y = -10 }
          },
          properties = {
            ["onActivate"] = "'closeDoorFast'"
          }
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 416,
          y = 20,
          width = 44,
          height = 33,
          visible = true,
          properties = {
            ["onActivate"] = "'recttest'"
          }
        }
      }
    }
  }
}