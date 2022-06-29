module ToolipsBase64
using Toolips
using ToolipsSession
using Base64

"""
**Base64 Interface**
### base64img(path::String) -> ::Component
------------------
Creates a Base64 image component from an image file.
#### example
```

```
"""
function base64img(path::String)
      filetype = split(path, ".")[2]
      raw = read(path)
      io = IOBuffer();
      b64 = Base64.Base64EncodePipe(io)
      write(b64, raw)
      close(b64)
      mysrc = String(io.data)
      img("myimg", src = "data:image/$filetype;base64," * mysrc)
end

"""
**Base64 Interface**
### base64img(raw::String, filetype::String = "png") -> ::Component
------------------
Creates a Base64 image component from a raw string of image data.
#### example
```

```
"""
function base64img(raw::String, filetype::String = "png")
      io = IOBuffer();
      b64 = Base64.Base64EncodePipe(io)
      write(b64, raw)
      close(b64)
      mysrc = String(io.data)
      img("myimg", src = "data:image/$filetype;base64," * mysrc)
end

"""
**Base64 Interface**
### base64img(raw::String, filetype::String = "png") -> ::Component
------------------
Creates a Base64 image component from any type shown with the image/png mime.
For example, a plot which only shows as a png.
#### example
```

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
```

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

"""
**Base64 Interface**
### update_base64!(cm::ComponentModifier, name::Component, raw::String, filetype::String = "png") -> ::Component
------------------
Updates a given img component with the raw source as Base64
#### example
```

```
"""
function update_base64!(cm::ComponentModifier, s::Component, raw::String,
      filetype::String = "png")
      update_base64!(cm, s.name, raw, filetype)
end

export base64img, update_base64!
end # module
