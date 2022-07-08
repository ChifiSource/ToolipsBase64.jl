<div align = "center"><img src = "https://github.com/ChifiSource/image_dump/blob/main/toolips/toolipsbase64.png" href = "https://toolips.app"></img></div>

- [Documentation](doc.toolips.app/extensions/toolips_base64)
- [Toolips](https://github.com/ChifiSource/Toolips.jl)
- [Extension Gallery](https://doc.toolips.app/?page=gallery&selected=base64)
### usage
Go ahead and try this example code in your REPL!
```julia
using Pkg
Pkg.add("Toolips")
Pkg.add("ToolipsBase64")
Pkg.add("ToolipsSession")
using Toolips
using ToolipsSession
using ToolipsBase64

serveb64 = route("/") do c::Connection
      # this content could be a Julia Image, or a plot, in this example we assume
      #    julia_img is a PNG Julia image.
      image = base64img("image", julia_img, "png")
      on(c, image, "click") do cm::ComponentModifier
            update_base64!(cm, image, other_julia_img, "png")
      end
      write!(c, image)
end

routes = routes(serveb64)
st = ServerTemplate("127.0.0.1", 8000, routes(serveb64), [Session(), Logger()]
```
