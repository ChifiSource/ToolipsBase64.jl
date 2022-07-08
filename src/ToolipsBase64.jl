"""
Created in July, 2022 by
[chifi - an open source software dynasty.](https://github.com/orgs/ChifiSource)
by team
[toolips](https://github.com/orgs/ChifiSource/teams/toolips)
This software is MIT-licensed.
### ToolipsBase64
Toolips Base64 exports the base64img Component, a component which can be created
from regular image data.
##### Module Composition
- [**ToolipsBase64**](https://github.com/ChifiSource/ToolipsBase64.jl)
"""
module ToolipsBase64
using Toolips
using ToolipsSession
using Base64

"""
**Base64 Interface**
### base64img(raw::String) -> ::Component
------------------
Creates a Base64 image component from a raw string of image data.
#### example
```
function serveb64(c::Connection)
      rawpng = read("myimage.png", String)
      image = base64img(rawpng)
      write!(c, image)
end
```
"""
function base64img(raw::String)
      io::IOBuffer = IOBuffer();
      b64::Base64.Base64EncodePipe = Base64.Base64EncodePipe(io)
      write(b64, raw)
      close(b64)
      mysrc::String = String(io.data)
      img("myimg", src = "data:image/$filetype;base64," * mysrc)::Component
end

"""
**Base64 Interface**
### base64img(raw::Any, filetype::String = "png") -> ::Component
------------------
Creates a Base64 image component from any type shown with the image/png mime.
For example, a plot which only shows as a png.
#### example
```
function serveb64(c::Connection)
      # this content could be a Julia Image, or a plot, in this example we assume
      #    julia_img is a PNG Julia image.
      image = base64img(julia_img, "png")
      write!(c, image)
end
```
"""
function base64img(raw::Any, filetype::String = "png")
      io = IOBuffer();
      b64 = Base64.Base64EncodePipe(io)
      show(b64, "image/$filetype", raw)
      close(b64)
      mysrc = String(io.data)
      img("myimg", src = "data:image/$filetype;base64," * mysrc)
end

"""
**Base64 Interface**
### update_base64!(cm::ComponentModifier, name::String, raw::Any, filetype::String = "png") -> ::Component
------------------
Updates a given img component by name with the raw source as Base64
#### example
```julia
function serveb64(c::Connection)
      # this content could be a Julia Image, or a plot, in this example we assume
      #    julia_img is a PNG Julia image.
      image = base64img("myimage", julia_img, "png")
      on(c, image, "click") do cm::ComponentModifier
            update_base64!(cm, "image", other_julia_img, "png")
      end
      write!(c, image)
end
```
"""
function update_base64!(cm::ComponentModifier, name::String, raw::Any,
      filetype::String = "png")
      io = IOBuffer();
      b64 = Base64.Base64EncodePipe(io)
      show(b64, "image/$filetype", raw)
      close(b64)
      mysrc = String(io.data)
      cm[name] = "src" => "data:image/$filetype;base64," * mysrc
end

"""
**Base64 Interface**
### update_base64!(cm::ComponentModifier, name::Component, raw::Any, filetype::String = "png") -> ::Component
------------------
Updates a given img component with the raw source as Base64
#### example
```
function serveb64(c::Connection)
      # this content could be a Julia Image, or a plot, in this example we assume
      #    julia_img is a PNG Julia image.
      image = base64img("image", julia_img, "png")
      on(c, image, "click") do cm::ComponentModifier
            update_base64!(cm, image, other_julia_img, "png")
      end
      write!(c, image)
end
```
"""
function update_base64!(cm::ComponentModifier, s::Component, raw::Any,
      filetype::String = "png")
      update_base64!(cm, s.name, raw, filetype)
end

"""
**Base64 Interface**
### update_base64!(cm::ComponentModifier, name::String, raw::String, filetype::String = "png") -> ::Component
------------------
Updates a given img component by name with the raw source as Base64
#### example
```
function serveb64(c::Connection)
      # this content could be a Julia Image, or a plot, in this example we assume
      #    julia_img is a PNG Julia image.
      image = base64img(julia_img, "png")
      on(c, image, "click") do cm::ComponentModifier
            update_base64!(cm, "image", other_julia_img, "png")
      end
      write!(c, image)
end
```
"""
function update_base64!(cm::ComponentModifier, name::String, raw::String,
      filetype::String = "png")
      io = IOBuffer();
      b64 = Base64.Base64EncodePipe(io)
      write(b64, raw)
      close(b64)
      mysrc = String(io.data)
      cm[name] = "src" => "data:image/$filetype;base64," * mysrc
end

export base64img, update_base64!
end # module
