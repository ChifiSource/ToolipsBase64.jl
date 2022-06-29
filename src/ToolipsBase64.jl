module ToolipsBase64
using Toolips
using ToolipsSession
using Base64

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

function base64img(raw::String, filetype::String = "png")
      io = IOBuffer();
      b64 = Base64.Base64EncodePipe(io)
      write(b64, raw)
      close(b64)
      mysrc = String(io.data)
      img("myimg", src = "data:image/$filetype;base64," * mysrc)
end

function base64img(raw::Any, filetype::String = "png")
      io = IOBuffer();
      b64 = Base64.Base64EncodePipe(io)
      show(b64, "image/$filetype", raw)
      close(b64)
      mysrc = String(io.data)
      img("myimg", src = "data:image/$filetype;base64," * mysrc)
end

function update_base64!(cm::ComponentModifier, name::String, raw::Any,
      filetype::String = "png")
      io = IOBuffer();
      b64 = Base64.Base64EncodePipe(io)
      show(b64, "image/$filetype", raw)
      close(b64)
      mysrc = String(io.data)
      cm[name] = "src" => "data:image/$filetype;base64," * mysrc
end

function update_base64!(cm::ComponentModifier, s::Component, raw::Any,
      filetype::String = "png")
      update_base64!(cm, s.name, raw, filetype)
end

function update_base64!(cm::ComponentModifier, name::String, raw::String,
      filetype::String = "png")
      io = IOBuffer();
      b64 = Base64.Base64EncodePipe(io)
      write(b64, raw)
      close(b64)
      mysrc = String(io.data)
      cm[name] = "src" => "data:image/$filetype;base64," * mysrc
end

function update_base64!(cm::ComponentModifier, s::Component, raw::String,
      filetype::String = "png")
      update_base64!(cm, s.name, raw, filetype)
end

export base64img, update_base64!
end # module
