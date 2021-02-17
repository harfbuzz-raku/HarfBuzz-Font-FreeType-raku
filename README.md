class HarfBuzz::Font::FreeType
------------------------------

A HarfBuzz FreeType face integrated font

### has Font::FreeType::Face:D $.ft-face

HarfBuzz FreeType bound font data-type

Synopsis
--------

    use HarfBuzz::Font::FreeType;
    use Font::FreeType::Face;
    my  Font::FreeType::Face .= new: ...;
    my HarfBuzz::Font::FreeType() .= %( :$ft-face, :@features, :$size, :@scale );

Methods
-------

### method ft-load-flags

```perl6
method ft-load-flags() returns Mu
```

Get or set the FreeType load flags

