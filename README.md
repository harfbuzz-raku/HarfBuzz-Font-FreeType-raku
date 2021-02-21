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

Note that HarfBuzz can load OpenType and TrueType format fonts directly. The FreeType integration most likely to be useful for other font formats, that can be loaded by [Font::FreeType](https://harfbuzz-raku.github.io/Font-FreeType-raku/).

Methods
-------

This class inherits from [HarfBuzz::Font](https://harfbuzz-raku.github.io/HarfBuzz-raku/Font) and has all its methods available.

### new

```raku
use Font::FreeType::Face;
use HarfBuzz::Font::FreeType;
method new(
    Font::FreeType::Face:D :$ft-face!, # FreeeType face
    Bool  :$funcs = True,              # use FreeType functions
    Num() :$size = 12e0,               # font size (points)
    :@scale,                           # font scale [x, y?]
) returns HarfBuzz::Font::FreeType:D
```

Creates a new FreeType integrated font.

```raku
multi method COERCE(
    %ops (Font::FreeType::Face:D :$ft-face!, |etc)
) returns HarfBuzz::Font::FreeType:D
```

Coerces a FreeType integrated font, from an options hash.

### method ft-load-flags

```perl6
method ft-load-flags() returns Int
```

Get or set the FreeType load flags

See Also
--------

