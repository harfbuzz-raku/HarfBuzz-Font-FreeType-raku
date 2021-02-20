[[Raku HarfBuzz Project]](https://harfbuzz-raku.github.io)
 / [[HarfBuzz-Font-FreeType Module]](https://harfbuzz-raku.github.io/HarfBuzz-Font-FreeType-raku)

class HarfBuzz::Font::FreeType
------------------------------

A HarfBuzz FreeType face integrated font

### has Font::FreeType::Face:D $.ft-face

HarfBuzz FreeType bound font data-type

Synopsis
--------

    use HarfBuzz::Font::FreeType;
    use HarfBuzz::Shaper;
    use Font::FreeType::Face;
    my  Font::FreeType::Face $ft-face .= new: ...;
    my  HarfBuzz::Font::FreeType() .= %( :$ft-face, :@features, :$size, :@scale );
    my  HarfBuzz::Shaper $shaper .= new: :$font, :buf{ :text<Hello> };

Description
-----------

This modules supports [FreeType integration](https://harfbuzz.github.io/integration-freetype.html) for the HarfBuzz library.

It may be used to do [HarfBuzz](https://harfbuzz-raku.github.io/HarfBuzz-raku) shaping from a [Font::FreeType](https://pdf-raku.github.io/Font-FreeType-raku/Font/FreeType) object.

Methods
-------

### method ft-load-flags

```perl6
method ft-load-flags() returns Int
```

Get or set the FreeType load flags

See Also
--------

